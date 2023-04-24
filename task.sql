-- Найти решение только на вложенных запросах

-- Вариант 1 (очень плохой с точки зрения зрения оптимизации, а также с точки зрения структуры)

SELECT 
	video.id as video_id,
	(
		SELECT users.first_name FROM users 
		WHERE users.id = video.owner_id
	) as video_owner_first_name,
	(
		SELECT users.last_name FROM users 
		WHERE users.id = video.owner_id
	) as video_owner_last_name,
	(
		SELECT photo.url FROM photo 
		WHERE id = (
			SELECT users.main_photo_id FROM users 
			WHERE users.id = video.owner_id
		)
	) as video_owner_main_photo_url, 
	video.url as video_url,
	video.size as video_size
FROM video
	ORDER BY video.size DESC 
	LIMIT 10;

-- Вариант 2 (не совсем "только на вложенных запросах" так как используется "JOIN")

SELECT 
	video.id as video_id,
	video_owner_first_name,
	video_owner_last_name,
	video_owner_main_photo_url,
	video.url as video_url,
	video.size as video_size
FROM video
	JOIN (SELECT 
					users.id as user_id,
					users.main_photo_id as user_main_photo_id,
					users.first_name as video_owner_first_name, 
					users.last_name as video_owner_last_name
				FROM users) as video_owners
		ON video.owner_id = user_id
	JOIN (SELECT 
					photo.id as photo_id,
					photo.url as video_owner_main_photo_url 
				FROM photo) as video_owners_main_photos
		ON user_main_photo_id = photo_id
	ORDER BY video.size DESC 
	LIMIT 10;

-- Найти решение с помощью объединения JOIN

SELECT 
	video.id as video_id,
	users.first_name as video_owner_first_name,
	users.last_name as video_owner_last_name,
	photo.url as video_owner_main_photo_url,
	video.url as video_url,
	video.size as video_size
FROM video
	JOIN users
		ON video.owner_id = users.id
	JOIN photo
		ON users.main_photo_id = photo.id
	ORDER BY video.size DESC 
	LIMIT 10;

-- Найти решение с использованием временной таблицы

CREATE TEMPORARY TABLE ten_biggest_videos (
	id INT,
	url VARCHAR(250),
	size INT,
	owner_id INT
);

INSERT INTO ten_biggest_videos
	SELECT id, url, size, owner_id 
	FROM video ORDER BY size DESC LIMIT 10;
		
SELECT
	ten_biggest_videos.id as video_id,
	users.first_name as video_owner_first_name,
	users.last_name as video_owner_last_name,
	photo.url as video_owner_main_photo_url,
	ten_biggest_videos.url as video_url,
	ten_biggest_videos.size as video_size
FROM ten_biggest_videos
	JOIN users
		ON ten_biggest_videos.owner_id = users.id
	JOIN photo
		ON users.main_photo_id = photo.id;

-- Найти решение с использованием общего табличного выражения

WITH ten_biggest_videos AS (
	SELECT 
		video.id,
		video.url,
		video.owner_id,
		video.size
	FROM video
		ORDER BY video.size DESC 
		LIMIT 10
)
SELECT
	ten_biggest_videos.id as video_id,
	users.first_name as video_owner_first_name,
	users.last_name as video_owner_last_name,
	photo.url as video_owner_main_photo_url,
	ten_biggest_videos.url as video_url,
	ten_biggest_videos.size as video_size
FROM ten_biggest_videos
	JOIN users
		ON ten_biggest_videos.owner_id = users.id
	JOIN photo
		ON users.main_photo_id = photo.id
	ORDER BY video_size DESC;