SELECT 
	profiles.user_id,
	profiles.main_photo_id,
	photo.id AS photo_id,
	photo.owner_id AS photo_owner_id
FROM profiles 
	JOIN photo 
ON profiles.main_photo_id = photo.id
LIMIT 3;

--  user_id | main_photo_id | photo_id | photo_owner_id
-- ---------+---------------+----------+----------------
--      101 |             1 |        1 |            101
--       26 |            59 |       59 |             12
--       27 |            64 |       64 |             28

CREATE OR REPLACE PROCEDURE check_users_main_photo_ownership()
LANGUAGE PLPGSQL AS
$$
DECLARE user_profile_row RECORD;
BEGIN
	FOR user_profile_row IN
		SELECT 
			profiles.user_id
		FROM profiles
			JOIN photo
				ON profiles.main_photo_id = photo.id
			WHERE profiles.user_id != photo.owner_id
	LOOP
		UPDATE profiles 
		SET main_photo_id = NULL
		WHERE user_id = user_profile_row.user_id;
	END LOOP;
	COMMIT;
END;
$$;

-- CREATE PROCEDURE

CALL check_users_main_photo_ownership();

-- CALL

SELECT user_id, main_photo_id 
FROM profiles 
  WHERE user_id IN (101, 26, 27);

--  user_id | main_photo_id
-- ---------+---------------
--      101 |             1
--       26 |
--       27 |