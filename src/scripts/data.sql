INSERT INTO lba.team
(id, name, logo_url)
VALUES(1, 'EA7 Emporio Armani Milano', 'https://lba-media.s3.eu-south-1.amazonaws.com/3foUZjx8QLznxMz1ZYDdqoWH');
INSERT INTO lba.team
(id, name, logo_url)
VALUES(2, 'Virtus Segafredo Bologna', 'https://lba-media.s3.eu-south-1.amazonaws.com/f1wqLAuPXWrvRrQnZb9CxFN1');
INSERT INTO lba.team
(id, name, logo_url)
VALUES(3, 'Umana Reyer Venezia', 'https://lba-media.s3.eu-south-1.amazonaws.com/QHN2KbVQQpDgGwT7CYrGciek');
INSERT INTO lba.team
(id, name, logo_url)
VALUES(4, 'Dolomiti Energia Trentino', 'https://lba-media.s3.eu-south-1.amazonaws.com/s5EcVfJudL9hL8RTCtYrhsYz');
INSERT INTO lba.team
(id, name, logo_url)
VALUES(5, 'Germani Brescia', 'https://lba-media.s3.eu-south-1.amazonaws.com/FbjnjNui3pJii4UoTUHJsoWr');
INSERT INTO lba.team
(id, name, logo_url)
VALUES(6, 'Banco di Sardegna Sassari', 'https://lba-media.s3.eu-south-1.amazonaws.com/ZdDK2bEpxmZngCshUBrtDZKi');
INSERT INTO lba.team
(id, name, logo_url)
VALUES(7, 'Napolibasket', 'https://lba-media.s3.eu-south-1.amazonaws.com/9MxckBSz3B7iD1E5oxUmyXbA');
INSERT INTO lba.team
(id, name, logo_url)
VALUES(8, 'Trapani Shark', 'https://lba-media.s3.eu-south-1.amazonaws.com/WvGYhjeQEb7H8zNZGncpCFiL');
INSERT INTO lba.team
(id, name, logo_url)
VALUES(9, 'Openjobmetis Varese', 'https://lba-media.s3.eu-south-1.amazonaws.com/LbsfVfYPLfc48uRV4DYtZHpJ');
INSERT INTO lba.team
(id, name, logo_url)
VALUES(10, 'UNAHOTELS Reggio Emilia', 'https://lba-media.s3.eu-south-1.amazonaws.com/QJYDAWxPLKk3a4noAz67J3jq');
INSERT INTO lba.team
(id, name, logo_url)
VALUES(11, 'Bertram Derthona Tortona', 'https://lba-media.s3.eu-south-1.amazonaws.com/LwweSUMoSmT3UfbQ5RHL4i3c');
INSERT INTO lba.team
(id, name, logo_url)
VALUES(12, 'Givova Scafati', 'https://lba-media.s3.eu-south-1.amazonaws.com/jpF39uNp5E4EcWcSWSDYt1pb');
INSERT INTO lba.team
(id, name, logo_url)
VALUES(13, 'Pallacanestro Trieste', 'https://lba-media.s3.eu-south-1.amazonaws.com/fG1iaynEv5fKwTqJAjaLy5aX');
INSERT INTO lba.team
(id, name, logo_url)
VALUES(14, 'Vanoli Basket Cremona', 'https://lba-media.s3.eu-south-1.amazonaws.com/JnqS2vY6pzamCQnXkNAyn5pW');
INSERT INTO lba.team
(id, name, logo_url)
VALUES(15, 'Estra Pistoia', 'https://lba-media.s3.eu-south-1.amazonaws.com/CYWVb8hjAugrTtQ9Uu2SZEtF');
INSERT INTO lba.team
(id, name, logo_url)
VALUES(16, 'NutriBullet Treviso Basket', 'https://lba-media.s3.eu-south-1.amazonaws.com/5Sxj77afD5Qufy9zifKW1HoB');


INSERT INTO lba.card_type
(id, description)
VALUES('GAME', 'Card per analisi partite');
INSERT INTO lba.card_type
(id, description)
VALUES('PLAYER', 'Card per analisi giocatori');
INSERT INTO lba.card_type
(id, description)
VALUES('TEAM', 'Card per analisi squadre');

INSERT INTO lba.card
(card_id, card_type_id, description)
VALUES('CALENDAR_PLAYER', 'PLAYER', 'Calendar');
INSERT INTO lba.card
(card_id, card_type_id, description)
VALUES('CALENDAR_TEAM', 'TEAM', 'Calendar');
INSERT INTO lba.card
(card_id, card_type_id, description)
VALUES('LINE_CONSECUTIVE_MINUTES_PLAYED', 'PLAYER', 'Area consecutive minutes played');
INSERT INTO lba.card
(card_id, card_type_id, description)
VALUES('LINE_GAME_GAME', 'GAME', 'Area minutes game');
INSERT INTO lba.card
(card_id, card_type_id, description)
VALUES('LINE_GAME_PLAYER', 'PLAYER', 'Area minutes game');
INSERT INTO lba.card
(card_id, card_type_id, description)
VALUES('LINE_GAME_TEAM', 'TEAM', 'Area minutes game');
INSERT INTO lba.card
(card_id, card_type_id, description)
VALUES('LINE_MINUTES_PLAYED', 'PLAYER', 'Area minutes played');
INSERT INTO lba.card
(card_id, card_type_id, description)
VALUES('LINE_PLAY_GAME', 'GAME', 'Area seconds play');
INSERT INTO lba.card
(card_id, card_type_id, description)
VALUES('LINE_PLAY_PLAYER', 'PLAYER', 'Area seconds play');
INSERT INTO lba.card
(card_id, card_type_id, description)
VALUES('LINE_PLAY_TEAM', 'TEAM', 'Area seconds play');
INSERT INTO lba.card
(card_id, card_type_id, description)
VALUES('LINE_QUARTER_GAME', 'GAME', 'Area minutes quarter');
INSERT INTO lba.card
(card_id, card_type_id, description)
VALUES('LINE_QUARTER_PLAYER', 'PLAYER', 'Area minutes quarter');
INSERT INTO lba.card
(card_id, card_type_id, description)
VALUES('LINE_QUARTER_TEAM', 'TEAM', 'Area minutes quarter');
INSERT INTO lba.card
(card_id, card_type_id, description)
VALUES('RADAR_PLAYER_GAME', 'GAME', 'Radar');
INSERT INTO lba.card
(card_id, card_type_id, description)
VALUES('RADAR_PLAYER_TEAM', 'TEAM', 'Radar');
INSERT INTO lba.card
(card_id, card_type_id, description)
VALUES('SCATTER_3STAT_TEAM', 'TEAM', 'Scatter team');
INSERT INTO lba.card
(card_id, card_type_id, description)
VALUES('SCATTER_3STAT_GAME', 'GAME', 'Scatter game');
INSERT INTO lba.card
(card_id, card_type_id, description)
VALUES('TABLE_LINEUP_GAME', 'GAME', 'Table lineup');
INSERT INTO lba.card
(card_id, card_type_id, description)
VALUES('TABLE_LINEUP_TEAM', 'TEAM', 'Table lineup');
INSERT INTO lba.card
(card_id, card_type_id, description)
VALUES('TABLE_PLAYER_GAME', 'GAME', 'Table player');
INSERT INTO lba.card
(card_id, card_type_id, description)
VALUES('TABLE_PLAYER_TEAM', 'TEAM', 'Table player');

INSERT INTO lba.card_settings
(card_id, setting_id, description, default_value, possible_values)
VALUES('LINE_CONSECUTIVE_MINUTES_PLAYED', 'Y', 'Asse Y', '"three_point_shot_ratio"', '["one_point_shots_made", "one_point_shots_miss", "two_point_shots_made", "two_point_shots_miss", "three_point_shots_made", "three_point_shots_miss", "one_point_shot_ratio", "two_point_shot_ratio", "three_point_shot_ratio"]');
INSERT INTO lba.card_settings
(card_id, setting_id, description, default_value, possible_values)
VALUES('LINE_GAME_GAME', 'Y', 'Asse Y', '"three_point_shot_ratio"', '["one_point_shots_made", "one_point_shots_miss", "two_point_shots_made", "two_point_shots_miss", "three_point_shots_made", "three_point_shots_miss", "one_point_shot_ratio", "two_point_shot_ratio", "three_point_shot_ratio"]');
INSERT INTO lba.card_settings
(card_id, setting_id, description, default_value, possible_values)
VALUES('LINE_GAME_PLAYER', 'Y', 'Asse Y', '"three_point_shot_ratio"', '["one_point_shots_made", "one_point_shots_miss", "two_point_shots_made", "two_point_shots_miss", "three_point_shots_made", "three_point_shots_miss", "one_point_shot_ratio", "two_point_shot_ratio", "three_point_shot_ratio"]');
INSERT INTO lba.card_settings
(card_id, setting_id, description, default_value, possible_values)
VALUES('LINE_GAME_TEAM', 'Y', 'Asse Y', '"three_point_shot_ratio"', '["one_point_shots_made", "one_point_shots_miss", "two_point_shots_made", "two_point_shots_miss", "three_point_shots_made", "three_point_shots_miss", "one_point_shot_ratio", "two_point_shot_ratio", "three_point_shot_ratio"]');
INSERT INTO lba.card_settings
(card_id, setting_id, description, default_value, possible_values)
VALUES('LINE_MINUTES_PLAYED', 'Y', 'Asse Y', '"three_point_shot_ratio"', '["one_point_shots_made", "one_point_shots_miss", "two_point_shots_made", "two_point_shots_miss", "three_point_shots_made", "three_point_shots_miss", "one_point_shot_ratio", "two_point_shot_ratio", "three_point_shot_ratio"]');
INSERT INTO lba.card_settings
(card_id, setting_id, description, default_value, possible_values)
VALUES('LINE_PLAY_GAME', 'Y', 'Asse Y', '"three_point_shot_ratio"', '["one_point_shots_made", "one_point_shots_miss", "two_point_shots_made", "two_point_shots_miss", "three_point_shots_made", "three_point_shots_miss", "one_point_shot_ratio", "two_point_shot_ratio", "three_point_shot_ratio"]');
INSERT INTO lba.card_settings
(card_id, setting_id, description, default_value, possible_values)
VALUES('LINE_PLAY_PLAYER', 'Y', 'Asse Y', '"three_point_shot_ratio"', '["one_point_shots_made", "one_point_shots_miss", "two_point_shots_made", "two_point_shots_miss", "three_point_shots_made", "three_point_shots_miss", "one_point_shot_ratio", "two_point_shot_ratio", "three_point_shot_ratio"]');
INSERT INTO lba.card_settings
(card_id, setting_id, description, default_value, possible_values)
VALUES('LINE_PLAY_TEAM', 'Y', 'Asse Y', '"three_point_shot_ratio"', '["one_point_shots_made", "one_point_shots_miss", "two_point_shots_made", "two_point_shots_miss", "three_point_shots_made", "three_point_shots_miss", "one_point_shot_ratio", "two_point_shot_ratio", "three_point_shot_ratio"]');
INSERT INTO lba.card_settings
(card_id, setting_id, description, default_value, possible_values)
VALUES('LINE_QUARTER_GAME', 'Y', 'Asse Y', '"three_point_shot_ratio"', '["one_point_shots_made", "one_point_shots_miss", "two_point_shots_made", "two_point_shots_miss", "three_point_shots_made", "three_point_shots_miss", "one_point_shot_ratio", "two_point_shot_ratio", "three_point_shot_ratio"]');
INSERT INTO lba.card_settings
(card_id, setting_id, description, default_value, possible_values)
VALUES('LINE_QUARTER_PLAYER', 'Y', 'Asse Y', '"three_point_shot_ratio"', '["one_point_shots_made", "one_point_shots_miss", "two_point_shots_made", "two_point_shots_miss", "three_point_shots_made", "three_point_shots_miss", "one_point_shot_ratio", "two_point_shot_ratio", "three_point_shot_ratio"]');
INSERT INTO lba.card_settings
(card_id, setting_id, description, default_value, possible_values)
VALUES('LINE_QUARTER_TEAM', 'Y', 'Asse Y', '"three_point_shot_ratio"', '["one_point_shots_made", "one_point_shots_miss", "two_point_shots_made", "two_point_shots_miss", "three_point_shots_made", "three_point_shots_miss", "one_point_shot_ratio", "two_point_shot_ratio", "three_point_shot_ratio"]');
INSERT INTO lba.card_settings
(card_id, setting_id, description, default_value, possible_values)
VALUES('RADAR_PLAYER_GAME', 'STAT', 'Stat', '["one_point_shots_made", "one_point_shots_miss", "two_point_shots_made", "two_point_shots_miss", "three_point_shots_made", "three_point_shots_miss", "one_point_shot_ratio", "two_point_shot_ratio", "three_point_shot_ratio"]', '["one_point_shots_made", "one_point_shots_miss", "two_point_shots_made", "two_point_shots_miss", "three_point_shots_made", "three_point_shots_miss", "one_point_shot_ratio", "two_point_shot_ratio", "three_point_shot_ratio"]');
INSERT INTO lba.card_settings
(card_id, setting_id, description, default_value, possible_values)
VALUES('RADAR_PLAYER_TEAM', 'STAT', 'Stat', '["one_point_shots_made", "one_point_shots_miss", "two_point_shots_made", "two_point_shots_miss", "three_point_shots_made", "three_point_shots_miss", "one_point_shot_ratio", "two_point_shot_ratio", "three_point_shot_ratio"]', '["one_point_shots_made", "one_point_shots_miss", "two_point_shots_made", "two_point_shots_miss", "three_point_shots_made", "three_point_shots_miss", "one_point_shot_ratio", "two_point_shot_ratio", "three_point_shot_ratio"]');
INSERT INTO lba.card_settings
(card_id, setting_id, description, default_value, possible_values)
VALUES('SCATTER_3STAT_TEAM', '1', '1', '"three_point_shot_ratio"', '["one_point_shots_made", "one_point_shots_miss", "two_point_shots_made", "two_point_shots_miss", "three_point_shots_made", "three_point_shots_miss", "one_point_shot_ratio", "two_point_shot_ratio", "three_point_shot_ratio"]');
INSERT INTO lba.card_settings
(card_id, setting_id, description, default_value, possible_values)
VALUES('SCATTER_3STAT_TEAM', '2', '2', '"three_point_shot_ratio"', '["one_point_shots_made", "one_point_shots_miss", "two_point_shots_made", "two_point_shots_miss", "three_point_shots_made", "three_point_shots_miss", "one_point_shot_ratio", "two_point_shot_ratio", "three_point_shot_ratio"]');
INSERT INTO lba.card_settings
(card_id, setting_id, description, default_value, possible_values)
VALUES('SCATTER_3STAT_TEAM', '3', '3', '"three_point_shot_ratio"', '["one_point_shots_made", "one_point_shots_miss", "two_point_shots_made", "two_point_shots_miss", "three_point_shots_made", "three_point_shots_miss", "one_point_shot_ratio", "two_point_shot_ratio", "three_point_shot_ratio"]');
INSERT INTO lba.card_settings
(card_id, setting_id, description, default_value, possible_values)
VALUES('SCATTER_3STAT_GAME', '1', '1', '"three_point_shot_ratio"', '["one_point_shots_made", "one_point_shots_miss", "two_point_shots_made", "two_point_shots_miss", "three_point_shots_made", "three_point_shots_miss", "one_point_shot_ratio", "two_point_shot_ratio", "three_point_shot_ratio"]');
INSERT INTO lba.card_settings
(card_id, setting_id, description, default_value, possible_values)
VALUES('SCATTER_3STAT_GAME', '2', '2', '"three_point_shot_ratio"', '["one_point_shots_made", "one_point_shots_miss", "two_point_shots_made", "two_point_shots_miss", "three_point_shots_made", "three_point_shots_miss", "one_point_shot_ratio", "two_point_shot_ratio", "three_point_shot_ratio"]');
INSERT INTO lba.card_settings
(card_id, setting_id, description, default_value, possible_values)
VALUES('SCATTER_3STAT_GAME', '3', '3', '"three_point_shot_ratio"', '["one_point_shots_made", "one_point_shots_miss", "two_point_shots_made", "two_point_shots_miss", "three_point_shots_made", "three_point_shots_miss", "one_point_shot_ratio", "two_point_shot_ratio", "three_point_shot_ratio"]');
INSERT INTO lba.card_settings
(card_id, setting_id, description, default_value, possible_values)
VALUES('TABLE_LINEUP_GAME', 'STAT', 'Stat', '["one_point_shots_made", "one_point_shots_miss", "two_point_shots_made", "two_point_shots_miss", "three_point_shots_made", "three_point_shots_miss", "one_point_shot_ratio", "two_point_shot_ratio", "three_point_shot_ratio"]', '["one_point_shots_made", "one_point_shots_miss", "two_point_shots_made", "two_point_shots_miss", "three_point_shots_made", "three_point_shots_miss", "one_point_shot_ratio", "two_point_shot_ratio", "three_point_shot_ratio"]');
INSERT INTO lba.card_settings
(card_id, setting_id, description, default_value, possible_values)
VALUES('TABLE_LINEUP_TEAM', 'STAT', 'Stat', '["one_point_shots_made", "one_point_shots_miss", "two_point_shots_made", "two_point_shots_miss", "three_point_shots_made", "three_point_shots_miss", "one_point_shot_ratio", "two_point_shot_ratio", "three_point_shot_ratio"]', '["one_point_shots_made", "one_point_shots_miss", "two_point_shots_made", "two_point_shots_miss", "three_point_shots_made", "three_point_shots_miss", "one_point_shot_ratio", "two_point_shot_ratio", "three_point_shot_ratio"]');
INSERT INTO lba.card_settings
(card_id, setting_id, description, default_value, possible_values)
VALUES('TABLE_PLAYER_GAME', 'STAT', 'Stat', '["one_point_shots_made", "one_point_shots_miss", "two_point_shots_made", "two_point_shots_miss", "three_point_shots_made", "three_point_shots_miss", "one_point_shot_ratio", "two_point_shot_ratio", "three_point_shot_ratio"]', '["one_point_shots_made", "one_point_shots_miss", "two_point_shots_made", "two_point_shots_miss", "three_point_shots_made", "three_point_shots_miss", "one_point_shot_ratio", "two_point_shot_ratio", "three_point_shot_ratio"]');
INSERT INTO lba.card_settings
(card_id, setting_id, description, default_value, possible_values)
VALUES('TABLE_PLAYER_TEAM', 'STAT', 'Stat', '["one_point_shots_made", "one_point_shots_miss", "two_point_shots_made", "two_point_shots_miss", "three_point_shots_made", "three_point_shots_miss", "one_point_shot_ratio", "two_point_shot_ratio", "three_point_shot_ratio"]', '["one_point_shots_made", "one_point_shots_miss", "two_point_shots_made", "two_point_shots_miss", "three_point_shots_made", "three_point_shots_miss", "one_point_shot_ratio", "two_point_shot_ratio", "three_point_shot_ratio"]');

