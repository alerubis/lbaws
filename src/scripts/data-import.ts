import { PrismaClient } from '@prisma/client';
import axios from 'axios';
import inquirer from 'inquirer';
import _ from 'lodash';
import { skip } from 'node:test';

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
                        height: player.height,
                        year: player.year,
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
                                console.log(`Anno ${anno} - Competizione ${competition.name} - Giornata ${calendarDay.name} - Partita ${match.h_team_name} vs ${match.v_team_name} - Finisce ${match.home_final_score} - ${match.visitor_final_score}`);
                            }
                        }
                    }

                }
            }

        }

    }

}

inquirer
    .prompt([
        { message: 'Che dati vuoi importare?', name: 'cosa', type: 'select', choices: ['Squadre', 'Giocatori', 'Partite'] },
    ])
    .then(async (answers) => {

        // Ottengo il token;
        console.log('Ottengo il token...');
        const authResponse = await axios.get('https://www.legabasket.it/api/oauth', {
            headers: {},
            responseType: "text"
        });
        const token: string = JSON.parse(authResponse.data).data.token;
        console.log('Token ottenuto: ' + token);

        const cosa = answers.cosa;
        switch (cosa) {
            case 'Squadre':
                importTeams(token);
                break;
            case 'Giocatori':
                importPlayers(token);
                break;
            case 'Partite':
                importGames(token);
                break;
            default:
                console.log('Nessuna selezione effettuata');
                break;
        }

    })
    .catch((error) => {
        console.error("ERRORE", error);
    });
