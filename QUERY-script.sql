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



-- 4.



-- 5.



-- 6.



-- 7.



-- 8.



-- 9.



-- 10.