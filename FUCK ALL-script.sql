DROP SCHEMA spikee CASCADE

-- -----------------------------------------------------
-- Schema Spikee
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS Spikee AUTHORIZATION r0584854;

COMMENT ON SCHEMA Spikee IS 'Assignment TD2';

SET SEARCH_PATH TO Spikee;

-- -----------------------------------------------------
-- Table Klant
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS Klant (
    Klant_id SERIAL NOT NULL,
    Naam VARCHAR(45) NULL,

    CONSTRAINT pk_Klant PRIMARY KEY (Klant_id)
);


CREATE TYPE ENUM_SOORT AS ENUM ('Fixed-Price','T&M Project','T&M Diensten','Abonnement');

-- -----------------------------------------------------
-- Table Project
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS Project (
    Project_id SERIAL NOT NULL,
    Naam VARCHAR(45) NULL,
    Start_datum DATE NULL,
    Eind_datum DATE NULL,
    Soort ENUM_SOORT NULL,
    Tarief MONEY NULL,
    Klant_id SERIAL NOT NULL,
    
    CONSTRAINT pk_Project PRIMARY KEY (Project_id),
    CONSTRAINT fk_Project_Klant FOREIGN KEY (Klant_id)
    	REFERENCES Spikee.Klant (Klant_id)
    	ON DELETE RESTRICT
    	ON UPDATE CASCADE
);


CREATE TYPE ENUM_STAGE AS ENUM ('verkoop','voorbereiding','ontwerp','implementatie','testing','onderhoud');

-- -----------------------------------------------------
-- Table Fase
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS Fase (
    Stage ENUM_STAGE NOT NULL,
    Gebruikte_Tijd INTERVAL NULL,
    Voorziene_Tijd INTERVAL NULL,
    Gebruikt_Budget MONEY NULL,
    Voorzien_Budget MONEY NULL,
    Project_id SERIAL NOT NULL,
    
    CONSTRAINT pk_Fase PRIMARY KEY (Project_id, Stage),
    CONSTRAINT fk_Fase_Project FOREIGN KEY (Project_id)
    	REFERENCES Spikee.Project (Project_id)
    	ON DELETE RESTRICT
    	ON UPDATE CASCADE
);


-- -----------------------------------------------------
-- Table Task
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS Task (
    Task_id SERIAL NOT NULL,
    Naam VARCHAR(45) NULL,
    Voorziene_budget MONEY NULL,
    Gebruikte_budget MONEY NULL,
    Project_id SERIAL NOT NULL,
    
    CONSTRAINT pk_Task PRIMARY KEY (Task_id),
    CONSTRAINT fk_Task_Project FOREIGN KEY (Project_id)
    	REFERENCES Spikee.Project (Project_id)
    	ON DELETE RESTRICT
    	ON UPDATE CASCADE
);


CREATE TYPE ENUM_PRIORITEIT AS ENUM ('Laag', 'Medium', 'Hoog');

-- -----------------------------------------------------
-- Table Problemen
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS Problemen (
    Probleem_id SERIAL NOT NULL,
    Description TEXT NULL,
    Prioriteit ENUM_PRIORITEIT NULL,
    Task_id SERIAL NOT NULL,
    
    CONSTRAINT pk_Problemen PRIMARY KEY (Probleem_id),
    CONSTRAINT fk_Problemen_Task FOREIGN KEY (Task_id)
    	REFERENCES Spikee.Task (Task_id)
    	ON DELETE RESTRICT
    	ON UPDATE CASCADE
);


-- -----------------------------------------------------
-- Table Materials
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS Materials (
    Material_id SERIAL NOT NULL,
    Soort VARCHAR(45) NULL,
    
    CONSTRAINT pk_Materials PRIMARY KEY (Material_id)
);


-- -----------------------------------------------------
-- Table Task_Has_Materials
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS Task_Has_Materials (
    Material_id SERIAL NOT NULL,
    Task_id SERIAL NOT NULL,
    
    CONSTRAINT pk_Task_has_Materials PRIMARY KEY (Material_id, Task_id),
    CONSTRAINT fk_Task_has_Materials_Materials FOREIGN KEY (Material_id)
    	REFERENCES Spikee.Materials (Material_id)
    	ON DELETE RESTRICT
    	ON UPDATE CASCADE,
    CONSTRAINT fk_Task_has_Materials_Task FOREIGN KEY (Task_id)
    	REFERENCES Spikee.Task (Task_id)
    	ON DELETE RESTRICT
    	ON UPDATE CASCADE
);


