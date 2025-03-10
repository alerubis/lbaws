CREATE DATABASE `lba` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;

CREATE TABLE `squadra` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(64) NOT NULL,
  `password` varchar(64) NOT NULL,
  PRIMARY KEY (`id`)
);

CREATE TABLE `arbitro` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(64) NOT NULL,
  `cognome` varchar(64) NOT NULL,
  PRIMARY KEY (`id`)
);

CREATE TABLE `giocatore` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(64) NOT NULL,
  `cognome` varchar(64) NOT NULL,
  `altezza` int default NULL,
  `anno` int default NULL,
  PRIMARY KEY (`id`)
);

CREATE TABLE `allenatore` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(64) NOT NULL,
  `cognome` varchar(64) NOT NULL,
  PRIMARY KEY (`id`)
);

CREATE TABLE `tipo_lega` (
  `id` int NOT NULL AUTO_INCREMENT,
  `descrizione` varchar(256) NOT NULL,
  PRIMARY KEY (`id`)
);

CREATE TABLE `tipo_partita` (
  `id` int NOT NULL AUTO_INCREMENT,
  `descrizione` varchar(256) NOT NULL,
  PRIMARY KEY (`id`)
);

CREATE TABLE `tipo_lega_tipo_partita` (
  `tipo_lega_id` int NOT NULL,
  `tipo_partita_id` int NOT NULL,
  PRIMARY KEY (`tipo_lega_id`, `tipo_partita_id`),
  CONSTRAINT `tipo_lega_tipo_partita_tipo_lega_id` FOREIGN KEY (`tipo_lega_id`) REFERENCES `tipo_lega` (`id`),
  CONSTRAINT `tipo_lega_tipo_partita_tipo_partita_id` FOREIGN KEY (`tipo_partita_id`) REFERENCES `tipo_partita` (`id`)
);

CREATE TABLE `lega` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(64) NOT NULL,
  `descrizione` varchar(256) NOT NULL,
  `tipo_lega_id` int NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `lega_tipo_lega_id` FOREIGN KEY (`tipo_lega_id`) REFERENCES `tipo_lega` (`id`)
);

CREATE TABLE `lega_anno` (
  `id` int NOT NULL AUTO_INCREMENT,
  `lega_id` int NOT NULL,
  `data_inizio_utc` bigint,
  `data_fine_utc` bigint,
  PRIMARY KEY (`id`),
  CONSTRAINT `lega_anno_lega_id` FOREIGN KEY (`lega_id`) REFERENCES `lega` (`id`)
);

CREATE TABLE `partita` (
  `id` int NOT NULL AUTO_INCREMENT,
  `lega_anno_id` int NOT NULL,
  `tipo_partita_id` int NOT NULL,
  `squadra_casa_id` int NOT NULL,
  `squadra_ospite_id` int NOT NULL,
  `data_ora_utc` bigint,
  `arbitro_1_id` int NOT NULL,
  `arbitro_2_id` int NOT NULL,
  `arbitro_3_id` int NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `partita_lega_anno_id` FOREIGN KEY (`lega_anno_id`) REFERENCES `lega_anno` (`id`),
  CONSTRAINT `partita_tipo_partita_id` FOREIGN KEY (`tipo_partita_id`) REFERENCES `tipo_partita` (`id`),
  CONSTRAINT `partita_squadra_casa_id` FOREIGN KEY (`squadra_casa_id`) REFERENCES `squadra` (`id`),
  CONSTRAINT `partita_squadra_ospite_id` FOREIGN KEY (`squadra_ospite_id`) REFERENCES `squadra` (`id`),
  CONSTRAINT `partita_arbitro_1_id` FOREIGN KEY (`arbitro_1_id`) REFERENCES `arbitro` (`id`),
  CONSTRAINT `partita_arbitro_2_id` FOREIGN KEY (`arbitro_2_id`) REFERENCES `arbitro` (`id`),
  CONSTRAINT `partita_arbitro_3_id` FOREIGN KEY (`arbitro_3_id`) REFERENCES `arbitro` (`id`)
);

CREATE TABLE `dashboard` (
  `id` int NOT NULL AUTO_INCREMENT,
  `squadra_id` int NOT NULL,
  `description` text,
  PRIMARY KEY (`id`),
  CONSTRAINT `dashboard_squadra_id` FOREIGN KEY (`squadra_id`) REFERENCES `squadra` (`id`)
);

CREATE TABLE `card_type` (
  `id` varchar(64) NOT NULL,
  `description` text,
  PRIMARY KEY (`id`)
);

