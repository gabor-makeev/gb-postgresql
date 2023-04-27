CREATE ROLE fserov LOGIN;
CREATE ROLE rbelov LOGIN;

ALTER ROLE fserov WITH PASSWORD 'test_password';
ALTER ROLE rbelov WITH PASSWORD 'test_password';

CREATE ROLE analyst;
CREATE ROLE tester;

GRANT analyst TO fserov;
GRANT tester TO rbelov;

\c vk

GRANT SELECT ON ALL TABLES IN SCHEMA public TO analyst;

GRANT ALL ON ALL TABLES IN SCHEMA public TO tester;
GRANT ALL ON ALL SEQUENCES IN SCHEMA public TO tester;

-- psql -U fserov -d vk -h 127.0.0.1

SELECT * FROM users WHERE id = 5;

--  id | first_name | last_name |            email            |  phone   | main_photo_id |     created_at      |             user_contacts
-- ----+------------+-----------+-----------------------------+----------+---------------+---------------------+----------------------------------------
--   5 | Yoko       | Sims      | nostra.per.inceptos@aol.com | 655-1605 |            93 | 2022-09-07 01:11:08 | (655-1605,nostra.per.inceptos@aol.com)
-- (1 row)

INSERT INTO users (first_name, last_name, email, phone, main_photo_id, created_at, user_contacts)
  VALUES ('test_first_name', 'test_last_name', 'test@test.test', '000-0000', 1, '2023-04-27 00:00:00', ('000-0000', 'test@test.test'));

-- ERROR:  permission denied for table users

UPDATE users SET first_name = 'Test first name' WHERE id = 5;

-- ERROR:  permission denied for table users

DELETE FROM users WHERE id = 5;

-- ERROR:  permission denied for table users

-- psql -U rbelov -d vk -h 127.0.0.1

SELECT * FROM users WHERE id = 5;

--  id | first_name | last_name |            email            |  phone   | main_photo_id |     created_at      |             user_contacts
-- ----+------------+-----------+-----------------------------+----------+---------------+---------------------+----------------------------------------
--   5 | Yoko       | Sims      | nostra.per.inceptos@aol.com | 655-1605 |            93 | 2022-09-07 01:11:08 | (655-1605,nostra.per.inceptos@aol.com)
-- (1 row)

INSERT INTO users (first_name, last_name, email, phone, main_photo_id, created_at, user_contacts)
  VALUES ('test_first_name', 'test_last_name', 'test@test.test', '000-0000', 1, '2023-04-27 00:00:00', ('000-0000', 'test@test.test'));

-- INSERT 0 1

UPDATE users SET first_name = 'Test first name' WHERE id = 5;

-- UPDATE 1

DELETE FROM users WHERE id = 5;

-- DELETE 1