-- -----------------------------------------------------
-- Table Uren
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS Uren (
    Gepland_einduur TIMESTAMP NULL,
    Gepland_beginuur TIMESTAMP NOT NULL,
    Task_id SERIAL NOT NULL,
    
    CONSTRAINT pk_Uren PRIMARY KEY (Gepland_beginuur, Task_id),
    CONSTRAINT fk_Uren_Task FOREIGN KEY (Task_id)
    	REFERENCES Spikee.Task (Task_id)
    	ON DELETE RESTRICT
    	ON UPDATE CASCADE
);


-- -----------------------------------------------------
-- Table Team
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS Team (
    Team_id SERIAL NOT NULL,
    Naam VARCHAR(45) NULL,
    
    CONSTRAINT pk_Team PRIMARY KEY (Team_id)
);


-- -----------------------------------------------------
-- Table Team_has_Task
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS Team_has_Task (
    Team_id SERIAL NOT NULL,
    Task_id SERIAL NOT NULL,
    
    CONSTRAINT pk_Team_has_Task PRIMARY KEY (Team_id, Task_id),
    CONSTRAINT fk_Team_has_Task_Team FOREIGN KEY (Team_id)
    	REFERENCES Spikee.Team (Team_id)
    	ON DELETE RESTRICT
    	ON UPDATE CASCADE,
    CONSTRAINT fk_Team_has_Task_Task FOREIGN KEY (Task_id)
    	REFERENCES Spikee.Task (Task_id)
    	ON DELETE RESTRICT
    	ON UPDATE CASCADE
);


-- -----------------------------------------------------
-- Table Werknemer
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS Werknemer (
    Werknemer_id SERIAL NOT NULL,
    Naam VARCHAR(45) NULL,
    Ziek BOOLEAN NULL,
    Loon_category VARCHAR(45) NULL,
    
    CONSTRAINT pk_Werknemer PRIMARY KEY (Werknemer_id)
);


-- -----------------------------------------------------
-- Table Team_has_Werknemer
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS Team_has_Werknemer (
    Team_id SERIAL NOT NULL,
    Werknemer_id SERIAL NOT NULL,
    Service_Area_Manager BOOLEAN NULL,
    
    CONSTRAINT pk_Team_has_Werknemer PRIMARY KEY (Team_id, Werknemer_id),
    CONSTRAINT fk_Team_has_Werknemer_Team FOREIGN KEY (Team_id)
    	REFERENCES Spikee.Team (Team_id)
    	ON DELETE NO ACTION
    	ON UPDATE NO ACTION,
    CONSTRAINT fk_Team_has_Werknemer_Werknemer FOREIGN KEY (Werknemer_id)
    	REFERENCES Spikee.Werknemer (Werknemer_id)
    	ON DELETE RESTRICT
    	ON UPDATE CASCADE
);


-- -----------------------------------------------------
-- Table Werknemer_has_Uren
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS Werknemer_has_Uren (
    Werknemer_id SERIAL NOT NULL,
    Task_id SERIAL NOT NULL,
    Uren_Gepland_beginuur TIMESTAMP NOT NULL,
    Gepresteerde_einduur TIMESTAMP NULL,
    Gepresteerde_beginuur TIMESTAMP NULL,
    
    CONSTRAINT pk_Werknemer_has_Uren PRIMARY KEY (Werknemer_id, Task_id, Uren_Gepland_beginuur),
    CONSTRAINT fk_Werknemer_has_Uren_Werknemer FOREIGN KEY (Werknemer_id)
    	REFERENCES Spikee.Werknemer (Werknemer_id)
    	ON DELETE RESTRICT
    	ON UPDATE CASCADE,
    CONSTRAINT fk_Werknemer_has_Uren_Uren FOREIGN KEY (Task_id, Uren_Gepland_beginuur)
    	REFERENCES Spikee.Uren (Task_id, Gepland_beginuur)
    	ON DELETE RESTRICT
    	ON UPDATE CASCADE
);


-- -----------------------------------------------------
-- Table Verlof
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS Verlof (
    Begin_datum DATE NOT NULL,
    Eind_datum DATE NULL,
    Werknemer_id SERIAL NOT NULL,
    
    CONSTRAINT pk_Verlof PRIMARY KEY (Begin_datum, Werknemer_id),
    CONSTRAINT fk_Verlof_Werknemer FOREIGN KEY (Werknemer_id)
    	REFERENCES Spikee.Werknemer (Werknemer_id)
    	ON DELETE RESTRICT
    	ON UPDATE CASCADE
);


