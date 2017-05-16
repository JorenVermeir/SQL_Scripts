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
	(1, 'eind ontwikkeling', 123,678 , 97650, 5678),
	(2, 'eind ontwikkeling', 56,876 , 97650, 5678),
	(3, 'eind ontwikkeling', 5678, 76, 97650, 5678),	
	(4, 'eind ontwikkeling', 678, 678, 97650, 5678),
	(5, 'eind ontwikkeling', 9865, 6543, 97650, 5678),
	(6, 'eind ontwikkeling', 567, 765, 97650, 5678),
	(7, 'eind ontwikkeling', 6789, 65, 97650, 5678);

-- ------------------------------------------------------------------ --


INSERT INTO spikee.task(
	task_id, voorziene_budget, gebruikte_budget)
	VALUES (1, 567, 5678);
	
INSERT INTO spikee.task(
	task_id, voorziene_budget, gebruikte_budget)
	VALUES (2, 970, 245);
	
INSERT INTO spikee.task(
	task_id, voorziene_budget, gebruikte_budget)
	VALUES (3, 57986, 2455);
	
INSERT INTO spikee.task(
	task_id, voorziene_budget, gebruikte_budget)
	VALUES (4, 555, 555);
	
INSERT INTO spikee.task(
	task_id, voorziene_budget, gebruikte_budget)
	VALUES (5, 3456, 5678);
	
INSERT INTO spikee.task(
	task_id, voorziene_budget, gebruikte_budget)
	VALUES (6, 9876, 466);
	
INSERT INTO spikee.task(
	task_id, voorziene_budget, gebruikte_budget)
	VALUES (7, 567, 325676);
	
-- ------------------------------------------------------------------ --

INSERT INTO spikee.resources(resource_id, soort )
	VALUES (1, 'computer'),
	(2, 'netwerk team'),
	(3, 'programeur'),
	(4, 'multimeter'),
	(5, 'computer'),
	(6, 'computer'),
	(7, 'computer');

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


-- ------------------------------------------------------------------ --


INSERT INTO spikee.werknemer(
	werknemer_id, ziek, loon_categorie)
	VALUES (1, false, 'Hoog');
	
INSERT INTO spikee.werknemer(
	werknemer_id, ziek, loon_categorie)
	VALUES (2, false, 'Laag');

INSERT INTO spikee.werknemer(
	werknemer_id, ziek, loon_categorie)
	VALUES (3, false, 'Hoog');

INSERT INTO spikee.werknemer(
	werknemer_id, ziek, loon_categorie)
	VALUES (4, true, 'Hoog');

INSERT INTO spikee.werknemer(
	werknemer_id, ziek, loon_categorie)
	VALUES (5, false, 'Gemiddeld');

INSERT INTO spikee.werknemer(
	werknemer_id, ziek, loon_categorie)
	VALUES (6, false, 'Hoog');

INSERT INTO spikee.werknemer(
	werknemer_id, ziek, loon_categorie)
	VALUES (7, true, 'Laag');

-- ------------------------------------------------------------------ --
