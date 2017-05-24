-- 1. In welke fase zit het project en sorteer op volgorde van fases

SELECT fase.stage, spikee.project.naam
FROM spikee.project INNER JOIN spikee.fase USING (project_id)
ORDER BY CASE
WHEN fase.stage = 'verkoop' THEN '0'
WHEN fase.stage = 'voorbereiding' THEN '1'
WHEN fase.stage = 'ontwerp' THEN '2'
WHEN fase.stage = 'implementatie' THEN '3'
WHEN fase.stage = 'testing' THEN '4'
WHEN fase.stage = 'onderhoud' THEN '5'
END

-- 2. Wat zijn de problemen dat een taak heeft.

SELECT task.task_id, task.naam, problemen.description, problemen.prioriteit
FROM spikee.task INNER JOIN spikee.problemen USING (task_id)

-- 3. Tot welke teams behoort een werknemer.

SELECT st.naam, sw.naam ,sw.werknemer_id
FROM spikee.team st INNER JOIN spikee.team_has_werknemer sthw ON (st.team_id = sthw.team_id)
	INNER JOIN spikee.werknemer sw ON (sthw.werknemer_id = sw.werknemer_id)
ORDER BY sw.naam

-- 4. Welke werknemers zitten in een team.

SELECT sw.naam, st.naam
FROM spikee.werknemer sw INNER JOIN spikee.team_has_werknemer sthw ON (sw.werknemer_id = sthw.werknemer_id)
	INNER JOIN spikee.team st ON (sthw.team_id = st.team_id)

-- 5. Aan welke taken werkt een werknemer en tot welk project behoort deze taak, rangschik alfabetisch op naam van de werknemer.

SELECT swe.naam, st.naam, spr.naam
FROM spikee.task st LEFT JOIN spikee.team_has_task stht ON (st.task_id = stht.task_id)
	INNER JOIN spikee.team ste ON (stht.team_id = ste.team_id)
	INNER JOIN spikee.team_has_werknemer sthw ON (ste.team_id = sthw.team_id)
	INNER JOIN spikee.werknemer swe ON (sthw.werknemer_id = swe.werknemer_id)
	INNER JOIN spikee.project spr USING (project_id)
ORDER BY swe.naam

-- 6. toon voor elk team aan welke fases van elk project waar ze werken.

SELECT distinct ste.naam as "team naam", sfa.stage, spr.naam as "project naam"
FROM spikee.team ste INNER JOIN spikee.team_has_task stht USING (team_id) 
		     INNER JOIN spikee.task USING (task_id) 
		     INNER JOIN spikee.project spr USING (project_id) 
		     INNER JOIN spikee.fase sfa USING (project_id)
order by ste.naam

-- 7. Het totaal aantal uren dat een team aan een project heeft gewerkt.



-- 8. Welk team heeft 5 of meer problemen, georderd op grootst aantal problemen

SELECT ste.naam, count(*) as "aantal problemen"
FROM spikee.team ste INNER JOIN spikee.team_has_task stht USING (team_id)
	INNER JOIN spikee.task sta USING (task_id)
	INNER JOIN spikee.problemen spr USING (task_id)
group by ste.naam
having count(*) >= 5
order by count(*) desc


-- 9. Welke werknemers werken aan de meeste taken (van hoog naar laag).
