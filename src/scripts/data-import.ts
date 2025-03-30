import { PrismaClient } from '@prisma/client';
import axios from 'axios';
import inquirer, { DistinctQuestion } from 'inquirer';
import _ from 'lodash';
import fs from 'fs';
import path from 'path';
import readline from 'readline';

export interface Team {
    id: number;
    name: string;
    year: number;
    club_id: number;
    club_code: string;
    updated_at: string;
    logo_key: string;
}

export interface Player {
    id: number;
    name: string;
    surname: string;
    code: string;
    place_of_birth: string;
    birth_date: string;
    player_number: string;
    country: string;
    uefa_ratio: string;
    height: number;
    weight: number;
    year: number;
    start_date: string;
    end_date: string;
    player_role_id: number;
    player_role: string;
    team_name: string;
    player_picture_key: string;
    team_logo_key: string;
}

export interface Competition {
    id: number;
    year: number;
    name: string;
    status: number;
    championship_type_id: number;
    championship_series_id: number;
    full_name: string;
    focus_on: boolean;
    ctype_code: string;
    ctype_name: string;
    cserie_code: string;
    cserie_name: string;
    logo_key: string;
}

export interface CalendarDay {
    id: string;
    event_serial: number;
    code: string;
    name: string;
    focus_on: boolean;
}

export interface Match {
    id: number;
    game_status: string;
    championship_id: number;
    championships_day_id: number;
    year: number;
    number: number;
    match_datetime: string;
    match_hh: number;
    match_mm: number;
    home_final_score: number;
    visitor_final_score: number;
    target_score: number;
    additional_time: number;
    plant_id: number;
    websocket_match_id: string;
    has_streaming: number;
    updated_at: string;
    h_team_id: number;
    h_team_name: string;
    h_club_code: string;
    h_team_enabled: boolean;
    home_logo_key: string;
    v_team_id: number;
    v_team_name: string;
    v_club_code: string;
    v_team_enabled: boolean;
    v_logo_key: string;
    town_id: number;
    plant_name: string;
    town_name: string;
    day_code: string;
    day_serial: number;
    day_name: string;
    match_serie_key: string;
}

const prisma = new PrismaClient();

async function importTeamsAndPlayersFromStats(token: string) {
    for (let anno = new Date().getFullYear(); anno >= 2024; anno--) {
        // 1. Recupero squadre della stagione
        const teamResponse = await axios.get(`https://api-lba.procne.cloud/api/v1/teams?year=${anno}`, {
            headers: { Authorization: `Bearer ${token}` },
            responseType: "text",
        });

        const rawTeamData = JSON.parse(teamResponse.data);
        const teams: Team[] = rawTeamData.teams;

        console.log(`${anno} - ${teams.length} squadre trovate`);

        await prisma.team.createMany({
            data: teams.map(team => ({
                id: team.id,
                name: team.name,
                logo_url: `https://lba-media.s3.eu-south-1.amazonaws.com/${team.logo_key}`,
            })),
            skipDuplicates: true,
        });

        // 2. Per ogni squadra, recupero player stats
        for (const team of teams) {
            try {
                const statsResponse = await axios.get(`https://api-lba.procne.cloud/api/v1/teams/${team.id}/players_stats?s=${anno}&st=sum`, {
                    headers: { Authorization: `Bearer ${token}` },
                    responseType: "text",
                });

                const statsData = JSON.parse(statsResponse.data);
                const playersStats: any[] = statsData.players;

                console.log(`${anno} - ${team.name} - ${playersStats.length} giocatori trovati tramite stats`);

                for (const stat of playersStats) {
                    const playerId = stat.player_id;

                    try {
                        const playerResponse = await axios.get(`https://api-lba.procne.cloud/api/v1/players/${playerId}`, {
                            headers: { Authorization: `Bearer ${token}` },
                            responseType: "text",
                        });

                        const playerData = JSON.parse(playerResponse.data);
                        const player: Player = playerData.player;

                        await prisma.player.create({
                            data: {
                                id: player.id,
                                name: player.name,
                                surname: player.surname,
                                logo_url: "https://www.legabasket.it/_next/static/media/AvatarPlaceholder.64b5f792.svg",
                                height: player.height,
                                year: player?.birth_date ? +player.birth_date.substring(0, 4) : null,
                            },
                        });

                        console.log(`Inserito: ${player.name} ${player.surname}`);

                    } catch (err: any) {
                        if (err.code === 'P2002') {
                            console.log(`Già presente: ${stat.player_name} ${stat.player_surname}`);
                        } else {
                            console.warn(`Errore per il giocatore ${stat.player_name} ${stat.player_surname}:`, err.message);
                        }
                    }
                }

            } catch (error: any) {
                console.warn(`Errore stats squadra ${team.name} (${team.id}) - ${anno}:`, error.message);
            }
        }
    }
}

