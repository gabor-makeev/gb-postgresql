CREATE TABLE profiles (
	user_id INT PRIMARY KEY,
	main_photo_id INT,
	created_at VARCHAR(255),
	user_contacts contacts,
	CONSTRAINT profiles_user_id_fk
	FOREIGN KEY (user_id)
	REFERENCES users (id)
		ON DELETE RESTRICT,
	CONSTRAINT profiles_main_photo_id_fk
	FOREIGN KEY (main_photo_id)
	REFERENCES photo (id)
		ON DELETE RESTRICT
);

INSERT INTO profiles (user_id, main_photo_id, created_at, user_contacts)
	SELECT id, main_photo_id, created_at, user_contacts FROM users;
	
ALTER TABLE users
	DROP COLUMN main_photo_id, 
	DROP COLUMN created_at, 
	DROP COLUMN user_contacts;
	