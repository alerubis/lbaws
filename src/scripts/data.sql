
INSERT INTO card_type
(id, description)
VALUES('PLAYER', 'Card per analisi giocatori');
INSERT INTO card_type
(id, description)
VALUES('GAME', 'Card per analisi partite');
INSERT INTO card_type
(id, description)
VALUES('TEAM', 'Card per analisi squadre');
INSERT INTO card_type
(id, description)
VALUES('LEAGUE_YEAR', 'Card per analisi una leghe');

INSERT INTO card (card_id, card_type_id, description) VALUES('AREA', 'PLAYER', 'Area chart');

INSERT INTO card_settings (card_id, setting_id, description, default_value, possible_values) VALUES('AREA', 'X', 'Asse X', '"team_year_league_summary_seconds_play"', '["team_year_league_summary_seconds_play", "team_year_league_summary_minutes_quart", "team_year_league_summary_minutes_game"]');
INSERT INTO card_settings (card_id, setting_id, description, default_value, possible_values) VALUES('AREA', 'Y', 'Asse Y', '"%2"', '["%2", "%3"]');



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

INSERT INTO user (`username`, `password`, `team_id`) VALUES('ale', 'ale', 1);
INSERT INTO user (`username`, `password`, `team_id`) VALUES('test', 'test', 1);


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

-- Popolamento tabella `player` con 10 giocatori per squadra 160 totali
INSERT INTO `player` (`name`, `surname`, `height`, `year`) VALUES
('Caroline','Pierce',202,1988),
('Jeffrey','Morgan',194,1987),
('Michael','Dickerson',196,2004),
('Richard','Gonzalez',187,1993),
('Brandon','Peters',189,1993),
('Christina','Wilson',185,1993),
('Lee','Moore',178,1993),
('Richard','Burton',215,1996),
('Thomas','Morrow',189,1986),
('Jill','Jones',175,2000),
('Brett','Santiago',198,2004),
('Mackenzie','Guzman',210,1988),
('Kyle','Roberts',195,1991),
('Peter','Smith',208,1985),
('Marissa','Crawford',186,1995),
('Gabrielle','Obrien',191,1986),
('Frank','Hill',175,1988),
('Jeremiah','Pruitt',203,2004),
('Amanda','Sandoval',177,1996),
('Ashley','Johnson',184,1999),
('Matthew','Baker',198,1986),
('Lori','Collins',204,1989),
('Mario','Walker',197,2004),
('Susan','Kennedy',193,2002),
('Christopher','Peters',183,1995),
('Melissa','Perez',201,1986),
('Cory','Green',219,1985),
('John','Edwards',188,1990),
('Alexandria','Long',204,2001),
('Lynn','Hahn',217,2001),
('Matthew','Carpenter',198,1987),
('Amy','Adams',186,2003),
('Ashley','Odom',181,2004),
('Joshua','Smith',183,2005),
('Paul','Combs',211,2004),
('Cheryl','Neal',180,2005),
('Stephen','Brooks',215,1992),
('Darius','Dyer',193,1994),
('Jeffery','Young',181,1996),
('Mario','Jones',177,1999),
('John','Medina',199,1990),
('David','Maynard',203,1987),
('Hunter','Huber',205,1992),
('Ernest','Nelson',208,1988),
('Crystal','Ramos',183,1997),
('Kimberly','Williams',210,1990),
('Bryan','Pierce',190,1992),
('Amy','Long',211,2005),
('Jeremy','Hill',205,1987),
('Jesse','Campbell',218,1989),
('Michael','Small',185,1995),
('Karen','Mcdonald',206,1986),
('Vanessa','Huynh',189,1993),
('Miguel','Walters',196,2003),
('Adam','Gomez',206,1995),
('Alex','Perez',207,1998),
('Tiffany','Martinez',175,1986),
('Melvin','Kramer',198,1986),
('David','Hall',190,1991),
('Robin','Powell',187,1993),
('Elizabeth','Snow',197,2004),
('Andrea','Gray',183,1999),
('Michael','Collins',214,1991),
('Randall','Wallace',211,1991),
('Katherine','Nelson',175,1989),
('William','Hunter',189,1995),
('Brittany','Smith',204,1986),
('Tyler','Golden',212,2002),
('Lisa','Hoffman',192,1992),
('Mark','Dunn',192,1995),
('Andrew','Parker',193,1997),
('Daniel','Allen',184,1997),
('Richard','Wilson',217,2001),
('Ashley','Rodriguez',177,2002),
('Rose','Campbell',197,1985),
('Jose','Mccullough',178,1987),
('Brandon','Torres',212,1994),
('James','Adams',178,1998),
('Tammie','Walsh',184,1990),
('Laura','Davis',190,2005),
('Amanda','Rowe',211,2002),
('Valerie','Mitchell',203,1985),
('David','Farrell',206,1990),
('Eric','Glover',193,1996),
('James','Martinez',179,1985),
('Patricia','Diaz',214,2002),
('Debra','Jenkins',206,1996),
('Jeffery','Valencia',191,1985),
('Kathleen','Reed',194,2002),
('Wayne','Kelley',213,1988),
('David','Vargas',217,1996),
('Amanda','Osborne',204,1985),
('Susan','Brooks',210,1990),
('Christopher','Bowman',187,1989),
('Alex','Sloan',211,1992),
('Brenda','Gaines',188,2003),
('Betty','Waters',181,2001),
('Leah','Miller',202,2001),
('Michael','Soto',196,2005),
('Rebecca','Schmidt',212,1988),
('Mark','Johnson',206,1989),
('Dustin','Ramirez',196,1996),
('William','Harris',201,1996),
('Alexandria','Carney',217,2005),
('Jim','Alexander',181,1996),
('Johnny','Galloway',201,1998),
('James','Simmons',197,2002),
('Tracy','Smith',185,1985),
('Bethany','Johnson',186,1994),
('Christopher','Miller',206,1996),
('William','Porter',207,2001),
('Christina','Gonzalez',203,2003),
('Charles','Smith',197,1995),
('Christine','Hart',217,2000),
('Sharon','Martinez',197,1988),
('Jessica','Knapp',184,1995),
('Andrew','Carter',189,1989),
('Amanda','Saunders',195,1985),
('Kelly','Morris',220,1986),
('Christopher','Harris',215,1997),
('Bobby','Velazquez',198,1997),
('Francisco','Erickson',193,1985),
('Gail','Romero',200,1992),
('Samantha','Walker',187,1998),
('Kimberly','Jones',207,1988),
('Patricia','Webster',194,1997),
('Tamara','Miller',204,1996),
('Kimberly','Price',217,1985),
('Tyrone','Jones',220,2005),
('Crystal','Hall',195,1985),
('Todd','Lee',186,1985),
('James','Barry',216,2002),
('Nancy','Harris',214,2002),
('Christine','Chen',175,2005),
('David','Thompson',179,2002),
('Kevin','Cruz',182,2005),
('Andrew','Bowman',188,1985),
('Karen','Perkins',181,2000),
('Manuel','Stafford',187,2001),
('Linda','Gomez',192,1995),
('Alex','Cortez',215,1995),
('Stephen','Juarez',175,1986),
('Kristina','Pratt',179,1997),
('Jessica','Smith',203,1986),
('Chad','Edwards',187,1992),
('David','Fleming',214,1999),
('Donald','Mcmahon',201,1998),
('Cesar','Miller',188,1988),
('Nicholas','Ortiz',188,1988),
('Jeffrey','Hernandez',218,2002),
('Ashley','Ferguson',206,1996),
('Eric','Day',215,2004),
('Robert','Salazar',184,1989),
('Jonathan','Hughes',214,1988),
('Mark','Maldonado',198,1996),
('Xavier','Gibson',186,1999),
('Steven','Lowe',177,1991),
('Gabriela','James',185,1990),
('Michael','Johnson',191,1990),
('Michele','Smith',185,1986);