async function importTeams(token: string) {

    // Ottengo le squadre da qui al 2000
    // Chiamando https://api-lba.procne.cloud/api/v1/teams senza anno ti da le 16 della stagione corrente
    for (let anno = new Date().getFullYear(); anno >= 2000; anno--) {
        const championshipsResponse = await axios.get('https://api-lba.procne.cloud/api/v1/teams?year=' + anno, {
            headers: { Authorization: `Bearer ${token}` },
            responseType: "text",
        });
        const rawData = JSON.parse(championshipsResponse.data);
        const teams: Team[] = rawData.teams as Team[];

        // Inserisco in db le squadre
        console.log(anno + ' - Inserisco in db le ' + teams.length + ' squadre...');
        await prisma.team.createMany({
            data: teams.map(team => {
                return {
                    id: team.id,
                    name: team.name,
                    logo_url: 'https://lba-media.s3.eu-south-1.amazonaws.com/' + team.logo_key,
                };
            }),
            skipDuplicates: true,
        });
    }

}

async function importAllPlayers(token: string) {
    let page = 0;
    let rawData: any = null;

    do {
        page++;

        // Ottengo i giocatori
        const response = await axios.get(`https://api-lba.procne.cloud/api/v1/players?full=1&ob=surname&sb=asc&page=${page}&items=25`, {
            headers: { Authorization: `Bearer ${token}` },
            responseType: "text",
        });

        rawData = JSON.parse(response.data);
        const players: Player[] = rawData.players;

        // Inserisco in db i giocatori
        console.log(`Pagina ${page} - Inserisco in db ${players.length} giocatori...`);
        await prisma.player.createMany({
            data: players.map(player => ({
                id: player.id,
                name: player.name,
                surname: player.surname,
                logo_url: "https://www.legabasket.it/_next/static/media/AvatarPlaceholder.64b5f792.svg",
                height: player.height,
                year: player?.birth_date ? +player.birth_date.substring(0, 4) : null,
            })),
            skipDuplicates: true,
        });

    } while (rawData && rawData.pagination?.next != null);
}

async function importPlayers(token: string) {

    for (let anno = new Date().getFullYear(); anno >= 2000; anno--) {

        let page = 0;
        let rawData: any = null;
        do {

            // Ottengo i giocatori
            page++;
            const championshipsResponse = await axios.get('https://api-lba.procne.cloud/api/v1/players?year=' + anno + '&full=1&ob=surname&sb=asc&page=' + page + '&items=25', {
                headers: { Authorization: `Bearer ${token}` },
                responseType: "text",
            });
            rawData = JSON.parse(championshipsResponse.data);
            const players: Player[] = rawData.players as Player[];

            // Inserisco in db i giocatori
            console.log(anno + ' - Pagina ' + page + ' - Inserisco in db i ' + players.length + ' giocatori...');
            await prisma.player.createMany({
                data: players.map(player => {
                    return {
                        id: player.id,
                        name: player.name,
                        surname: player.surname,
                        logo_url: "https://www.legabasket.it/_next/static/media/AvatarPlaceholder.64b5f792.svg",
                        height: player.height,
                        year: player?.birth_date ? +player.birth_date.substring(0, 4) : null,
                    };
                }),
                skipDuplicates: true,
            });

        } while (rawData && rawData.pagination?.next != null)

    }

}

