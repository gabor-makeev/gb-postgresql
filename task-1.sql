BEGIN;
	CREATE TEMPORARY VIEW users_not_to_delete AS
	SELECT DISTINCT
		users.id
	FROM users 
		JOIN friendship 
		ON users.id = friendship.requested_by_user_id 
		OR users.id = friendship.requested_to_user_id
		WHERE friendship.status_id = 2;
	
	DELETE FROM profiles
		WHERE profiles.user_id NOT IN (SELECT id FROM users_not_to_delete);
		
	DELETE FROM users 
		WHERE users.id NOT IN (SELECT id FROM users_not_to_delete);
	
	DROP VIEW users_not_to_delete;
COMMIT;