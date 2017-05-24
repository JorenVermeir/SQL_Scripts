-- 1. In welke fase zit het project en sorteer op volgorde van fases

SELECT fase.stage, project_id, project.naam
FROM project INNER JOIN fase USING (project_id)
ORDER BY CASE
WHEN fase.stage = 'verkoop' THEN '0'
WHEN fase.stage = 'voorbereiding' THEN '1'
WHEN fase.stage = 'ontwerp' THEN '2'
WHEN fase.stage = 'implementatie' THEN '3'
WHEN fase.stage = 'testing' THEN '4'
WHEN fase.stage = 'onderhoud' THEN '5'
END

-- 2. Wat zijn de problemen dat een taak heeft.

SELECT *
FROM task INNER JOIN problemen USING (task_id)

-- 3. Tot welke teams behoort een werknemer.

SELECT st.naam, sw.naam ,sw.werknemer_id
FROM team st INNER JOIN team_has_werknemer sthw ON (st.team_id = sthw.team_id)
	INNER JOIN werknemer sw ON (sthw.werknemer_id = sw.werknemer_id)
ORDER BY sw.naam

-- 4. Welke werknemers zitten in een team.



-- 5. Aan welke taken werkt een werknemer en tot welk project behoort deze taak, rangschik alfabetisch op naam van de werknemer.

SELECT swe.naam, st.naam, spr.naam
FROM task st LEFT JOIN team_has_task stht ON (st.task_id = stht.task_id)
	INNER JOIN team ste ON (stht.team_id = ste.team_id)
	INNER JOIN team_has_werknemer sthw ON (ste.team_id = sthw.team_id)
	INNER JOIN werknemer swe ON (sthw.werknemer_id = swe.werknemer_id)
	INNER JOIN project spr USING (project_id)
ORDER BY swe.naam

-- 6. Per team weergeven in welke fase het project zit.



-- 7. Het totaal aantal uren dat een team aan een project heeft gewerkt.



-- 8. Wat is het team die de meeste problemen heeft.

SELECT ste.naam
FROM team ste INNER JOIN team_has_task stht USING (team_id)
	INNER JOIN task sta USING (task_id)
	INNER JOIN problemen spr USING 	(task_id)
WHERE max(count(spr.))

-- 9. Welke werknemers werken aan de meeste taken (van hoog naar laag).