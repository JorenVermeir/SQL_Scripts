-- 1. In welke fase zit het project en sorteer op volgorde van fases

SELECT fase.stage, project_id
FROM spikee.project INNER JOIN spikee.fase USING (project_id)
ORDER BY CASE
WHEN fase.stage = 'verkoop' THEN '0'
WHEN fase.stage = 'voorbereiding' THEN '1'
WHEN fase.stage = 'ontwerp' THEN '2'
WHEN fase.stage = 'implementatie' THEN '3'
WHEN fase.stage = 'testing' THEN '4'
WHEN fase.stage = 'onderhoud' THEN '5'
END

-- 2.



-- 3.
SELECT st.naam, sw.naam ,sw.werknemer_id
FROM spikee.team st INNER JOIN spikee.team_has_werknemer sthw ON (st.team_id = sthw.team_id)
	INNER JOIN spikee.werknemer sw ON (sthw.werknemer_id = sw.werknemer_id)
ORDER BY sw.naam

-- 4.



-- 5.



-- 6.



-- 7.



-- 8.



-- 9.



-- 10.