CREATE TABLE `card` (
  `id` int NOT NULL AUTO_INCREMENT,
  `card_type_id` varchar(64) NOT NULL,
  `description` text,
  `default_settings` json,
  PRIMARY KEY (`id`),
  CONSTRAINT `card_card_type_id` FOREIGN KEY (`card_type_id`) REFERENCES `card_type` (`id`)
);

CREATE TABLE `dashboard_card` (
  `id` int NOT NULL AUTO_INCREMENT,
  `squadra_id` int NOT NULL,
  `dashboard_id` int NOT NULL,
  `card_id` int NOT NULL,
  `x` int,
  `y` int,
  `width` int,
  `height` int,
  `settings` json,
  PRIMARY KEY (`id`),
  CONSTRAINT `dashboard_card_squadra_id` FOREIGN KEY (`squadra_id`) REFERENCES `squadra` (`id`),
  CONSTRAINT `dashboard_card_dashboard_id` FOREIGN KEY (`dashboard_id`) REFERENCES `dashboard` (`id`),
  CONSTRAINT `dashboard_card_card_id` FOREIGN KEY (`card_id`) REFERENCES `card` (`id`)
);

CREATE TABLE `giocatore_squadra` (
  `giocatore_id` int NOT NULL,
  `squadra_id` int NOT NULL,
  `numero` int NOT NULL,
  `data_inizio_utc` bigint,
  `data_fine_utc` bigint,
  PRIMARY KEY (`giocatore_id`, `squadra_id`),
  CONSTRAINT `giocatore_squadra_giocatore_id` FOREIGN KEY (`giocatore_id`) REFERENCES `giocatore` (`id`),
  CONSTRAINT `giocatore_squadra_squadra_id` FOREIGN KEY (`squadra_id`) REFERENCES `squadra` (`id`)
);

CREATE TABLE `allenatore_squadra` (
  `allenatore_id` int NOT NULL,
  `squadra_id` int NOT NULL,
  `numero` int NOT NULL,
  `data_inizio_utc` bigint,
  `data_fine_utc` bigint,
  PRIMARY KEY (`allenatore_id`, `squadra_id`),
  CONSTRAINT `giocatore_squadra_allenatore_id` FOREIGN KEY (`allenatore_id`) REFERENCES `allenatore` (`id`),
  CONSTRAINT `giocatore_squadra_squadra_id` FOREIGN KEY (`squadra_id`) REFERENCES `squadra` (`id`)
);

CREATE TABLE `azione` (
  `id` int NOT NULL,
  `partita_id` int NOT NULL,
  `secondi_inizio` int NOT NULL,
  `secondi_fine` int NOT NULL,
  `quarto` int NOT NULL,
  `attacco_casa_01` varchar(1) NOT NULL,
  `punteggio_casa` int NOT NULL,
  `punteggio_ospite` int NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `azione_partita_id` FOREIGN KEY (`partita_id`) REFERENCES `partita` (`id`)
);

CREATE TABLE `giocatore_squadra_partita` (
  `giocatore_id` int NOT NULL,
  `squadra_id` int NOT NULL,
  `partita_id` int NOT NULL,
  PRIMARY KEY (`giocatore_id`, `squadra_id`, `partita_id`),
  CONSTRAINT `giocatore_squadra_partita_giocatore_id` FOREIGN KEY (`giocatore_id`) REFERENCES `giocatore` (`id`),
  CONSTRAINT `giocatore_squadra_partita_squadra_id` FOREIGN KEY (`squadra_id`) REFERENCES `squadra` (`id`),
  CONSTRAINT `giocatore_squadra_partita_partita_id` FOREIGN KEY (`partita_id`) REFERENCES `partita` (`id`)
);

CREATE TABLE `giocatore_squadra_partita_azione` (
  `giocatore_id` int NOT NULL,
  `squadra_id` int NOT NULL,
  `partita_id` int NOT NULL,
  `azione_id` int NOT NULL,
  `secondi_ingresso` int default NULL,
  `secondi_uscita` int default NULL,
  PRIMARY KEY (`giocatore_id`, `squadra_id`, `partita_id`, 'azione_id'),
  CONSTRAINT `giocatore_squadra_partita_giocatore_id_squadra_id_partita_id` FOREIGN KEY (`giocatore_id`, `squadra_id`, `partita_id`) REFERENCES `giocatore_squadra_partita` (`giocatore_id`, `squadra_id`, `partita_id`),
  CONSTRAINT `giocatore_squadra_partita_azione_id` FOREIGN KEY (`azione_id`) REFERENCES `azione` (`id`)
);

