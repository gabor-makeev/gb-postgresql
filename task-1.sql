ALTER TABLE communities
	ADD CONSTRAINT communities_creator_id_fk
	FOREIGN KEY (creator_id)
	REFERENCES users (id)
		ON DELETE CASCADE;

ALTER TABLE communities_users
	ADD CONSTRAINT communities_users_community_id_fk
	FOREIGN KEY (community_id)
	REFERENCES communities (id)
		ON DELETE CASCADE,
	ADD CONSTRAINT communities_users_user_id_fk
	FOREIGN KEY (user_id)
	REFERENCES users (id)
		ON DELETE CASCADE;

ALTER TABLE followers_communities
	ADD CONSTRAINT followers_communities_follower_user_id_fk
	FOREIGN KEY (follower_user_id)
	REFERENCES users (id)
		ON DELETE CASCADE,
	ADD CONSTRAINT followers_communities_community_id_fk
	FOREIGN KEY (community_id)
	REFERENCES communities (id)
		ON DELETE CASCADE;

ALTER TABLE followers_users
	ADD CONSTRAINT followers_users_follower_user_id_fk
	FOREIGN KEY (follower_user_id)
	REFERENCES users (id)
		ON DELETE CASCADE,
	ADD CONSTRAINT followers_users_user_id_fk
	FOREIGN KEY (user_id)
	REFERENCES users (id)
		ON DELETE CASCADE;

ALTER TABLE friendship
	ADD CONSTRAINT friendship_requested_by_user_id_fk
	FOREIGN KEY (requested_by_user_id)
	REFERENCES users (id)
		ON DELETE CASCADE,
	ADD CONSTRAINT friendship_requested_to_user_id_fk
	FOREIGN KEY (requested_to_user_id)
	REFERENCES users (id)
		ON DELETE CASCADE,
	ADD CONSTRAINT friendship_status_id_fk
	FOREIGN KEY (status_id)
	REFERENCES friendship_statuses (id)
		ON DELETE CASCADE;

ALTER TABLE messages
	ADD CONSTRAINT messages_from_user_id_fk
	FOREIGN KEY (from_user_id)
	REFERENCES users (id)
		ON DELETE CASCADE,
	ADD CONSTRAINT messages_to_user_id_fk
	FOREIGN KEY (to_user_id)
	REFERENCES users (id)
		ON DELETE CASCADE;

ALTER TABLE photo
	ADD CONSTRAINT photo_owner_id_fk
	FOREIGN KEY (owner_id)
	REFERENCES users (id)
		ON DELETE CASCADE;

ALTER TABLE video
	ADD CONSTRAINT video_owner_id_fk
	FOREIGN KEY (owner_id)
	REFERENCES users (id)
		ON DELETE CASCADE;

ALTER TABLE users
	ADD CONSTRAINT users_main_photo_id_fk
	FOREIGN KEY (main_photo_id)
	REFERENCES photo (id)
		ON DELETE RESTRICT;
