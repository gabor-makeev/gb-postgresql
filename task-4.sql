-- postgres@gb-postgresql:~$ pg_dump vk > vk.dump.sql
-- createdb vk_staging
-- psql vk_staging < vk.dump.sql

\c vk_staging

\x

SELECT * FROM photo LIMIT 5;

-- -[ RECORD 1 ]---------------------------------------------------------------------------------------------------------------------
-- id          | 1
-- url         | http://nytimes.com/user/110
-- owner_id    | 17
-- description | dui. Fusce aliquam, enim nec tempus scelerisque, lorem ipsum sodales purus, in molestie
-- uploaded_at | 2023-09-19 16:30:07
-- size        | 163831
-- metadata    | {"id" : 1, "url" : "http://nytimes.com/user/110", "size" : 163831}
-- -[ RECORD 2 ]---------------------------------------------------------------------------------------------------------------------
-- id          | 2
-- url         | https://naver.com/site
-- owner_id    | 10
-- description | magna. Sed eu eros. Nam consequat
-- uploaded_at | 2022-08-23 20:16:16
-- size        | 147786
-- metadata    | {"id" : 2, "url" : "https://naver.com/site", "size" : 147786}
-- -[ RECORD 3 ]---------------------------------------------------------------------------------------------------------------------
-- id          | 3
-- url         | https://naver.com/en-us
-- owner_id    | 67
-- description | Quisque ac libero nec ligula consectetuer rhoncus. Nullam velit dui, semper et,
-- uploaded_at | 2023-07-16 23:27:54
-- size        | 572807
-- metadata    | {"id" : 3, "url" : "https://naver.com/en-us", "size" : 572807}
-- -[ RECORD 4 ]---------------------------------------------------------------------------------------------------------------------
-- id          | 4
-- url         | http://bbc.co.uk/user/110
-- owner_id    | 84
-- description | Nunc commodo auctor velit. Aliquam nisl. Nulla eu neque pellentesque massa lobortis ultrices. Vivamus rhoncus. Donec
-- uploaded_at | 2023-12-11 17:08:47
-- size        | 26014
-- metadata    | {"id" : 4, "url" : "http://bbc.co.uk/user/110", "size" : 26014}
-- -[ RECORD 5 ]---------------------------------------------------------------------------------------------------------------------
-- id          | 78
-- url         | http://ebay.com/group/9
-- owner_id    | 66
-- description | nibh. Donec est mauris,
-- uploaded_at | 2023-07-26 08:07:50
-- size        | 485493
-- metadata    | {"id" : 78, "url" : "http://ebay.com/group/9", "size" : 485493}