-- -----------------------------------------------------
-- PRIVILEGES
-- -----------------------------------------------------

GRANT ALL ON SCHEMA Spikee TO r0584854;

GRANT ALL ON SCHEMA Spikee TO r0662663;

GRANT ALL ON SCHEMA Spikee TO r0674221;

GRANT ALL ON ALL SEQUENCES IN SCHEMA Spikee to r0584854, r0662663, r0674221;
GRANT ALL ON ALL FUNCTIONS IN SCHEMA Spikee to r0584854, r0662663, r0674221;

GRANT ALL PRIVILEGES
ON TABLE Klant
TO r0584854, r0662663, r0674221;

GRANT ALL PRIVILEGES
ON TABLE Project
TO r0584854, r0662663, r0674221;

GRANT ALL PRIVILEGES
ON TABLE Fase
TO r0584854, r0662663, r0674221;

GRANT ALL PRIVILEGES
ON TABLE Task
TO r0584854, r0662663, r0674221;

GRANT ALL PRIVILEGES
ON TABLE Problemen
TO r0584854, r0662663, r0674221;

GRANT ALL PRIVILEGES
ON TABLE Materials
TO r0584854, r0662663, r0674221;

GRANT ALL PRIVILEGES
ON TABLE Task_Has_Materials
TO r0584854, r0662663, r0674221;

GRANT ALL PRIVILEGES
ON TABLE Uren
TO r0584854, r0662663, r0674221;

GRANT ALL PRIVILEGES
ON TABLE Team
TO r0584854, r0662663, r0674221;

GRANT ALL PRIVILEGES
ON TABLE Team_has_Task
TO r0584854, r0662663, r0674221;

GRANT ALL PRIVILEGES
ON TABLE Werknemer
TO r0584854, r0662663, r0674221;

GRANT ALL PRIVILEGES
ON TABLE Team_has_Werknemer
TO r0584854, r0662663, r0674221;

GRANT ALL PRIVILEGES
ON TABLE Werknemer_has_Uren
TO r0584854, r0662663, r0674221;

GRANT ALL PRIVILEGES
ON TABLE Verlof
TO r0584854, r0662663, r0674221;

-- ------------------------------------------------------------------ --
-- INSERT TABLE klant --
-- ------------------------------------------------------------------ --

INSERT INTO spikee.klant( klant_id, naam ) VALUES
	(1, 'Mathias'),
	(2, 'Shiva'),
	(3, 'Arnold'),
	(4, 'Pietsnol'),
	(5, 'Jaak'),
	(6, 'Freddie'),
	(7, 'Dirk'),
	(8, 'Jan'),
	(9, 'Sam'),
	(10, 'Rune');

-- ------------------------------------------------------------------ --
-- INSERT TABLE project --
-- ------------------------------------------------------------------ --

INSERT INTO spikee.project( project_id, naam, start_datum, eind_datum, soort, tarief, klant_id ) VALUES 
	(1, 'CSGO', '1997-07-18', '2001-03-11', 'Fixed-Price', 4500, 1),
	(2, 'Minecraft', '1997-07-18', '2007-11-11', 'T&M Project', 90000, 2),
	(3, 'League of Legends', '1981-07-18', '2017-03-01', 'T&M Diensten', 35789.53, 3),
	(4, 'Roblox', '1917-01-19', '2011-04-27', 'Abonnement', 12, 4),
	(5, 'Arma 3', '1998-04-18', '2018-09-21', 'Fixed-Price', 450900, 5),
	(6, 'Outlast 2', '1997-07-18', '2001-03-11', 'T&M Diensten', 77500, 6),
	(7, 'Rocket League', '1876-09-30', '2007-12-03', 'Abonnement', 97650, 7);

-- ------------------------------------------------------------------ --
-- INSERT TABLE fase --
-- ------------------------------------------------------------------ --

INSERT INTO spikee.fase( stage, gebruikte_tijd, voorziene_tijd, gebruikt_budget, voorzien_budget, project_id) VALUES
	('onderhoud', '12:00:00', '13:00:00' , 97650, 5678, 1),
	('voorbereiding', '3300:00:00', '2200:00:00' , 97650, 5678, 2),
	('testing', '58:00:00', '59:00:00', 97650, 5678, 5),
	('voorbereiding', '123:00:00', '132:00:00', 97650, 5678, 4),
	('verkoop', '2:00:00', '3:00:00', 97650, 5678, 5),
	('implementatie', '16:00:00', '15:00:00', 97650, 5678, 6),
	('ontwerp', '66:00:00', '55:00:00', 97650, 5678, 1),
	
	('onderhoud', '15:00:00', '15:00:01' , 976570, 56678, 6),
	('voorbereiding', '30:00:00', '20:00:00' , 997650, 56678, 5),
	('testing', '22:00:20', '22:00:00', 97650, 56798, 2),
	('voorbereiding', '555:00:00', '666:00:00', 975650, 58678, 3),
	('verkoop', '9:00:00', '1:00:00', 97650, 56785, 7),
	('implementatie', '10:30:00', '11:00:00', 976550, 56678, 4),
	('ontwerp', '25:00:00', '25:00:00', 97650, 55678, 6);

	

