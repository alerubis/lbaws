CREATE DATABASE `lba` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;

CREATE TABLE `user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(64) NOT NULL,
  `password` varchar(64) NOT NULL,
  PRIMARY KEY (`id`)
);

CREATE TABLE `dashboard` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `description` text,
  PRIMARY KEY (`id`),
  CONSTRAINT `dashboard_user_id` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
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
  `user_id` int NOT NULL,
  `dashboard_id` int NOT NULL,
  `card_id` int NOT NULL,
  `x` int,
  `y` int,
  `width` int,
  `height` int,
  `settings` json,
  PRIMARY KEY (`id`),
  CONSTRAINT `dashboard_card_user_id` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`),
  CONSTRAINT `dashboard_card_dashboard_id` FOREIGN KEY (`dashboard_id`) REFERENCES `dashboard` (`id`),
  CONSTRAINT `dashboard_card_card_id` FOREIGN KEY (`card_id`) REFERENCES `card` (`id`)
);

INSERT INTO user (`username`, `password`) VALUES('ale', 'ale');
INSERT INTO user (`username`, `password`) VALUES('test', 'test');

INSERT INTO card_type (`id`, `description`) VALUES('RADAR', 'Radar Chart');

INSERT INTO card (`card_type_id`, `description`, `default_settings`)
VALUES('RADAR', 'Radar Chart Attack', '{"names": ["Attack", "Speed", "Shooting", "Ball Handling", "Finishing"], "values": [90, 80, 70, 60, 50]}');

INSERT INTO card (`card_type_id`, `description`, `default_settings`)
VALUES('RADAR', 'Radar Chart Defense', '{"names": ["Defense", "Endurance", "Rebounding", "Shot Blocking"], "values": [90, 80, 70, 60]}');
