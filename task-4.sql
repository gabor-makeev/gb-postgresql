CREATE FUNCTION most_active_user_contact_id(user_id INTEGER)
RETURNS INTEGER AS
$$
  SELECT 
		messages.from_user_id
  FROM messages
  	WHERE messages.to_user_id = user_id
  GROUP BY messages.from_user_id
  ORDER BY COUNT(*) DESC
	LIMIT 1;
$$
LANGUAGE SQL;

-- CREATE FUNCTION

SELECT 
  id, 
  from_user_id, 
  to_user_id 
FROM messages 
  WHERE to_user_id = 47;

--  id | from_user_id | to_user_id
-- ----+--------------+------------
--   1 |           11 |         47
--  21 |            1 |         47
--  22 |            1 |         47
--  23 |            2 |         47
--  24 |            3 |         47
--  25 |            3 |         47
--  26 |            3 |         47
--  27 |            2 |         47
--  28 |            3 |         47

SELECT most_active_user_contact_id(47);

--  most_active_user_contact_id
-- -----------------------------
--                            3