-- ------------------------------------------------------------------ --
-- INSERT TABLE werknemer --
-- ------------------------------------------------------------------ --

INSERT INTO spikee.werknemer( werknemer_id, naam, ziek, loon_category ) VALUES 
	(1, 'Joran', false, 'Hoog'),
	(2, 'Quinten', false, 'Laag'),
	(3, 'Mathias', false, 'Hoog'),
	(4, 'Shiva', true, 'Hoog'),
	(5, 'Arnold', false, 'Gemiddeld'),
	(6, 'Pieter', false, 'Hoog'),
	(7, 'Thomas', true, 'Laag'),
	(8, 'Josh', false, 'Gemiddeld'),
	(9, 'Ellen', false, 'Hoog'),
	(10, 'Amy', true, 'Laag');


-- ------------------------------------------------------------------ --
-- INSERT TABLE materials --
-- ------------------------------------------------------------------ --

INSERT INTO spikee.materials(material_id, soort ) VALUES
	(1, 'computer'),
	(2, 'muis'),
	(3, 'schaar'),
	(4, 'multimeter'),
	(5, 'router'),
	(6, 'netwerkkabel'),
	(7, 'laptop');


-- ------------------------------------------------------------------ --
-- INSERT TABLE task --
-- ------------------------------------------------------------------ --

INSERT INTO spikee.task( task_id, naam, voorziene_budget, gebruikte_budget, project_id ) VALUES 
	(1, 'Graphics Design', 22, 5678, 1),
	(2, 'Terrain Design', 9750, 245, 1),
	(3, 'Ai Design', 57986, 24455, 3),
	(4, 'Storyline writing', 555, 555, 4),
	(5, 'Audio Design', 3456, 58678,4),
	(6, 'UI', 9876, 4696, 6),
	(7, 'Tutorial', 5677, 325676, 6),

	(8, 'Front web development', 22567, 5678, 2),
	(9, 'Game Site', 97660, 245, 3),
	(10, 'Forum', 57986, 2666455, 7),
	(11, 'Storyline writing', 55555, 555, 6),
	(12, 'Audio Design', 345666, 5678,4),
	(13, 'UI', 9876, 466, 5),
	(14, 'Tutorial', 567, 676, 6);

-- ------------------------------------------------------------------ --
-- INSERT TABLE team --
-- ------------------------------------------------------------------ --

INSERT INTO spikee.team( team_id, naam ) VALUES
	(1, 'netwerken'),
	(2, 'OOP'),
	(3, 'linux'),
	(4, 'onderhoud'),
	(5, 'grafisch'),
	(6, 'UML'),
	(7, 'algo');
	
-- ------------------------------------------------------------------ --
-- INSERT TABLE verlof --
-- ------------------------------------------------------------------ --

INSERT INTO spikee.verlof( begin_datum, eind_datum, werknemer_id ) VALUES
	('2012-10-05' , '2012-12-07', 1),
	('2017-09-28' , '2017-12-17', 5),
	('2000-08-25' , '2012-12-07', 7),
	('2004-01-15' , '2004-01-16', 2),

	('2013-10-05' , '2019-12-07', 1),
	('2015-09-28' , '2016-12-17', 6),
	('2001-08-25' , '2002-12-07', 6),
	('2006-01-15' , '2007-01-16', 3),

	('2015-10-05' , '2016-12-07', 2),
	('2018-09-28' , '2019-12-17', 3),
	('2003-08-25' , '2004-12-07', 5),
	('2009-01-15' , '2010-01-16', 9);

-- ------------------------------------------------------------------ --
-- INSERT TABLE problemen --
-- ------------------------------------------------------------------ --

INSERT INTO spikee.problemen( probleem_id, description, prioriteit, task_id ) VALUES
	(1, 'AI Loopt vast', 'Laag', 3),
	(2, 'Graphics crasht', 'Medium', 2),
	(3, 'UI is lelijk', 'Medium', 2),
	(4, 'Multiplayer lagged', 'Laag', 7),
	(5, 'AI loopt tegen de muur', 'Hoog', 1);