async function importGames(token: string) {

    for (let anno = new Date().getFullYear(); anno >= 2023; anno--) {

        // Ottengo le competizioni
        const reponse = await axios.get('https://api-lba.procne.cloud/api/v1/championships?s=' + anno + '&items=1000', {
            headers: { Authorization: `Bearer ${token}` },
            responseType: "text",
        });
        const rawData = JSON.parse(reponse.data);
        const competitions: Competition[] = rawData.competitions as Competition[];

        for (const competition of competitions) {

            // Ottengo il calendario
            const reponse = await axios.get('https://api-lba.procne.cloud/api/v1/championships/' + competition.id + '/calendar', {
                headers: { Authorization: `Bearer ${token}` },
                responseType: "text",
            });
            const rawData = JSON.parse(reponse.data);
            if (rawData.filters?.days) {
                const calendarDays: CalendarDay[] = rawData.filters.days as CalendarDay[];

                // Ottengo l'elenco delle partite di quella giornata
                for (const calendarDay of calendarDays) {

                    // Ottengo il calendario
                    const reponse = await axios.get('https://api-lba.procne.cloud/api/v1/championships/' + competition.id + '/calendar?d=' + calendarDay.code, {
                        headers: { Authorization: `Bearer ${token}` },
                        responseType: "text",
                    });
                    const rawData = JSON.parse(reponse.data);
                    if (rawData.filters?.days) {
                        const matches: Match[] = rawData.matches as Match[];

                        if (matches && _.isArray(matches)) {
                            for (const match of matches) {
                                const matchId = match.id;

                                try {
                                    const response = await axios.get(`https://api-lba.procne.cloud/api/v1/championships_matches/${matchId}/play_by_play?info=1&sort=desc`, {
                                        headers: { Authorization: `Bearer ${token}` },
                                        responseType: "json"
                                    });

                                    const playByPlayData = response.data;

                                    const fs = require('fs');
                                    const path = require('path');

                                    const outputDir = './playbyplay_data';
                                    if (!fs.existsSync(outputDir)) {
                                        fs.mkdirSync(outputDir);
                                    }

                                    const filePath = path.join(outputDir, `playbyplay_${matchId}.json`);
                                    fs.writeFileSync(filePath, JSON.stringify(playByPlayData, null, 2));

                                    console.log(`✅ Salvato play-by-play per match ${matchId}`);
                                } catch (err: any) {
                                    console.error(`❌ Errore nel play-by-play per match ${matchId}:`, err.message);
                                }

                                console.log(`Anno ${anno} - Competizione ${competition.name} - Giornata ${calendarDay.name} - Partita ${match.h_team_name} vs ${match.v_team_name} - Finisce ${match.home_final_score} - ${match.visitor_final_score}`);
                            }
                        }
                    }

                }
            }

        }

    }

}

