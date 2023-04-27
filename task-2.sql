-- postgres@gb-postgresql:~$ psql

SELECT * FROM pg_extension WHERE extname = 'intarray';

--  oid | extname | extowner | extnamespace | extrelocatable | extversion | extconfig | extcondition
-- -----+---------+----------+--------------+----------------+------------+-----------+--------------
-- (0 rows)

CREATE EXTENSION "intarray";

-- CREATE EXTENSION

SELECT * FROM pg_extension WHERE extname = 'intarray';

--   oid  | extname  | extowner | extnamespace | extrelocatable | extversion | extconfig | extcondition
-- -------+----------+----------+--------------+----------------+------------+-----------+--------------
--  17119 | intarray |       10 |         2200 | t              | 1.5        |           |
-- (1 row)