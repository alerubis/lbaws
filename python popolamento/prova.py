import json
from datetime import datetime
from itertools import groupby
import os
from operator import itemgetter
import glob

shot_map = {
    "2 punti segnato": 1,
    "2 punti sbagliato": 2,
    "3 punti segnato": 3,
    "3 punti sbagliato": 4,
    "Tiro libero segnato": 5,
    "Tiro libero sbagliato": 6,
}

turnover_map = {
    "Passaggio sbagliato": 1,
    "Palleggio": 2,
    "Doppio Palleggio": 3,
    "Passi": 4,
    "Fuori dal campo": 5,
    "Infrazione di campo": 6,
    "3 secondi": 7,
    "5 secondi": 8,
    "Interferenza a canestro in attacco": 9,
    "Altro": 10,
    "8 Secondi": 11,
    "24 Secondi": 12,
}

foul_map = {
    "personale": 1,
    "tecnico": 2,
    "antisportivo": 3,
    "tiro": 4,
    "doppio": 5,
    "antisportivo su tiro": 6,
    "offensivo": 7,
    "espulsione": 8,
    "espulsione su tiro": 9,
    "compensazione": 10,
}

linked_description_map = {
    "Fallo commesso": "Fallo Subito",
    "Stoppata": "Stoppata subita",
    "Palla persa": "Palla recuperata"
}


input_dir = "C:/Users/Alessandro Salvi/Documents/GitHub/lbaws/python popolamento/json_matches"
json_files = sorted(glob.glob(os.path.join(input_dir, "*.json")))

if not json_files:
    print("Nessun file JSON trovato nella cartella:", input_dir)
    exit()

output_dir = "./sql_matches"
os.makedirs(output_dir, exist_ok=True)

batch_size = 184
play_id = 27807
batch_file = None
f = None

