-- =============================================
-- 1. DB creation
-- =============================================

CREATE DATABASE `lba` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;

use lba;

CREATE TABLE `team` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(64) NOT NULL,
  `logo_url` varchar(1024) NOT NULL,
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
  `team_home_points` int,
  `team_guest_points` int,
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

CREATE TABLE `card` (
  `card_id` varchar(64) NOT NULL,
  `description` text,
  PRIMARY KEY (`card_id`)
);

CREATE TABLE `card_settings` (
  `card_id` varchar(64) NOT NULL,
  `setting_id` varchar(64) NOT NULL,
  `description` text,
  `default_value` json,
  `possible_values` json,
  PRIMARY KEY (`card_id`, `setting_id`),
  CONSTRAINT `card_settings_card_id` FOREIGN KEY (`card_id`) REFERENCES `card` (`card_id`)
);

CREATE TABLE `dashboard` (
  `dashboard_id` int NOT NULL AUTO_INCREMENT,
  `team_id` int NOT NULL,
  `description` text,
  PRIMARY KEY (`dashboard_id`),
  CONSTRAINT `dashboard_team_id` FOREIGN KEY (`team_id`) REFERENCES `team` (`id`)
);

CREATE TABLE `dashboard_card` (
  `dashboard_id` int NOT NULL,
  `dashboard_card_id` int NOT NULL,
  `card_id` varchar(64) NOT NULL,
  `title` text,
  `x` int,
  `y` int,
  `width` int,
  `height` int,
  PRIMARY KEY (`dashboard_id`, `dashboard_card_id`),
  CONSTRAINT `dashboard_card_dashboard_id` FOREIGN KEY (`dashboard_id`) REFERENCES `dashboard` (`dashboard_id`),
  CONSTRAINT `dashboard_card_card_id` FOREIGN KEY (`card_id`) REFERENCES `card` (`card_id`)
);

CREATE TABLE `dashboard_card_settings` (
  `dashboard_id` int NOT NULL,
  `dashboard_card_id` int NOT NULL,
  `card_id` varchar(64) NOT NULL,
  `setting_id` varchar(64) NOT NULL,
  `value` json,
  PRIMARY KEY (`dashboard_id`, `dashboard_card_id`, `card_id`, `setting_id`),
  CONSTRAINT `dashboard_card_settings_dashboard_card` FOREIGN KEY (`dashboard_id`, `dashboard_card_id`) REFERENCES `dashboard_card` (`dashboard_id`, `dashboard_card_id`),
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
  PRIMARY KEY (`id`)
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
  CONSTRAINT `sub_play_player_made_id_team_made_id_game_fat` FOREIGN KEY (`player_made_id`, `team_made_id`, `game_made_id`, `play_id`) REFERENCES `player_team_game_play` (`player_id`, `team_id`, `game_id`, `play_id`),
  CONSTRAINT `sub_play_player_suffered_id_team_suffered_id_game_sub` FOREIGN KEY (`player_suffered_id`, `team_suffered_id`, `game_suffered_id`, `play_id`) REFERENCES `player_team_game_play` (`player_id`, `team_id`, `game_id`, `play_id`),
  CONSTRAINT `sub_play_play_id` FOREIGN KEY (`play_id`) REFERENCES `play` (`id`),
  CONSTRAINT `sub_play_shot_id` FOREIGN KEY (`shot_id`) REFERENCES `dz_shot` (`id`),
  CONSTRAINT `sub_play_turnover_id` FOREIGN KEY (`turnover_id`) REFERENCES `dz_turnover` (`id`),
  CONSTRAINT `sub_play_foul_id` FOREIGN KEY (`foul_id`) REFERENCES `dz_foul` (`id`),
  CONSTRAINT `sub_play_infraction_id` FOREIGN KEY (`infraction_id`) REFERENCES `dz_infraction` (`id`)
);


-- ogni card avrà un tipo che la incasella in una tipologia di analisi, giocatori, partite, squadre o campionati
-- cosi non ci saranno piu problemi di mille filtri da dover applicare
-- anche i grafici simili verranno separati, secondi quarti e partita saranno tre grafici diversi per le categorie giocatori e squadra ognuno con la sua vista.
-- dashboard_card_settings restera e verrà utilizzato per dire quali varaibili della vista bisognerà usare permettendo di rendere tutto parametrrizzabile.

-- Quindi ogni card avrà un solo grafico, ogni grafico avrà una vista.
-- Bisognerà permettere all utente di inserire il tipo di dashboard e una volta entrato potra solamente inserire card di quel tipo.
-- I grafici se simili si ripetereanno quindi nel grafico che stiamo facedno ce ne saranno tre (secondi quarto partita) ognuno con il suo grafico e la sua vista .
-- Una volta scelto il grafico l unica variabile che l utente dovrà inserire sarà in questo l asse y(scegliendo sostanzialmente dalle colonne della vista)

-- nel campo value di dashboard_card_settings bisognerebbe mettere direttamenti i campi della vista.


CREATE TABLE `card_type` (
  `id` varchar(64) NOT NULL,
  `description` text,
  PRIMARY KEY (`id`)
);

alter table card add column card_type_id varchar(64) NOT null after card_id;
alter table card add CONSTRAINT card_card_type_id FOREIGN KEY (card_type_id) REFERENCES card_type (id);
