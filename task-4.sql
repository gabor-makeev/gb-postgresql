ALTER TABLE communities ADD COLUMN members INT[];

UPDATE communities 
	SET members = (
		SELECT ARRAY_AGG(user_id) 
		FROM communities_users 
			WHERE community_id = 3)
	WHERE id = 3;