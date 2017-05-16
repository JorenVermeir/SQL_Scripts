-- -----------------------------------------------------
-- Schema Spikee
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS Spikee AUTHORIZATION r0584854;

COMMENT ON SCHEMA Spikee IS 'Assignment TD2';

SET SEARCH_PATH TO Spikee;

GRANT ALL ON SCHEMA Spikee TO r0584854;

GRANT ALL ON SCHEMA Spikee TO r0662663;

GRANT ALL ON SCHEMA Spikee TO r0674221;


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
    Start_datum DATE NULL,
    Eind_datum DATE NULL,
    Soort ENUM_SOORT NULL,
    Tarief MONEY NULL,
    Klant_id SERIAL NOT NULL,
    
    CONSTRAINT uq_Project UNIQUE (Project_id),
    CONSTRAINT pk_Project_Klant PRIMARY KEY (Project_id),
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
    
    CONSTRAINT pk_Project PRIMARY KEY (Project_id),
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
    	REFERENCES Spikee.Task (Task_id , Project_id)
    	ON DELETE RESTRICT
    	ON UPDATE CASCADE
);


-- -----------------------------------------------------
-- Table Resources
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS Resources (
    Resource_id SERIAL NOT NULL,
    Soort VARCHAR(45) NULL,
    
    CONSTRAINT pk_Resource PRIMARY KEY (Resource_id)
);


-- -----------------------------------------------------
-- Table Task_Has_Resources
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS Task_Has_Resources (
    Resources_id SERIAL NOT NULL,
    Task_id SERIAL NOT NULL,
    
    CONSTRAINT pk_Resource_Task PRIMARY KEY (Resources_id, Task_id),
    CONSTRAINT fk_Task_has_Resources_Resources FOREIGN KEY (Resources_id)
    	REFERENCES Spikee.Resources (Resource_id)
    	ON DELETE RESTRICT
    	ON UPDATE CASCADE,
    CONSTRAINT fk_Task_has_Resources_Task FOREIGN KEY (Task_id)
    	REFERENCES Spikee.Task (Task_id)
    	ON DELETE RESTRICT
    	ON UPDATE CASCADE
);


-- -----------------------------------------------------
-- Table Uren
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS Uren (
    Gepland_einduur TIMESTAMP NULL,
    Gepland_beginuur TIMESTAMP NULL,
    Task_id SERIAL NOT NULL,
    
    CONSTRAINT pk_Task_Project PRIMARY KEY (Task_id),
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
    
    CONSTRAINT pk_Team_Task PRIMARY KEY (Team_id, Task_id),
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
    
    CONSTRAINT pk_Team_Werknemer PRIMARY KEY (Team_id, Werknemer_id),
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
    Uren_Task_id SERIAL NOT NULL,
    Gepresteerde_einduur TIMESTAMP NULL,
    Gepresteerde_beginuur TIMESTAMP NULL,
    
    CONSTRAINT pk_Werknemer_Uren_Task PRIMARY KEY (Werknemer_id, Uren_Task_id),
    CONSTRAINT fk_Werknemer_has_Uren_Werknemer FOREIGN KEY (Werknemer_id)
    	REFERENCES Spikee.Werknemer (Werknemer_id)
    	ON DELETE RESTRICT
    	ON UPDATE CASCADE,
    CONSTRAINT fk_Werknemer_has_Uren_Uren FOREIGN KEY (Uren_Task_id)
    	REFERENCES Spikee.Uren (Task_id)
    	ON DELETE RESTRICT
    	ON UPDATE CASCADE
);


-- -----------------------------------------------------
-- Table Verlof
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS Verlof (
    Verlof_id VARCHAR(45) NOT NULL,
    Begin_datum DATE NULL,
    Eind_datum DATE NULL,
    Werknemer_id SERIAL NOT NULL,
    
    CONSTRAINT pk_Verlof_Werknemer PRIMARY KEY (Verlof_id, Werknemer_id),
    CONSTRAINT fk_Verlof_Werknemer FOREIGN KEY (Werknemer_id)
    	REFERENCES Spikee.Werknemer (Werknemer_id)
    	ON DELETE RESTRICT
    	ON UPDATE CASCADE
);

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
ON TABLE Resources
TO r0584854, r0662663, r0674221;

GRANT ALL PRIVILEGES
ON TABLE Task_Has_Resources
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
