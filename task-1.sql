-- Описание запроса: найти имена, а также идентификаторы фотографии пользователя 5 пользователей, которые отправили наибольшее количество сообщений (также вывести количество отправленных сообщений)

-- Оценка эффективности выполнения сложного запроса

EXPLAIN ANALYZE SELECT
	users.id,
	users.first_name,
	users.last_name,
	profiles.main_photo_id,
	COUNT(messages.id) as messages_count
FROM users
JOIN profiles
	ON users.id = profiles.user_id
LEFT JOIN messages
	ON users.id = messages.from_user_id
GROUP BY users.id, profiles.main_photo_id
ORDER BY messages_count DESC
LIMIT 5;

--                                                                 QUERY PLAN
-- ------------------------------------------------------------------------------------------------------------------------------------------
--  Limit  (cost=430.75..430.76 rows=5 width=29) (actual time=14.756..14.762 rows=5 loops=1)
--    ->  Sort  (cost=430.75..431.31 rows=225 width=29) (actual time=14.749..14.754 rows=5 loops=1)
--          Sort Key: (count(messages.id)) DESC
--          Sort Method: top-N heapsort  Memory: 25kB
--          ->  HashAggregate  (cost=424.76..427.01 rows=225 width=29) (actual time=14.634..14.643 rows=15 loops=1)
--                Group Key: users.id, profiles.main_photo_id
--                Batches: 1  Memory Usage: 40kB
--                ->  Hash Join  (cost=8.68..347.36 rows=10320 width=25) (actual time=0.353..11.988 rows=10324 loops=1)
--                      Hash Cond: (users.id = profiles.user_id)
--                      ->  Hash Right Join  (cost=5.34..309.28 rows=10320 width=21) (actual time=0.178..9.107 rows=10324 loops=1)
--                            Hash Cond: (messages.from_user_id = users.id)
--                            ->  Seq Scan on messages  (cost=0.00..269.20 rows=10320 width=8) (actual time=0.025..3.708 rows=10320 loops=1)
--                            ->  Hash  (cost=5.15..5.15 rows=15 width=17) (actual time=0.089..0.090 rows=15 loops=1)
--                                  Buckets: 1024  Batches: 1  Memory Usage: 9kB
--                                  ->  Seq Scan on users  (cost=0.00..5.15 rows=15 width=17) (actual time=0.036..0.073 rows=15 loops=1)
--                      ->  Hash  (cost=3.15..3.15 rows=15 width=8) (actual time=0.109..0.110 rows=15 loops=1)
--                            Buckets: 1024  Batches: 1  Memory Usage: 9kB
--                            ->  Seq Scan on profiles  (cost=0.00..3.15 rows=15 width=8) (actual time=0.065..0.069 rows=15 loops=1)
--  Planning Time: 4.382 ms
--  Execution Time: 15.862 ms
-- (20 rows)

-- Предполагаю что индексация колонок profiles.user_id и messages.from_user_id должно улучшить производительность подобного запроса (вероятно скорее в случае большого количества данных)

CREATE INDEX profiles_user_id_fk ON profiles (user_id);

-- CREATE INDEX

CREATE INDEX messages_from_user_id_fk ON messages (from_user_id);

-- CREATE INDEX

EXPLAIN ANALYZE SELECT
	users.id,
	users.first_name,
	users.last_name,
	profiles.main_photo_id,
	COUNT(messages.id) as messages_count
FROM users
JOIN profiles
	ON users.id = profiles.user_id
LEFT JOIN messages
	ON users.id = messages.from_user_id
GROUP BY users.id, profiles.main_photo_id
ORDER BY messages_count DESC
LIMIT 5;

