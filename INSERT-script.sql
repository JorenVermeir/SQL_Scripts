-- ------------------------------------------------------------------ --
--INSERT TABLE klant --
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
--INSERT TABLE project --
-- ------------------------------------------------------------------ --

INSERT INTO spikee.project( project_id, start_datum, eind_datum, soort, tarief, klant_id ) VALUES 
	(1, '1997-07-18', '2001-03-11', 'Fixed-Price', 4500, 1),
	(2, '1997-07-18', '2007-11-11', 'T&M Project', 90000, 2),
	(3, '1981-07-18', '2017-03-01', 'T&M Diensten', 35789.53, 3),
	(4, '1917-01-19', '2011-04-27', 'Abonnement', 12, 4),
	(5, '1998-04-18', '2018-09-21', 'Fixed-Price', 450900, 5),
	(6, '1997-07-18', '2001-03-11', 'T&M Diensten', 77500, 6),
	(7, '1876-09-30', '2007-12-03', 'Abonnement', 97650, 7);

-- ------------------------------------------------------------------ --
--INSERT TABLE fase --
-- ------------------------------------------------------------------ --

INSERT INTO spikee.fase( project_id, stage, gebruikte_tijd, voorziene_tijd, gebruikt_budget, voorzien_budget ) VALUES
	(1, 'onderhoud', '12:00:00', '13:00:00' , 97650, 5678),
	(2, 'voorbereiding', '3300:00:00', '2200:00:00' , 97650, 5678),
	(3, 'testing', '58:00:00', '59:00:00', 97650, 5678),	
	(4, 'voorbereiding', '123:00:00', '132:00:00', 97650, 5678),
	(5, 'verkoop', '2:00:00', '3:00:00', 97650, 5678),
	(6, 'implementatie', '16:00:00', '15:00:00', 97650, 5678),
	(7, 'ontwerp', '66:00:00', '55:00:00', 97650, 5678);

-- ------------------------------------------------------------------ --
--INSERT TABLE werknemer --
-- ------------------------------------------------------------------ --

<<<<<<< HEAD
INSERT INTO spikee.werknemer( werknemer_id, ziek, loon_category ) VALUES 
	(1, false, 'Hoog'),
	(2, false, 'Laag'),
	(3, false, 'Hoog'),
	(4, true, 'Hoog'),
	(5, false, 'Gemiddeld'),
	(6, false, 'Hoog'),
	(7, true, 'Laag');

----------------------------------------------------------------- --
--INSERT TABLE resources --
-- ------------------------------------------------------------------ --

INSERT INTO spikee.resources(resource_id, soort ) VALUES
	(1, 'computer'),
	(2, 'netwerk team'),
	(3, 'programeur'),
	(4, 'multimeter'),
	(5, 'computer'),
	(6, 'computer'),
	(7, 'computer');

----------------------------------------------------------------- --
--INSERT TABLE task --
-- ------------------------------------------------------------------ --

INSERT INTO spikee.task( task_id, voorziene_budget, gebruikte_budget, project_id ) VALUES 
	(1, 567, 5678, 1),
	(2, 970, 245, 2),
	(3, 57986, 2455, 3),
	(4, 555, 555, 4),
	(5, 3456, 5678, 5),
	(6, 9876, 466, 6),
	(7, 567, 325676, 7);
	
-- ------------------------------------------------------------------ --
-- probleem nogniet gedaan --
-- ------------------------------------------------------------------ --



INSERT INTO spikee.team(
	team_id, naam)
	VALUES (1, 'netwerken');

INSERT INTO spikee.team(
	team_id, naam)
	VALUES (2, 'OOP');

INSERT INTO spikee.team(
	team_id, naam)
	VALUES (3, 'linux');

INSERT INTO spikee.team(
	team_id, naam)
	VALUES (4, 'onderhoud');

INSERT INTO spikee.team(
	team_id, naam)
	VALUES (5, 'grafisch');

INSERT INTO spikee.team(
	team_id, naam)
	VALUES (6, 'UML');

INSERT INTO spikee.team(
	team_id, naam)
	VALUES (7, 'algo');