INSERT INTO user (`username`, `password`, `team_id`) VALUES('ale', 'ale', 1);
INSERT INTO user (`username`, `password`, `team_id`) VALUES('test', 'test', 1);
-- Inserimento nella tabella `type_league`
INSERT INTO `type_league` (`description`) VALUES ('Campionato Nazionale');

-- Recupero dell'ID dell'ultima `type_league` inserita
SET @type_league_id = LAST_INSERT_ID();

-- Inserimento nella tabella `league`
INSERT INTO `league` (`name`, `description`, `type_league_id`)
VALUES ('LBA', 'Lega Basket Serie A', @type_league_id);

-- Recupero dell'ID della `league` inserita
SET @league_id = LAST_INSERT_ID();

-- Inserimento nella tabella `type_game`
INSERT INTO `type_game` (`description`) VALUES ('Regular Season');

-- Recupero dell'ID del `type_game`
SET @type_game_id = LAST_INSERT_ID();

-- Associazione `type_league` e `type_game`
INSERT INTO `type_league_type_game` (`type_league_id`, `type_game_id`)
VALUES (@type_league_id, @type_game_id);

-- Inserimento nella tabella `league_year`
INSERT INTO `league_year` (`league_id`, `date_start_utc`, `date_end_utc`)
VALUES (@league_id, UNIX_TIMESTAMP(STR_TO_DATE('01-09-2024', '%d-%m-%Y')), UNIX_TIMESTAMP(STR_TO_DATE('30-06-2025', '%d-%m-%Y')));

-- Dizionario dei tiri
INSERT INTO `dz_shot` (`description`, `point`, `made_01`) VALUES
('2 punti segnato', 2, '1'),
('2 punti sbagliato', 2, '0'),
('3 punti segnato', 3, '1'),
('3 punti sbagliato', 3, '0'),
('Tiro libero segnato', 1, '1'),
('Tiro libero sbagliato', 1, '0');

-- Dizionario dei falli
INSERT INTO `dz_foul` (`description`) VALUES
('personale'),
('tecnico'),
('antisportivo'),
('tiro'),
('doppio'),
('antisportivo su tiro'),
('offensivo'),
('espulsione'),
('espulsione su tiro'),
('compensazione');

-- Dizionario dei turnover (palle perse)
INSERT INTO `dz_turnover` (`description`) VALUES
('Passaggio sbagliato'),
('Palleggio'),
('Doppio Palleggio'),
('Passi'),
('Fuori dal campo'),
('Infrazione di campo'),
('3 secondi'),
('5 secondi'),
('Interferenza a canestro in attacco'),
('Altro'),
('8 Secondi'),
('24 Secondi');

-- Popolamento tabella `referee` con alcuni arbitri
INSERT INTO `referee` (`name`, `surname`) VALUES
('Marco', 'Pesenti'),
('Luca', 'Pancotto'),
('Alessandro', 'Cremonini'),
('Davide', 'Santi');

-- Popolamento tabella `trainer` con gli allenatori delle squadre
INSERT INTO `trainer` (`name`, `surname`) VALUES
('Christian', 'Jamion'),
('Ivanovic', 'Dusko');

-- Popolamento tabella `trainer_team`
INSERT INTO lba.trainer_team
(trainer_id, team_id, date_start_utc, date_end_utc)
VALUES(1, 13, 1725926400, NULL);
INSERT INTO lba.trainer_team
(trainer_id, team_id, date_start_utc, date_end_utc)
VALUES(2, 2, 1725926400, NULL);

