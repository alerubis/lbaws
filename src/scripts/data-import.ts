import { PrismaClient } from '@prisma/client';
import axios from 'axios';
import inquirer from 'inquirer';
import { skip } from 'node:test';

export interface Team {
    id: number;
    name: string;
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

const prisma = new PrismaClient();

async function importData(token: string, anno: number) {

    // Ottengo le squadre
    const championshipsResponse = await axios.get('https://api-lba.procne.cloud/api/v1/teams?year=' + anno, {
        headers: { Authorization: `Bearer ${token}` },
        responseType: "text",
    });
    const rawData = JSON.parse(championshipsResponse.data);
    const teams: Team[] = rawData.teams as Team[];

    // Inserisco in db le squadre
    console.log('Inserisco in db le ' + teams.length + ' squadre...');
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

    for (const team of teams) {

        // Ottengo i giocatori
        const rosterResponse = await axios.get('	https://api-lba.procne.cloud/api/v1/teams/' + team.id + '/roster', {
            headers: { Authorization: `Bearer ${token}` },
            responseType: "text",
        });
        const rawData = JSON.parse(rosterResponse.data);
        const players: Player[] = rawData.players as Player[];

        // Inserisco in db i giocatori
        console.log('Inserisco in db i ' + players.length + ' giocatori di ' + team.name + ' (' + team.id + ')...');
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
    }

}

inquirer
    .prompt([
        { message: 'Per che anno vuoi importare i dati?', name: 'anno', type: 'input' },
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

        // Import
        const anno = answers.anno;
        importData(token, anno);

    })
    .catch((error) => {
        console.error("ERRORE", error);
    });