-- ------------------------------------------------------------------ --
-- INSERT TABLE uren --
-- ------------------------------------------------------------------ --

INSERT INTO spikee.uren( gepland_einduur, gepland_beginuur, task_id ) VALUES
	('1999-01-20 20:17:00', '1999-01-20 10:37:00', 1),
	('2002-04-12 15:33:00', '2002-04-12 06:23:00', 4),
	('2012-11-15 18:25:00', '2012-11-15 09:30:00', 3),
	('2010-07-22 12:00:00', '2010-07-22 08:15:00', 2),
	('2015-06-07 23:59:00', '2015-06-07 07:00:00', 5),
	('2017-05-08 16:00:00', '2017-05-08 08:30:00', 6),
	('2001-09-11 19:11:00', '2001-09-11 09:11:00', 7);

-- ------------------------------------------------------------------ --
-- INSERT TABLE task_has_resources --
-- ------------------------------------------------------------------ --

INSERT INTO spikee.task_has_materials( material_id, task_id ) VALUES
	(1,1),(1,2),(1,3),(1,4),(1,5),(1,6),(1,7),(1,8),(1,9),(1,10),(1,11),(1,12),(1,13),(1,14),(2,1),(2,2),(2,3),(2,4),(2,5),(2,6),(2,7),(2,8),(2,9),(2,10),(2,11),(2,12),(2,13),(2,14),(3,1),(3,2),(3,8),(3,9),(3,10),(3,11),(3,12),(3,13),(3,14),(4,1),(5,4),(5,5),(5,6),(5,7),(5,8),(5,9),(5,10),(5,11),(6,14),(7,1),(7,2),(7,3),(7,4),(7,5),(7,6),(7,7),(7,8),(7,9),(7,10),(7,11),(7,12),(7,13),(7,14);

-- ------------------------------------------------------------------ --
-- INSERT TABLE team_has_task --
-- ------------------------------------------------------------------ --

INSERT INTO spikee.team_has_task( team_id, task_id ) VALUES
	(1,1),(1,2),(1,3),(1,4),(1,5),(1,6),(1,7),(1,8),(1,9),(1,10),(1,11),(1,12),(1,13),(1,14),(2,1),(2,2),(2,3),(2,11),(2,12),(2,13),(2,14),(3,1),(3,2),(3,8),(3,9),(3,10),(3,11),(3,12),(3,13),(3,14),(4,1),(5,4),(5,5),(5,6),(5,7),(5,8),(5,9),(5,10),(5,11),(6,14),(7,1),(7,2),(7,3),(7,4),(7,5),(7,6),(7,7),(7,8);

-- ------------------------------------------------------------------ --
-- INSERT TABLE team_has_werknemer --
-- ------------------------------------------------------------------ --

INSERT INTO spikee.team_has_werknemer( team_id, werknemer_id, service_area_manager ) VALUES
	(7, 10, true),
	(5, 3, true),
	(3, 9, false),
	(1, 7, true),
	(6, 6, false),
	(4, 6, false),
	(2, 2, false);

-- ------------------------------------------------------------------ --
-- INSERT TABLE werknemer_has_uren --
-- ------------------------------------------------------------------ --

INSERT INTO spikee.werknemer_has_uren( werknemer_id, task_id, uren_gepland_beginuur, gepresteerde_einduur, gepresteerde_beginuur ) VALUES
	(7, 1, '1999-01-20 10:37:00', '1999-01-20 20:17:00', '1999-01-20 10:37:00'),
	(5, 2, '2010-07-22 08:15:00','2002-04-12 15:33:00', '2002-04-12 06:23:00'),
	(3, 3, '2012-11-15 09:30:00', '2012-11-15 18:25:00', '2012-11-15 09:30:00'),
	(1, 4, '2002-04-12 06:23:00', '2010-07-22 12:00:00', '2010-07-22 08:15:00'),
	(6, 5, '2015-06-07 07:00:00', '2015-06-07 23:59:00', '2015-06-07 07:00:00'),
	(4, 6, '2017-05-08 08:30:00', '2017-05-08 16:00:00', '2017-05-08 08:30:00'),
	(2, 7, '2001-09-11 09:11:00', '2001-09-11 19:11:00', '2001-09-11 09:11:00');

-- ------------------------------------------------------------------ --
-- END INSERT TABLE SCRIPT --
-- ------------------------------------------------------------------ --