async function executeQueriesFromFile() {
    // Chiedi all'utente il percorso del file
    const answers = await inquirer.prompt([
        {
            type: 'input',
            name: 'filePath',
            message: 'Inserisci il percorso del file contenente le query:',
            validate: (input: string) => {
                if (!input.trim()) {
                    return 'Il percorso del file è obbligatorio';
                }
                return true;
            }
        },
        {
            type: 'confirm',
            name: 'confirm',
            message: 'Sei sicuro di voler eseguire tutte le query nel file? (Potrebbero essercene migliaia)',
            default: false
        }
    ]);

    if (!answers.confirm) {
        console.log('Operazione annullata');
        return;
    }

    const filePath = path.resolve(answers.filePath);
    
    if (!fs.existsSync(filePath)) {
        console.error(`Il file ${filePath} non esiste`);
        return;
    }

    console.log(`Inizio esecuzione delle query da ${filePath}...`);

    let queryCount = 0;
    let successCount = 0;
    let errorCount = 0;
    let batchCount = 0;
    const batchSize = 100;

    // Mappa per memorizzare le variabili
    const variables: Record<string, any> = {};

    const fileStream = fs.createReadStream(filePath);
    const rl = readline.createInterface({
        input: fileStream,
        crlfDelay: Infinity
    });

    let currentBatch: {query: string, params: any[]}[] = [];

    for await (const line of rl) {
        const rawLine = line.trim();
        if (!rawLine) continue;

        // Gestione delle variabili (es: SET @game_id = 12345;)
        if (rawLine.startsWith('SET @')) {
            const varMatch = rawLine.match(/SET @(\w+)\s*=\s*([^;]+);/);
            if (varMatch) {
                variables[varMatch[1]] = varMatch[2].trim();
                continue;
            }
        }

        queryCount++;
        
        // Sostituisci le variabili nella query
        let finalQuery = rawLine;
        const params: any[] = [];
        
        // Trova tutte le variabili nella query
        const varMatches = rawLine.match(/@(\w+)/g) || [];
        for (const varName of varMatches) {
            const cleanVarName = varName.substring(1); // Rimuovi @
            if (variables[cleanVarName] !== undefined) {
                // Sostituisci la variabile con un parametro posizionale
                finalQuery = finalQuery.replace(new RegExp(varName, 'g'), '?');
                params.push(variables[cleanVarName]);
            }
        }

        currentBatch.push({query: finalQuery, params});

        if (currentBatch.length >= batchSize) {
            batchCount++;
            try {
                await prisma.$transaction(
                    currentBatch.map(({query, params}) => 
                        params.length > 0 
                            ? prisma.$executeRawUnsafe(query, ...params)
                            : prisma.$executeRawUnsafe(query)
                    )
                );
                successCount += currentBatch.length;
                console.log(`Batch ${batchCount} eseguito con successo (${successCount} query totali)`);
            } catch (error) {
                errorCount += currentBatch.length;
                console.error(`Errore nel batch ${batchCount}:`, error);
                
                // Esegui le query una per una per debug
                for (const {query, params} of currentBatch) {
                    try {
                        if (params.length > 0) {
                            await prisma.$executeRawUnsafe(query, ...params);
                        } else {
                            await prisma.$executeRawUnsafe(query);
                        }
                        successCount++;
                    } catch (err) {
                        errorCount++;
                        console.error('Query fallita:', query);
                        console.error('Parametri:', params);
                        console.error('Errore:', err);
                    }
                }
            }
            currentBatch = [];
        }
    }

    // Esegui le query rimanenti
    if (currentBatch.length > 0) {
        batchCount++;
        try {
            await prisma.$transaction(
                currentBatch.map(({query, params}) => 
                    params.length > 0 
                        ? prisma.$executeRawUnsafe(query, ...params)
                        : prisma.$executeRawUnsafe(query)
                )
            );
            successCount += currentBatch.length;
            console.log(`Ultimo batch eseguito con successo (${successCount} query totali)`);
        } catch (error) {
            errorCount += currentBatch.length;
            console.error(`Errore nell'ultimo batch:`, error);
            for (const {query, params} of currentBatch) {
                try {
                    if (params.length > 0) {
                        await prisma.$executeRawUnsafe(query, ...params);
                    } else {
                        await prisma.$executeRawUnsafe(query);
                    }
                    successCount++;
                } catch (err) {
                    errorCount++;
                    console.error('Query fallita:', query);
                    console.error('Parametri:', params);
                    console.error('Errore:', err);
                }
            }
        }
    }

    console.log(`Esecuzione completata.`);
    console.log(`Query totali: ${queryCount}`);
    console.log(`Query eseguite con successo: ${successCount}`);
    console.log(`Query fallite: ${errorCount}`);
}

inquirer
    .prompt([
        {
            message: 'Che dati vuoi importare?',
            name: 'cosa',
            type: 'list',
            choices: [
                'Squadre',
                'Giocatori',
                'Partite',
                'Esegui query da file'
            ]
        },
    ])
    .then(async (answers) => {
        const cosa = answers.cosa;

        // Le prime tre opzioni richiedono il token
        if (['Squadre', 'Giocatori', 'Partite'].includes(cosa)) {
            console.log('Ottengo il token...');
            const authResponse = await axios.get('https://www.legabasket.it/api/oauth', {
                headers: {},
                responseType: "text"
            });
            const token: string = JSON.parse(authResponse.data).data.token;
            console.log('Token ottenuto: ' + token);

            switch (cosa) {
                case 'Squadre':
                    await importTeams(token);
                    break;
                case 'Giocatori':
                    await importTeamsAndPlayersFromStats(token);
                    break;
                case 'Partite':
                    await importGames(token);
                    break;
            }
        } else {
            // L'esecuzione delle query non richiede il token
            await executeQueriesFromFile();
        }
    })
    .catch((error) => {
        console.error("ERRORE", error);
    })
    .finally(async () => {
        await prisma.$disconnect();
    });