for match_index, json_path in enumerate(json_files):
    if match_index % batch_size == 0:
        if f:
            f.close()
        batch_num = match_index // batch_size + 1
        batch_filename = os.path.join(output_dir, f"LBA_batch_{batch_num:03}.sql")
        f = open(batch_filename, "w", encoding="utf-8")
        print(f"✍️  Scrittura su batch: {batch_filename}")

    with open(json_path, "r", encoding="utf-8") as f_json:
        data = json.load(f_json)

    match = data["match"]
    actions = data["pbp"]["actions"]
    actions.sort(key=itemgetter("period", "minute", "seconds", "action_id"))

    match_datetime = datetime.fromisoformat(match["match_datetime"].replace("Z", "+00:00"))
    match_timestamp = int(match_datetime.timestamp() * 1000)
    team_home_id = match["h_team_id"]
    team_guest_id = match["v_team_id"]
    team_home = match["h_team_name"]
    team_guest = match["v_team_name"]
    game_id = match["id"]

    f.write(
        #f"-- Partita {team_home} vs {team_guest} del {match['match_datetime']}\n"
        f"INSERT INTO game (id, league_year_id, type_game_id, team_home_id, team_guest_id, team_home_points, team_guest_points, "
        f"date_hours_utc, referee_1_id, referee_2_id, referee_3_id) VALUES "
        f"({game_id}, 1, 1, {team_home_id}, {team_guest_id}, {match['home_final_score']}, {match['visitor_final_score']}, "
        f"{match_timestamp}, 1, 2, 3);\n"
    )

    ############################################################# scrittura dei quintetti presenti in campo
    # Funzione di supporto per ottenere nome giocatore formattato
    # Filtra e ordina i cambi
    cambi = [a for a in actions if a["description"] in ["Ingresso", "Uscita"]]

    # Inizializza strutture
    in_field_home = set()
    in_field_guest = set()
    id_to_name = {}
    seen_ingressi = set()

    for action in cambi:
        pid = action["player_id"]
        team = action["team_id"]
        if action["description"] == "Ingresso":
            seen_ingressi.add(pid)

    # Trova i 10 iniziali
    for action in cambi:
        if action["description"] == "Uscita" and action["player_id"] not in seen_ingressi:
            if action["team_id"] == team_home_id:
                in_field_home.add(action["player_id"])
            elif action["team_id"] == team_guest_id:
                in_field_guest.add(action["player_id"])

    # Lista quintetti da scrivere
    quintetti_log = []

    # Aggiungi quintetti iniziali
    quintetti_log.append({
        "period": 0,
        "minute": 0,
        "seconds": 0,
        "tot_seconds": 0,
        "home_quintet": in_field_home.copy(),
        "guest_quintet": in_field_guest.copy(),
    })

    # Simulazione dei cambi
    current_home = in_field_home.copy()
    current_guest = in_field_guest.copy()
    cambi_by_time = groupby(cambi, key=itemgetter("period", "minute", "seconds"))

    for (period, minute, seconds), group in cambi_by_time:
        group = list(group)
        for action in group:
            pid = action["player_id"]
            team = action["team_id"]

            if team == team_home_id:
                team_set = current_home
            elif team == team_guest_id:
                team_set = current_guest
            else:
                continue

            if action["description"] == "Uscita":
                if pid not in team_set:
                    # Aggiungi il giocatore a tutti i quintetti precedenti
                    for q in quintetti_log:
                        if team == team_home_id:
                            if pid not in q["home_quintet"]:
                                q["home_quintet"].add(pid)
                        elif team == team_guest_id:
                            if pid not in q["guest_quintet"]:
                                q["guest_quintet"].add(pid)
                team_set.discard(pid)
            elif action["description"] == "Ingresso":
                team_set.add(pid)

        quintetti_log.append({
            "period": period,
            "minute": minute,
            "seconds": seconds,
            "tot_seconds": ((period-1)*600) + (minute*60) + (seconds),
            "home_quintet": current_home.copy(),
            "guest_quintet": current_guest.copy(),
        })

    # Ora scrivi tutti i quintetti in fondo
    #f.write("-- Quintetti aggiornati durante i cambi (compreso l'iniziale)\n")
    #for q in quintetti_log:
        #f.write(f"-- Periodo {q['period']}, Minuto {q['minute']}, Secondi {q['seconds']}\n")
        #f.write(f"-- Quintetto Home : {q['home_quintet']}\n")
        #f.write(f"-- Quintetto Guest: {q['guest_quintet']}\n\n")


    ####################################################### definizione dei possessi
    # Azioni che determinano fine possesso
    # Ordina le azioni
    ordered_actions = sorted(
        actions,
        key=lambda a: (a["period"], a["minute"], a["seconds"], a.get("action_id") or 0)
    )

    # Filtra le azioni rilevanti (no Ingresso/Uscita e serve team_name)
    exclude_keywords = {"Ingresso", "Uscita"}
    filtered_actions = [
        a for a in ordered_actions
        if a["description"] not in exclude_keywords and a.get("team_id")
    ]

    # Regole di chiusura possesso
    poss_end_keywords = {
        "Rimbalzo difensivo",
        "Rimbalzi difensivi di squadra",
        "3 punti segnato",
        "2 punti segnato",
        "Palla persa",
        "Fine Tempo",
        "Palle perse di squadra",
        "Assist",
    }

    def is_end_of_possession(action, next_action=None, pre_action=None):
        desc = action["description"]
        if desc == "Tiro libero segnato":
            return not (next_action and next_action["description"] == "Tiro libero segnato") and not (next_action and next_action["description"] == "Assist")
        elif desc == "3 punti segnato" or desc == "2 punti segnato":
            return not (next_action and next_action["description"] == "Assist") and not (next_action and next_action["description"] == "Fallo commesso")
        elif desc == "Palla persa":
            return not (next_action and next_action["description"] == "Fallo Subito") and not (next_action and next_action["description"] == "Palla recuperata")
        elif desc == "Fallo Subito":
            return (pre_action and pre_action["description"] == "Palla persa")
        elif desc == "Palla recuperata":
            return (pre_action and pre_action["description"] == "Palla persa")
        else:
            return desc in poss_end_keywords

    def team_possession(action):
        desc = action["description"]
        if desc == "Rimbalzo difensivo" or desc == "Rimbalzi difensivi di squadra" or desc == "Fallo Subito" or desc == "Palla recuperata":
            if action["team_id"] == team_home_id:
                return team_guest_id
            else:
                return team_home_id
        elif desc == "3 punti segnato" or desc == "2 punti segnato" or desc == "Palla persa" or desc == "Palle perse di squadra" or desc == "Assist" or desc == "Tiro libero segnato":
            if action["team_id"] == team_home_id:
                return team_home_id
            else:
                return team_guest_id
        elif desc == "Fine Tempo":
            return action["team_id"]


    # Nuova logica: il possesso termina solo su evento, e appartiene alla squadra dell'ultima azione
    possessions = []
    current_possession = []

    for i, action in enumerate(filtered_actions):
        current_possession.append(action)
        next_action = filtered_actions[i + 1] if i + 1 < len(filtered_actions) else None
        pre_action = filtered_actions[i - 1] if i - 1 > 0 else None

        if is_end_of_possession(action, next_action, pre_action):
            last_team = team_possession(action)
            possessions.append({
                "team": last_team,
                "start": current_possession[0],
                "end": current_possession[-1],
                "actions": current_possession.copy()
            })
            current_possession = []

    # Coda finale (se rimasto qualcosa)
    if current_possession:
        last_team = current_possession[-1]["team_id"]
        possessions.append({
            "team": last_team,
            "start": current_possession[0],
            "end": current_possession[-1],
            "actions": current_possession.copy()
        })



    # Set per tenere traccia delle coppie già viste
    player_team_set = set()

    for q in quintetti_log:
        for pid in q["home_quintet"]:
            player_team_set.add((pid, team_home_id))
        for pid in q["guest_quintet"]:
            player_team_set.add((pid, team_guest_id))

    # Scrivi le INSERT
    #f.write("-- INSERT player_team_game da quintetti_log\n")
    for player_id, team_id in sorted(player_team_set):
        f.write(f"INSERT INTO lba.player_team_game(player_id, team_id, game_id) VALUES({player_id}, {team_id}, {game_id});\n")

    #f.write("-- Azioni dettagliate per ogni possesso (logica corretta basata su eventi)\n")
    for idx, p in enumerate(possessions, start=0):
        #f.write(f"-- Possesso #{idx} - Squadra: {p['team']}\n")
