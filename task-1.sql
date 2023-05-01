-- Неизменяемое представление

CREATE VIEW videos_per_owners AS
SELECT 
	owner_id, 
	COUNT(id) AS number_of_videos
FROM video 
	GROUP BY owner_id;

-- CREATE VIEW

UPDATE videos_per_owners SET owner_id = 101 WHERE owner_id = 91;

-- ERROR:  Views containing GROUP BY are not automatically updatable.cannot update view "videos_per_owners" 

-- ERROR:  cannot update view "videos_per_owners"
-- SQL state: 55000
-- Detail: Views containing GROUP BY are not automatically updatable.
-- Hint: To enable updating the view, provide an INSTEAD OF UPDATE trigger or an unconditional ON UPDATE DO INSTEAD rule.

-- Изменяемое представление

CREATE VIEW heavy_videos AS
SELECT * FROM video WHERE size > 1000000;

-- CREATE VIEW

UPDATE heavy_videos 
	SET description = '[HEAVY VIDEO] ' || description;

-- UPDATE 3

SELECT id, description FROM heavy_videos;

--  id |                                        description
-- ----+-------------------------------------------------------------------------------------------
--   3 | [HEAVY VIDEO] sem, vitae aliquam eros turpis non enim. Mauris quis turpis vitae purus
--   8 | [HEAVY VIDEO] nunc sed libero. Proin sed turpis nec mauris blandit mattis. Cras eget nisi
--  13 | [HEAVY VIDEO] a,