CREATE TABLE `sotto_azione` (
  `id` int NOT NULL AUTO_INCREMENT,
  `azione_id` int NOT NULL,
  `secondi_da_inizio` int default NULL,
  `giocatore_fatta_id` int default NULL,
  `squadra_fatta_id` int default NULL,
  `partita_fatta_id` int default NULL,
  `giocatore_subita_id` int default NULL,
  `squadra_subita_id` int default NULL,
  `partita_subita_id` int default NULL,
  `tipo_sotto_azione_id` int NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `partita_lega_anno_id` FOREIGN KEY (`lega_anno_id`) REFERENCES `lega_anno` (`id`),
  CONSTRAINT `partita_tipo_partita_id` FOREIGN KEY (`tipo_partita_id`) REFERENCES `tipo_partita` (`id`),
  CONSTRAINT `partita_squadra_casa_id` FOREIGN KEY (`squadra_casa_id`) REFERENCES `squadra` (`id`),
  CONSTRAINT `partita_squadra_ospite_id` FOREIGN KEY (`squadra_ospite_id`) REFERENCES `squadra` (`id`),
  CONSTRAINT `sotto_azione_giocatore_fatta_id_squadra_fatta_id_partita_fat` FOREIGN KEY (`giocatore_fatta_id`, `squadra_fatta_id`, `partita_fatta_id`, `azione_id`) REFERENCES `giocatore_squadra_partita_azione` (`giocatore_id`, `squadra_id`, `partita_id`, `azione_id`),
  CONSTRAINT `sotto_azione_giocatore_subita_id_squadra_subita_id_partita_sub` FOREIGN KEY (`giocatore_subita_id`, `squadra_subita_id`, `partita_subita_id`, `azione_id`) REFERENCES `giocatore_squadra_partita_azione` (`giocatore_id`, `squadra_id`, `partita_id`, `azione_id`),
  CONSTRAINT `sotto_azione_tipo_sotto_azione_id` FOREIGN KEY (`tipo_sotto_azione_id`) REFERENCES `tipo_sotto_azione` (`id`),
);

CREATE TABLE `tipo_sotto_azione` (
  `id` int NOT NULL AUTO_INCREMENT,
  `tiro_id` int default NULL,
  `palla_persa_id` int default NULL,
  `fallo_id` int default NULL,
  `infrazione_id` int default NULL,
  `rimbalzo_difensivo_01` varchar(1) default NULL,
  `rimbalzo_offensivo_01` varchar(1) default NULL,
  `assist_01` varchar(1) default NULL,
  `stoppata_01` varchar(1) default NULL,
  `time_out_01` varchar(1) default NULL,
  `x` int default NULL,
  `y` int default NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `tipo_sotto_azione_tiro_id` FOREIGN KEY (`tiro_id`) REFERENCES `tiro` (`id`),
  CONSTRAINT `tipo_sotto_azione_palla_persa_id` FOREIGN KEY (`palla_persa_id`) REFERENCES `palla_persa` (`id`),
  CONSTRAINT `tipo_sotto_azione_fallo_id` FOREIGN KEY (`fallo_id`) REFERENCES `fallo` (`id`),
  CONSTRAINT `tipo_sotto_azione_infrazione_id` FOREIGN KEY (`infrazione_id`) REFERENCES `infrazione` (`id`)
);

CREATE TABLE `dz_tiro` (
  `id` int NOT NULL AUTO_INCREMENT,
  `descrizione` varchar(64) NOT NULL,
  `punti` int NOT NULL,
  `made_01` varchar(1) NOT NULL,
  PRIMARY KEY (`id`)
);

CREATE TABLE `dz_fallo` (
  `id` int NOT NULL AUTO_INCREMENT,
  `descrizione` varchar(64) NOT NULL,
  PRIMARY KEY (`id`)
);

CREATE TABLE `dz_infrazione` (
  `id` int NOT NULL AUTO_INCREMENT,
  `descrizione` varchar(64) NOT NULL,
  PRIMARY KEY (`id`)
);

CREATE TABLE `dz_palla_persa` (
  `id` int NOT NULL AUTO_INCREMENT,
  `descrizione` varchar(64) NOT NULL,
  PRIMARY KEY (`id`)
);


INSERT INTO squadra (`nome`, `password`) VALUES('olimpia', 'olimpia');
INSERT INTO squadra (`nome`, `password`) VALUES('test', 'test');

INSERT INTO card_type (`id`, `description`) VALUES('RADAR', 'Radar Chart');

INSERT INTO card (`card_type_id`, `description`, `default_settings`)
VALUES('RADAR', 'Radar Chart Attack', '{"names": ["Attack", "Speed", "Shooting", "Ball Handling", "Finishing"], "values": [90, 80, 70, 60, 50]}');

INSERT INTO card (`card_type_id`, `description`, `default_settings`)
VALUES('RADAR', 'Radar Chart Defense', '{"names": ["Defense", "Endurance", "Rebounding", "Shot Blocking"], "values": [90, 80, 70, 60]}');