#creazione insert di play
        p["actions"].sort(key=lambda a: a["action_id"])

        pre_period = possessions[idx - 1] if idx - 1 >= 0 else None
        start = 0
        if pre_period:
            last_pre_period = None
            for action in pre_period["actions"]:
                last_pre_period = action
            start = ((last_pre_period["period"]-1)*600) + (last_pre_period["minute"]*60) + (last_pre_period["seconds"])
        
        last_period = None
        for action in p["actions"]:
            last_period = action
        
        if idx + 1 < len(possessions):
            end = ((last_period["period"]-1)*600) + (last_period["minute"]*60) + (last_period["seconds"])
        else:
            end = 2400

        home = 0
        score_h, score_g = map(int, last_period["score"].split(" - "))

        if p['team'] == team_home_id:
            home = 1

        play_id = play_id + 1
        f.write(f"INSERT INTO play(id, game_id, seconds_start, seconds_end, quarter, attack_home_01, score_home, score_guest)VALUES({play_id}, {game_id}, {start}, {end}, {last_period["period"]}, '{home}', {score_h}, {score_g});\n")
#creazione insert di play_player
# Salva lo stato iniziale
        quintetti_log.sort(key=lambda q: q["tot_seconds"])
        quintetti_nel_range = [
            q for q in quintetti_log
            if start <= q["tot_seconds"] <= end
        ]

        if start != 0:
            quintetto_iniziale = [q for q in quintetti_log if q["tot_seconds"] < start][-1]
        else:
            quintetto_iniziale = [q for q in quintetti_log if q["tot_seconds"] <= start][-1]

        q_inizio = quintetto_iniziale
        giocatori_gia_inseriti_home = set(q_inizio['home_quintet'])
        giocatori_gia_inseriti_guest = set(q_inizio['guest_quintet'])

        # Scrivi i 10 iniziali
        for idp in q_inizio['home_quintet']:
            f.write(f"INSERT INTO player_team_game_play(player_id, team_id, game_id, play_id, seconds_start, seconds_end) VALUES({idp}, {team_home_id}, {game_id}, {play_id}, {start}, {end});\n")
        for idp in q_inizio['guest_quintet']:
            f.write(f"INSERT INTO player_team_game_play(player_id, team_id, game_id, play_id, seconds_start, seconds_end) VALUES({idp}, {team_guest_id}, {game_id}, {play_id}, {start}, {end});\n")

        # Applichiamo i cambi interni
        prev_home = set(q_inizio['home_quintet'])
        prev_guest = set(q_inizio['guest_quintet'])

        for q in quintetti_nel_range:
            current_home = set(q['home_quintet'])
            current_guest = set(q['guest_quintet'])
            t = q['tot_seconds']

            # Giocatori usciti dalla home
            usciti_home = prev_home - current_home
            # Giocatori entrati nella home
            entrati_home = current_home - prev_home

            for idp in usciti_home:
                f.write(f"UPDATE player_team_game_play SET seconds_end = {t} WHERE player_id = {idp} AND game_id = {game_id} AND play_id = {play_id};\n")
            for idp in entrati_home:
                if idp not in giocatori_gia_inseriti_home:
                    f.write(f"INSERT INTO player_team_game_play(player_id, team_id, game_id, play_id, seconds_start, seconds_end) VALUES({idp}, {team_home_id}, {game_id}, {play_id}, {t}, {end});\n")
                    giocatori_gia_inseriti_home.add(idp)

            # Stessa cosa per guest
            usciti_guest = prev_guest - current_guest
            entrati_guest = current_guest - prev_guest

            for idp in usciti_guest:
                f.write(f"UPDATE player_team_game_play SET seconds_end = {t} WHERE player_id = {idp} AND game_id = {game_id} AND play_id = {play_id};\n")
            for idp in entrati_guest:
                if idp not in giocatori_gia_inseriti_guest:
                    f.write(f"INSERT INTO player_team_game_play(player_id, team_id, game_id, play_id, seconds_start, seconds_end) VALUES({idp}, {team_guest_id}, {game_id}, {play_id}, {t}, {end});\n")
                    giocatori_gia_inseriti_guest.add(idp)

            # Aggiorna lo stato corrente
            prev_home = current_home
            prev_guest = current_guest


        for action in p["actions"]:

            # Mappatura campi speciali
            desc = action.get("description")
            qual = action.get("action_1_qualifier_description")

            if desc == "Fallo Subito" or desc == "Stoppata subita" or desc == "Palla recuperata" or desc == "Palla contesa":
                continue  # salta, gestiamo solo quelle principali

            # Calcolo del tempo dall'inizio del possesso
            seconds_da_start = (((action["period"]-1)*600) + (action["minute"]*60) + (action["seconds"])) - start


            player_made_id = action.get("player_id", "NULL")
            team_made_id = action.get("team_id", "NULL")
            # Cerca linked action per il suffered
            # Descrizione che ci aspettiamo nella linked
            linked_expected_desc = linked_description_map.get(desc)

            linked_actions = []
            if linked_expected_desc:
                # Cerchiamo solo le linked che hanno anche la descrizione giusta
                if linked_expected_desc != 'Stoppata subita':
                    linked_actions = [
                        a for a in p["actions"]
                        if a.get("linked_action_id") == action["action_id"]
                        and a.get("description") == linked_expected_desc
                    ]
                else:
                    linked_actions = [
                        a for a in p["actions"]
                        if a.get("linked_action_id") == action["linked_action_id"]
                        and a.get("description") == linked_expected_desc
                    ]


            if not linked_actions:
                player_suffered_id = "NULL"
                team_suffered_id = "NULL"
                game_suffered_id = "NULL"
            else:
                linked = linked_actions[0]
                player_suffered_id = linked.get("player_id", "NULL")
                team_suffered_id = linked.get("team_id", "NULL")
                game_suffered_id = game_id

            shot_id = shot_map.get(desc, "NULL")

            turnover_id = "NULL"
            if desc == "Palla persa":
                turnover_id = turnover_map.get(qual, 13 if qual is None else 13)

            foul_id = "NULL"
            if desc == "Fallo commesso":
                foul_id = foul_map.get(qual, "NULL")

            rebound_defensive_01 = '1' if desc == "Rimbalzo difensivo" else ''
            rebound_offensive_01 = '1' if desc == "Rimbalzo offensivo" else ''
            assist_01 = '1' if desc == "Assist" else ''
            blocks_01 = '1' if desc == "Stoppata" else ''
            time_out_01 = '1' if desc == "Time Out" else ''

            x = action.get("x")
            y = action.get("y")

            x_val = x if x is not None else "NULL"
            y_val = y if y is not None else "NULL"

            if team_made_id is None or player_made_id is None:
                continue

            if player_made_id not in giocatori_gia_inseriti_guest and player_made_id not in giocatori_gia_inseriti_home:
                f.write(f"INSERT INTO player_team_game_play(player_id, team_id, game_id, play_id, seconds_start, seconds_end) VALUES({player_made_id}, {team_made_id}, {game_id}, {play_id}, {start}, {end});\n")
                giocatori_gia_inseriti_guest.add(player_made_id)
            if player_suffered_id != "NULL":
                if player_suffered_id not in giocatori_gia_inseriti_guest and player_suffered_id not in giocatori_gia_inseriti_home:
                    f.write(f"INSERT INTO player_team_game_play(player_id, team_id, game_id, play_id, seconds_start, seconds_end) VALUES({player_suffered_id}, {team_suffered_id}, {game_id}, {play_id}, {start}, {end});\n")
                    giocatori_gia_inseriti_guest.add(player_suffered_id)


            f.write(
                "INSERT INTO lba.sub_play "
                "(play_id, seconds_da_start, player_made_id, team_made_id, game_made_id, "
                "player_suffered_id, team_suffered_id, game_suffered_id, "
                "shot_id, turnover_id, foul_id, rebound_defensive_01, rebound_offensive_01, "
                "assist_01, blocks_01, time_out_01, x, y)"
                f"VALUES({play_id}, {seconds_da_start}, {player_made_id}, {team_made_id}, {game_id}, "
                f"{player_suffered_id}, {team_suffered_id}, {game_suffered_id}, "
                f"{shot_id}, {turnover_id}, {foul_id}, "
                f"'{rebound_defensive_01}', '{rebound_offensive_01}', '{assist_01}', "
                f"'{blocks_01}', '{time_out_01}', {x_val}, {y_val});\n"
            )

        for action in p["actions"]:
            period = action["period"]
            minute = action["minute"]
            seconds = action["seconds"]
            desc = action["description"]
            name = action.get("player_name", "")
            surname = action.get("player_surname", "")
            number = action.get("player_number", "")
            player_str = f"{name} {surname}".strip() + (f" (#{number})" if number else "")
            #f.write(f"--   [{period}-{minute}:{seconds:02}] {desc} - {player_str}\n")
        f.write("\n")

if f:
    f.close()