-- Popolamento tabella `player_team` per assegnare i giocatori alle squadre
INSERT INTO `player_team` (`player_id`, `team_id`, `number`, `date_start_utc`, `date_end_utc`) values (1,1,1,1725141600,null);
INSERT INTO `player_team` (`player_id`, `team_id`, `number`, `date_start_utc`, `date_end_utc`) values (2,1,2,1725141600,null);
INSERT INTO `player_team` (`player_id`, `team_id`, `number`, `date_start_utc`, `date_end_utc`) values (3,1,3,1725141600,null);
INSERT INTO `player_team` (`player_id`, `team_id`, `number`, `date_start_utc`, `date_end_utc`) values (4,1,4,1725141600,null);
INSERT INTO `player_team` (`player_id`, `team_id`, `number`, `date_start_utc`, `date_end_utc`) values (5,1,5,1725141600,null);
INSERT INTO `player_team` (`player_id`, `team_id`, `number`, `date_start_utc`, `date_end_utc`) values (6,1,6,1725141600,null);
INSERT INTO `player_team` (`player_id`, `team_id`, `number`, `date_start_utc`, `date_end_utc`) values (7,1,7,1725141600,null);
INSERT INTO `player_team` (`player_id`, `team_id`, `number`, `date_start_utc`, `date_end_utc`) values (8,1,8,1725141600,null);
INSERT INTO `player_team` (`player_id`, `team_id`, `number`, `date_start_utc`, `date_end_utc`) values (9,1,9,1725141600,null);
INSERT INTO `player_team` (`player_id`, `team_id`, `number`, `date_start_utc`, `date_end_utc`) values (10,1,10,1725141600,null);
INSERT INTO `player_team` (`player_id`, `team_id`, `number`, `date_start_utc`, `date_end_utc`) values (11,2,11,1725141600,null);
INSERT INTO `player_team` (`player_id`, `team_id`, `number`, `date_start_utc`, `date_end_utc`) values (12,2,12,1725141600,null);
INSERT INTO `player_team` (`player_id`, `team_id`, `number`, `date_start_utc`, `date_end_utc`) values (13,2,13,1725141600,null);
INSERT INTO `player_team` (`player_id`, `team_id`, `number`, `date_start_utc`, `date_end_utc`) values (14,2,14,1725141600,null);
INSERT INTO `player_team` (`player_id`, `team_id`, `number`, `date_start_utc`, `date_end_utc`) values (15,2,15,1725141600,null);
INSERT INTO `player_team` (`player_id`, `team_id`, `number`, `date_start_utc`, `date_end_utc`) values (16,2,16,1725141600,null);
INSERT INTO `player_team` (`player_id`, `team_id`, `number`, `date_start_utc`, `date_end_utc`) values (17,2,17,1725141600,null);
INSERT INTO `player_team` (`player_id`, `team_id`, `number`, `date_start_utc`, `date_end_utc`) values (18,2,18,1725141600,null);
INSERT INTO `player_team` (`player_id`, `team_id`, `number`, `date_start_utc`, `date_end_utc`) values (19,2,19,1725141600,null);
INSERT INTO `player_team` (`player_id`, `team_id`, `number`, `date_start_utc`, `date_end_utc`) values (20,2,20,1725141600,null);
INSERT INTO `player_team` (`player_id`, `team_id`, `number`, `date_start_utc`, `date_end_utc`) values (21,3,21,1725141600,null);
INSERT INTO `player_team` (`player_id`, `team_id`, `number`, `date_start_utc`, `date_end_utc`) values (22,3,22,1725141600,null);
INSERT INTO `player_team` (`player_id`, `team_id`, `number`, `date_start_utc`, `date_end_utc`) values (23,3,23,1725141600,null);
INSERT INTO `player_team` (`player_id`, `team_id`, `number`, `date_start_utc`, `date_end_utc`) values (24,3,24,1725141600,null);
INSERT INTO `player_team` (`player_id`, `team_id`, `number`, `date_start_utc`, `date_end_utc`) values (25,3,25,1725141600,null);
INSERT INTO `player_team` (`player_id`, `team_id`, `number`, `date_start_utc`, `date_end_utc`) values (26,3,26,1725141600,null);
INSERT INTO `player_team` (`player_id`, `team_id`, `number`, `date_start_utc`, `date_end_utc`) values (27,3,27,1725141600,null);
INSERT INTO `player_team` (`player_id`, `team_id`, `number`, `date_start_utc`, `date_end_utc`) values (28,3,28,1725141600,null);
INSERT INTO `player_team` (`player_id`, `team_id`, `number`, `date_start_utc`, `date_end_utc`) values (29,3,29,1725141600,null);
INSERT INTO `player_team` (`player_id`, `team_id`, `number`, `date_start_utc`, `date_end_utc`) values (30,3,30,1725141600,null);
INSERT INTO `player_team` (`player_id`, `team_id`, `number`, `date_start_utc`, `date_end_utc`) values (31,4,31,1725141600,null);
INSERT INTO `player_team` (`player_id`, `team_id`, `number`, `date_start_utc`, `date_end_utc`) values (32,4,32,1725141600,null);
INSERT INTO `player_team` (`player_id`, `team_id`, `number`, `date_start_utc`, `date_end_utc`) values (33,4,33,1725141600,null);
INSERT INTO `player_team` (`player_id`, `team_id`, `number`, `date_start_utc`, `date_end_utc`) values (34,4,34,1725141600,null);
INSERT INTO `player_team` (`player_id`, `team_id`, `number`, `date_start_utc`, `date_end_utc`) values (35,4,35,1725141600,null);
INSERT INTO `player_team` (`player_id`, `team_id`, `number`, `date_start_utc`, `date_end_utc`) values (36,4,36,1725141600,null);
INSERT INTO `player_team` (`player_id`, `team_id`, `number`, `date_start_utc`, `date_end_utc`) values (37,4,37,1725141600,null);
INSERT INTO `player_team` (`player_id`, `team_id`, `number`, `date_start_utc`, `date_end_utc`) values (38,4,38,1725141600,null);
INSERT INTO `player_team` (`player_id`, `team_id`, `number`, `date_start_utc`, `date_end_utc`) values (39,4,39,1725141600,null);
INSERT INTO `player_team` (`player_id`, `team_id`, `number`, `date_start_utc`, `date_end_utc`) values (40,4,40,1725141600,null);
INSERT INTO `player_team` (`player_id`, `team_id`, `number`, `date_start_utc`, `date_end_utc`) values (41,5,41,1725141600,null);
INSERT INTO `player_team` (`player_id`, `team_id`, `number`, `date_start_utc`, `date_end_utc`) values (42,5,42,1725141600,null);
INSERT INTO `player_team` (`player_id`, `team_id`, `number`, `date_start_utc`, `date_end_utc`) values (43,5,43,1725141600,null);
INSERT INTO `player_team` (`player_id`, `team_id`, `number`, `date_start_utc`, `date_end_utc`) values (44,5,44,1725141600,null);
INSERT INTO `player_team` (`player_id`, `team_id`, `number`, `date_start_utc`, `date_end_utc`) values (45,5,45,1725141600,null);
INSERT INTO `player_team` (`player_id`, `team_id`, `number`, `date_start_utc`, `date_end_utc`) values (46,5,46,1725141600,null);
INSERT INTO `player_team` (`player_id`, `team_id`, `number`, `date_start_utc`, `date_end_utc`) values (47,5,47,1725141600,null);
INSERT INTO `player_team` (`player_id`, `team_id`, `number`, `date_start_utc`, `date_end_utc`) values (48,5,48,1725141600,null);
INSERT INTO `player_team` (`player_id`, `team_id`, `number`, `date_start_utc`, `date_end_utc`) values (49,5,49,1725141600,null);
INSERT INTO `player_team` (`player_id`, `team_id`, `number`, `date_start_utc`, `date_end_utc`) values (50,5,50,1725141600,null);
INSERT INTO `player_team` (`player_id`, `team_id`, `number`, `date_start_utc`, `date_end_utc`) values (51,6,51,1725141600,null);
INSERT INTO `player_team` (`player_id`, `team_id`, `number`, `date_start_utc`, `date_end_utc`) values (52,6,52,1725141600,null);
INSERT INTO `player_team` (`player_id`, `team_id`, `number`, `date_start_utc`, `date_end_utc`) values (53,6,53,1725141600,null);
INSERT INTO `player_team` (`player_id`, `team_id`, `number`, `date_start_utc`, `date_end_utc`) values (54,6,54,1725141600,null);
INSERT INTO `player_team` (`player_id`, `team_id`, `number`, `date_start_utc`, `date_end_utc`) values (55,6,55,1725141600,null);
INSERT INTO `player_team` (`player_id`, `team_id`, `number`, `date_start_utc`, `date_end_utc`) values (56,6,56,1725141600,null);
INSERT INTO `player_team` (`player_id`, `team_id`, `number`, `date_start_utc`, `date_end_utc`) values (57,6,57,1725141600,null);
INSERT INTO `player_team` (`player_id`, `team_id`, `number`, `date_start_utc`, `date_end_utc`) values (58,6,58,1725141600,null);
INSERT INTO `player_team` (`player_id`, `team_id`, `number`, `date_start_utc`, `date_end_utc`) values (59,6,59,1725141600,null);
INSERT INTO `player_team` (`player_id`, `team_id`, `number`, `date_start_utc`, `date_end_utc`) values (60,6,60,1725141600,null);
INSERT INTO `player_team` (`player_id`, `team_id`, `number`, `date_start_utc`, `date_end_utc`) values (61,7,61,1725141600,null);
INSERT INTO `player_team` (`player_id`, `team_id`, `number`, `date_start_utc`, `date_end_utc`) values (62,7,62,1725141600,null);
INSERT INTO `player_team` (`player_id`, `team_id`, `number`, `date_start_utc`, `date_end_utc`) values (63,7,63,1725141600,null);
INSERT INTO `player_team` (`player_id`, `team_id`, `number`, `date_start_utc`, `date_end_utc`) values (64,7,64,1725141600,null);
INSERT INTO `player_team` (`player_id`, `team_id`, `number`, `date_start_utc`, `date_end_utc`) values (65,7,65,1725141600,null);
INSERT INTO `player_team` (`player_id`, `team_id`, `number`, `date_start_utc`, `date_end_utc`) values (66,7,66,1725141600,null);
INSERT INTO `player_team` (`player_id`, `team_id`, `number`, `date_start_utc`, `date_end_utc`) values (67,7,67,1725141600,null);
INSERT INTO `player_team` (`player_id`, `team_id`, `number`, `date_start_utc`, `date_end_utc`) values (68,7,68,1725141600,null);
INSERT INTO `player_team` (`player_id`, `team_id`, `number`, `date_start_utc`, `date_end_utc`) values (69,7,69,1725141600,null);
INSERT INTO `player_team` (`player_id`, `team_id`, `number`, `date_start_utc`, `date_end_utc`) values (70,7,70,1725141600,null);
INSERT INTO `player_team` (`player_id`, `team_id`, `number`, `date_start_utc`, `date_end_utc`) values (71,8,71,1725141600,null);
INSERT INTO `player_team` (`player_id`, `team_id`, `number`, `date_start_utc`, `date_end_utc`) values (72,8,72,1725141600,null);
INSERT INTO `player_team` (`player_id`, `team_id`, `number`, `date_start_utc`, `date_end_utc`) values (73,8,73,1725141600,null);
INSERT INTO `player_team` (`player_id`, `team_id`, `number`, `date_start_utc`, `date_end_utc`) values (74,8,74,1725141600,null);
INSERT INTO `player_team` (`player_id`, `team_id`, `number`, `date_start_utc`, `date_end_utc`) values (75,8,75,1725141600,null);
INSERT INTO `player_team` (`player_id`, `team_id`, `number`, `date_start_utc`, `date_end_utc`) values (76,8,76,1725141600,null);
INSERT INTO `player_team` (`player_id`, `team_id`, `number`, `date_start_utc`, `date_end_utc`) values (77,8,77,1725141600,null);
INSERT INTO `player_team` (`player_id`, `team_id`, `number`, `date_start_utc`, `date_end_utc`) values (78,8,78,1725141600,null);
INSERT INTO `player_team` (`player_id`, `team_id`, `number`, `date_start_utc`, `date_end_utc`) values (79,8,79,1725141600,null);
INSERT INTO `player_team` (`player_id`, `team_id`, `number`, `date_start_utc`, `date_end_utc`) values (80,8,80,1725141600,null);
INSERT INTO `player_team` (`player_id`, `team_id`, `number`, `date_start_utc`, `date_end_utc`) values (81,9,81,1725141600,null);
INSERT INTO `player_team` (`player_id`, `team_id`, `number`, `date_start_utc`, `date_end_utc`) values (82,9,82,1725141600,null);
INSERT INTO `player_team` (`player_id`, `team_id`, `number`, `date_start_utc`, `date_end_utc`) values (83,9,83,1725141600,null);
INSERT INTO `player_team` (`player_id`, `team_id`, `number`, `date_start_utc`, `date_end_utc`) values (84,9,84,1725141600,null);
INSERT INTO `player_team` (`player_id`, `team_id`, `number`, `date_start_utc`, `date_end_utc`) values (85,9,85,1725141600,null);
INSERT INTO `player_team` (`player_id`, `team_id`, `number`, `date_start_utc`, `date_end_utc`) values (86,9,86,1725141600,null);
INSERT INTO `player_team` (`player_id`, `team_id`, `number`, `date_start_utc`, `date_end_utc`) values (87,9,87,1725141600,null);
INSERT INTO `player_team` (`player_id`, `team_id`, `number`, `date_start_utc`, `date_end_utc`) values (88,9,88,1725141600,null);
INSERT INTO `player_team` (`player_id`, `team_id`, `number`, `date_start_utc`, `date_end_utc`) values (89,9,89,1725141600,null);
INSERT INTO `player_team` (`player_id`, `team_id`, `number`, `date_start_utc`, `date_end_utc`) values (90,9,90,1725141600,null);
INSERT INTO `player_team` (`player_id`, `team_id`, `number`, `date_start_utc`, `date_end_utc`) values (91,10,91,1725141600,null);
INSERT INTO `player_team` (`player_id`, `team_id`, `number`, `date_start_utc`, `date_end_utc`) values (92,10,92,1725141600,null);
INSERT INTO `player_team` (`player_id`, `team_id`, `number`, `date_start_utc`, `date_end_utc`) values (93,10,93,1725141600,null);
INSERT INTO `player_team` (`player_id`, `team_id`, `number`, `date_start_utc`, `date_end_utc`) values (94,10,94,1725141600,null);
INSERT INTO `player_team` (`player_id`, `team_id`, `number`, `date_start_utc`, `date_end_utc`) values (95,10,95,1725141600,null);
INSERT INTO `player_team` (`player_id`, `team_id`, `number`, `date_start_utc`, `date_end_utc`) values (96,10,96,1725141600,null);
INSERT INTO `player_team` (`player_id`, `team_id`, `number`, `date_start_utc`, `date_end_utc`) values (97,10,97,1725141600,null);
INSERT INTO `player_team` (`player_id`, `team_id`, `number`, `date_start_utc`, `date_end_utc`) values (98,10,98,1725141600,null);
INSERT INTO `player_team` (`player_id`, `team_id`, `number`, `date_start_utc`, `date_end_utc`) values (99,10,99,1725141600,null);
INSERT INTO `player_team` (`player_id`, `team_id`, `number`, `date_start_utc`, `date_end_utc`) values (100,10,100,1725141600,null);
INSERT INTO `player_team` (`player_id`, `team_id`, `number`, `date_start_utc`, `date_end_utc`) values (101,11,101,1725141600,null);
INSERT INTO `player_team` (`player_id`, `team_id`, `number`, `date_start_utc`, `date_end_utc`) values (102,11,102,1725141600,null);
INSERT INTO `player_team` (`player_id`, `team_id`, `number`, `date_start_utc`, `date_end_utc`) values (103,11,103,1725141600,null);
INSERT INTO `player_team` (`player_id`, `team_id`, `number`, `date_start_utc`, `date_end_utc`) values (104,11,104,1725141600,null);
INSERT INTO `player_team` (`player_id`, `team_id`, `number`, `date_start_utc`, `date_end_utc`) values (105,11,105,1725141600,null);
INSERT INTO `player_team` (`player_id`, `team_id`, `number`, `date_start_utc`, `date_end_utc`) values (106,11,106,1725141600,null);
INSERT INTO `player_team` (`player_id`, `team_id`, `number`, `date_start_utc`, `date_end_utc`) values (107,11,107,1725141600,null);
INSERT INTO `player_team` (`player_id`, `team_id`, `number`, `date_start_utc`, `date_end_utc`) values (108,11,108,1725141600,null);
INSERT INTO `player_team` (`player_id`, `team_id`, `number`, `date_start_utc`, `date_end_utc`) values (109,11,109,1725141600,null);
INSERT INTO `player_team` (`player_id`, `team_id`, `number`, `date_start_utc`, `date_end_utc`) values (110,11,110,1725141600,null);
INSERT INTO `player_team` (`player_id`, `team_id`, `number`, `date_start_utc`, `date_end_utc`) values (111,12,111,1725141600,null);
INSERT INTO `player_team` (`player_id`, `team_id`, `number`, `date_start_utc`, `date_end_utc`) values (112,12,112,1725141600,null);
INSERT INTO `player_team` (`player_id`, `team_id`, `number`, `date_start_utc`, `date_end_utc`) values (113,12,113,1725141600,null);
INSERT INTO `player_team` (`player_id`, `team_id`, `number`, `date_start_utc`, `date_end_utc`) values (114,12,114,1725141600,null);
INSERT INTO `player_team` (`player_id`, `team_id`, `number`, `date_start_utc`, `date_end_utc`) values (115,12,115,1725141600,null);
INSERT INTO `player_team` (`player_id`, `team_id`, `number`, `date_start_utc`, `date_end_utc`) values (116,12,116,1725141600,null);
INSERT INTO `player_team` (`player_id`, `team_id`, `number`, `date_start_utc`, `date_end_utc`) values (117,12,117,1725141600,null);
INSERT INTO `player_team` (`player_id`, `team_id`, `number`, `date_start_utc`, `date_end_utc`) values (118,12,118,1725141600,null);
INSERT INTO `player_team` (`player_id`, `team_id`, `number`, `date_start_utc`, `date_end_utc`) values (119,12,119,1725141600,null);
INSERT INTO `player_team` (`player_id`, `team_id`, `number`, `date_start_utc`, `date_end_utc`) values (120,12,120,1725141600,null);
INSERT INTO `player_team` (`player_id`, `team_id`, `number`, `date_start_utc`, `date_end_utc`) values (121,13,121,1725141600,null);
INSERT INTO `player_team` (`player_id`, `team_id`, `number`, `date_start_utc`, `date_end_utc`) values (122,13,122,1725141600,null);
INSERT INTO `player_team` (`player_id`, `team_id`, `number`, `date_start_utc`, `date_end_utc`) values (123,13,123,1725141600,null);
INSERT INTO `player_team` (`player_id`, `team_id`, `number`, `date_start_utc`, `date_end_utc`) values (124,13,124,1725141600,null);
INSERT INTO `player_team` (`player_id`, `team_id`, `number`, `date_start_utc`, `date_end_utc`) values (125,13,125,1725141600,null);
INSERT INTO `player_team` (`player_id`, `team_id`, `number`, `date_start_utc`, `date_end_utc`) values (126,13,126,1725141600,null);
INSERT INTO `player_team` (`player_id`, `team_id`, `number`, `date_start_utc`, `date_end_utc`) values (127,13,127,1725141600,null);
INSERT INTO `player_team` (`player_id`, `team_id`, `number`, `date_start_utc`, `date_end_utc`) values (128,13,128,1725141600,null);
INSERT INTO `player_team` (`player_id`, `team_id`, `number`, `date_start_utc`, `date_end_utc`) values (129,13,129,1725141600,null);
INSERT INTO `player_team` (`player_id`, `team_id`, `number`, `date_start_utc`, `date_end_utc`) values (130,13,130,1725141600,null);
INSERT INTO `player_team` (`player_id`, `team_id`, `number`, `date_start_utc`, `date_end_utc`) values (131,14,131,1725141600,null);
INSERT INTO `player_team` (`player_id`, `team_id`, `number`, `date_start_utc`, `date_end_utc`) values (132,14,132,1725141600,null);
INSERT INTO `player_team` (`player_id`, `team_id`, `number`, `date_start_utc`, `date_end_utc`) values (133,14,133,1725141600,null);
INSERT INTO `player_team` (`player_id`, `team_id`, `number`, `date_start_utc`, `date_end_utc`) values (134,14,134,1725141600,null);
INSERT INTO `player_team` (`player_id`, `team_id`, `number`, `date_start_utc`, `date_end_utc`) values (135,14,135,1725141600,null);
INSERT INTO `player_team` (`player_id`, `team_id`, `number`, `date_start_utc`, `date_end_utc`) values (136,14,136,1725141600,null);
INSERT INTO `player_team` (`player_id`, `team_id`, `number`, `date_start_utc`, `date_end_utc`) values (137,14,137,1725141600,null);
INSERT INTO `player_team` (`player_id`, `team_id`, `number`, `date_start_utc`, `date_end_utc`) values (138,14,138,1725141600,null);
INSERT INTO `player_team` (`player_id`, `team_id`, `number`, `date_start_utc`, `date_end_utc`) values (139,14,139,1725141600,null);
INSERT INTO `player_team` (`player_id`, `team_id`, `number`, `date_start_utc`, `date_end_utc`) values (140,14,140,1725141600,null);
INSERT INTO `player_team` (`player_id`, `team_id`, `number`, `date_start_utc`, `date_end_utc`) values (141,15,141,1725141600,null);
INSERT INTO `player_team` (`player_id`, `team_id`, `number`, `date_start_utc`, `date_end_utc`) values (142,15,142,1725141600,null);
INSERT INTO `player_team` (`player_id`, `team_id`, `number`, `date_start_utc`, `date_end_utc`) values (143,15,143,1725141600,null);
INSERT INTO `player_team` (`player_id`, `team_id`, `number`, `date_start_utc`, `date_end_utc`) values (144,15,144,1725141600,null);
INSERT INTO `player_team` (`player_id`, `team_id`, `number`, `date_start_utc`, `date_end_utc`) values (145,15,145,1725141600,null);
INSERT INTO `player_team` (`player_id`, `team_id`, `number`, `date_start_utc`, `date_end_utc`) values (146,15,146,1725141600,null);
INSERT INTO `player_team` (`player_id`, `team_id`, `number`, `date_start_utc`, `date_end_utc`) values (147,15,147,1725141600,null);
INSERT INTO `player_team` (`player_id`, `team_id`, `number`, `date_start_utc`, `date_end_utc`) values (148,15,148,1725141600,null);
INSERT INTO `player_team` (`player_id`, `team_id`, `number`, `date_start_utc`, `date_end_utc`) values (149,15,149,1725141600,null);
INSERT INTO `player_team` (`player_id`, `team_id`, `number`, `date_start_utc`, `date_end_utc`) values (150,15,150,1725141600,null);
INSERT INTO `player_team` (`player_id`, `team_id`, `number`, `date_start_utc`, `date_end_utc`) values (151,16,151,1725141600,null);
INSERT INTO `player_team` (`player_id`, `team_id`, `number`, `date_start_utc`, `date_end_utc`) values (152,16,152,1725141600,null);
INSERT INTO `player_team` (`player_id`, `team_id`, `number`, `date_start_utc`, `date_end_utc`) values (153,16,153,1725141600,null);
INSERT INTO `player_team` (`player_id`, `team_id`, `number`, `date_start_utc`, `date_end_utc`) values (154,16,154,1725141600,null);
INSERT INTO `player_team` (`player_id`, `team_id`, `number`, `date_start_utc`, `date_end_utc`) values (155,16,155,1725141600,null);
INSERT INTO `player_team` (`player_id`, `team_id`, `number`, `date_start_utc`, `date_end_utc`) values (156,16,156,1725141600,null);
INSERT INTO `player_team` (`player_id`, `team_id`, `number`, `date_start_utc`, `date_end_utc`) values (157,16,157,1725141600,null);
INSERT INTO `player_team` (`player_id`, `team_id`, `number`, `date_start_utc`, `date_end_utc`) values (158,16,158,1725141600,null);
INSERT INTO `player_team` (`player_id`, `team_id`, `number`, `date_start_utc`, `date_end_utc`) values (159,16,159,1725141600,null);
INSERT INTO `player_team` (`player_id`, `team_id`, `number`, `date_start_utc`, `date_end_utc`) values (160,16,160,1725141600,null);


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

