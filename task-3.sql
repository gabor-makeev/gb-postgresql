-- Вариант решения 1 — через сохранение старого значения

CREATE OR REPLACE FUNCTION update_profile_main_photo_id_trigger()
RETURNS TRIGGER AS
$$
DECLARE is_photo_owner BOOLEAN;
BEGIN
	is_photo_owner := EXISTS(
		SELECT id 
			FROM photo 
				WHERE photo.id = NEW.main_photo_id 
				AND photo.owner_id = NEW.user_id
	);
	IF is_photo_owner IS NOT TRUE THEN
		NEW.main_photo_id = OLD.main_photo_id;
	END IF;
	RETURN NEW;
END
$$
LANGUAGE PLPGSQL;

-- CREATE FUNCTION

CREATE TRIGGER check_profile_on_update BEFORE UPDATE ON profiles
	FOR EACH ROW
	EXECUTE FUNCTION update_profile_main_photo_id_trigger();

-- CREATE TRIGGER

SELECT * FROM profiles WHERE user_id = 10;

--  user_id | main_photo_id |     created_at      |                user_contacts
-- ---------+---------------+---------------------+----------------------------------------------
--       10 |               | 2024-02-28 03:33:56 | (1-372-139-8317,lobortis.tellus@hotmail.org)

SELECT id, owner_id FROM photo LIMIT 5;

--  id | owner_id
-- ----+----------
--  25 |       26
--   1 |      101
--   2 |       10
--   3 |       67
--   4 |       84

UPDATE profiles SET main_photo_id = 1 WHERE user_id = 10;

-- UPDATE 1

SELECT * FROM profiles WHERE user_id = 10;

--  user_id | main_photo_id |     created_at      |                user_contacts
-- ---------+---------------+---------------------+----------------------------------------------
--       10 |               | 2024-02-28 03:33:56 | (1-372-139-8317,lobortis.tellus@hotmail.org)

UPDATE profiles SET main_photo_id = 2 WHERE user_id = 10;

-- UPDATE 1

SELECT * FROM profiles WHERE user_id = 10;

--  user_id | main_photo_id |     created_at      |                user_contacts
-- ---------+---------------+---------------------+----------------------------------------------
--       10 |             2 | 2024-02-28 03:33:56 | (1-372-139-8317,lobortis.tellus@hotmail.org)

-- Вариант решения 2 — через исключение

CREATE OR REPLACE FUNCTION update_profile_main_photo_id_trigger()
RETURNS TRIGGER AS
$$
DECLARE is_photo_owner BOOLEAN;
BEGIN
	is_photo_owner := EXISTS(
		SELECT id 
			FROM photo 
				WHERE photo.id = NEW.main_photo_id 
				AND photo.owner_id = NEW.user_id
	);
	IF is_photo_owner IS NOT TRUE THEN
		RAISE EXCEPTION 'The user is not the owner of the photo';
	END IF;
	RETURN NEW;
END
$$
LANGUAGE PLPGSQL;

-- CREATE FUNCTION

UPDATE profiles SET main_photo_id = 3 WHERE user_id = 10;

-- ERROR:  The user is not the owner of the photo
-- CONTEXT:  PL/pgSQL function update_profile_main_photo_id_trigger() line 11 at RAISE 
-- 
-- SQL state: P0001

SELECT * FROM profiles WHERE user_id = 10;

--  user_id | main_photo_id |     created_at      |                user_contacts
-- ---------+---------------+---------------------+----------------------------------------------
--       10 |             2 | 2024-02-28 03:33:56 | (1-372-139-8317,lobortis.tellus@hotmail.org)

UPDATE photo SET owner_id = 10 WHERE id = 3;

-- UPDATE 1

UPDATE profiles SET main_photo_id = 3 WHERE user_id = 10;

-- UPDATE 1

SELECT * FROM profiles WHERE user_id = 10;

--  user_id | main_photo_id |     created_at      |                user_contacts
-- ---------+---------------+---------------------+----------------------------------------------
--       10 |             3 | 2024-02-28 03:33:56 | (1-372-139-8317,lobortis.tellus@hotmail.org)

-- Триггер можно также улучшить проверкой нового значения main_photo_id на значение NULL для того 
-- чтобы можно было также использовать NULL в качестве целевого значения для столбца main_photo_id