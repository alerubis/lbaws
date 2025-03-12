-- =============================================
-- 1. DB creation
-- =============================================

CREATE DATABASE `lba` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;

use lba;

CREATE TABLE `team` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(64) NOT NULL,
  PRIMARY KEY (`id`)
);

CREATE TABLE `user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(64) NOT NULL,
  `password` varchar(64) NOT NULL,
  `team_id` int NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `user_team_id` FOREIGN KEY (`team_id`) REFERENCES `team` (`id`)
);

CREATE TABLE `referee` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(64) NOT NULL,
  `surname` varchar(64) NOT NULL,
  PRIMARY KEY (`id`)
);

CREATE TABLE `player` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(64) NOT NULL,
  `surname` varchar(64) NOT NULL,
  `height` int default NULL,
  `year` int default NULL,
  PRIMARY KEY (`id`)
);

CREATE TABLE `trainer` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(64) NOT NULL,
  `surname` varchar(64) NOT NULL,
  PRIMARY KEY (`id`)
);

CREATE TABLE `type_league` (
  `id` int NOT NULL AUTO_INCREMENT,
  `description` varchar(256) NOT NULL,
  PRIMARY KEY (`id`)
);

CREATE TABLE `type_game` (
  `id` int NOT NULL AUTO_INCREMENT,
  `description` varchar(256) NOT NULL,
  PRIMARY KEY (`id`)
);

CREATE TABLE `type_league_type_game` (
  `type_league_id` int NOT NULL,
  `type_game_id` int NOT NULL,
  PRIMARY KEY (`type_league_id`, `type_game_id`),
  CONSTRAINT `type_league_type_game_type_league_id` FOREIGN KEY (`type_league_id`) REFERENCES `type_league` (`id`),
  CONSTRAINT `type_league_type_game_type_game_id` FOREIGN KEY (`type_game_id`) REFERENCES `type_game` (`id`)
);

CREATE TABLE `league` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(64) NOT NULL,
  `description` varchar(256) NOT NULL,
  `type_league_id` int NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `league_type_league_id` FOREIGN KEY (`type_league_id`) REFERENCES `type_league` (`id`)
);

CREATE TABLE `league_year` (
  `id` int NOT NULL AUTO_INCREMENT,
  `league_id` int NOT NULL,
  `date_start_utc` bigint,
  `date_end_utc` bigint,
  PRIMARY KEY (`id`),
  CONSTRAINT `league_year_league_id` FOREIGN KEY (`league_id`) REFERENCES `league` (`id`)
);

CREATE TABLE `game` (
  `id` int NOT NULL AUTO_INCREMENT,
  `league_year_id` int NOT NULL,
  `type_game_id` int NOT NULL,
  `team_home_id` int NOT NULL,
  `team_guest_id` int NOT NULL,
  `date_hours_utc` bigint,
  `referee_1_id` int NOT NULL,
  `referee_2_id` int NOT NULL,
  `referee_3_id` int NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `game_league_year_id` FOREIGN KEY (`league_year_id`) REFERENCES `league_year` (`id`),
  CONSTRAINT `game_type_game_id` FOREIGN KEY (`type_game_id`) REFERENCES `type_game` (`id`),
  CONSTRAINT `game_team_home_id` FOREIGN KEY (`team_home_id`) REFERENCES `team` (`id`),
  CONSTRAINT `game_team_guest_id` FOREIGN KEY (`team_guest_id`) REFERENCES `team` (`id`),
  CONSTRAINT `game_referee_1_id` FOREIGN KEY (`referee_1_id`) REFERENCES `referee` (`id`),
  CONSTRAINT `game_referee_2_id` FOREIGN KEY (`referee_2_id`) REFERENCES `referee` (`id`),
  CONSTRAINT `game_referee_3_id` FOREIGN KEY (`referee_3_id`) REFERENCES `referee` (`id`)
);

CREATE TABLE `dashboard` (
  `id` int NOT NULL AUTO_INCREMENT,
  `team_id` int NOT NULL,
  `description` text,
  PRIMARY KEY (`id`),
  CONSTRAINT `dashboard_team_id` FOREIGN KEY (`team_id`) REFERENCES `team` (`id`)
);

CREATE TABLE `card` (
  `id` varchar(64) NOT NULL,
  `description` text,
  `view_name` varchar(64),
  PRIMARY KEY (`id`)
);

CREATE TABLE `card_settings` (
  `card_id` varchar(64) NOT NULL,
  `setting_id` varchar(64) NOT NULL,
  `description` text,
  `view_column` varchar(64),
  `default_value` json,
  `possible_values` json,
  PRIMARY KEY (`card_id`, `setting_id`),
  CONSTRAINT `card_settings_card_id` FOREIGN KEY (`card_id`) REFERENCES `card` (`id`)
);

CREATE TABLE `dashboard_card` (
  `id` int NOT NULL AUTO_INCREMENT,
  `dashboard_id` int NOT NULL,
  `card_id` varchar(64) NOT NULL,
  `x` int,
  `y` int,
  `width` int,
  `height` int,
  PRIMARY KEY (`id`),
  CONSTRAINT `dashboard_card_dashboard_id` FOREIGN KEY (`dashboard_id`) REFERENCES `dashboard` (`id`),
  CONSTRAINT `dashboard_card_card_id` FOREIGN KEY (`card_id`) REFERENCES `card` (`id`)
);

CREATE TABLE `dashboard_card_settings` (
  `dashboard_id` int NOT NULL,
  `dashboard_card_id` int NOT NULL,
  `card_id` varchar(64) NOT NULL,
  `setting_id` varchar(64) NOT NULL,
  `value` json,
  PRIMARY KEY (`dashboard_id`, `dashboard_card_id`, `card_id`, `setting_id`),
  CONSTRAINT `dashboard_card_settings_dashboard_id` FOREIGN KEY (`dashboard_id`) REFERENCES `dashboard` (`id`),
  CONSTRAINT `dashboard_card_settings_dashboard_card_id` FOREIGN KEY (`dashboard_card_id`) REFERENCES `dashboard_card` (`id`),
  CONSTRAINT `dashboard_card_settings_card_settings` FOREIGN KEY (`card_id`, `setting_id`) REFERENCES `card_settings` (`card_id`, `setting_id`)
);

CREATE TABLE `player_team` (
  `player_id` int NOT NULL,
  `team_id` int NOT NULL,
  `number` int NOT NULL,
  `date_start_utc` bigint,
  `date_end_utc` bigint,
  PRIMARY KEY (`player_id`, `team_id`),
  CONSTRAINT `player_team_player_id` FOREIGN KEY (`player_id`) REFERENCES `player` (`id`),
  CONSTRAINT `player_team_team_id` FOREIGN KEY (`team_id`) REFERENCES `team` (`id`)
);

CREATE TABLE `trainer_team` (
  `trainer_id` int NOT NULL,
  `team_id` int NOT NULL,
  `date_start_utc` bigint,
  `date_end_utc` bigint,
  PRIMARY KEY (`trainer_id`, `team_id`),
  CONSTRAINT `trainer_team_trainer_id` FOREIGN KEY (`trainer_id`) REFERENCES `trainer` (`id`),
  CONSTRAINT `trainer_team_team_id` FOREIGN KEY (`team_id`) REFERENCES `team` (`id`)
);

CREATE TABLE `play` (
  `id` int NOT NULL AUTO_INCREMENT,
  `game_id` int NOT NULL,
  `seconds_start` int NOT NULL,
  `seconds_end` int NOT NULL,
  `quarter` int NOT NULL,
  `attack_home_01` varchar(1) NOT NULL,
  `score_home` int NOT NULL,
  `score_guest` int NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `play_game_id` FOREIGN KEY (`game_id`) REFERENCES `game` (`id`)
);

CREATE TABLE `player_team_game` (
  `player_id` int NOT NULL,
  `team_id` int NOT NULL,
  `game_id` int NOT NULL,
  PRIMARY KEY (`player_id`, `team_id`, `game_id`),
  CONSTRAINT `player_team_game_player_id` FOREIGN KEY (`player_id`) REFERENCES `player` (`id`),
  CONSTRAINT `player_team_game_team_id` FOREIGN KEY (`team_id`) REFERENCES `team` (`id`),
  CONSTRAINT `player_team_game_game_id` FOREIGN KEY (`game_id`) REFERENCES `game` (`id`)
);

CREATE TABLE `player_team_game_play` (
  `player_id` int NOT NULL,
  `team_id` int NOT NULL,
  `game_id` int NOT NULL,
  `play_id` int NOT NULL,
  `seconds_start` int default NULL,
  `seconds_end` int default NULL,
  PRIMARY KEY (`player_id`, `team_id`, `game_id`, `play_id`),
  CONSTRAINT `player_team_game_player_id_team_id_game_id` FOREIGN KEY (`player_id`, `team_id`, `game_id`) REFERENCES `player_team_game` (`player_id`, `team_id`, `game_id`),
  CONSTRAINT `player_team_game_play_id` FOREIGN KEY (`play_id`) REFERENCES `play` (`id`)
);

CREATE TABLE `dz_shot` (
  `id` int NOT NULL AUTO_INCREMENT,
  `description` varchar(64) NOT NULL,
  `point` int NOT NULL,
  `made_01` varchar(1) NOT NULL,
  PRIMARY KEY (`id`)
);

CREATE TABLE `dz_foul` (
  `id` int NOT NULL AUTO_INCREMENT,
  `description` varchar(64) NOT NULL,
  PRIMARY KEY (`id`)
);

CREATE TABLE `dz_infraction` (
  `id` int NOT NULL AUTO_INCREMENT,
  `description` varchar(64) NOT NULL,
  PRIMARY KEY (`id`)
);

CREATE TABLE `dz_turnover` (
  `id` int NOT NULL AUTO_INCREMENT,
  `description` varchar(64) NOT NULL,
  PRIMARY KEY (`id`)
);

CREATE TABLE `type_sub_play` (
  `id` int NOT NULL AUTO_INCREMENT,
  `shot_id` int default NULL,
  `turnover_id` int default NULL,
  `foul_id` int default NULL,
  `infraction_id` int default NULL,
  `rebound_defensive_01` varchar(1) default NULL,
  `rebound_offensive_01` varchar(1) default NULL,
  `assist_01` varchar(1) default NULL,
  `blocks_01` varchar(1) default NULL,
  `time_out_01` varchar(1) default NULL,
  `x` int default NULL,
  `y` int default NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `type_sub_play_shot_id` FOREIGN KEY (`shot_id`) REFERENCES `dz_shot` (`id`),
  CONSTRAINT `type_sub_play_turnover_id` FOREIGN KEY (`turnover_id`) REFERENCES `dz_turnover` (`id`),
  CONSTRAINT `type_sub_play_foul_id` FOREIGN KEY (`foul_id`) REFERENCES `dz_foul` (`id`),
  CONSTRAINT `type_sub_play_infraction_id` FOREIGN KEY (`infraction_id`) REFERENCES `dz_infraction` (`id`)
);

CREATE TABLE `sub_play` (
  `id` int NOT NULL AUTO_INCREMENT,
  `play_id` int NOT NULL,
  `seconds_da_start` int default NULL,
  `player_made_id` int default NULL,
  `team_made_id` int default NULL,
  `game_made_id` int default NULL,
  `player_suffered_id` int default NULL,
  `team_suffered_id` int default NULL,
  `game_suffered_id` int default NULL,
  `type_sub_play_id` int NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `sub_play_player_made_id_team_made_id_game_fat` FOREIGN KEY (`player_made_id`, `team_made_id`, `game_made_id`, `play_id`) REFERENCES `player_team_game_play` (`player_id`, `team_id`, `game_id`, `play_id`),
  CONSTRAINT `sub_play_player_suffered_id_team_suffered_id_game_sub` FOREIGN KEY (`player_suffered_id`, `team_suffered_id`, `game_suffered_id`, `play_id`) REFERENCES `player_team_game_play` (`player_id`, `team_id`, `game_id`, `play_id`),
  CONSTRAINT `sub_play_type_sub_play_id` FOREIGN KEY (`type_sub_play_id`) REFERENCES `type_sub_play` (`id`),
  CONSTRAINT `sub_play_play_id` FOREIGN KEY (`play_id`) REFERENCES `play` (`id`)
);






-- =============================================
-- 2. DATA POPULATION
-- =============================================

INSERT INTO card (id, description, view_name) VALUES('AREA', 'Area chart', 'v_area');

INSERT INTO card_settings (card_id, setting_id, description, view_column, default_value, possible_values) VALUES('AREA', 'X', 'Asse X', 'asse_x', '"PLAY"', '["PLAY", "QUARTER", "GAME"]');
INSERT INTO card_settings (card_id, setting_id, description, view_column, default_value, possible_values) VALUES('AREA', 'Y', 'Asse Y', 'asse_y', '"%2"', '["%2", "%3"]');



-- Popolamento tabella `team` con le squadre della Serie A
INSERT INTO `team` (`name`) VALUES
('EA7 Emporio Armani Milano'),
('Virtus Segafredo Bologna'),
('Umana Reyer Venezia'),
('Dolomiti Energia Trentino'),
('Germani Brescia'),
('Banco di Sardegna Sassari'),
('Happy Casa Brindisi'),
('Carpegna Prosciutto Pesaro'),
('Openjobmetis Varese'),
('UNAHOTELS Reggio Emilia'),
('Bertram Yachts Derthona Tortona'),
('Givova Scafati'),
('Pallacanestro Trieste'),
('Vanoli Basket Cremona'),
('Estra Pistoia Basket'),
('NutriBullet Treviso Basket');

-- Popolamento tabella `referee` con alcuni arbitri
INSERT INTO `referee` (`name`, `surname`) VALUES
('Marco', 'Pesenti'),
('Luca', 'Pancotto'),
('Alessandro', 'Cremonini'),
('Davide', 'Santi');

-- Popolamento tabella `trainer` con gli allenatori delle squadre
INSERT INTO `trainer` (`name`, `surname`) VALUES
('Ettore', 'Messina'),
('Luca', 'Banchi'),
('Walter', 'De Raffaele'),
('Emanuele', 'Molin'),
('Alessandro', 'Magro'),
('Piero', 'Bucchi'),
('Fabio', 'Corbani'),
('Maurizio', 'Buscaglia'),
('Matt', 'Brase'),
('Dimitrios', 'Priftis'),
('Marco', 'Ramondino'),
('Pino', 'Sacripanti'),
('Marco', 'Legovich'),
('Paolo', 'Galbiati'),
('Nicola', 'Brienza'),
('Frank', 'Vitucci');

-- Popolamento tabella `trainer_team`
INSERT INTO `trainer_team` (`trainer_id`, `team_id`, `date_start_utc`, `date_end_utc`)
SELECT t.id, tm.id, 1704067200, NULL
FROM trainer t JOIN team tm ON t.id = tm.id;

-- Popolamento tabella `player` con 6-7 giocatori per squadra
INSERT INTO `player` (`name`, `surname`, `height`, `year`) VALUES
('Nicolò', 'Melli', 205, 1991),
('Shavon', 'Shields', 201, 1994),
('Kyle', 'Hines', 198, 1986),
('Billy', 'Baron', 188, 1990),
('Stefano', 'Tonut', 194, 1993),
('Johannes', 'Voigtmann', 211, 1992),
('Gigi', 'Datome', 203, 1987),

('Marco', 'Belinelli', 196, 1986),
('Daniel', 'Hackett', 193, 1987),
('Mouhammadou', 'Jaiteh', 211, 1994),
('Ismael', 'Bako', 208, 1995),
('Alessandro', 'Pajola', 194, 1999),
('Jordan', 'Mickey', 203, 1994),
('Awudu', 'Abass', 198, 1993),

('Michael', 'Bramos', 196, 1987),
('Mitchell', 'Watt', 208, 1989),
('Jeff', 'Brooks', 203, 1989),
('Stefano', 'Tonut', 194, 1993),
('Bruno', 'Cerella', 194, 1986),
('Andrea', 'De Nicolao', 185, 1991),

('Diego', 'Flaccadori', 193, 1996),
('Luca', 'Lechthaler', 206, 1986),
('Gary', 'Browning', 198, 1998),
('Fabio', 'Mian', 196, 1992),
('Andrea', 'Mezzanotte', 207, 1998),
('Davide', 'Pascolo', 202, 1990);

-- Popolamento tabella `player_team` per assegnare i giocatori alle squadre
INSERT INTO `player_team` (`player_id`, `team_id`, `number`, `date_start_utc`, `date_end_utc`)
SELECT p.id, t.id, ROW_NUMBER() OVER (PARTITION BY t.id ORDER BY p.id) + 4, 1704067200, NULL
FROM player p JOIN team t ON p.id % 16 = t.id - 1;

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
('Tiro da 2 - segnato', 2, '1'),
('Tiro da 2 - sbagliato', 2, '0'),
('Tiro da 3 - segnato', 3, '1'),
('Tiro da 3 - sbagliato', 3, '0'),
('Tiro libero - segnato', 1, '1'),
('Tiro libero - sbagliato', 1, '0');

-- Dizionario dei falli
INSERT INTO `dz_foul` (`description`) VALUES
('Fallo personale'),
('Fallo antisportivo'),
('Fallo tecnico'),
('Fallo in attacco'),
('Fallo su tiro');

-- Dizionario delle infrazioni
INSERT INTO `dz_infraction` (`description`) VALUES
('Passi'),
('Doppio palleggio'),
('Campo e campo'),
('8 secondi'),
('24 secondi');

-- Dizionario dei turnover (palle perse)
INSERT INTO `dz_turnover` (`description`) VALUES
('Passaggio sbagliato'),
('Palla rubata'),
('Errore di palleggio'),
('Infrazione di passi'),
('Violazione di tempo');

-- Creazione della partita (Esempio: Milano vs Bologna)
INSERT INTO `game` (`league_year_id`, `type_game_id`, `team_home_id`, `team_guest_id`, `date_hours_utc`, `referee_1_id`, `referee_2_id`, `referee_3_id`)
VALUES (1, 1, 1, 2, UNIX_TIMESTAMP(STR_TO_DATE('10-03-2025 20:30', '%d-%m-%Y %H:%i')), 1, 2, 3);