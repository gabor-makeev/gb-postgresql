CREATE TYPE contacts AS (phone VARCHAR(100), email VARCHAR(255));

ALTER TABLE users ADD COLUMN user_contacts contacts;

UPDATE users SET user_contacts = (phone, email);
UPDATE users SET user_contacts.email = 'test@somemail.ru' WHERE id = 21;