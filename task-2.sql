WITH users_with_uploaded_photos_and_videos AS (
	SELECT DISTINCT 
		users.id as user_id, 
		COUNT(photo.id) OVER (PARTITION BY users.id) AS number_of_photos, 
		COUNT(video.id) OVER (PARTITION BY users.id) AS number_of_videos
	FROM users
		LEFT JOIN photo
			ON users.id = photo.owner_id
		LEFT JOIN video
			ON users.id = video.owner_id
)
SELECT
	user_id,
	number_of_photos,
	number_of_videos,
	DENSE_RANK() OVER (ORDER BY number_of_photos DESC) AS photo_rank,
	DENSE_RANK() OVER (ORDER BY number_of_videos DESC) AS video_rank
		FROM users_with_uploaded_photos_and_videos;