-- Popolamento tabella `player` con 10 giocatori per squadra 160 totali
INSERT INTO lba.player(name, surname, logo_url)VALUES('Kevin', 'Acciari', 'https://www.legabasket.it/_next/static/media/AvatarPlaceholder.64b5f792.svg');
INSERT INTO lba.player_team(player_id, team_id, `number`)VALUES(LAST_INSERT_ID(), 9, 19);
INSERT INTO lba.player(name, surname, logo_url)VALUES('Matteo', 'Accorsi', 'https://www.legabasket.it/_next/static/media/AvatarPlaceholder.64b5f792.svg');
INSERT INTO lba.player_team(player_id, team_id, `number`)VALUES(LAST_INSERT_ID(), 2, 2);
INSERT INTO lba.player(name, surname, logo_url)VALUES('Thomas', 'Acunzo', 'https://www.legabasket.it/_next/static/media/AvatarPlaceholder.64b5f792.svg');
INSERT INTO lba.player_team(player_id, team_id, `number`)VALUES(LAST_INSERT_ID(), 7, 7);
INSERT INTO lba.player(name, surname, logo_url)VALUES('Lorenzo', 'Agostini', 'https://www.legabasket.it/_next/static/media/AvatarPlaceholder.64b5f792.svg');
INSERT INTO lba.player_team(player_id, team_id, `number`)VALUES(LAST_INSERT_ID(), 15, 0);
INSERT INTO lba.player(name, surname, logo_url)VALUES('Nicola', 'Akele', 'https://www.legabasket.it/_next/static/media/AvatarPlaceholder.64b5f792.svg');
INSERT INTO lba.player_team(player_id, team_id, `number`)VALUES(LAST_INSERT_ID(), 2, 45);
INSERT INTO lba.player(name, surname, logo_url)VALUES('Daniel', 'Akin', 'https://www.legabasket.it/_next/static/media/AvatarPlaceholder.64b5f792.svg');
INSERT INTO lba.player_team(player_id, team_id, `number`)VALUES(LAST_INSERT_ID(), 12, 47);
INSERT INTO lba.player(name, surname, logo_url)VALUES('Kaodirichi', 'Akobundu-Ehiogu', 'https://www.legabasket.it/_next/static/media/AvatarPlaceholder.64b5f792.svg');
INSERT INTO lba.player_team(player_id, team_id, `number`)VALUES(LAST_INSERT_ID(), 9, 0);
INSERT INTO lba.player(name, surname, logo_url)VALUES('Amar', 'Alibegovic', 'https://www.legabasket.it/_next/static/media/AvatarPlaceholder.64b5f792.svg');
INSERT INTO lba.player_team(player_id, team_id, `number`)VALUES(LAST_INSERT_ID(), 8, 7);
INSERT INTO lba.player(name, surname, logo_url)VALUES('Justin', 'Alston', 'https://www.legabasket.it/_next/static/media/AvatarPlaceholder.64b5f792.svg');
INSERT INTO lba.player_team(player_id, team_id, `number`)VALUES(LAST_INSERT_ID(), 16, 32);
INSERT INTO lba.player(name, surname, logo_url)VALUES('Davide', 'Alviti', 'https://www.legabasket.it/_next/static/media/AvatarPlaceholder.64b5f792.svg');
INSERT INTO lba.player_team(player_id, team_id, `number`)VALUES(LAST_INSERT_ID(), 9, 2);
INSERT INTO lba.player(name, surname, logo_url)VALUES('Sacar', 'Anim', 'https://www.legabasket.it/_next/static/media/AvatarPlaceholder.64b5f792.svg');
INSERT INTO lba.player_team(player_id, team_id, `number`)VALUES(LAST_INSERT_ID(), 12, 7);
INSERT INTO lba.player(name, surname, logo_url)VALUES('Elisee', 'Assui N''guessan', 'https://www.legabasket.it/_next/static/media/AvatarPlaceholder.64b5f792.svg');
INSERT INTO lba.player_team(player_id, team_id, `number`)VALUES(LAST_INSERT_ID(), 9, 24);
INSERT INTO lba.player(name, surname, logo_url)VALUES('Gabriele', 'Avvinti', 'https://www.legabasket.it/_next/static/media/AvatarPlaceholder.64b5f792.svg');
INSERT INTO lba.player_team(player_id, team_id, `number`)VALUES(LAST_INSERT_ID(), 9, 19);
INSERT INTO lba.player(name, surname, logo_url)VALUES('Dennis', 'Badalau', 'https://www.legabasket.it/_next/static/media/AvatarPlaceholder.64b5f792.svg');
INSERT INTO lba.player_team(player_id, team_id, `number`)VALUES(LAST_INSERT_ID(), 4, 27);
INSERT INTO lba.player(name, surname, logo_url)VALUES('Tommaso', 'Baldasso', 'https://www.legabasket.it/_next/static/media/AvatarPlaceholder.64b5f792.svg');
INSERT INTO lba.player_team(player_id, team_id, `number`)VALUES(LAST_INSERT_ID(), 11, 13);
INSERT INTO lba.player(name, surname, logo_url)VALUES('Jaylen', 'Barford', 'https://www.legabasket.it/_next/static/media/AvatarPlaceholder.64b5f792.svg');
INSERT INTO lba.player_team(player_id, team_id, `number`)VALUES(LAST_INSERT_ID(), 10, 0);
INSERT INTO lba.player(name, surname, logo_url)VALUES('Jordan', 'Bayehe', 'https://www.legabasket.it/_next/static/media/AvatarPlaceholder.64b5f792.svg');
INSERT INTO lba.player_team(player_id, team_id, `number`)VALUES(LAST_INSERT_ID(), 4, 26);
INSERT INTO lba.player(name, surname, logo_url)VALUES('Marco', 'Belinelli', 'https://www.legabasket.it/_next/static/media/AvatarPlaceholder.64b5f792.svg');
INSERT INTO lba.player_team(player_id, team_id, `number`)VALUES(LAST_INSERT_ID(), 2, 3);
INSERT INTO lba.player(name, surname, logo_url)VALUES('Eimantas', 'Bendzius', 'https://www.legabasket.it/_next/static/media/AvatarPlaceholder.64b5f792.svg');
INSERT INTO lba.player_team(player_id, team_id, `number`)VALUES(LAST_INSERT_ID(), 6, 20);
INSERT INTO lba.player(name, surname, logo_url)VALUES('Gabriele', 'Benetti', 'https://www.legabasket.it/_next/static/media/AvatarPlaceholder.64b5f792.svg');
INSERT INTO lba.player_team(player_id, team_id, `number`)VALUES(LAST_INSERT_ID(), 15, 0);
INSERT INTO lba.player(name, surname, logo_url)VALUES('Justin', 'Bibbins', 'https://www.legabasket.it/_next/static/media/AvatarPlaceholder.64b5f792.svg');
INSERT INTO lba.player_team(player_id, team_id, `number`)VALUES(LAST_INSERT_ID(), 6, 1);
INSERT INTO lba.player(name, surname, logo_url)VALUES('Miro', 'Bilan', 'https://www.legabasket.it/_next/static/media/AvatarPlaceholder.64b5f792.svg');
INSERT INTO lba.player_team(player_id, team_id, `number`)VALUES(LAST_INSERT_ID(), 5, 2);
INSERT INTO lba.player(name, surname, logo_url)VALUES('Paul Stephan', 'Biligha', 'https://www.legabasket.it/_next/static/media/AvatarPlaceholder.64b5f792.svg');
INSERT INTO lba.player_team(player_id, team_id, `number`)VALUES(LAST_INSERT_ID(), 11, 19);
INSERT INTO lba.player(name, surname, logo_url)VALUES('Alfredo', 'Boglio', 'https://www.legabasket.it/_next/static/media/AvatarPlaceholder.64b5f792.svg');
INSERT INTO lba.player_team(player_id, team_id, `number`)VALUES(LAST_INSERT_ID(), 15, 12);
INSERT INTO lba.player(name, surname, logo_url)VALUES('Leandro', 'Bolmaro', 'https://www.legabasket.it/_next/static/media/AvatarPlaceholder.64b5f792.svg');
INSERT INTO lba.player_team(player_id, team_id, `number`)VALUES(LAST_INSERT_ID(), 1, 10);
INSERT INTO lba.player(name, surname, logo_url)VALUES('Davide', 'Borasi', 'https://www.legabasket.it/_next/static/media/AvatarPlaceholder.64b5f792.svg');
INSERT INTO lba.player_team(player_id, team_id, `number`)VALUES(LAST_INSERT_ID(), 11, 25);
INSERT INTO lba.player(name, surname, logo_url)VALUES('Francesco', 'Borrelli', 'https://www.legabasket.it/_next/static/media/AvatarPlaceholder.64b5f792.svg');
INSERT INTO lba.player_team(player_id, team_id, `number`)VALUES(LAST_INSERT_ID(), 12, 10);
INSERT INTO lba.player(name, surname, logo_url)VALUES('Salvatore', 'Borriello', 'https://www.legabasket.it/_next/static/media/AvatarPlaceholder.64b5f792.svg');
INSERT INTO lba.player_team(player_id, team_id, `number`)VALUES(LAST_INSERT_ID(), 12, 10);
INSERT INTO lba.player(name, surname, logo_url)VALUES('Giordano', 'Bortolani', 'https://www.legabasket.it/_next/static/media/AvatarPlaceholder.64b5f792.svg');
INSERT INTO lba.player_team(player_id, team_id, `number`)VALUES(LAST_INSERT_ID(), 1, 3);
INSERT INTO lba.player(name, surname, logo_url)VALUES('Stefano', 'Bosio', 'https://www.legabasket.it/_next/static/media/AvatarPlaceholder.64b5f792.svg');
INSERT INTO lba.player_team(player_id, team_id, `number`)VALUES(LAST_INSERT_ID(), 9, 19);
INSERT INTO lba.player(name, surname, logo_url)VALUES('Ky', 'Bowman', 'https://www.legabasket.it/_next/static/media/AvatarPlaceholder.64b5f792.svg');
INSERT INTO lba.player_team(player_id, team_id, `number`)VALUES(LAST_INSERT_ID(), 16, 0);
INSERT INTO lba.player(name, surname, logo_url)VALUES('Desonta', 'Bradford', 'https://www.legabasket.it/_next/static/media/AvatarPlaceholder.64b5f792.svg');
INSERT INTO lba.player_team(player_id, team_id, `number`)VALUES(LAST_INSERT_ID(), 9, 8);
INSERT INTO lba.player(name, surname, logo_url)VALUES('Jeff', 'Brooks', 'https://www.legabasket.it/_next/static/media/AvatarPlaceholder.64b5f792.svg');
INSERT INTO lba.player_team(player_id, team_id, `number`)VALUES(LAST_INSERT_ID(), 13, 23);
INSERT INTO lba.player(name, surname, logo_url)VALUES('Armoni', 'Brooks', 'https://www.legabasket.it/_next/static/media/AvatarPlaceholder.64b5f792.svg');
INSERT INTO lba.player_team(player_id, team_id, `number`)VALUES(LAST_INSERT_ID(), 1, 12);
INSERT INTO lba.player(name, surname, logo_url)VALUES('Markel', 'Brown', 'https://www.legabasket.it/_next/static/media/AvatarPlaceholder.64b5f792.svg');
INSERT INTO lba.player_team(player_id, team_id, `number`)VALUES(LAST_INSERT_ID(), 13, 22);
INSERT INTO lba.player(name, surname, logo_url)VALUES('Gabe', 'Brown', 'https://www.legabasket.it/_next/static/media/AvatarPlaceholder.64b5f792.svg');
INSERT INTO lba.player_team(player_id, team_id, `number`)VALUES(LAST_INSERT_ID(), 8, 44);
INSERT INTO lba.player(name, surname, logo_url)VALUES('Jason', 'Burnell', 'https://www.legabasket.it/_next/static/media/AvatarPlaceholder.64b5f792.svg');
INSERT INTO lba.player_team(player_id, team_id, `number`)VALUES(LAST_INSERT_ID(), 5, 10);
INSERT INTO lba.player(name, surname, logo_url)VALUES('Christian', 'Burns', 'https://www.legabasket.it/_next/static/media/AvatarPlaceholder.64b5f792.svg');
INSERT INTO lba.player_team(player_id, team_id, `number`)VALUES(LAST_INSERT_ID(), 14, 23);
INSERT INTO lba.player(name, surname, logo_url)VALUES('Devontae', 'Cacok', 'https://www.legabasket.it/_next/static/media/AvatarPlaceholder.64b5f792.svg');
INSERT INTO lba.player_team(player_id, team_id, `number`)VALUES(LAST_INSERT_ID(), 2, 15);
INSERT INTO lba.player(name, surname, logo_url)VALUES('Myles', 'Cale', 'https://www.legabasket.it/_next/static/media/AvatarPlaceholder.64b5f792.svg');
INSERT INTO lba.player_team(player_id, team_id, `number`)VALUES(LAST_INSERT_ID(), 4, 3);
INSERT INTO lba.player(name, surname, logo_url)VALUES('Luca', 'Campogrande', 'https://www.legabasket.it/_next/static/media/AvatarPlaceholder.64b5f792.svg');
INSERT INTO lba.player_team(player_id, team_id, `number`)VALUES(LAST_INSERT_ID(), 13, 12);
INSERT INTO lba.player(name, surname, logo_url)VALUES('Leonardo', 'Candi', 'https://www.legabasket.it/_next/static/media/AvatarPlaceholder.64b5f792.svg');
INSERT INTO lba.player_team(player_id, team_id, `number`)VALUES(LAST_INSERT_ID(), 11, 7);
INSERT INTO lba.player(name, surname, logo_url)VALUES('Francesco', 'Candussi', 'https://www.legabasket.it/_next/static/media/AvatarPlaceholder.64b5f792.svg');
INSERT INTO lba.player_team(player_id, team_id, `number`)VALUES(LAST_INSERT_ID(), 13, 13);
INSERT INTO lba.player(name, surname, logo_url)VALUES('Alessandro', 'Cappelletti', 'https://www.legabasket.it/_next/static/media/AvatarPlaceholder.64b5f792.svg');
INSERT INTO lba.player_team(player_id, team_id, `number`)VALUES(LAST_INSERT_ID(), 6, 0);
INSERT INTO lba.player(name, surname, logo_url)VALUES('Claudio', 'Carità', 'https://www.legabasket.it/_next/static/media/AvatarPlaceholder.64b5f792.svg');
INSERT INTO lba.player_team(player_id, team_id, `number`)VALUES(LAST_INSERT_ID(), 9, 19);
INSERT INTO lba.player(name, surname, logo_url)VALUES('Jordan', 'Caroline', 'https://www.legabasket.it/_next/static/media/AvatarPlaceholder.64b5f792.svg');
INSERT INTO lba.player_team(player_id, team_id, `number`)VALUES(LAST_INSERT_ID(), 16, 25);
INSERT INTO lba.player(name, surname, logo_url)VALUES('Guglielmo', 'Caruso', 'https://www.legabasket.it/_next/static/media/AvatarPlaceholder.64b5f792.svg');
INSERT INTO lba.player_team(player_id, team_id, `number`)VALUES(LAST_INSERT_ID(), 1, 30);
INSERT INTO lba.player(name, surname, logo_url)VALUES('Davide', 'Casarin', 'https://www.legabasket.it/_next/static/media/AvatarPlaceholder.64b5f792.svg');
INSERT INTO lba.player_team(player_id, team_id, `number`)VALUES(LAST_INSERT_ID(), 3, 7);
INSERT INTO lba.player(name, surname, logo_url)VALUES('Enrico', 'Casu', 'https://www.legabasket.it/_next/static/media/AvatarPlaceholder.64b5f792.svg');
INSERT INTO lba.player_team(player_id, team_id, `number`)VALUES(LAST_INSERT_ID(), 6, 4);
INSERT INTO lba.player(name, surname, logo_url)VALUES('Fabien', 'Causeur', 'https://www.legabasket.it/_next/static/media/AvatarPlaceholder.64b5f792.svg');
INSERT INTO lba.player_team(player_id, team_id, `number`)VALUES(LAST_INSERT_ID(), 1, 5);
INSERT INTO lba.player(name, surname, logo_url)VALUES('Marco', 'Ceron', 'https://www.legabasket.it/_next/static/media/AvatarPlaceholder.64b5f792.svg');
INSERT INTO lba.player_team(player_id, team_id, `number`)VALUES(LAST_INSERT_ID(), 15, 4);
INSERT INTO lba.player(name, surname, logo_url)VALUES('Kwan', 'Cheatham', 'https://www.legabasket.it/_next/static/media/AvatarPlaceholder.64b5f792.svg');
INSERT INTO lba.player_team(player_id, team_id, `number`)VALUES(LAST_INSERT_ID(), 10, 55);
INSERT INTO lba.player(name, surname, logo_url)VALUES('Matteo', 'Chillo', 'https://www.legabasket.it/_next/static/media/AvatarPlaceholder.64b5f792.svg');
INSERT INTO lba.player_team(player_id, team_id, `number`)VALUES(LAST_INSERT_ID(), 10, 51);
INSERT INTO lba.player(name, surname, logo_url)VALUES('Jacopo', 'Chiti', 'https://www.legabasket.it/_next/static/media/AvatarPlaceholder.64b5f792.svg');
INSERT INTO lba.player_team(player_id, team_id, `number`)VALUES(LAST_INSERT_ID(), 15, 14);
INSERT INTO lba.player(name, surname, logo_url)VALUES('Semaj', 'Christon', 'https://www.legabasket.it/_next/static/media/AvatarPlaceholder.64b5f792.svg');
INSERT INTO lba.player_team(player_id, team_id, `number`)VALUES(LAST_INSERT_ID(), 14, 0);
INSERT INTO lba.player(name, surname, logo_url)VALUES('Andrea', 'Cinciarini', 'https://www.legabasket.it/_next/static/media/AvatarPlaceholder.64b5f792.svg');
INSERT INTO lba.player_team(player_id, team_id, `number`)VALUES(LAST_INSERT_ID(), 12, 20);
INSERT INTO lba.player(name, surname, logo_url)VALUES('Will', 'Clyburn', 'https://www.legabasket.it/_next/static/media/AvatarPlaceholder.64b5f792.svg');
INSERT INTO lba.player_team(player_id, team_id, `number`)VALUES(LAST_INSERT_ID(), 2, 8);
INSERT INTO lba.player(name, surname, logo_url)VALUES('Luca', 'Conti', 'https://www.legabasket.it/_next/static/media/AvatarPlaceholder.64b5f792.svg');
INSERT INTO lba.player_team(player_id, team_id, `number`)VALUES(LAST_INSERT_ID(), 14, 8);
INSERT INTO lba.player(name, surname, logo_url)VALUES('Derek', 'Cooke', 'https://www.legabasket.it/_next/static/media/AvatarPlaceholder.64b5f792.svg');
INSERT INTO lba.player_team(player_id, team_id, `number`)VALUES(LAST_INSERT_ID(), 15, 10);
INSERT INTO lba.player(name, surname, logo_url)VALUES('Isaia', 'Cordinier', 'https://www.legabasket.it/_next/static/media/AvatarPlaceholder.64b5f792.svg');
INSERT INTO lba.player_team(player_id, team_id, `number`)VALUES(LAST_INSERT_ID(), 2, 00);
INSERT INTO lba.player(name, surname, logo_url)VALUES('David Reginald', 'Cournooh', 'https://www.legabasket.it/_next/static/media/AvatarPlaceholder.64b5f792.svg');
INSERT INTO lba.player_team(player_id, team_id, `number`)VALUES(LAST_INSERT_ID(), 5, 25);
INSERT INTO lba.player(name, surname, logo_url)VALUES('Riccardo', 'Crnobrnja', 'https://www.legabasket.it/_next/static/media/AvatarPlaceholder.64b5f792.svg');
INSERT INTO lba.player_team(player_id, team_id, `number`)VALUES(LAST_INSERT_ID(), 13, 2);
INSERT INTO lba.player(name, surname, logo_url)VALUES('Corey', 'Davis', 'https://www.legabasket.it/_next/static/media/AvatarPlaceholder.64b5f792.svg');
INSERT INTO lba.player_team(player_id, team_id, `number`)VALUES(LAST_INSERT_ID(), 14, 5);
INSERT INTO lba.player(name, surname, logo_url)VALUES('Lodovico', 'Deangeli', 'https://www.legabasket.it/_next/static/media/AvatarPlaceholder.64b5f792.svg');
INSERT INTO lba.player_team(player_id, team_id, `number`)VALUES(LAST_INSERT_ID(), 13, 8);
INSERT INTO lba.player(name, surname, logo_url)VALUES('Gianluca', 'Della Rosa', 'https://www.legabasket.it/_next/static/media/AvatarPlaceholder.64b5f792.svg');
INSERT INTO lba.player_team(player_id, team_id, `number`)VALUES(LAST_INSERT_ID(), 15, 2);
INSERT INTO lba.player(name, surname, logo_url)VALUES('Amedeo', 'Della Valle', 'https://www.legabasket.it/_next/static/media/AvatarPlaceholder.64b5f792.svg');
INSERT INTO lba.player_team(player_id, team_id, `number`)VALUES(LAST_INSERT_ID(), 5, 8);
INSERT INTO lba.player(name, surname, logo_url)VALUES('Giovanni', 'De Marchi', 'https://www.legabasket.it/_next/static/media/AvatarPlaceholder.64b5f792.svg');
INSERT INTO lba.player_team(player_id, team_id, `number`)VALUES(LAST_INSERT_ID(), 16, 13);
INSERT INTO lba.player(name, surname, logo_url)VALUES('Mattia', 'De Martin', 'https://www.legabasket.it/_next/static/media/AvatarPlaceholder.64b5f792.svg');
INSERT INTO lba.player_team(player_id, team_id, `number`)VALUES(LAST_INSERT_ID(), 14, 1);
INSERT INTO lba.player(name, surname, logo_url)VALUES('Davide', 'Denegri', 'https://www.legabasket.it/_next/static/media/AvatarPlaceholder.64b5f792.svg');
INSERT INTO lba.player_team(player_id, team_id, `number`)VALUES(LAST_INSERT_ID(), 11, 11);
INSERT INTO lba.player(name, surname, logo_url)VALUES('Giovanni', 'De Nicolao', 'https://www.legabasket.it/_next/static/media/AvatarPlaceholder.64b5f792.svg');
INSERT INTO lba.player_team(player_id, team_id, `number`)VALUES(LAST_INSERT_ID(), 7, 5);
INSERT INTO lba.player(name, surname, logo_url)VALUES('Nenad', 'Dimitrijevic', 'https://www.legabasket.it/_next/static/media/AvatarPlaceholder.64b5f792.svg');
INSERT INTO lba.player_team(player_id, team_id, `number`)VALUES(LAST_INSERT_ID(), 1, 1);
INSERT INTO lba.player(name, surname, logo_url)VALUES('Ousmane', 'Diop', 'https://www.legabasket.it/_next/static/media/AvatarPlaceholder.64b5f792.svg');
INSERT INTO lba.player_team(player_id, team_id, `number`)VALUES(LAST_INSERT_ID(), 1, 25);
INSERT INTO lba.player(name, surname, logo_url)VALUES('Mouhamet Rassoul', 'Diouf', 'https://www.legabasket.it/_next/static/media/AvatarPlaceholder.64b5f792.svg');
INSERT INTO lba.player_team(player_id, team_id, `number`)VALUES(LAST_INSERT_ID(), 2, 35);
INSERT INTO lba.player(name, surname, logo_url)VALUES('Nicola', 'Dorigotti', 'https://www.legabasket.it/_next/static/media/AvatarPlaceholder.64b5f792.svg');
INSERT INTO lba.player_team(player_id, team_id, `number`)VALUES(LAST_INSERT_ID(), 4, 11);
INSERT INTO lba.player(name, surname, logo_url)VALUES('Chris', 'Dowe', 'https://www.legabasket.it/_next/static/media/AvatarPlaceholder.64b5f792.svg');
INSERT INTO lba.player_team(player_id, team_id, `number`)VALUES(LAST_INSERT_ID(), 5, 5);
INSERT INTO lba.player(name, surname, logo_url)VALUES('Dario', 'Dreznjak', 'https://www.legabasket.it/_next/static/media/AvatarPlaceholder.64b5f792.svg');
INSERT INTO lba.player_team(player_id, team_id, `number`)VALUES(LAST_INSERT_ID(), 14, 24);
INSERT INTO lba.player(name, surname, logo_url)VALUES('Paul', 'Eboua', 'https://www.legabasket.it/_next/static/media/AvatarPlaceholder.64b5f792.svg');
INSERT INTO lba.player_team(player_id, team_id, `number`)VALUES(LAST_INSERT_ID(), 8, 00);
INSERT INTO lba.player(name, surname, logo_url)VALUES('John', 'Egbunu', 'https://www.legabasket.it/_next/static/media/AvatarPlaceholder.64b5f792.svg');
INSERT INTO lba.player_team(player_id, team_id, `number`)VALUES(LAST_INSERT_ID(), 7, 15);
INSERT INTO lba.player(name, surname, logo_url)VALUES('Quinn', 'Ellis', 'https://www.legabasket.it/_next/static/media/AvatarPlaceholder.64b5f792.svg');
INSERT INTO lba.player_team(player_id, team_id, `number`)VALUES(LAST_INSERT_ID(), 4, 1);
INSERT INTO lba.player(name, surname, logo_url)VALUES('Tyler', 'Ennis', 'https://www.legabasket.it/_next/static/media/AvatarPlaceholder.64b5f792.svg');
INSERT INTO lba.player_team(player_id, team_id, `number`)VALUES(LAST_INSERT_ID(), 3, 11);
INSERT INTO lba.player(name, surname, logo_url)VALUES('Elhadji', 'Fainke', 'https://www.legabasket.it/_next/static/media/AvatarPlaceholder.64b5f792.svg');
INSERT INTO lba.player_team(player_id, team_id, `number`)VALUES(LAST_INSERT_ID(), 10, 25);
INSERT INTO lba.player(name, surname, logo_url)VALUES('Abdel', 'Fall', 'https://www.legabasket.it/_next/static/media/AvatarPlaceholder.64b5f792.svg');
INSERT INTO lba.player_team(player_id, team_id, `number`)VALUES(LAST_INSERT_ID(), 9, 28);
INSERT INTO lba.player(name, surname, logo_url)VALUES('Nicola', 'Fantoma', 'https://www.legabasket.it/_next/static/media/AvatarPlaceholder.64b5f792.svg');
INSERT INTO lba.player_team(player_id, team_id, `number`)VALUES(LAST_INSERT_ID(), 14, 16);
INSERT INTO lba.player(name, surname, logo_url)VALUES('Bruno', 'Farias', 'https://www.legabasket.it/_next/static/media/AvatarPlaceholder.64b5f792.svg');
INSERT INTO lba.player_team(player_id, team_id, `number`)VALUES(LAST_INSERT_ID(), 11, 9);
INSERT INTO lba.player(name, surname, logo_url)VALUES('Kenneth', 'Faried', 'https://www.legabasket.it/_next/static/media/AvatarPlaceholder.64b5f792.svg');
INSERT INTO lba.player_team(player_id, team_id, `number`)VALUES(LAST_INSERT_ID(), 10, 35);
INSERT INTO lba.player(name, surname, logo_url)VALUES('Mouhamed', 'Faye', 'https://www.legabasket.it/_next/static/media/AvatarPlaceholder.64b5f792.svg');
INSERT INTO lba.player_team(player_id, team_id, `number`)VALUES(LAST_INSERT_ID(), 10, 11);
INSERT INTO lba.player(name, surname, logo_url)VALUES('Juan Manuel', 'Fernandez', 'https://www.legabasket.it/_next/static/media/AvatarPlaceholder.64b5f792.svg');
INSERT INTO lba.player_team(player_id, team_id, `number`)VALUES(LAST_INSERT_ID(), 3, 8);
INSERT INTO lba.player(name, surname, logo_url)VALUES('Giancarlo', 'Ferrero', 'https://www.legabasket.it/_next/static/media/AvatarPlaceholder.64b5f792.svg');
INSERT INTO lba.player_team(player_id, team_id, `number`)VALUES(LAST_INSERT_ID(), 5, 3);
INSERT INTO lba.player(name, surname, logo_url)VALUES('Massimo', 'Fiodo', 'https://www.legabasket.it/_next/static/media/AvatarPlaceholder.64b5f792.svg');
INSERT INTO lba.player_team(player_id, team_id, `number`)VALUES(LAST_INSERT_ID(), 7, 0);
INSERT INTO lba.player(name, surname, logo_url)VALUES('Diego', 'Flaccadori', 'https://www.legabasket.it/_next/static/media/AvatarPlaceholder.64b5f792.svg');
INSERT INTO lba.player_team(player_id, team_id, `number`)VALUES(LAST_INSERT_ID(), 1, 21);
INSERT INTO lba.player(name, surname, logo_url)VALUES('Brian', 'Fobbs', 'https://www.legabasket.it/_next/static/media/AvatarPlaceholder.64b5f792.svg');
INSERT INTO lba.player_team(player_id, team_id, `number`)VALUES(LAST_INSERT_ID(), 6, 11);
INSERT INTO lba.player(name, surname, logo_url)VALUES('Jordan', 'Ford', 'https://www.legabasket.it/_next/static/media/AvatarPlaceholder.64b5f792.svg');
INSERT INTO lba.player_team(player_id, team_id, `number`)VALUES(LAST_INSERT_ID(), 4, 5);
INSERT INTO lba.player(name, surname, logo_url)VALUES('Toto', 'Forray', 'https://www.legabasket.it/_next/static/media/AvatarPlaceholder.64b5f792.svg');
INSERT INTO lba.player_team(player_id, team_id, `number`)VALUES(LAST_INSERT_ID(), 4, 10);
INSERT INTO lba.player(name, surname, logo_url)VALUES('Michael', 'Forrest', 'https://www.legabasket.it/_next/static/media/AvatarPlaceholder.64b5f792.svg');
INSERT INTO lba.player_team(player_id, team_id, `number`)VALUES(LAST_INSERT_ID(), 15, 11);
INSERT INTO lba.player(name, surname, logo_url)VALUES('Filippo', 'Gallo', 'https://www.legabasket.it/_next/static/media/AvatarPlaceholder.64b5f792.svg');
INSERT INTO lba.player_team(player_id, team_id, `number`)VALUES(LAST_INSERT_ID(), 10, 3);
INSERT INTO lba.player(name, surname, logo_url)VALUES('Langston', 'Galloway', 'https://www.legabasket.it/_next/static/media/AvatarPlaceholder.64b5f792.svg');
INSERT INTO lba.player_team(player_id, team_id, `number`)VALUES(LAST_INSERT_ID(), 8, 9);
INSERT INTO lba.player(name, surname, logo_url)VALUES('Diego', 'Garavaglia', 'https://www.legabasket.it/_next/static/media/AvatarPlaceholder.64b5f792.svg');
INSERT INTO lba.player_team(player_id, team_id, `number`)VALUES(LAST_INSERT_ID(), 1, 6);
INSERT INTO lba.player(name, surname, logo_url)VALUES('Alberto', 'Gatto', 'https://www.legabasket.it/_next/static/media/AvatarPlaceholder.64b5f792.svg');
INSERT INTO lba.player_team(player_id, team_id, `number`)VALUES(LAST_INSERT_ID(), 16, 13);
INSERT INTO lba.player(name, surname, logo_url)VALUES('Erten', 'Gazi', 'https://www.legabasket.it/_next/static/media/AvatarPlaceholder.64b5f792.svg');
INSERT INTO lba.player_team(player_id, team_id, `number`)VALUES(LAST_INSERT_ID(), 6, 77);
INSERT INTO lba.player(name, surname, logo_url)VALUES('Stefano', 'Gentile', 'https://www.legabasket.it/_next/static/media/AvatarPlaceholder.64b5f792.svg');
INSERT INTO lba.player_team(player_id, team_id, `number`)VALUES(LAST_INSERT_ID(), 8, 22);
INSERT INTO lba.player(name, surname, logo_url)VALUES('Frederick', 'Gillespie', 'https://www.legabasket.it/_next/static/media/AvatarPlaceholder.64b5f792.svg');
INSERT INTO lba.player_team(player_id, team_id, `number`)VALUES(LAST_INSERT_ID(), 1, 55);
INSERT INTO lba.player(name, surname, logo_url)VALUES('Stephane', 'Gombauld', 'https://www.legabasket.it/_next/static/media/AvatarPlaceholder.64b5f792.svg');
INSERT INTO lba.player_team(player_id, team_id, `number`)VALUES(LAST_INSERT_ID(), 10, 13);
INSERT INTO lba.player(name, surname, logo_url)VALUES('Justin', 'Gorham', 'https://www.legabasket.it/_next/static/media/AvatarPlaceholder.64b5f792.svg');
INSERT INTO lba.player_team(player_id, team_id, `number`)VALUES(LAST_INSERT_ID(), 11, 4);
INSERT INTO lba.player(name, surname, logo_url)VALUES('Sasha', 'Grant', 'https://www.legabasket.it/_next/static/media/AvatarPlaceholder.64b5f792.svg');
INSERT INTO lba.player_team(player_id, team_id, `number`)VALUES(LAST_INSERT_ID(), 10, 44);
INSERT INTO lba.player(name, surname, logo_url)VALUES('Justin', 'Gray', 'https://www.legabasket.it/_next/static/media/AvatarPlaceholder.64b5f792.svg');
INSERT INTO lba.player_team(player_id, team_id, `number`)VALUES(LAST_INSERT_ID(), 9, 5);
INSERT INTO lba.player(name, surname, logo_url)VALUES('Rob', 'Gray', 'https://www.legabasket.it/_next/static/media/AvatarPlaceholder.64b5f792.svg');
INSERT INTO lba.player_team(player_id, team_id, `number`)VALUES(LAST_INSERT_ID(), 12, 2);
INSERT INTO lba.player(name, surname, logo_url)VALUES('Justin Nathaniel', 'Gray', 'https://www.legabasket.it/_next/static/media/AvatarPlaceholder.64b5f792.svg');
INSERT INTO lba.player_team(player_id, team_id, `number`)VALUES(LAST_INSERT_ID(), 9, 5);
INSERT INTO lba.player(name, surname, logo_url)VALUES('Andrejs', 'Grazulis', 'https://www.legabasket.it/_next/static/media/AvatarPlaceholder.64b5f792.svg');
INSERT INTO lba.player_team(player_id, team_id, `number`)VALUES(LAST_INSERT_ID(), 2, 24);
INSERT INTO lba.player(name, surname, logo_url)VALUES('Gianluca', 'Greco', 'https://www.legabasket.it/_next/static/media/AvatarPlaceholder.64b5f792.svg');
INSERT INTO lba.player_team(player_id, team_id, `number`)VALUES(LAST_INSERT_ID(), 12, 10);
INSERT INTO lba.player(name, surname, logo_url)VALUES('Erick', 'Green', 'https://www.legabasket.it/_next/static/media/AvatarPlaceholder.64b5f792.svg');
INSERT INTO lba.player_team(player_id, team_id, `number`)VALUES(LAST_INSERT_ID(), 7, 32);
INSERT INTO lba.player(name, surname, logo_url)VALUES('Edoardo', 'Grieco', 'https://www.legabasket.it/_next/static/media/AvatarPlaceholder.64b5f792.svg');
INSERT INTO lba.player_team(player_id, team_id, `number`)VALUES(LAST_INSERT_ID(), 15, 6);
INSERT INTO lba.player(name, surname, logo_url)VALUES('Cristiano', 'Guidolin', 'https://www.legabasket.it/_next/static/media/AvatarPlaceholder.64b5f792.svg');
INSERT INTO lba.player_team(player_id, team_id, `number`)VALUES(LAST_INSERT_ID(), 16, 8);
INSERT INTO lba.player(name, surname, logo_url)VALUES('Daniel', 'Hackett', 'https://www.legabasket.it/_next/static/media/AvatarPlaceholder.64b5f792.svg');
INSERT INTO lba.player_team(player_id, team_id, `number`)VALUES(LAST_INSERT_ID(), 2, 23);
INSERT INTO lba.player(name, surname, logo_url)VALUES('Miralem', 'Halilovic', 'https://www.legabasket.it/_next/static/media/AvatarPlaceholder.64b5f792.svg');
INSERT INTO lba.player_team(player_id, team_id, `number`)VALUES(LAST_INSERT_ID(), 6, 7);
INSERT INTO lba.player(name, surname, logo_url)VALUES('Jaylen', 'Hands', 'https://www.legabasket.it/_next/static/media/AvatarPlaceholder.64b5f792.svg');
INSERT INTO lba.player_team(player_id, team_id, `number`)VALUES(LAST_INSERT_ID(), 9, 50);
INSERT INTO lba.player(name, surname, logo_url)VALUES('D''Angelo', 'Harrison', 'https://www.legabasket.it/_next/static/media/AvatarPlaceholder.64b5f792.svg');
INSERT INTO lba.player_team(player_id, team_id, `number`)VALUES(LAST_INSERT_ID(), 16, 7);
INSERT INTO lba.player(name, surname, logo_url)VALUES('Patrick', 'Hassan', 'https://www.legabasket.it/_next/static/media/AvatarPlaceholder.64b5f792.svg');
INSERT INTO lba.player_team(player_id, team_id, `number`)VALUES(LAST_INSERT_ID(), 4, 68);
INSERT INTO lba.player(name, surname, logo_url)VALUES('Justin', 'Holiday', 'https://www.legabasket.it/_next/static/media/AvatarPlaceholder.64b5f792.svg');
INSERT INTO lba.player_team(player_id, team_id, `number`)VALUES(LAST_INSERT_ID(), 2, 1);
INSERT INTO lba.player(name, surname, logo_url)VALUES('Chris', 'Horton', 'https://www.legabasket.it/_next/static/media/AvatarPlaceholder.64b5f792.svg');
INSERT INTO lba.player_team(player_id, team_id, `number`)VALUES(LAST_INSERT_ID(), 8, 2);
INSERT INTO lba.player(name, surname, logo_url)VALUES('Pietro', 'Iacopini', 'https://www.legabasket.it/_next/static/media/AvatarPlaceholder.64b5f792.svg');
INSERT INTO lba.player_team(player_id, team_id, `number`)VALUES(LAST_INSERT_ID(), 16, 6);
INSERT INTO lba.player(name, surname, logo_url)VALUES('Pietro', 'Iannuzzi', 'https://www.legabasket.it/_next/static/media/AvatarPlaceholder.64b5f792.svg');
INSERT INTO lba.player_team(player_id, team_id, `number`)VALUES(LAST_INSERT_ID(), 3, 40);
INSERT INTO lba.player(name, surname, logo_url)VALUES('Nikola', 'Ivanovic', 'https://www.legabasket.it/_next/static/media/AvatarPlaceholder.64b5f792.svg');
INSERT INTO lba.player_team(player_id, team_id, `number`)VALUES(LAST_INSERT_ID(), 5, 18);
INSERT INTO lba.player(name, surname, logo_url)VALUES('Emils', 'Ivanovskis', 'https://www.legabasket.it/_next/static/media/AvatarPlaceholder.64b5f792.svg');
INSERT INTO lba.player_team(player_id, team_id, `number`)VALUES(LAST_INSERT_ID(), 14, 2);
INSERT INTO lba.player(name, surname, logo_url)VALUES('Giga', 'Janelidze', 'https://www.legabasket.it/_next/static/media/AvatarPlaceholder.64b5f792.svg');
INSERT INTO lba.player_team(player_id, team_id, `number`)VALUES(LAST_INSERT_ID(), 3, 14);
INSERT INTO lba.player(name, surname, logo_url)VALUES('Jaron', 'Johnson', 'https://www.legabasket.it/_next/static/media/AvatarPlaceholder.64b5f792.svg');
INSERT INTO lba.player_team(player_id, team_id, `number`)VALUES(LAST_INSERT_ID(), 9, 92);
INSERT INTO lba.player(name, surname, logo_url)VALUES('Jayce', 'Johnson', 'https://www.legabasket.it/_next/static/media/AvatarPlaceholder.64b5f792.svg');
INSERT INTO lba.player_team(player_id, team_id, `number`)VALUES(LAST_INSERT_ID(), 13, 34);
INSERT INTO lba.player(name, surname, logo_url)VALUES('Tajion', 'Jones', 'https://www.legabasket.it/_next/static/media/AvatarPlaceholder.64b5f792.svg');
INSERT INTO lba.player_team(player_id, team_id, `number`)VALUES(LAST_INSERT_ID(), 14, 3);
INSERT INTO lba.player(name, surname, logo_url)VALUES('Andrjia', 'Josovic', 'https://www.legabasket.it/_next/static/media/AvatarPlaceholder.64b5f792.svg');
INSERT INTO lba.player_team(player_id, team_id, `number`)VALUES(LAST_INSERT_ID(), 11, 23);
INSERT INTO lba.player(name, surname, logo_url)VALUES('Nikola', 'Jovanovic', 'https://www.legabasket.it/_next/static/media/AvatarPlaceholder.64b5f792.svg');
INSERT INTO lba.player_team(player_id, team_id, `number`)VALUES(LAST_INSERT_ID(), 12, 32);
INSERT INTO lba.player(name, surname, logo_url)VALUES('Mfiondu', 'Kabengele', 'https://www.legabasket.it/_next/static/media/AvatarPlaceholder.64b5f792.svg');
INSERT INTO lba.player_team(player_id, team_id, `number`)VALUES(LAST_INSERT_ID(), 3, 21);
INSERT INTO lba.player(name, surname, logo_url)VALUES('Ismael', 'Kamagate', 'https://www.legabasket.it/_next/static/media/AvatarPlaceholder.64b5f792.svg');
INSERT INTO lba.player_team(player_id, team_id, `number`)VALUES(LAST_INSERT_ID(), 11, 14);
INSERT INTO lba.player(name, surname, logo_url)VALUES('Maurice', 'Kemp', 'https://www.legabasket.it/_next/static/media/AvatarPlaceholder.64b5f792.svg');
INSERT INTO lba.player_team(player_id, team_id, `number`)VALUES(LAST_INSERT_ID(), 15, 9);
INSERT INTO lba.player(name, surname, logo_url)VALUES('Tommy', 'Kuhse', 'https://www.legabasket.it/_next/static/media/AvatarPlaceholder.64b5f792.svg');
INSERT INTO lba.player_team(player_id, team_id, `number`)VALUES(LAST_INSERT_ID(), 11, 2);
INSERT INTO lba.player(name, surname, logo_url)VALUES('Trevor', 'Lacey', 'https://www.legabasket.it/_next/static/media/AvatarPlaceholder.64b5f792.svg');
INSERT INTO lba.player_team(player_id, team_id, `number`)VALUES(LAST_INSERT_ID(), 14, 13);
INSERT INTO lba.player(name, surname, logo_url)VALUES('Anthony', 'Lamb', 'https://www.legabasket.it/_next/static/media/AvatarPlaceholder.64b5f792.svg');
INSERT INTO lba.player_team(player_id, team_id, `number`)VALUES(LAST_INSERT_ID(), 4, 22);
INSERT INTO lba.player(name, surname, logo_url)VALUES('Zach', 'LeDay', 'https://www.legabasket.it/_next/static/media/AvatarPlaceholder.64b5f792.svg');
INSERT INTO lba.player_team(player_id, team_id, `number`)VALUES(LAST_INSERT_ID(), 1, 16);
INSERT INTO lba.player(name, surname, logo_url)VALUES('Alessandro', 'Lever', 'https://www.legabasket.it/_next/static/media/AvatarPlaceholder.64b5f792.svg');
INSERT INTO lba.player_team(player_id, team_id, `number`)VALUES(LAST_INSERT_ID(), 3, 4);
INSERT INTO lba.player(name, surname, logo_url)VALUES('Matteo', 'Librizzi', 'https://www.legabasket.it/_next/static/media/AvatarPlaceholder.64b5f792.svg');
INSERT INTO lba.player_team(player_id, team_id, `number`)VALUES(LAST_INSERT_ID(), 9, 13);
INSERT INTO lba.player(name, surname, logo_url)VALUES('Achille', 'Lonati', 'https://www.legabasket.it/_next/static/media/AvatarPlaceholder.64b5f792.svg');
INSERT INTO lba.player_team(player_id, team_id, `number`)VALUES(LAST_INSERT_ID(), 1, 6);
INSERT INTO lba.player(name, surname, logo_url)VALUES('Andrea', 'Mabor Dut Biar', 'https://www.legabasket.it/_next/static/media/AvatarPlaceholder.64b5f792.svg');
INSERT INTO lba.player_team(player_id, team_id, `number`)VALUES(LAST_INSERT_ID(), 7, 44);
INSERT INTO lba.player(name, surname, logo_url)VALUES('JP', 'Macura', 'https://www.legabasket.it/_next/static/media/AvatarPlaceholder.64b5f792.svg');
INSERT INTO lba.player_team(player_id, team_id, `number`)VALUES(LAST_INSERT_ID(), 16, 55);
INSERT INTO lba.player(name, surname, logo_url)VALUES('Niccolò', 'Mannion', 'https://www.legabasket.it/_next/static/media/AvatarPlaceholder.64b5f792.svg');
INSERT INTO lba.player_team(player_id, team_id, `number`)VALUES(LAST_INSERT_ID(), 1, 2);
INSERT INTO lba.player(name, surname, logo_url)VALUES('Giacomo', 'Marostica', 'https://www.legabasket.it/_next/static/media/AvatarPlaceholder.64b5f792.svg');
INSERT INTO lba.player_team(player_id, team_id, `number`)VALUES(LAST_INSERT_ID(), 16, 44);
INSERT INTO lba.player(name, surname, logo_url)VALUES('Francesco', 'Martin', 'https://www.legabasket.it/_next/static/media/AvatarPlaceholder.64b5f792.svg');
INSERT INTO lba.player_team(player_id, team_id, `number`)VALUES(LAST_INSERT_ID(), 16, 15);
INSERT INTO lba.player(name, surname, logo_url)VALUES('Bruno', 'Mascolo', 'https://www.legabasket.it/_next/static/media/AvatarPlaceholder.64b5f792.svg');
INSERT INTO lba.player_team(player_id, team_id, `number`)VALUES(LAST_INSERT_ID(), 16, 14);
INSERT INTO lba.player(name, surname, logo_url)VALUES('Selom', 'Mawugbe', 'https://www.legabasket.it/_next/static/media/AvatarPlaceholder.64b5f792.svg');
INSERT INTO lba.player_team(player_id, team_id, `number`)VALUES(LAST_INSERT_ID(), 4, 21);
INSERT INTO lba.player(name, surname, logo_url)VALUES('Edon', 'Maxhuni', 'https://www.legabasket.it/_next/static/media/AvatarPlaceholder.64b5f792.svg');
INSERT INTO lba.player_team(player_id, team_id, `number`)VALUES(LAST_INSERT_ID(), 12, 21);
INSERT INTO lba.player(name, surname, logo_url)VALUES('Valerio', 'Mazzola', 'https://www.legabasket.it/_next/static/media/AvatarPlaceholder.64b5f792.svg');
INSERT INTO lba.player_team(player_id, team_id, `number`)VALUES(LAST_INSERT_ID(), 16, 22);
INSERT INTO lba.player(name, surname, logo_url)VALUES('Sean', 'McDermott', 'https://www.legabasket.it/_next/static/media/AvatarPlaceholder.64b5f792.svg');
INSERT INTO lba.player_team(player_id, team_id, `number`)VALUES(LAST_INSERT_ID(), 13, 30);
INSERT INTO lba.player(name, surname, logo_url)VALUES('Rodney', 'McGruder', 'https://www.legabasket.it/_next/static/media/AvatarPlaceholder.64b5f792.svg');
INSERT INTO lba.player_team(player_id, team_id, `number`)VALUES(LAST_INSERT_ID(), 3, 2);
INSERT INTO lba.player(name, surname, logo_url)VALUES('Andrea', 'Mezzanotte', 'https://www.legabasket.it/_next/static/media/AvatarPlaceholder.64b5f792.svg');
INSERT INTO lba.player_team(player_id, team_id, `number`)VALUES(LAST_INSERT_ID(), 16, 24);
INSERT INTO lba.player(name, surname, logo_url)VALUES('Federico', 'Miaschi', 'https://www.legabasket.it/_next/static/media/AvatarPlaceholder.64b5f792.svg');
INSERT INTO lba.player_team(player_id, team_id, `number`)VALUES(LAST_INSERT_ID(), 12, 11);
INSERT INTO lba.player(name, surname, logo_url)VALUES('Nikola', 'Mirotic', 'https://www.legabasket.it/_next/static/media/AvatarPlaceholder.64b5f792.svg');
INSERT INTO lba.player_team(player_id, team_id, `number`)VALUES(LAST_INSERT_ID(), 1, 33);
INSERT INTO lba.player(name, surname, logo_url)VALUES('Elijah', 'Mitrou-Long', 'https://www.legabasket.it/_next/static/media/AvatarPlaceholder.64b5f792.svg');
INSERT INTO lba.player_team(player_id, team_id, `number`)VALUES(LAST_INSERT_ID(), 9, 3);
INSERT INTO lba.player(name, surname, logo_url)VALUES('Joseph', 'Mobio', 'https://www.legabasket.it/_next/static/media/AvatarPlaceholder.64b5f792.svg');
INSERT INTO lba.player_team(player_id, team_id, `number`)VALUES(LAST_INSERT_ID(), 5, 21);
INSERT INTO lba.player(name, surname, logo_url)VALUES('Marco', 'Mollura', 'https://www.legabasket.it/_next/static/media/AvatarPlaceholder.64b5f792.svg');
INSERT INTO lba.player_team(player_id, team_id, `number`)VALUES(LAST_INSERT_ID(), 8, 18);
INSERT INTO lba.player(name, surname, logo_url)VALUES('Davide', 'Moretti', 'https://www.legabasket.it/_next/static/media/AvatarPlaceholder.64b5f792.svg');
INSERT INTO lba.player_team(player_id, team_id, `number`)VALUES(LAST_INSERT_ID(), 3, 9);
INSERT INTO lba.player(name, surname, logo_url)VALUES('Matt', 'Morgan', 'https://www.legabasket.it/_next/static/media/AvatarPlaceholder.64b5f792.svg');
INSERT INTO lba.player_team(player_id, team_id, `number`)VALUES(LAST_INSERT_ID(), 2, 30);
INSERT INTO lba.player(name, surname, logo_url)VALUES('Xavier', 'Munford', 'https://www.legabasket.it/_next/static/media/AvatarPlaceholder.64b5f792.svg');
INSERT INTO lba.player_team(player_id, team_id, `number`)VALUES(LAST_INSERT_ID(), 3, 5);
INSERT INTO lba.player(name, surname, logo_url)VALUES('Federico', 'Natale', 'https://www.legabasket.it/_next/static/media/AvatarPlaceholder.64b5f792.svg');
INSERT INTO lba.player_team(player_id, team_id, `number`)VALUES(LAST_INSERT_ID(), 3, 45);
INSERT INTO lba.player(name, surname, logo_url)VALUES('Maurice Daly', 'Ndour', 'https://www.legabasket.it/_next/static/media/AvatarPlaceholder.64b5f792.svg');
INSERT INTO lba.player_team(player_id, team_id, `number`)VALUES(LAST_INSERT_ID(), 5, 9);
INSERT INTO lba.player(name, surname, logo_url)VALUES('Josh', 'Nebo', 'https://www.legabasket.it/_next/static/media/AvatarPlaceholder.64b5f792.svg');
INSERT INTO lba.player_team(player_id, team_id, `number`)VALUES(LAST_INSERT_ID(), 1, 32);
INSERT INTO lba.player(name, surname, logo_url)VALUES('Saliou', 'Niang', 'https://www.legabasket.it/_next/static/media/AvatarPlaceholder.64b5f792.svg');
INSERT INTO lba.player_team(player_id, team_id, `number`)VALUES(LAST_INSERT_ID(), 4, 7);
INSERT INTO lba.player(name, surname, logo_url)VALUES('Cheichk', 'Niang', 'https://www.legabasket.it/_next/static/media/AvatarPlaceholder.64b5f792.svg');
INSERT INTO lba.player_team(player_id, team_id, `number`)VALUES(LAST_INSERT_ID(), 4, 11);
INSERT INTO lba.player(name, surname, logo_url)VALUES('Stefan', 'Nikolic', 'https://www.legabasket.it/_next/static/media/AvatarPlaceholder.64b5f792.svg');
INSERT INTO lba.player_team(player_id, team_id, `number`)VALUES(LAST_INSERT_ID(), 14, 11);
INSERT INTO lba.player(name, surname, logo_url)VALUES('JD', 'Notae', 'https://www.legabasket.it/_next/static/media/AvatarPlaceholder.64b5f792.svg');
INSERT INTO lba.player_team(player_id, team_id, `number`)VALUES(LAST_INSERT_ID(), 8, 1);
INSERT INTO lba.player(name, surname, logo_url)VALUES('Antonio', 'Novori', 'https://www.legabasket.it/_next/static/media/AvatarPlaceholder.64b5f792.svg');
INSERT INTO lba.player_team(player_id, team_id, `number`)VALUES(LAST_INSERT_ID(), 15, 6);
INSERT INTO lba.player(name, surname, logo_url)VALUES('Massimiliano', 'Obljubech', 'https://www.legabasket.it/_next/static/media/AvatarPlaceholder.64b5f792.svg');
INSERT INTO lba.player_team(player_id, team_id, `number`)VALUES(LAST_INSERT_ID(), 13, 0);
INSERT INTO lba.player(name, surname, logo_url)VALUES('Osvaldas', 'Olisevicius', 'https://www.legabasket.it/_next/static/media/AvatarPlaceholder.64b5f792.svg');
INSERT INTO lba.player_team(player_id, team_id, `number`)VALUES(LAST_INSERT_ID(), 16, 31);
INSERT INTO lba.player(name, surname, logo_url)VALUES('Tariq', 'Owens', 'https://www.legabasket.it/_next/static/media/AvatarPlaceholder.64b5f792.svg');
INSERT INTO lba.player_team(player_id, team_id, `number`)VALUES(LAST_INSERT_ID(), 14, 41);
INSERT INTO lba.player(name, surname, logo_url)VALUES('Davide', 'Paiano', 'https://www.legabasket.it/_next/static/media/AvatarPlaceholder.64b5f792.svg');
INSERT INTO lba.player_team(player_id, team_id, `number`)VALUES(LAST_INSERT_ID(), 13, 1);
INSERT INTO lba.player(name, surname, logo_url)VALUES('Alessandro', 'Pajola', 'https://www.legabasket.it/_next/static/media/AvatarPlaceholder.64b5f792.svg');
INSERT INTO lba.player_team(player_id, team_id, `number`)VALUES(LAST_INSERT_ID(), 2, 6);
INSERT INTO lba.player(name, surname, logo_url)VALUES('Kevin', 'Pangos', 'https://www.legabasket.it/_next/static/media/AvatarPlaceholder.64b5f792.svg');
INSERT INTO lba.player_team(player_id, team_id, `number`)VALUES(LAST_INSERT_ID(), 7, 4);
INSERT INTO lba.player(name, surname, logo_url)VALUES('Jordan', 'Parks', 'https://www.legabasket.it/_next/static/media/AvatarPlaceholder.64b5f792.svg');
INSERT INTO lba.player_team(player_id, team_id, `number`)VALUES(LAST_INSERT_ID(), 3, 22);
INSERT INTO lba.player(name, surname, logo_url)VALUES('Eric', 'Paschall', 'https://www.legabasket.it/_next/static/media/AvatarPlaceholder.64b5f792.svg');
INSERT INTO lba.player_team(player_id, team_id, `number`)VALUES(LAST_INSERT_ID(), 15, 5);
INSERT INTO lba.player(name, surname, logo_url)VALUES('Pauly', 'Paulicap', 'https://www.legabasket.it/_next/static/media/AvatarPlaceholder.64b5f792.svg');
INSERT INTO lba.player_team(player_id, team_id, `number`)VALUES(LAST_INSERT_ID(), 16, 33);
INSERT INTO lba.player(name, surname, logo_url)VALUES('Andrea', 'Pecchia', 'https://www.legabasket.it/_next/static/media/AvatarPlaceholder.64b5f792.svg');
INSERT INTO lba.player_team(player_id, team_id, `number`)VALUES(LAST_INSERT_ID(), 4, 6);
INSERT INTO lba.player(name, surname, logo_url)VALUES('Francesco', 'Pellegrino', 'https://www.legabasket.it/_next/static/media/AvatarPlaceholder.64b5f792.svg');
INSERT INTO lba.player_team(player_id, team_id, `number`)VALUES(LAST_INSERT_ID(), 16, 29);
INSERT INTO lba.player(name, surname, logo_url)VALUES('John', 'Petrucelli', 'https://www.legabasket.it/_next/static/media/AvatarPlaceholder.64b5f792.svg');
INSERT INTO lba.player_team(player_id, team_id, `number`)VALUES(LAST_INSERT_ID(), 8, 11);
INSERT INTO lba.player(name, surname, logo_url)VALUES('Massimiliano', 'Pezzella', 'https://www.legabasket.it/_next/static/media/AvatarPlaceholder.64b5f792.svg');
INSERT INTO lba.player_team(player_id, team_id, `number`)VALUES(LAST_INSERT_ID(), 12, 10);
INSERT INTO lba.player(name, surname, logo_url)VALUES('Gianmarco', 'Pinelli', 'https://www.legabasket.it/_next/static/media/AvatarPlaceholder.64b5f792.svg');
INSERT INTO lba.player_team(player_id, team_id, `number`)VALUES(LAST_INSERT_ID(), 15, 6);
INSERT INTO lba.player(name, surname, logo_url)VALUES('Kruize', 'Pinkins', 'https://www.legabasket.it/_next/static/media/AvatarPlaceholder.64b5f792.svg');
INSERT INTO lba.player_team(player_id, team_id, `number`)VALUES(LAST_INSERT_ID(), 12, 12);
INSERT INTO lba.player(name, surname, logo_url)VALUES('Stefano', 'Piredda', 'https://www.legabasket.it/_next/static/media/AvatarPlaceholder.64b5f792.svg');
INSERT INTO lba.player_team(player_id, team_id, `number`)VALUES(LAST_INSERT_ID(), 6, 2);
INSERT INTO lba.player(name, surname, logo_url)VALUES('Cesare', 'Placinschi', 'https://www.legabasket.it/_next/static/media/AvatarPlaceholder.64b5f792.svg');
INSERT INTO lba.player_team(player_id, team_id, `number`)VALUES(LAST_INSERT_ID(), 4, 32);
INSERT INTO lba.player(name, surname, logo_url)VALUES('Lorenzo', 'Pollini', 'https://www.legabasket.it/_next/static/media/AvatarPlaceholder.64b5f792.svg');
INSERT INTO lba.player_team(player_id, team_id, `number`)VALUES(LAST_INSERT_ID(), 5, 35);
INSERT INTO lba.player(name, surname, logo_url)VALUES('Achille', 'Polonara', 'https://www.legabasket.it/_next/static/media/AvatarPlaceholder.64b5f792.svg');
INSERT INTO lba.player_team(player_id, team_id, `number`)VALUES(LAST_INSERT_ID(), 2, 33);
INSERT INTO lba.player(name, surname, logo_url)VALUES('Federico', 'Poser', 'https://www.legabasket.it/_next/static/media/AvatarPlaceholder.64b5f792.svg');
INSERT INTO lba.player_team(player_id, team_id, `number`)VALUES(LAST_INSERT_ID(), 14, 12);
INSERT INTO lba.player(name, surname, logo_url)VALUES('Lorenzo', 'Prai', 'https://www.legabasket.it/_next/static/media/AvatarPlaceholder.64b5f792.svg');
INSERT INTO lba.player_team(player_id, team_id, `number`)VALUES(LAST_INSERT_ID(), 16, 10);
INSERT INTO lba.player(name, surname, logo_url)VALUES('Jacob', 'Pullen', 'https://www.legabasket.it/_next/static/media/AvatarPlaceholder.64b5f792.svg');
INSERT INTO lba.player_team(player_id, team_id, `number`)VALUES(LAST_INSERT_ID(), 7, 0);
INSERT INTO lba.player(name, surname, logo_url)VALUES('Mattia', 'Reghenzani', 'https://www.legabasket.it/_next/static/media/AvatarPlaceholder.64b5f792.svg');
INSERT INTO lba.player_team(player_id, team_id, `number`)VALUES(LAST_INSERT_ID(), 9, 0);
INSERT INTO lba.player(name, surname, logo_url)VALUES('Nate', 'Renfro', 'https://www.legabasket.it/_next/static/media/AvatarPlaceholder.64b5f792.svg');
INSERT INTO lba.player_team(player_id, team_id, `number`)VALUES(LAST_INSERT_ID(), 6, 35);
INSERT INTO lba.player(name, surname, logo_url)VALUES('Justin', 'Reyes', 'https://www.legabasket.it/_next/static/media/AvatarPlaceholder.64b5f792.svg');
INSERT INTO lba.player_team(player_id, team_id, `number`)VALUES(LAST_INSERT_ID(), 13, 7);
INSERT INTO lba.player(name, surname, logo_url)VALUES('Giampaolo', 'Ricci', 'https://www.legabasket.it/_next/static/media/AvatarPlaceholder.64b5f792.svg');
INSERT INTO lba.player_team(player_id, team_id, `number`)VALUES(LAST_INSERT_ID(), 1, 17);
INSERT INTO lba.player(name, surname, logo_url)VALUES('Martino', 'Risi', 'https://www.legabasket.it/_next/static/media/AvatarPlaceholder.64b5f792.svg');
INSERT INTO lba.player_team(player_id, team_id, `number`)VALUES(LAST_INSERT_ID(), 9, 19);
INSERT INTO lba.player(name, surname, logo_url)VALUES('Demetre', 'Rivers', 'https://www.legabasket.it/_next/static/media/AvatarPlaceholder.64b5f792.svg');
INSERT INTO lba.player_team(player_id, team_id, `number`)VALUES(LAST_INSERT_ID(), 5, 23);
INSERT INTO lba.player(name, surname, logo_url)VALUES('Davide', 'Rizzo', 'https://www.legabasket.it/_next/static/media/AvatarPlaceholder.64b5f792.svg');
INSERT INTO lba.player_team(player_id, team_id, `number`)VALUES(LAST_INSERT_ID(), 8, 21);
INSERT INTO lba.player(name, surname, logo_url)VALUES('Justin', 'Robinson', 'https://www.legabasket.it/_next/static/media/AvatarPlaceholder.64b5f792.svg');
INSERT INTO lba.player_team(player_id, team_id, `number`)VALUES(LAST_INSERT_ID(), 8, 5);
INSERT INTO lba.player(name, surname, logo_url)VALUES('Colbey', 'Ross', 'https://www.legabasket.it/_next/static/media/AvatarPlaceholder.64b5f792.svg');
INSERT INTO lba.player_team(player_id, team_id, `number`)VALUES(LAST_INSERT_ID(), 13, 4);
INSERT INTO lba.player(name, surname, logo_url)VALUES('Riccardo', 'Rossato', 'https://www.legabasket.it/_next/static/media/AvatarPlaceholder.64b5f792.svg');
INSERT INTO lba.player_team(player_id, team_id, `number`)VALUES(LAST_INSERT_ID(), 8, 6);
INSERT INTO lba.player(name, surname, logo_url)VALUES('Michele', 'Ruzzier', 'https://www.legabasket.it/_next/static/media/AvatarPlaceholder.64b5f792.svg');
INSERT INTO lba.player_team(player_id, team_id, `number`)VALUES(LAST_INSERT_ID(), 13, 10);
INSERT INTO lba.player(name, surname, logo_url)VALUES('Lorenzo', 'Saccaggi', 'https://www.legabasket.it/_next/static/media/AvatarPlaceholder.64b5f792.svg');
INSERT INTO lba.player_team(player_id, team_id, `number`)VALUES(LAST_INSERT_ID(), 15, 15);
INSERT INTO lba.player(name, surname, logo_url)VALUES('Stefano', 'Saccoccia', 'https://www.legabasket.it/_next/static/media/AvatarPlaceholder.64b5f792.svg');
INSERT INTO lba.player_team(player_id, team_id, `number`)VALUES(LAST_INSERT_ID(), 7, 11);
INSERT INTO lba.player(name, surname, logo_url)VALUES('Simone', 'Salvietti', 'https://www.legabasket.it/_next/static/media/AvatarPlaceholder.64b5f792.svg');
INSERT INTO lba.player_team(player_id, team_id, `number`)VALUES(LAST_INSERT_ID(), 16, 10);
INSERT INTO lba.player(name, surname, logo_url)VALUES('Pierfrancesco', 'Sangiovanni', 'https://www.legabasket.it/_next/static/media/AvatarPlaceholder.64b5f792.svg');
INSERT INTO lba.player_team(player_id, team_id, `number`)VALUES(LAST_INSERT_ID(), 12, 3);
INSERT INTO lba.player(name, surname, logo_url)VALUES('Vincenzo', 'Sannino', 'https://www.legabasket.it/_next/static/media/AvatarPlaceholder.64b5f792.svg');
INSERT INTO lba.player_team(player_id, team_id, `number`)VALUES(LAST_INSERT_ID(), 12, 15);
INSERT INTO lba.player(name, surname, logo_url)VALUES('Luca', 'Santi', 'https://www.legabasket.it/_next/static/media/AvatarPlaceholder.64b5f792.svg');
INSERT INTO lba.player_team(player_id, team_id, `number`)VALUES(LAST_INSERT_ID(), 15, 0);
INSERT INTO lba.player(name, surname, logo_url)VALUES('Alessandro', 'Scialpi', 'https://www.legabasket.it/_next/static/media/AvatarPlaceholder.64b5f792.svg');
INSERT INTO lba.player_team(player_id, team_id, `number`)VALUES(LAST_INSERT_ID(), 16, 15);
INSERT INTO lba.player(name, surname, logo_url)VALUES('Luca', 'Severini', 'https://www.legabasket.it/_next/static/media/AvatarPlaceholder.64b5f792.svg');
INSERT INTO lba.player_team(player_id, team_id, `number`)VALUES(LAST_INSERT_ID(), 11, 20);
INSERT INTO lba.player(name, surname, logo_url)VALUES('Tornike', 'Shengelia', 'https://www.legabasket.it/_next/static/media/AvatarPlaceholder.64b5f792.svg');
INSERT INTO lba.player_team(player_id, team_id, `number`)VALUES(LAST_INSERT_ID(), 2, 21);
INSERT INTO lba.player(name, surname, logo_url)VALUES('Shavon', 'Shields', 'https://www.legabasket.it/_next/static/media/AvatarPlaceholder.64b5f792.svg');
INSERT INTO lba.player_team(player_id, team_id, `number`)VALUES(LAST_INSERT_ID(), 1, 31);
INSERT INTO lba.player(name, surname, logo_url)VALUES('Aamir', 'Simms', 'https://www.legabasket.it/_next/static/media/AvatarPlaceholder.64b5f792.svg');
INSERT INTO lba.player_team(player_id, team_id, `number`)VALUES(LAST_INSERT_ID(), 3, 25);
INSERT INTO lba.player(name, surname, logo_url)VALUES('Jamar', 'Smith', 'https://www.legabasket.it/_next/static/media/AvatarPlaceholder.64b5f792.svg');
INSERT INTO lba.player_team(player_id, team_id, `number`)VALUES(LAST_INSERT_ID(), 10, 15);
INSERT INTO lba.player(name, surname, logo_url)VALUES('Michal', 'Sokolowski', 'https://www.legabasket.it/_next/static/media/AvatarPlaceholder.64b5f792.svg');
INSERT INTO lba.player_team(player_id, team_id, `number`)VALUES(LAST_INSERT_ID(), 6, 24);
INSERT INTO lba.player(name, surname, logo_url)VALUES('Paulius', 'Sorokas', 'https://www.legabasket.it/_next/static/media/AvatarPlaceholder.64b5f792.svg');
INSERT INTO lba.player_team(player_id, team_id, `number`)VALUES(LAST_INSERT_ID(), 12, 9);
INSERT INTO lba.player(name, surname, logo_url)VALUES('Tommaso', 'Spinazzè', 'https://www.legabasket.it/_next/static/media/AvatarPlaceholder.64b5f792.svg');
INSERT INTO lba.player_team(player_id, team_id, `number`)VALUES(LAST_INSERT_ID(), 16, 44);
INSERT INTO lba.player(name, surname, logo_url)VALUES('Federico', 'Stoch', 'https://www.legabasket.it/_next/static/media/AvatarPlaceholder.64b5f792.svg');
INSERT INTO lba.player_team(player_id, team_id, `number`)VALUES(LAST_INSERT_ID(), 15, 0);
INSERT INTO lba.player(name, surname, logo_url)VALUES('Arturs', 'Strautins', 'https://www.legabasket.it/_next/static/media/AvatarPlaceholder.64b5f792.svg');
INSERT INTO lba.player_team(player_id, team_id, `number`)VALUES(LAST_INSERT_ID(), 11, 12);
INSERT INTO lba.player(name, surname, logo_url)VALUES('Luigi', 'Suigo', 'https://www.legabasket.it/_next/static/media/AvatarPlaceholder.64b5f792.svg');
INSERT INTO lba.player_team(player_id, team_id, `number`)VALUES(LAST_INSERT_ID(), 1, 19);
INSERT INTO lba.player(name, surname, logo_url)VALUES('Matteo', 'Tambone', 'https://www.legabasket.it/_next/static/media/AvatarPlaceholder.64b5f792.svg');
INSERT INTO lba.player_team(player_id, team_id, `number`)VALUES(LAST_INSERT_ID(), 6, 15);
INSERT INTO lba.player(name, surname, logo_url)VALUES('Amedeo', 'Tessitori', 'https://www.legabasket.it/_next/static/media/AvatarPlaceholder.64b5f792.svg');
INSERT INTO lba.player_team(player_id, team_id, `number`)VALUES(LAST_INSERT_ID(), 3, 00);
INSERT INTO lba.player(name, surname, logo_url)VALUES('Rashawn', 'Thomas', 'https://www.legabasket.it/_next/static/media/AvatarPlaceholder.64b5f792.svg');
INSERT INTO lba.player_team(player_id, team_id, `number`)VALUES(LAST_INSERT_ID(), 6, 0);
INSERT INTO lba.player(name, surname, logo_url)VALUES('Alessandro', 'Tonelli', 'https://www.legabasket.it/_next/static/media/AvatarPlaceholder.64b5f792.svg');
INSERT INTO lba.player_team(player_id, team_id, `number`)VALUES(LAST_INSERT_ID(), 5, 11);
INSERT INTO lba.player(name, surname, logo_url)VALUES('Stefano', 'Tonut', 'https://www.legabasket.it/_next/static/media/AvatarPlaceholder.64b5f792.svg');
INSERT INTO lba.player_team(player_id, team_id, `number`)VALUES(LAST_INSERT_ID(), 1, 7);
INSERT INTO lba.player(name, surname, logo_url)VALUES('David', 'Torresani', 'https://www.legabasket.it/_next/static/media/AvatarPlaceholder.64b5f792.svg');
INSERT INTO lba.player_team(player_id, team_id, `number`)VALUES(LAST_INSERT_ID(), 16, 9);
INSERT INTO lba.player(name, surname, logo_url)VALUES('Leonardo', 'Totè', 'https://www.legabasket.it/_next/static/media/AvatarPlaceholder.64b5f792.svg');
INSERT INTO lba.player_team(player_id, team_id, `number`)VALUES(LAST_INSERT_ID(), 7, 35);
INSERT INTO lba.player(name, surname, logo_url)VALUES('Kaspar', 'Treier', 'https://www.legabasket.it/_next/static/media/AvatarPlaceholder.64b5f792.svg');
INSERT INTO lba.player_team(player_id, team_id, `number`)VALUES(LAST_INSERT_ID(), 7, 3);
INSERT INTO lba.player(name, surname, logo_url)VALUES('Tobia', 'Triggiani', 'https://www.legabasket.it/_next/static/media/AvatarPlaceholder.64b5f792.svg');
INSERT INTO lba.player_team(player_id, team_id, `number`)VALUES(LAST_INSERT_ID(), 4, 4);
INSERT INTO lba.player(name, surname, logo_url)VALUES('Stefano', 'Trucchetti', 'https://www.legabasket.it/_next/static/media/AvatarPlaceholder.64b5f792.svg');
INSERT INTO lba.player_team(player_id, team_id, `number`)VALUES(LAST_INSERT_ID(), 6, 5);
INSERT INTO lba.player(name, surname, logo_url)VALUES('Rayjon', 'Tucker', 'https://www.legabasket.it/_next/static/media/AvatarPlaceholder.64b5f792.svg');
INSERT INTO lba.player_team(player_id, team_id, `number`)VALUES(LAST_INSERT_ID(), 2, 59);
INSERT INTO lba.player(name, surname, logo_url)VALUES('Gabriele', 'Turconi', 'https://www.legabasket.it/_next/static/media/AvatarPlaceholder.64b5f792.svg');
INSERT INTO lba.player_team(player_id, team_id, `number`)VALUES(LAST_INSERT_ID(), 9, 19);
INSERT INTO lba.player(name, surname, logo_url)VALUES('Alex', 'Tyus', 'https://www.legabasket.it/_next/static/media/AvatarPlaceholder.64b5f792.svg');
INSERT INTO lba.player_team(player_id, team_id, `number`)VALUES(LAST_INSERT_ID(), 9, 9);
INSERT INTO lba.player(name, surname, logo_url)VALUES('Mattia', 'Udom', 'https://www.legabasket.it/_next/static/media/AvatarPlaceholder.64b5f792.svg');
INSERT INTO lba.player_team(player_id, team_id, `number`)VALUES(LAST_INSERT_ID(), 6, 17);
INSERT INTO lba.player(name, surname, logo_url)VALUES('Lorenzo', 'Uglietti', 'https://www.legabasket.it/_next/static/media/AvatarPlaceholder.64b5f792.svg');
INSERT INTO lba.player_team(player_id, team_id, `number`)VALUES(LAST_INSERT_ID(), 10, 16);
INSERT INTO lba.player(name, surname, logo_url)VALUES('Scott', 'Ulaneo', 'https://www.legabasket.it/_next/static/media/AvatarPlaceholder.64b5f792.svg');
INSERT INTO lba.player_team(player_id, team_id, `number`)VALUES(LAST_INSERT_ID(), 12, 8);
INSERT INTO lba.player(name, surname, logo_url)VALUES('Francesco', 'Ursini', 'https://www.legabasket.it/_next/static/media/AvatarPlaceholder.64b5f792.svg');
INSERT INTO lba.player_team(player_id, team_id, `number`)VALUES(LAST_INSERT_ID(), 12, 10);
INSERT INTO lba.player(name, surname, logo_url)VALUES('Jarrod', 'Uthoff', 'https://www.legabasket.it/_next/static/media/AvatarPlaceholder.64b5f792.svg');
INSERT INTO lba.player_team(player_id, team_id, `number`)VALUES(LAST_INSERT_ID(), 13, 9);
INSERT INTO lba.player(name, surname, logo_url)VALUES('Denzel', 'Valentine', 'https://www.legabasket.it/_next/static/media/AvatarPlaceholder.64b5f792.svg');
INSERT INTO lba.player_team(player_id, team_id, `number`)VALUES(LAST_INSERT_ID(), 13, 45);
INSERT INTO lba.player(name, surname, logo_url)VALUES('Marco', 'Vasselli', 'https://www.legabasket.it/_next/static/media/AvatarPlaceholder.64b5f792.svg');
INSERT INTO lba.player_team(player_id, team_id, `number`)VALUES(LAST_INSERT_ID(), 6, 4);
INSERT INTO lba.player(name, surname, logo_url)VALUES('Matteo', 'Venturini', 'https://www.legabasket.it/_next/static/media/AvatarPlaceholder.64b5f792.svg');
INSERT INTO lba.player_team(player_id, team_id, `number`)VALUES(LAST_INSERT_ID(), 14, 16);
INSERT INTO lba.player(name, surname, logo_url)VALUES('Giovanni', 'Veronesi', 'https://www.legabasket.it/_next/static/media/AvatarPlaceholder.64b5f792.svg');
INSERT INTO lba.player_team(player_id, team_id, `number`)VALUES(LAST_INSERT_ID(), 6, 16);
INSERT INTO lba.player(name, surname, logo_url)VALUES('Alessandro', 'Villa', 'https://www.legabasket.it/_next/static/media/AvatarPlaceholder.64b5f792.svg');
INSERT INTO lba.player_team(player_id, team_id, `number`)VALUES(LAST_INSERT_ID(), 14, 16);
INSERT INTO lba.player(name, surname, logo_url)VALUES('Luca', 'Vincini', 'https://www.legabasket.it/_next/static/media/AvatarPlaceholder.64b5f792.svg');
INSERT INTO lba.player_team(player_id, team_id, `number`)VALUES(LAST_INSERT_ID(), 6, 22);
INSERT INTO lba.player(name, surname, logo_url)VALUES('Nicolò', 'Virginio', 'https://www.legabasket.it/_next/static/media/AvatarPlaceholder.64b5f792.svg');
INSERT INTO lba.player_team(player_id, team_id, `number`)VALUES(LAST_INSERT_ID(), 9, 18);
INSERT INTO lba.player(name, surname, logo_url)VALUES('Riccardo', 'Visconti', 'https://www.legabasket.it/_next/static/media/AvatarPlaceholder.64b5f792.svg');
INSERT INTO lba.player_team(player_id, team_id, `number`)VALUES(LAST_INSERT_ID(), 2, 9);
INSERT INTO lba.player(name, surname, logo_url)VALUES('Christian', 'Vital', 'https://www.legabasket.it/_next/static/media/AvatarPlaceholder.64b5f792.svg');
INSERT INTO lba.player_team(player_id, team_id, `number`)VALUES(LAST_INSERT_ID(), 11, 1);
INSERT INTO lba.player(name, surname, logo_url)VALUES('Michele', 'Vitali', 'https://www.legabasket.it/_next/static/media/AvatarPlaceholder.64b5f792.svg');
INSERT INTO lba.player_team(player_id, team_id, `number`)VALUES(LAST_INSERT_ID(), 10, 31);
INSERT INTO lba.player(name, surname, logo_url)VALUES('Briante', 'Weber', 'https://www.legabasket.it/_next/static/media/AvatarPlaceholder.64b5f792.svg');
INSERT INTO lba.player_team(player_id, team_id, `number`)VALUES(LAST_INSERT_ID(), 6, 2);
INSERT INTO lba.player(name, surname, logo_url)VALUES('Kyle', 'Weems', 'https://www.legabasket.it/_next/static/media/AvatarPlaceholder.64b5f792.svg');
INSERT INTO lba.player_team(player_id, team_id, `number`)VALUES(LAST_INSERT_ID(), 11, 34);
INSERT INTO lba.player(name, surname, logo_url)VALUES('Carl', 'Wheatle', 'https://www.legabasket.it/_next/static/media/AvatarPlaceholder.64b5f792.svg');
INSERT INTO lba.player_team(player_id, team_id, `number`)VALUES(LAST_INSERT_ID(), 3, 24);
INSERT INTO lba.player(name, surname, logo_url)VALUES('Payton Terrell', 'Willis', 'https://www.legabasket.it/_next/static/media/AvatarPlaceholder.64b5f792.svg');
INSERT INTO lba.player_team(player_id, team_id, `number`)VALUES(LAST_INSERT_ID(), 14, 2);
INSERT INTO lba.player(name, surname, logo_url)VALUES('Kyle', 'Wiltjer', 'https://www.legabasket.it/_next/static/media/AvatarPlaceholder.64b5f792.svg');
INSERT INTO lba.player_team(player_id, team_id, `number`)VALUES(LAST_INSERT_ID(), 3, 33);
INSERT INTO lba.player(name, surname, logo_url)VALUES('Cassius', 'Winston', 'https://www.legabasket.it/_next/static/media/AvatarPlaceholder.64b5f792.svg');
INSERT INTO lba.player_team(player_id, team_id, `number`)VALUES(LAST_INSERT_ID(), 10, 5);
INSERT INTO lba.player(name, surname, logo_url)VALUES('Andriu Tomas', 'Woldetensae', 'https://www.legabasket.it/_next/static/media/AvatarPlaceholder.64b5f792.svg');
INSERT INTO lba.player_team(player_id, team_id, `number`)VALUES(LAST_INSERT_ID(), 7, 8);
INSERT INTO lba.player(name, surname, logo_url)VALUES('Akwasi', 'Yeboah', 'https://www.legabasket.it/_next/static/media/AvatarPlaceholder.64b5f792.svg');
INSERT INTO lba.player_team(player_id, team_id, `number`)VALUES(LAST_INSERT_ID(), 8, 15);
INSERT INTO lba.player(name, surname, logo_url)VALUES('Federico', 'Zampini', 'https://www.legabasket.it/_next/static/media/AvatarPlaceholder.64b5f792.svg');
INSERT INTO lba.player_team(player_id, team_id, `number`)VALUES(LAST_INSERT_ID(), 14, 9);
INSERT INTO lba.player(name, surname, logo_url)VALUES('Alessandro', 'Zanelli', 'https://www.legabasket.it/_next/static/media/AvatarPlaceholder.64b5f792.svg');
INSERT INTO lba.player_team(player_id, team_id, `number`)VALUES(LAST_INSERT_ID(), 12, 6);
INSERT INTO lba.player(name, surname, logo_url)VALUES('Lorenzo', 'Zani', 'https://www.legabasket.it/_next/static/media/AvatarPlaceholder.64b5f792.svg');
INSERT INTO lba.player_team(player_id, team_id, `number`)VALUES(LAST_INSERT_ID(), 14, 16);
INSERT INTO lba.player(name, surname, logo_url)VALUES('Matteo', 'Zanotti', 'https://www.legabasket.it/_next/static/media/AvatarPlaceholder.64b5f792.svg');
INSERT INTO lba.player_team(player_id, team_id, `number`)VALUES(LAST_INSERT_ID(), 14, 16);
INSERT INTO lba.player(name, surname, logo_url)VALUES('Matias', 'Zanotto', 'https://www.legabasket.it/_next/static/media/AvatarPlaceholder.64b5f792.svg');
INSERT INTO lba.player_team(player_id, team_id, `number`)VALUES(LAST_INSERT_ID(), 14, 15);
INSERT INTO lba.player(name, surname, logo_url)VALUES('Andrea', 'Zerini', 'https://www.legabasket.it/_next/static/media/AvatarPlaceholder.64b5f792.svg');
INSERT INTO lba.player_team(player_id, team_id, `number`)VALUES(LAST_INSERT_ID(), 11, 0);
INSERT INTO lba.player(name, surname, logo_url)VALUES('Ante', 'Zizic', 'https://www.legabasket.it/_next/static/media/AvatarPlaceholder.64b5f792.svg');
INSERT INTO lba.player_team(player_id, team_id, `number`)VALUES(LAST_INSERT_ID(), 2, 41);
INSERT INTO lba.player(name, surname, logo_url)VALUES('Tomislav', 'Zubcic', 'https://www.legabasket.it/_next/static/media/AvatarPlaceholder.64b5f792.svg');
INSERT INTO lba.player_team(player_id, team_id, `number`)VALUES(LAST_INSERT_ID(), 7, 1);
INSERT INTO lba.player(name, surname, logo_url)VALUES('Eigirdas', 'Zukauskas', 'https://www.legabasket.it/_next/static/media/AvatarPlaceholder.64b5f792.svg');
INSERT INTO lba.player_team(player_id, team_id, `number`)VALUES(LAST_INSERT_ID(), 4, 33);


