import axios from 'axios';
import inquirer from 'inquirer';

export interface Team {
    id: number;
    name: string;
    logo_key: string;
}

async function importSquadre(token: string, anno: number) {

    // Ottengo le squadre
    console.log('Ottengo le squadre...');
    const championshipsResponse = await axios.get('https://api-lba.procne.cloud/api/v1/teams?year=' + anno, {
        headers: { Authorization: `Bearer ${token}` },
        responseType: "text",
    });
    const rawData = JSON.parse(championshipsResponse.data);
    const teams: Team[] = rawData.teams.map((team: any) => ({
        id: team.id,
        name: team.name,
        logo_key: team.logo_key
    }));
    console.log(teams);

}

inquirer
    .prompt([
        { message: 'Per che anno vuoi importare i dati?', name: 'year', type: 'input' },
        { message: 'Che dati vuoi importare?', name: 'data', type: 'select', choices: ['Squadre', 'Giocatori'] },
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

        // In base alla scelta dell'utente, importo i dati
        const anno = answers.year;
        const dati = answers.data;
        console.log(answers);
        switch (dati) {

            case 'Squadre':
                importSquadre(token, anno);
                break;

            case 'Giocatori':
                // importGiocatori(anno);
                break;

            default:
                console.log('Nessun dato selezionato');
                break;

        }

    })
    .catch((error) => {
        console.error("ERRORE", error);
    });