-- Creazione partite, 10 giornate
INSERT INTO `game` (`league_year_id`, `type_game_id`, `team_home_id`, `team_guest_id`, `date_hours_utc`, `referee_1_id`, `referee_2_id`, `referee_3_id`)VALUES (1, 1, 15,3, 1725222600, 1, 2, 3);
INSERT INTO `game` (`league_year_id`, `type_game_id`, `team_home_id`, `team_guest_id`, `date_hours_utc`, `referee_1_id`, `referee_2_id`, `referee_3_id`)VALUES (1, 1, 16,6, 1725222600, 1, 2, 3);
INSERT INTO `game` (`league_year_id`, `type_game_id`, `team_home_id`, `team_guest_id`, `date_hours_utc`, `referee_1_id`, `referee_2_id`, `referee_3_id`)VALUES (1, 1, 7,2, 1725222600, 1, 2, 3);
INSERT INTO `game` (`league_year_id`, `type_game_id`, `team_home_id`, `team_guest_id`, `date_hours_utc`, `referee_1_id`, `referee_2_id`, `referee_3_id`)VALUES (1, 1, 14,1, 1725222600, 1, 2, 3);
INSERT INTO `game` (`league_year_id`, `type_game_id`, `team_home_id`, `team_guest_id`, `date_hours_utc`, `referee_1_id`, `referee_2_id`, `referee_3_id`)VALUES (1, 1, 10,13, 1725222600, 1, 2, 3);
INSERT INTO `game` (`league_year_id`, `type_game_id`, `team_home_id`, `team_guest_id`, `date_hours_utc`, `referee_1_id`, `referee_2_id`, `referee_3_id`)VALUES (1, 1, 11,9, 1725222600, 1, 2, 3);
INSERT INTO `game` (`league_year_id`, `type_game_id`, `team_home_id`, `team_guest_id`, `date_hours_utc`, `referee_1_id`, `referee_2_id`, `referee_3_id`)VALUES (1, 1, 8,4, 1725222600, 1, 2, 3);
INSERT INTO `game` (`league_year_id`, `type_game_id`, `team_home_id`, `team_guest_id`, `date_hours_utc`, `referee_1_id`, `referee_2_id`, `referee_3_id`)VALUES (1, 1, 5,12, 1725222600, 1, 2, 3);
INSERT INTO `game` (`league_year_id`, `type_game_id`, `team_home_id`, `team_guest_id`, `date_hours_utc`, `referee_1_id`, `referee_2_id`, `referee_3_id`)VALUES (1, 1, 13,15, 1725827400, 1, 2, 3);
INSERT INTO `game` (`league_year_id`, `type_game_id`, `team_home_id`, `team_guest_id`, `date_hours_utc`, `referee_1_id`, `referee_2_id`, `referee_3_id`)VALUES (1, 1, 7,16, 1725827400, 1, 2, 3);
INSERT INTO `game` (`league_year_id`, `type_game_id`, `team_home_id`, `team_guest_id`, `date_hours_utc`, `referee_1_id`, `referee_2_id`, `referee_3_id`)VALUES (1, 1, 4,11, 1725827400, 1, 2, 3);
INSERT INTO `game` (`league_year_id`, `type_game_id`, `team_home_id`, `team_guest_id`, `date_hours_utc`, `referee_1_id`, `referee_2_id`, `referee_3_id`)VALUES (1, 1, 8,5, 1725827400, 1, 2, 3);
INSERT INTO `game` (`league_year_id`, `type_game_id`, `team_home_id`, `team_guest_id`, `date_hours_utc`, `referee_1_id`, `referee_2_id`, `referee_3_id`)VALUES (1, 1, 6,14, 1725827400, 1, 2, 3);
INSERT INTO `game` (`league_year_id`, `type_game_id`, `team_home_id`, `team_guest_id`, `date_hours_utc`, `referee_1_id`, `referee_2_id`, `referee_3_id`)VALUES (1, 1, 10,1, 1725827400, 1, 2, 3);
INSERT INTO `game` (`league_year_id`, `type_game_id`, `team_home_id`, `team_guest_id`, `date_hours_utc`, `referee_1_id`, `referee_2_id`, `referee_3_id`)VALUES (1, 1, 2,12, 1725827400, 1, 2, 3);
INSERT INTO `game` (`league_year_id`, `type_game_id`, `team_home_id`, `team_guest_id`, `date_hours_utc`, `referee_1_id`, `referee_2_id`, `referee_3_id`)VALUES (1, 1, 3,9, 1725827400, 1, 2, 3);
INSERT INTO `game` (`league_year_id`, `type_game_id`, `team_home_id`, `team_guest_id`, `date_hours_utc`, `referee_1_id`, `referee_2_id`, `referee_3_id`)VALUES (1, 1, 6,7, 1726432200, 1, 2, 3);
INSERT INTO `game` (`league_year_id`, `type_game_id`, `team_home_id`, `team_guest_id`, `date_hours_utc`, `referee_1_id`, `referee_2_id`, `referee_3_id`)VALUES (1, 1, 5,9, 1726432200, 1, 2, 3);
INSERT INTO `game` (`league_year_id`, `type_game_id`, `team_home_id`, `team_guest_id`, `date_hours_utc`, `referee_1_id`, `referee_2_id`, `referee_3_id`)VALUES (1, 1, 12,13, 1726432200, 1, 2, 3);
INSERT INTO `game` (`league_year_id`, `type_game_id`, `team_home_id`, `team_guest_id`, `date_hours_utc`, `referee_1_id`, `referee_2_id`, `referee_3_id`)VALUES (1, 1, 10,14, 1726432200, 1, 2, 3);
INSERT INTO `game` (`league_year_id`, `type_game_id`, `team_home_id`, `team_guest_id`, `date_hours_utc`, `referee_1_id`, `referee_2_id`, `referee_3_id`)VALUES (1, 1, 16,2, 1726432200, 1, 2, 3);
INSERT INTO `game` (`league_year_id`, `type_game_id`, `team_home_id`, `team_guest_id`, `date_hours_utc`, `referee_1_id`, `referee_2_id`, `referee_3_id`)VALUES (1, 1, 11,3, 1726432200, 1, 2, 3);
INSERT INTO `game` (`league_year_id`, `type_game_id`, `team_home_id`, `team_guest_id`, `date_hours_utc`, `referee_1_id`, `referee_2_id`, `referee_3_id`)VALUES (1, 1, 8,1, 1726432200, 1, 2, 3);
INSERT INTO `game` (`league_year_id`, `type_game_id`, `team_home_id`, `team_guest_id`, `date_hours_utc`, `referee_1_id`, `referee_2_id`, `referee_3_id`)VALUES (1, 1, 15,4, 1726432200, 1, 2, 3);
INSERT INTO `game` (`league_year_id`, `type_game_id`, `team_home_id`, `team_guest_id`, `date_hours_utc`, `referee_1_id`, `referee_2_id`, `referee_3_id`)VALUES (1, 1, 10,15, 1727037000, 1, 2, 3);
INSERT INTO `game` (`league_year_id`, `type_game_id`, `team_home_id`, `team_guest_id`, `date_hours_utc`, `referee_1_id`, `referee_2_id`, `referee_3_id`)VALUES (1, 1, 5,7, 1727037000, 1, 2, 3);
INSERT INTO `game` (`league_year_id`, `type_game_id`, `team_home_id`, `team_guest_id`, `date_hours_utc`, `referee_1_id`, `referee_2_id`, `referee_3_id`)VALUES (1, 1, 16,1, 1727037000, 1, 2, 3);
INSERT INTO `game` (`league_year_id`, `type_game_id`, `team_home_id`, `team_guest_id`, `date_hours_utc`, `referee_1_id`, `referee_2_id`, `referee_3_id`)VALUES (1, 1, 11,8, 1727037000, 1, 2, 3);
INSERT INTO `game` (`league_year_id`, `type_game_id`, `team_home_id`, `team_guest_id`, `date_hours_utc`, `referee_1_id`, `referee_2_id`, `referee_3_id`)VALUES (1, 1, 4,2, 1727037000, 1, 2, 3);
INSERT INTO `game` (`league_year_id`, `type_game_id`, `team_home_id`, `team_guest_id`, `date_hours_utc`, `referee_1_id`, `referee_2_id`, `referee_3_id`)VALUES (1, 1, 9,6, 1727037000, 1, 2, 3);
INSERT INTO `game` (`league_year_id`, `type_game_id`, `team_home_id`, `team_guest_id`, `date_hours_utc`, `referee_1_id`, `referee_2_id`, `referee_3_id`)VALUES (1, 1, 13,3, 1727037000, 1, 2, 3);
INSERT INTO `game` (`league_year_id`, `type_game_id`, `team_home_id`, `team_guest_id`, `date_hours_utc`, `referee_1_id`, `referee_2_id`, `referee_3_id`)VALUES (1, 1, 14,12, 1727037000, 1, 2, 3);
INSERT INTO `game` (`league_year_id`, `type_game_id`, `team_home_id`, `team_guest_id`, `date_hours_utc`, `referee_1_id`, `referee_2_id`, `referee_3_id`)VALUES (1, 1, 6,12, 1727641800, 1, 2, 3);
INSERT INTO `game` (`league_year_id`, `type_game_id`, `team_home_id`, `team_guest_id`, `date_hours_utc`, `referee_1_id`, `referee_2_id`, `referee_3_id`)VALUES (1, 1, 11,14, 1727641800, 1, 2, 3);
INSERT INTO `game` (`league_year_id`, `type_game_id`, `team_home_id`, `team_guest_id`, `date_hours_utc`, `referee_1_id`, `referee_2_id`, `referee_3_id`)VALUES (1, 1, 10,4, 1727641800, 1, 2, 3);
INSERT INTO `game` (`league_year_id`, `type_game_id`, `team_home_id`, `team_guest_id`, `date_hours_utc`, `referee_1_id`, `referee_2_id`, `referee_3_id`)VALUES (1, 1, 3,16, 1727641800, 1, 2, 3);
INSERT INTO `game` (`league_year_id`, `type_game_id`, `team_home_id`, `team_guest_id`, `date_hours_utc`, `referee_1_id`, `referee_2_id`, `referee_3_id`)VALUES (1, 1, 8,7, 1727641800, 1, 2, 3);
INSERT INTO `game` (`league_year_id`, `type_game_id`, `team_home_id`, `team_guest_id`, `date_hours_utc`, `referee_1_id`, `referee_2_id`, `referee_3_id`)VALUES (1, 1, 9,13, 1727641800, 1, 2, 3);
INSERT INTO `game` (`league_year_id`, `type_game_id`, `team_home_id`, `team_guest_id`, `date_hours_utc`, `referee_1_id`, `referee_2_id`, `referee_3_id`)VALUES (1, 1, 15,5, 1727641800, 1, 2, 3);
INSERT INTO `game` (`league_year_id`, `type_game_id`, `team_home_id`, `team_guest_id`, `date_hours_utc`, `referee_1_id`, `referee_2_id`, `referee_3_id`)VALUES (1, 1, 1,2, 1727641800, 1, 2, 3);
INSERT INTO `game` (`league_year_id`, `type_game_id`, `team_home_id`, `team_guest_id`, `date_hours_utc`, `referee_1_id`, `referee_2_id`, `referee_3_id`)VALUES (1, 1, 10,9, 1728246600, 1, 2, 3);
INSERT INTO `game` (`league_year_id`, `type_game_id`, `team_home_id`, `team_guest_id`, `date_hours_utc`, `referee_1_id`, `referee_2_id`, `referee_3_id`)VALUES (1, 1, 14,8, 1728246600, 1, 2, 3);
INSERT INTO `game` (`league_year_id`, `type_game_id`, `team_home_id`, `team_guest_id`, `date_hours_utc`, `referee_1_id`, `referee_2_id`, `referee_3_id`)VALUES (1, 1, 3,1, 1728246600, 1, 2, 3);
INSERT INTO `game` (`league_year_id`, `type_game_id`, `team_home_id`, `team_guest_id`, `date_hours_utc`, `referee_1_id`, `referee_2_id`, `referee_3_id`)VALUES (1, 1, 12,16, 1728246600, 1, 2, 3);
INSERT INTO `game` (`league_year_id`, `type_game_id`, `team_home_id`, `team_guest_id`, `date_hours_utc`, `referee_1_id`, `referee_2_id`, `referee_3_id`)VALUES (1, 1, 13,11, 1728246600, 1, 2, 3);
INSERT INTO `game` (`league_year_id`, `type_game_id`, `team_home_id`, `team_guest_id`, `date_hours_utc`, `referee_1_id`, `referee_2_id`, `referee_3_id`)VALUES (1, 1, 7,4, 1728246600, 1, 2, 3);
INSERT INTO `game` (`league_year_id`, `type_game_id`, `team_home_id`, `team_guest_id`, `date_hours_utc`, `referee_1_id`, `referee_2_id`, `referee_3_id`)VALUES (1, 1, 6,15, 1728246600, 1, 2, 3);
INSERT INTO `game` (`league_year_id`, `type_game_id`, `team_home_id`, `team_guest_id`, `date_hours_utc`, `referee_1_id`, `referee_2_id`, `referee_3_id`)VALUES (1, 1, 2,5, 1728246600, 1, 2, 3);
INSERT INTO `game` (`league_year_id`, `type_game_id`, `team_home_id`, `team_guest_id`, `date_hours_utc`, `referee_1_id`, `referee_2_id`, `referee_3_id`)VALUES (1, 1, 14,9, 1728851400, 1, 2, 3);
INSERT INTO `game` (`league_year_id`, `type_game_id`, `team_home_id`, `team_guest_id`, `date_hours_utc`, `referee_1_id`, `referee_2_id`, `referee_3_id`)VALUES (1, 1, 7,12, 1728851400, 1, 2, 3);
INSERT INTO `game` (`league_year_id`, `type_game_id`, `team_home_id`, `team_guest_id`, `date_hours_utc`, `referee_1_id`, `referee_2_id`, `referee_3_id`)VALUES (1, 1, 2,6, 1728851400, 1, 2, 3);
INSERT INTO `game` (`league_year_id`, `type_game_id`, `team_home_id`, `team_guest_id`, `date_hours_utc`, `referee_1_id`, `referee_2_id`, `referee_3_id`)VALUES (1, 1, 15,1, 1728851400, 1, 2, 3);
INSERT INTO `game` (`league_year_id`, `type_game_id`, `team_home_id`, `team_guest_id`, `date_hours_utc`, `referee_1_id`, `referee_2_id`, `referee_3_id`)VALUES (1, 1, 4,13, 1728851400, 1, 2, 3);
INSERT INTO `game` (`league_year_id`, `type_game_id`, `team_home_id`, `team_guest_id`, `date_hours_utc`, `referee_1_id`, `referee_2_id`, `referee_3_id`)VALUES (1, 1, 5,11, 1728851400, 1, 2, 3);
INSERT INTO `game` (`league_year_id`, `type_game_id`, `team_home_id`, `team_guest_id`, `date_hours_utc`, `referee_1_id`, `referee_2_id`, `referee_3_id`)VALUES (1, 1, 8,16, 1728851400, 1, 2, 3);
INSERT INTO `game` (`league_year_id`, `type_game_id`, `team_home_id`, `team_guest_id`, `date_hours_utc`, `referee_1_id`, `referee_2_id`, `referee_3_id`)VALUES (1, 1, 3,10, 1728851400, 1, 2, 3);
INSERT INTO `game` (`league_year_id`, `type_game_id`, `team_home_id`, `team_guest_id`, `date_hours_utc`, `referee_1_id`, `referee_2_id`, `referee_3_id`)VALUES (1, 1, 12,1, 1729456200, 1, 2, 3);
INSERT INTO `game` (`league_year_id`, `type_game_id`, `team_home_id`, `team_guest_id`, `date_hours_utc`, `referee_1_id`, `referee_2_id`, `referee_3_id`)VALUES (1, 1, 3,4, 1729456200, 1, 2, 3);
INSERT INTO `game` (`league_year_id`, `type_game_id`, `team_home_id`, `team_guest_id`, `date_hours_utc`, `referee_1_id`, `referee_2_id`, `referee_3_id`)VALUES (1, 1, 9,2, 1729456200, 1, 2, 3);
INSERT INTO `game` (`league_year_id`, `type_game_id`, `team_home_id`, `team_guest_id`, `date_hours_utc`, `referee_1_id`, `referee_2_id`, `referee_3_id`)VALUES (1, 1, 13,8, 1729456200, 1, 2, 3);
INSERT INTO `game` (`league_year_id`, `type_game_id`, `team_home_id`, `team_guest_id`, `date_hours_utc`, `referee_1_id`, `referee_2_id`, `referee_3_id`)VALUES (1, 1, 11,15, 1729456200, 1, 2, 3);
INSERT INTO `game` (`league_year_id`, `type_game_id`, `team_home_id`, `team_guest_id`, `date_hours_utc`, `referee_1_id`, `referee_2_id`, `referee_3_id`)VALUES (1, 1, 10,6, 1729456200, 1, 2, 3);
INSERT INTO `game` (`league_year_id`, `type_game_id`, `team_home_id`, `team_guest_id`, `date_hours_utc`, `referee_1_id`, `referee_2_id`, `referee_3_id`)VALUES (1, 1, 7,14, 1729456200, 1, 2, 3);
INSERT INTO `game` (`league_year_id`, `type_game_id`, `team_home_id`, `team_guest_id`, `date_hours_utc`, `referee_1_id`, `referee_2_id`, `referee_3_id`)VALUES (1, 1, 16,5, 1729456200, 1, 2, 3);
INSERT INTO `game` (`league_year_id`, `type_game_id`, `team_home_id`, `team_guest_id`, `date_hours_utc`, `referee_1_id`, `referee_2_id`, `referee_3_id`)VALUES (1, 1, 14,16, 1730061000, 1, 2, 3);
INSERT INTO `game` (`league_year_id`, `type_game_id`, `team_home_id`, `team_guest_id`, `date_hours_utc`, `referee_1_id`, `referee_2_id`, `referee_3_id`)VALUES (1, 1, 3,12, 1730061000, 1, 2, 3);
INSERT INTO `game` (`league_year_id`, `type_game_id`, `team_home_id`, `team_guest_id`, `date_hours_utc`, `referee_1_id`, `referee_2_id`, `referee_3_id`)VALUES (1, 1, 10,7, 1730061000, 1, 2, 3);
INSERT INTO `game` (`league_year_id`, `type_game_id`, `team_home_id`, `team_guest_id`, `date_hours_utc`, `referee_1_id`, `referee_2_id`, `referee_3_id`)VALUES (1, 1, 2,8, 1730061000, 1, 2, 3);
INSERT INTO `game` (`league_year_id`, `type_game_id`, `team_home_id`, `team_guest_id`, `date_hours_utc`, `referee_1_id`, `referee_2_id`, `referee_3_id`)VALUES (1, 1, 4,5, 1730061000, 1, 2, 3);
INSERT INTO `game` (`league_year_id`, `type_game_id`, `team_home_id`, `team_guest_id`, `date_hours_utc`, `referee_1_id`, `referee_2_id`, `referee_3_id`)VALUES (1, 1, 9,15, 1730061000, 1, 2, 3);
INSERT INTO `game` (`league_year_id`, `type_game_id`, `team_home_id`, `team_guest_id`, `date_hours_utc`, `referee_1_id`, `referee_2_id`, `referee_3_id`)VALUES (1, 1, 1,11, 1730061000, 1, 2, 3);
INSERT INTO `game` (`league_year_id`, `type_game_id`, `team_home_id`, `team_guest_id`, `date_hours_utc`, `referee_1_id`, `referee_2_id`, `referee_3_id`)VALUES (1, 1, 6,13, 1730061000, 1, 2, 3);
INSERT INTO `game` (`league_year_id`, `type_game_id`, `team_home_id`, `team_guest_id`, `date_hours_utc`, `referee_1_id`, `referee_2_id`, `referee_3_id`)VALUES (1, 1, 11,12, 1730665800, 1, 2, 3);
INSERT INTO `game` (`league_year_id`, `type_game_id`, `team_home_id`, `team_guest_id`, `date_hours_utc`, `referee_1_id`, `referee_2_id`, `referee_3_id`)VALUES (1, 1, 13,2, 1730665800, 1, 2, 3);
INSERT INTO `game` (`league_year_id`, `type_game_id`, `team_home_id`, `team_guest_id`, `date_hours_utc`, `referee_1_id`, `referee_2_id`, `referee_3_id`)VALUES (1, 1, 14,5, 1730665800, 1, 2, 3);
INSERT INTO `game` (`league_year_id`, `type_game_id`, `team_home_id`, `team_guest_id`, `date_hours_utc`, `referee_1_id`, `referee_2_id`, `referee_3_id`)VALUES (1, 1, 6,4, 1730665800, 1, 2, 3);
INSERT INTO `game` (`league_year_id`, `type_game_id`, `team_home_id`, `team_guest_id`, `date_hours_utc`, `referee_1_id`, `referee_2_id`, `referee_3_id`)VALUES (1, 1, 1,9, 1730665800, 1, 2, 3);
INSERT INTO `game` (`league_year_id`, `type_game_id`, `team_home_id`, `team_guest_id`, `date_hours_utc`, `referee_1_id`, `referee_2_id`, `referee_3_id`)VALUES (1, 1, 7,3, 1730665800, 1, 2, 3);
INSERT INTO `game` (`league_year_id`, `type_game_id`, `team_home_id`, `team_guest_id`, `date_hours_utc`, `referee_1_id`, `referee_2_id`, `referee_3_id`)VALUES (1, 1, 16,10, 1730665800, 1, 2, 3);
INSERT INTO `game` (`league_year_id`, `type_game_id`, `team_home_id`, `team_guest_id`, `date_hours_utc`, `referee_1_id`, `referee_2_id`, `referee_3_id`)VALUES (1, 1, 8,15, 1730665800, 1, 2, 3);

-- popola i giocatori delle partite, mette tutti i giocatori della squadra
INSERT INTO player_team_game (player_id, team_id, game_id)
SELECT pt.player_id, g.team_home_id, g.id
FROM game g
JOIN player_team pt ON pt.team_id = g.team_home_id
WHERE (pt.date_end_utc IS NULL OR pt.date_end_utc > g.date_hours_utc)

UNION ALL

SELECT pt.player_id, g.team_guest_id, g.id
FROM game g
JOIN player_team pt ON pt.team_id = g.team_guest_id;