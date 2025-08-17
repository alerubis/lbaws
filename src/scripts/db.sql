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
  `logo_url` varchar(1024) NOT NULL,
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
  `total_seconds_played_before` INT DEFAULT 0,
  `consecutive_seconds_playing` INT DEFAULT 0,
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
  CONSTRAINT `sub_play_foul_id` FOREIGN KEY (`foul_id`) REFERENCES `dz_foul` (`id`)
);


CREATE TABLE `card_type` (
  `id` varchar(64) NOT NULL,
  `description` text,
  PRIMARY KEY (`id`)
);

alter table card add column card_type_id varchar(64) NOT null after card_id;
alter table card add CONSTRAINT card_card_type_id FOREIGN KEY (card_type_id) REFERENCES card_type (id);
alter table dashboard add column card_type_id varchar(64) NOT null after dashboard_id;
alter table dashboard add CONSTRAINT dashboard_card_type_id FOREIGN KEY (card_type_id) REFERENCES card_type (id);






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
('24 Secondi'),
('Fallo in attacco');

-- Popolamento tabella `referee` con alcuni arbitri
INSERT INTO `referee` (`name`, `surname`) VALUES
('Marco', 'Pesenti'),
('Luca', 'Pancotto'),
('Alessandro', 'Cremonini'),
('Davide', 'Santi');


CREATE TABLE `formula` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(64) NOT NULL,
  `formula` varchar(1024) NOT NULL,
  PRIMARY KEY (`id`)
);