--                                                                 QUERY PLAN
-- ------------------------------------------------------------------------------------------------------------------------------------------
--  Limit  (cost=430.75..430.76 rows=5 width=29) (actual time=14.395..14.402 rows=5 loops=1)
--    ->  Sort  (cost=430.75..431.31 rows=225 width=29) (actual time=14.378..14.383 rows=5 loops=1)
--          Sort Key: (count(messages.id)) DESC
--          Sort Method: top-N heapsort  Memory: 25kB
--          ->  HashAggregate  (cost=424.76..427.01 rows=225 width=29) (actual time=14.227..14.238 rows=15 loops=1)
--                Group Key: users.id, profiles.main_photo_id
--                Batches: 1  Memory Usage: 40kB
--                ->  Hash Join  (cost=8.68..347.36 rows=10320 width=25) (actual time=0.538..11.486 rows=10324 loops=1)
--                      Hash Cond: (users.id = profiles.user_id)
--                      ->  Hash Right Join  (cost=5.34..309.28 rows=10320 width=21) (actual time=0.173..8.123 rows=10324 loops=1)
--                            Hash Cond: (messages.from_user_id = users.id)
--                            ->  Seq Scan on messages  (cost=0.00..269.20 rows=10320 width=8) (actual time=0.009..2.546 rows=10320 loops=1)
--                            ->  Hash  (cost=5.15..5.15 rows=15 width=17) (actual time=0.089..0.090 rows=15 loops=1)
--                                  Buckets: 1024  Batches: 1  Memory Usage: 9kB
--                                  ->  Seq Scan on users  (cost=0.00..5.15 rows=15 width=17) (actual time=0.025..0.059 rows=15 loops=1)
--                      ->  Hash  (cost=3.15..3.15 rows=15 width=8) (actual time=0.174..0.175 rows=15 loops=1)
--                            Buckets: 1024  Batches: 1  Memory Usage: 9kB
--                            ->  Seq Scan on profiles  (cost=0.00..3.15 rows=15 width=8) (actual time=0.092..0.100 rows=15 loops=1)
--  Planning Time: 3.828 ms
--  Execution Time: 15.130 ms
-- (20 rows)

-- Видимо СУБД посчитало что последовательное сканирование все еще является более оптимальным решением

-- Отключаю последовательно сканирование явным образом

SET enable_seqscan TO OFF;

-- SET

EXPLAIN ANALYZE SELECT
	users.id,
	users.first_name,
	users.last_name,
	profiles.main_photo_id,
	COUNT(messages.id) as messages_count
FROM users
JOIN profiles
	ON users.id = profiles.user_id
LEFT JOIN messages
	ON users.id = messages.from_user_id
GROUP BY users.id, profiles.main_photo_id
ORDER BY messages_count DESC
LIMIT 5;

--                                                                                 QUERY PLAN
-- ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--  Limit  (cost=1051.78..1051.79 rows=5 width=29) (actual time=15.311..15.319 rows=5 loops=1)
--    ->  Sort  (cost=1051.78..1052.34 rows=225 width=29) (actual time=15.308..15.314 rows=5 loops=1)
--          Sort Key: (count(messages.id)) DESC
--          Sort Method: top-N heapsort  Memory: 25kB
--          ->  HashAggregate  (cost=1045.79..1048.04 rows=225 width=29) (actual time=15.282..15.293 rows=15 loops=1)
--                Group Key: users.id, profiles.main_photo_id
--                Batches: 1  Memory Usage: 40kB
--                ->  Hash Join  (cost=41.09..968.39 rows=10320 width=25) (actual time=0.095..12.473 rows=10324 loops=1)
--                      Hash Cond: (users.id = profiles.user_id)
--                      ->  Hash Right Join  (cost=23.13..915.69 rows=10320 width=21) (actual time=0.044..9.851 rows=10324 loops=1)
--                            Hash Cond: (messages.from_user_id = users.id)
--                            ->  Index Scan using messages_from_user_id_fk on messages  (cost=0.29..858.10 rows=10320 width=8) (actual time=0.011..6.148 rows=10320 loops=1)
--                            ->  Hash  (cost=22.66..22.66 rows=15 width=17) (actual time=0.026..0.028 rows=15 loops=1)
--                                  Buckets: 1024  Batches: 1  Memory Usage: 9kB
--                                  ->  Index Scan using users_pkey on users  (cost=0.14..22.66 rows=15 width=17) (actual time=0.004..0.021 rows=15 loops=1)
--                      ->  Hash  (cost=17.77..17.77 rows=15 width=8) (actual time=0.029..0.030 rows=15 loops=1)
--                            Buckets: 1024  Batches: 1  Memory Usage: 9kB
--                            ->  Index Scan using profiles_user_id_fk on profiles  (cost=0.14..17.77 rows=15 width=8) (actual time=0.006..0.017 rows=15 loops=1)
--  Planning Time: 0.546 ms
--  Execution Time: 15.441 ms
-- (20 rows)

-- Как можно заметить актуальное время выполнения запроса в целом не изменилось, также можно заметить что подсчитанная стоимость запросов (cost) также выросла (в случае использования индексного сканирования)

-- Предполагаю что оптимизация с использованием индексов было бы выгодным в случае большого количества данных
