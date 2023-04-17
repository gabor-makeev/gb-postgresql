--
-- PostgreSQL database dump
--

-- Dumped from database version 14.7 (Ubuntu 14.7-0ubuntu0.22.04.1)
-- Dumped by pg_dump version 14.7 (Ubuntu 14.7-0ubuntu0.22.04.1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: communities; Type: TABLE; Schema: public; Owner: gb_user
--

CREATE TABLE public.communities (
    id integer NOT NULL,
    name character varying(120),
    creator_id integer NOT NULL,
    created_at timestamp without time zone
);


ALTER TABLE public.communities OWNER TO gb_user;

--
-- Name: communities_id_seq; Type: SEQUENCE; Schema: public; Owner: gb_user
--

CREATE SEQUENCE public.communities_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.communities_id_seq OWNER TO gb_user;

--
-- Name: communities_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: gb_user
--

ALTER SEQUENCE public.communities_id_seq OWNED BY public.communities.id;


--
-- Name: communities_users; Type: TABLE; Schema: public; Owner: gb_user
--

CREATE TABLE public.communities_users (
    community_id integer NOT NULL,
    user_id integer NOT NULL,
    created_at timestamp without time zone
);


ALTER TABLE public.communities_users OWNER TO gb_user;

--
-- Name: followers_communities; Type: TABLE; Schema: public; Owner: gb_user
--

CREATE TABLE public.followers_communities (
    follower_user_id integer NOT NULL,
    community_id integer NOT NULL,
    created_at timestamp without time zone
);


ALTER TABLE public.followers_communities OWNER TO gb_user;

--
-- Name: followers_users; Type: TABLE; Schema: public; Owner: gb_user
--

CREATE TABLE public.followers_users (
    follower_user_id integer NOT NULL,
    user_id integer NOT NULL,
    created_at timestamp without time zone,
    CONSTRAINT followers_users_check CHECK ((follower_user_id <> user_id))
);


ALTER TABLE public.followers_users OWNER TO gb_user;

--
-- Name: friendship; Type: TABLE; Schema: public; Owner: gb_user
--

CREATE TABLE public.friendship (
    id integer NOT NULL,
    requested_by_user_id integer NOT NULL,
    requested_to_user_id integer NOT NULL,
    status_id integer NOT NULL,
    requested_at timestamp without time zone,
    confirmed_at timestamp without time zone
);


ALTER TABLE public.friendship OWNER TO gb_user;

--
-- Name: friendship_id_seq; Type: SEQUENCE; Schema: public; Owner: gb_user
--

CREATE SEQUENCE public.friendship_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.friendship_id_seq OWNER TO gb_user;

--
-- Name: friendship_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: gb_user
--

ALTER SEQUENCE public.friendship_id_seq OWNED BY public.friendship.id;


--
-- Name: friendship_statuses; Type: TABLE; Schema: public; Owner: gb_user
--

CREATE TABLE public.friendship_statuses (
    id integer NOT NULL,
    name character varying(30)
);


ALTER TABLE public.friendship_statuses OWNER TO gb_user;

--
-- Name: friendship_statuses_id_seq; Type: SEQUENCE; Schema: public; Owner: gb_user
--

CREATE SEQUENCE public.friendship_statuses_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.friendship_statuses_id_seq OWNER TO gb_user;

--
-- Name: friendship_statuses_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: gb_user
--

ALTER SEQUENCE public.friendship_statuses_id_seq OWNED BY public.friendship_statuses.id;


--
-- Name: messages; Type: TABLE; Schema: public; Owner: gb_user
--

CREATE TABLE public.messages (
    id integer NOT NULL,
    from_user_id integer NOT NULL,
    to_user_id integer NOT NULL,
    body text,
    is_important boolean,
    is_delivered boolean,
    created_at timestamp without time zone
);


ALTER TABLE public.messages OWNER TO gb_user;

--
-- Name: messages_id_seq; Type: SEQUENCE; Schema: public; Owner: gb_user
--

CREATE SEQUENCE public.messages_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.messages_id_seq OWNER TO gb_user;

--
-- Name: messages_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: gb_user
--

ALTER SEQUENCE public.messages_id_seq OWNED BY public.messages.id;


--
-- Name: photo; Type: TABLE; Schema: public; Owner: gb_user
--

CREATE TABLE public.photo (
    id integer NOT NULL,
    url character varying(250) NOT NULL,
    owner_id integer NOT NULL,
    description character varying(250) NOT NULL,
    uploaded_at timestamp without time zone NOT NULL,
    size integer NOT NULL
);


ALTER TABLE public.photo OWNER TO gb_user;

--
-- Name: photo_id_seq; Type: SEQUENCE; Schema: public; Owner: gb_user
--

CREATE SEQUENCE public.photo_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.photo_id_seq OWNER TO gb_user;

--
-- Name: photo_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: gb_user
--

ALTER SEQUENCE public.photo_id_seq OWNED BY public.photo.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: gb_user
--

CREATE TABLE public.users (
    id integer NOT NULL,
    first_name character varying(255) DEFAULT NULL::character varying,
    last_name character varying(255) DEFAULT NULL::character varying,
    email character varying(255) DEFAULT NULL::character varying,
    phone character varying(100) DEFAULT NULL::character varying,
    main_photo_id integer,
    created_at character varying(255)
);


ALTER TABLE public.users OWNER TO gb_user;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: gb_user
--

CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_id_seq OWNER TO gb_user;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: gb_user
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: video; Type: TABLE; Schema: public; Owner: gb_user
--

CREATE TABLE public.video (
    id integer NOT NULL,
    url character varying(250) NOT NULL,
    owner_id integer NOT NULL,
    description character varying(250) NOT NULL,
    uploaded_at timestamp without time zone NOT NULL,
    size integer NOT NULL
);


ALTER TABLE public.video OWNER TO gb_user;

--
-- Name: video_id_seq; Type: SEQUENCE; Schema: public; Owner: gb_user
--

CREATE SEQUENCE public.video_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.video_id_seq OWNER TO gb_user;

--
-- Name: video_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: gb_user
--

ALTER SEQUENCE public.video_id_seq OWNED BY public.video.id;


--
-- Name: communities id; Type: DEFAULT; Schema: public; Owner: gb_user
--

ALTER TABLE ONLY public.communities ALTER COLUMN id SET DEFAULT nextval('public.communities_id_seq'::regclass);


--
-- Name: friendship id; Type: DEFAULT; Schema: public; Owner: gb_user
--

ALTER TABLE ONLY public.friendship ALTER COLUMN id SET DEFAULT nextval('public.friendship_id_seq'::regclass);


--
-- Name: friendship_statuses id; Type: DEFAULT; Schema: public; Owner: gb_user
--

ALTER TABLE ONLY public.friendship_statuses ALTER COLUMN id SET DEFAULT nextval('public.friendship_statuses_id_seq'::regclass);


--
-- Name: messages id; Type: DEFAULT; Schema: public; Owner: gb_user
--

ALTER TABLE ONLY public.messages ALTER COLUMN id SET DEFAULT nextval('public.messages_id_seq'::regclass);


--
-- Name: photo id; Type: DEFAULT; Schema: public; Owner: gb_user
--

ALTER TABLE ONLY public.photo ALTER COLUMN id SET DEFAULT nextval('public.photo_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: gb_user
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Name: video id; Type: DEFAULT; Schema: public; Owner: gb_user
--

ALTER TABLE ONLY public.video ALTER COLUMN id SET DEFAULT nextval('public.video_id_seq'::regclass);


--
-- Data for Name: communities; Type: TABLE DATA; Schema: public; Owner: gb_user
--

INSERT INTO public.communities VALUES (1, 'at, velit. Pellentesque', 40, '2022-11-24 09:55:11');
INSERT INTO public.communities VALUES (2, 'in felis. Nulla', 29, '2022-11-17 05:08:32');
INSERT INTO public.communities VALUES (3, 'nec ante blandit', 9, '2023-06-30 15:39:58');
INSERT INTO public.communities VALUES (4, 'enim. Nunc ut', 50, '2024-01-25 23:45:28');
INSERT INTO public.communities VALUES (5, 'mi enim, condimentum', 48, '2023-10-18 18:16:08');
INSERT INTO public.communities VALUES (6, 'sem elit, pharetra', 67, '2023-07-06 22:42:28');
INSERT INTO public.communities VALUES (7, 'Lorem ipsum dolor', 49, '2023-05-27 21:28:19');
INSERT INTO public.communities VALUES (8, 'non, feugiat nec,', 91, '2022-10-11 22:09:12');
INSERT INTO public.communities VALUES (9, 'Proin eget odio.', 59, '2023-03-22 21:35:24');
INSERT INTO public.communities VALUES (10, 'ornare, facilisis eget,', 62, '2023-02-02 23:41:04');
INSERT INTO public.communities VALUES (11, 'ut dolor dapibus', 63, '2024-04-05 14:46:13');
INSERT INTO public.communities VALUES (12, 'dui. Suspendisse ac', 14, '2023-04-09 13:31:08');
INSERT INTO public.communities VALUES (13, 'mauris. Suspendisse aliquet', 79, '2024-03-17 16:36:56');
INSERT INTO public.communities VALUES (14, 'orci quis lectus.', 95, '2023-02-14 03:18:09');
INSERT INTO public.communities VALUES (15, 'magnis dis parturient', 88, '2023-08-20 22:11:21');
INSERT INTO public.communities VALUES (16, 'dignissim magna a', 94, '2023-01-02 14:18:22');
INSERT INTO public.communities VALUES (17, 'sed libero. Proin', 68, '2023-11-09 09:43:23');
INSERT INTO public.communities VALUES (18, 'pellentesque eget, dictum', 36, '2022-04-25 11:07:09');
INSERT INTO public.communities VALUES (19, 'conubia nostra, per', 89, '2024-02-05 11:45:20');
INSERT INTO public.communities VALUES (20, 'turpis. Nulla aliquet.', 60, '2023-12-07 14:11:27');


--
-- Data for Name: communities_users; Type: TABLE DATA; Schema: public; Owner: gb_user
--

INSERT INTO public.communities_users VALUES (14, 23, '2024-03-12 19:43:21');
INSERT INTO public.communities_users VALUES (2, 30, '2023-03-11 05:43:48');
INSERT INTO public.communities_users VALUES (17, 83, '2022-08-16 12:04:13');
INSERT INTO public.communities_users VALUES (12, 59, '2023-05-01 20:05:58');
INSERT INTO public.communities_users VALUES (2, 92, '2022-06-16 08:52:29');
INSERT INTO public.communities_users VALUES (3, 28, '2024-01-10 18:37:09');
INSERT INTO public.communities_users VALUES (20, 79, '2023-01-14 22:33:14');
INSERT INTO public.communities_users VALUES (7, 14, '2023-05-28 19:04:21');
INSERT INTO public.communities_users VALUES (18, 31, '2022-11-04 09:55:58');
INSERT INTO public.communities_users VALUES (11, 4, '2023-08-18 02:21:24');
INSERT INTO public.communities_users VALUES (16, 95, '2022-07-04 14:40:41');
INSERT INTO public.communities_users VALUES (9, 18, '2023-09-25 18:29:51');
INSERT INTO public.communities_users VALUES (20, 7, '2022-09-09 07:49:39');
INSERT INTO public.communities_users VALUES (3, 8, '2023-03-27 00:42:16');
INSERT INTO public.communities_users VALUES (7, 31, '2023-11-11 14:02:32');
INSERT INTO public.communities_users VALUES (16, 75, '2023-08-20 03:37:02');
INSERT INTO public.communities_users VALUES (12, 47, '2022-08-16 12:29:24');
INSERT INTO public.communities_users VALUES (3, 99, '2022-09-14 14:45:04');
INSERT INTO public.communities_users VALUES (17, 14, '2022-07-16 02:04:29');
INSERT INTO public.communities_users VALUES (3, 94, '2022-09-19 23:57:48');


--
-- Data for Name: followers_communities; Type: TABLE DATA; Schema: public; Owner: gb_user
--

INSERT INTO public.followers_communities VALUES (82, 13, '2023-04-03 12:29:55');
INSERT INTO public.followers_communities VALUES (33, 17, '2023-08-08 19:21:09');
INSERT INTO public.followers_communities VALUES (51, 9, '2024-03-26 04:16:27');
INSERT INTO public.followers_communities VALUES (94, 20, '2023-04-29 08:32:55');
INSERT INTO public.followers_communities VALUES (79, 18, '2024-02-19 21:38:08');
INSERT INTO public.followers_communities VALUES (5, 7, '2023-03-01 23:12:56');
INSERT INTO public.followers_communities VALUES (8, 9, '2022-09-18 05:18:30');
INSERT INTO public.followers_communities VALUES (57, 10, '2022-11-09 07:43:18');
INSERT INTO public.followers_communities VALUES (7, 9, '2022-08-16 01:51:49');
INSERT INTO public.followers_communities VALUES (65, 19, '2023-02-05 12:54:37');
INSERT INTO public.followers_communities VALUES (5, 15, '2023-01-21 08:42:16');
INSERT INTO public.followers_communities VALUES (41, 19, '2023-05-01 18:44:59');
INSERT INTO public.followers_communities VALUES (92, 16, '2023-03-07 01:13:38');
INSERT INTO public.followers_communities VALUES (42, 7, '2023-02-13 18:37:07');
INSERT INTO public.followers_communities VALUES (29, 10, '2024-03-28 21:13:43');
INSERT INTO public.followers_communities VALUES (13, 15, '2022-12-28 12:22:16');
INSERT INTO public.followers_communities VALUES (53, 17, '2022-06-04 13:39:22');
INSERT INTO public.followers_communities VALUES (75, 2, '2023-08-11 00:49:04');
INSERT INTO public.followers_communities VALUES (79, 13, '2022-06-22 20:03:48');
INSERT INTO public.followers_communities VALUES (34, 13, '2023-08-13 02:38:00');


--
-- Data for Name: followers_users; Type: TABLE DATA; Schema: public; Owner: gb_user
--

INSERT INTO public.followers_users VALUES (66, 85, '2023-10-11 09:47:47');
INSERT INTO public.followers_users VALUES (21, 38, '2022-05-21 03:24:04');
INSERT INTO public.followers_users VALUES (71, 69, '2024-01-10 14:18:06');
INSERT INTO public.followers_users VALUES (24, 49, '2023-02-23 23:29:25');
INSERT INTO public.followers_users VALUES (1, 18, '2022-12-31 10:32:59');
INSERT INTO public.followers_users VALUES (62, 77, '2023-01-14 21:06:34');
INSERT INTO public.followers_users VALUES (85, 80, '2022-07-30 02:50:34');
INSERT INTO public.followers_users VALUES (55, 13, '2022-10-19 18:21:38');
INSERT INTO public.followers_users VALUES (92, 67, '2024-02-08 01:11:18');
INSERT INTO public.followers_users VALUES (36, 51, '2023-05-17 01:10:53');
INSERT INTO public.followers_users VALUES (16, 100, '2022-11-24 09:58:18');
INSERT INTO public.followers_users VALUES (64, 96, '2024-02-16 13:09:38');
INSERT INTO public.followers_users VALUES (93, 56, '2023-06-13 22:56:55');
INSERT INTO public.followers_users VALUES (16, 87, '2022-06-17 05:19:15');
INSERT INTO public.followers_users VALUES (10, 20, '2024-02-03 16:16:21');
INSERT INTO public.followers_users VALUES (56, 88, '2023-05-18 03:10:57');
INSERT INTO public.followers_users VALUES (30, 31, '2022-08-27 16:18:30');
INSERT INTO public.followers_users VALUES (21, 72, '2024-03-08 05:13:19');
INSERT INTO public.followers_users VALUES (92, 23, '2023-03-24 13:28:26');
INSERT INTO public.followers_users VALUES (97, 76, '2023-04-06 17:42:15');


--
-- Data for Name: friendship; Type: TABLE DATA; Schema: public; Owner: gb_user
--

INSERT INTO public.friendship VALUES (1, 9, 12, 1, '2023-10-09 22:40:42', '2024-03-03 04:09:42');
INSERT INTO public.friendship VALUES (2, 57, 19, 3, '2022-10-23 00:24:49', '2022-07-04 02:05:10');
INSERT INTO public.friendship VALUES (3, 49, 47, 3, '2024-01-14 04:40:15', '2024-01-13 22:14:57');
INSERT INTO public.friendship VALUES (4, 13, 36, 3, '2023-01-13 20:12:25', '2023-02-24 00:25:02');
INSERT INTO public.friendship VALUES (5, 42, 33, 4, '2023-07-04 20:30:32', '2024-04-07 23:17:23');
INSERT INTO public.friendship VALUES (6, 77, 65, 2, '2022-12-17 06:32:00', '2024-04-16 07:26:10');
INSERT INTO public.friendship VALUES (7, 99, 12, 3, '2024-01-10 20:53:46', '2022-05-25 22:15:24');
INSERT INTO public.friendship VALUES (8, 55, 14, 3, '2024-03-28 21:01:24', '2022-08-15 07:29:34');
INSERT INTO public.friendship VALUES (9, 51, 68, 2, '2022-12-20 12:00:44', '2023-09-17 23:43:08');
INSERT INTO public.friendship VALUES (10, 66, 47, 3, '2022-10-17 23:31:00', '2023-11-19 18:24:19');
INSERT INTO public.friendship VALUES (11, 9, 43, 3, '2023-03-29 16:27:06', '2023-03-16 15:19:47');
INSERT INTO public.friendship VALUES (12, 39, 62, 3, '2022-12-26 19:20:46', '2023-05-10 10:43:52');
INSERT INTO public.friendship VALUES (13, 10, 12, 3, '2023-09-25 00:51:46', '2022-10-13 03:46:22');
INSERT INTO public.friendship VALUES (14, 46, 96, 2, '2023-09-13 04:07:02', '2024-01-19 10:26:45');
INSERT INTO public.friendship VALUES (15, 80, 47, 3, '2023-12-11 15:34:15', '2022-12-18 20:47:38');
INSERT INTO public.friendship VALUES (16, 79, 37, 2, '2023-09-15 20:53:24', '2022-10-24 02:07:43');
INSERT INTO public.friendship VALUES (17, 85, 96, 2, '2023-04-26 04:38:06', '2022-07-06 21:32:49');
INSERT INTO public.friendship VALUES (18, 97, 89, 2, '2022-10-23 00:42:36', '2023-09-14 12:40:55');
INSERT INTO public.friendship VALUES (19, 71, 90, 4, '2024-02-22 17:04:38', '2022-11-03 00:58:20');
INSERT INTO public.friendship VALUES (20, 83, 84, 4, '2022-12-05 04:30:17', '2022-12-21 06:22:05');


--
-- Data for Name: friendship_statuses; Type: TABLE DATA; Schema: public; Owner: gb_user
--

INSERT INTO public.friendship_statuses VALUES (1, 'Requested');
INSERT INTO public.friendship_statuses VALUES (2, 'Accepted');
INSERT INTO public.friendship_statuses VALUES (3, 'Rejected');


--
-- Data for Name: messages; Type: TABLE DATA; Schema: public; Owner: gb_user
--

INSERT INTO public.messages VALUES (1, 11, 47, 'urna et arcu imperdiet ullamcorper. Duis at lacus. Quisque purus', true, false, '2023-08-19 13:04:19');
INSERT INTO public.messages VALUES (2, 96, 90, 'at augue id ante', false, true, '2023-10-13 15:30:51');
INSERT INTO public.messages VALUES (3, 72, 93, 'semper cursus. Integer mollis. Integer tincidunt aliquam arcu. Aliquam ultrices iaculis', true, false, '2023-12-05 08:36:26');
INSERT INTO public.messages VALUES (4, 45, 16, 'mauris sagittis placerat. Cras dictum ultricies ligula. Nullam enim. Sed nulla ante, iaculis nec, eleifend', true, false, '2024-01-24 05:55:23');
INSERT INTO public.messages VALUES (5, 34, 37, 'eu dolor egestas rhoncus. Proin nisl sem, consequat nec, mollis vitae, posuere at, velit.', false, false, '2022-10-04 18:18:42');
INSERT INTO public.messages VALUES (6, 85, 18, 'nec luctus felis purus ac tellus. Suspendisse sed dolor. Fusce mi lorem,', false, true, '2023-06-02 09:15:29');
INSERT INTO public.messages VALUES (7, 86, 33, 'Donec luctus aliquet odio. Etiam ligula tortor, dictum eu, placerat eget, venenatis a, magna. Lorem', false, true, '2023-05-12 01:31:33');
INSERT INTO public.messages VALUES (8, 27, 73, 'tellus non magna. Nam ligula elit, pretium et, rutrum non, hendrerit id, ante. Nunc mauris sapien, cursus', false, true, '2024-01-17 09:45:09');
INSERT INTO public.messages VALUES (9, 64, 26, 'libero et tristique pellentesque, tellus sem mollis dui, in sodales elit', false, false, '2022-07-18 05:19:50');
INSERT INTO public.messages VALUES (10, 24, 11, 'est. Nunc laoreet lectus quis massa. Mauris vestibulum, neque sed dictum eleifend, nunc risus varius orci, in consequat enim', true, true, '2022-11-16 00:37:42');
INSERT INTO public.messages VALUES (11, 22, 3, 'Donec luctus aliquet odio. Etiam', false, true, '2022-08-22 06:03:35');
INSERT INTO public.messages VALUES (12, 2, 90, 'lectus. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec', false, false, '2022-10-21 09:00:49');
INSERT INTO public.messages VALUES (13, 4, 71, 'ultricies adipiscing, enim mi tempor lorem, eget mollis lectus pede et', true, true, '2022-11-26 22:08:52');
INSERT INTO public.messages VALUES (14, 76, 83, 'elementum, dui quis accumsan convallis, ante lectus convallis est, vitae sodales', false, false, '2022-11-29 06:30:11');
INSERT INTO public.messages VALUES (15, 16, 10, 'Integer sem elit, pharetra ut,', true, true, '2022-06-14 01:16:21');
INSERT INTO public.messages VALUES (16, 31, 23, 'conubia nostra, per inceptos hymenaeos. Mauris ut quam vel sapien imperdiet ornare.', true, true, '2022-08-22 15:38:19');
INSERT INTO public.messages VALUES (17, 72, 28, 'Phasellus libero mauris, aliquam eu, accumsan sed, facilisis vitae, orci. Phasellus dapibus quam quis diam.', false, false, '2024-01-26 17:11:54');
INSERT INTO public.messages VALUES (18, 16, 100, 'commodo at, libero. Morbi accumsan laoreet', false, false, '2022-05-13 12:35:24');
INSERT INTO public.messages VALUES (19, 73, 61, 'ipsum primis in faucibus orci luctus et ultrices posuere cubilia', false, true, '2023-04-27 05:41:39');
INSERT INTO public.messages VALUES (20, 42, 70, 'eu neque pellentesque massa lobortis ultrices. Vivamus rhoncus. Donec est. Nunc', false, false, '2022-12-19 05:49:55');


--
-- Data for Name: photo; Type: TABLE DATA; Schema: public; Owner: gb_user
--

INSERT INTO public.photo VALUES (1, 'http://nytimes.com/user/110', 17, 'dui. Fusce aliquam, enim nec tempus scelerisque, lorem ipsum sodales purus, in molestie', '2023-09-19 16:30:07', 163831);
INSERT INTO public.photo VALUES (2, 'https://naver.com/site', 10, 'magna. Sed eu eros. Nam consequat', '2022-08-23 20:16:16', 147786);
INSERT INTO public.photo VALUES (3, 'https://naver.com/en-us', 67, 'Quisque ac libero nec ligula consectetuer rhoncus. Nullam velit dui, semper et,', '2023-07-16 23:27:54', 572807);
INSERT INTO public.photo VALUES (4, 'http://bbc.co.uk/user/110', 84, 'Nunc commodo auctor velit. Aliquam nisl. Nulla eu neque pellentesque massa lobortis ultrices. Vivamus rhoncus. Donec', '2023-12-11 17:08:47', 26014);
INSERT INTO public.photo VALUES (5, 'http://naver.com/user/110', 19, 'imperdiet, erat nonummy ultricies ornare, elit elit fermentum risus, at fringilla purus mauris a nunc.', '2023-06-30 13:45:18', 46338);
INSERT INTO public.photo VALUES (6, 'https://baidu.com/sub/cars', 54, 'adipiscing lobortis risus. In mi', '2023-08-08 21:54:39', 633760);
INSERT INTO public.photo VALUES (7, 'https://wikipedia.org/settings', 95, 'senectus et', '2023-05-25 23:30:47', 496361);
INSERT INTO public.photo VALUES (8, 'http://instagram.com/user/110', 25, 'ultricies', '2023-02-23 13:08:54', 810282);
INSERT INTO public.photo VALUES (9, 'http://reddit.com/group/9', 69, 'Donec egestas.', '2022-07-11 23:49:21', 546439);
INSERT INTO public.photo VALUES (10, 'http://wikipedia.org/en-us', 14, 'tellus sem mollis dui, in sodales elit', '2022-08-06 05:46:08', 512970);
INSERT INTO public.photo VALUES (11, 'https://walmart.com/en-us', 38, 'sit amet, consectetuer adipiscing elit. Curabitur sed tortor. Integer aliquam adipiscing lacus. Ut nec urna et arcu imperdiet', '2023-07-01 06:28:17', 40484);
INSERT INTO public.photo VALUES (12, 'https://ebay.com/sub/cars', 86, 'eros non enim commodo hendrerit. Donec porttitor tellus non magna. Nam ligula elit, pretium et, rutrum non, hendrerit id,', '2023-04-23 09:56:48', 1024938);
INSERT INTO public.photo VALUES (13, 'http://nytimes.com/en-ca', 76, 'ac arcu. Nunc mauris. Morbi non sapien molestie orci tincidunt adipiscing. Mauris molestie pharetra nibh. Aliquam', '2023-09-27 09:30:36', 366329);
INSERT INTO public.photo VALUES (14, 'http://pinterest.com/site', 24, 'ullamcorper, nisl arcu iaculis', '2022-12-12 05:30:33', 747312);
INSERT INTO public.photo VALUES (15, 'http://guardian.co.uk/group/9', 18, 'feugiat. Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aliquam auctor, velit eget laoreet posuere, enim nisl elementum purus,', '2023-05-05 14:07:38', 757906);
INSERT INTO public.photo VALUES (16, 'http://pinterest.com/sub', 93, 'non, luctus sit amet, faucibus ut, nulla.', '2022-08-23 02:00:21', 1011045);
INSERT INTO public.photo VALUES (17, 'https://pinterest.com/en-us', 61, 'lorem, sit amet ultricies sem magna nec quam.', '2023-09-25 23:55:07', 746586);
INSERT INTO public.photo VALUES (18, 'http://youtube.com/sub', 54, 'Pellentesque ut ipsum ac mi eleifend', '2022-06-02 01:51:38', 287669);
INSERT INTO public.photo VALUES (19, 'http://guardian.co.uk/user/110', 41, 'sit amet ultricies sem magna nec quam. Curabitur vel lectus. Cum sociis natoque penatibus et magnis dis', '2024-01-08 05:40:47', 367275);
INSERT INTO public.photo VALUES (20, 'http://netflix.com/en-ca', 40, 'felis purus', '2022-11-30 01:02:27', 979255);

--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: gb_user
--

INSERT INTO public.users VALUES (1, 'Vance', 'Munoz', 'aenean@protonmail.couk', '398-8818', 88, '2024-03-01 01:58:48');
INSERT INTO public.users VALUES (2, 'Lance', 'Bowman', 'ac@aol.com', '385-1771', 35, '2023-05-10 19:04:53');
INSERT INTO public.users VALUES (3, 'Keegan', 'Bates', 'mi.fringilla.mi@google.ca', '1-637-152-3731', 8, '2022-10-11 03:44:27');
INSERT INTO public.users VALUES (4, 'Darryl', 'Snow', 'euismod.et@icloud.net', '397-5462', 45, '2023-09-25 04:33:00');
INSERT INTO public.users VALUES (5, 'Yoko', 'Sims', 'nostra.per.inceptos@aol.com', '655-1605', 93, '2022-09-07 01:11:08');
INSERT INTO public.users VALUES (6, 'Evelyn', 'Watson', 'praesent@hotmail.com', '259-6757', 48, '2022-07-23 06:11:26');
INSERT INTO public.users VALUES (7, 'Herman', 'Mcintosh', 'a.dui.cras@google.org', '1-672-761-5154', 97, '2022-05-12 20:17:36');
INSERT INTO public.users VALUES (8, 'Levi', 'Blanchard', 'dolor@yahoo.org', '961-5551', 43, '2022-09-28 04:20:32');
INSERT INTO public.users VALUES (9, 'Kylan', 'Bray', 'sem.magna.nec@icloud.edu', '595-3180', 4, '2024-03-16 02:55:15');
INSERT INTO public.users VALUES (10, 'Quamar', 'Lancaster', 'lobortis.tellus@hotmail.org', '1-372-139-8317', 29, '2024-02-28 03:33:56');
INSERT INTO public.users VALUES (11, 'Felix', 'Craft', 'nec.tempus@yahoo.couk', '1-687-345-3450', 34, '2023-06-26 11:05:17');
INSERT INTO public.users VALUES (12, 'Paki', 'Clayton', 'et.rutrum.eu@outlook.com', '342-1577', 20, '2022-05-08 00:08:06');
INSERT INTO public.users VALUES (13, 'Karina', 'Nolan', 'dictum@yahoo.ca', '1-506-988-1064', 19, '2022-12-15 15:03:22');
INSERT INTO public.users VALUES (14, 'Idola', 'Hudson', 'sed.est@protonmail.com', '1-524-930-1558', 53, '2023-09-11 13:55:34');
INSERT INTO public.users VALUES (15, 'Talon', 'Melton', 'velit@google.com', '565-6483', 31, '2023-12-23 06:55:59');
INSERT INTO public.users VALUES (16, 'Kameko', 'Rosa', 'odio.tristique.pharetra@aol.edu', '1-742-728-2115', 22, '2023-11-13 11:56:26');
INSERT INTO public.users VALUES (17, 'Ezra', 'Benjamin', 'porttitor.interdum.sed@protonmail.org', '483-8867', 57, '2023-12-19 07:07:44');
INSERT INTO public.users VALUES (18, 'Illiana', 'Finley', 'justo.nec@hotmail.net', '258-1122', 92, '2023-08-05 10:39:43');
INSERT INTO public.users VALUES (19, 'Maile', 'Bruce', 'in.tempus.eu@google.edu', '861-1802', 73, '2022-05-04 09:33:26');
INSERT INTO public.users VALUES (20, 'Kyra', 'Mcclain', 'natoque.penatibus@icloud.edu', '326-1180', 40, '2023-02-26 23:18:07');


--
-- Data for Name: video; Type: TABLE DATA; Schema: public; Owner: gb_user
--

INSERT INTO public.video VALUES (1, 'http://facebook.com/one', 91, 'tellus. Nunc lectus pede, ultrices a, auctor non, feugiat nec, diam. Duis mi', '2023-02-09 17:07:10', 435980);
INSERT INTO public.video VALUES (2, 'http://instagram.com/group/9', 94, 'nulla magna,', '2023-05-14 10:07:59', 748050);
INSERT INTO public.video VALUES (3, 'https://whatsapp.com/site', 99, 'sem, vitae aliquam eros turpis non enim. Mauris quis turpis vitae purus', '2024-04-02 16:17:10', 1001267);
INSERT INTO public.video VALUES (4, 'http://google.com/user/111', 57, 'eu, ligula. Aenean euismod mauris eu elit. Nulla facilisi. Sed neque. Sed eget lacus. Mauris', '2024-02-05 21:02:17', 717534);
INSERT INTO public.video VALUES (5, 'https://instagram.com/one', 20, 'non enim. Mauris quis turpis vitae purus gravida sagittis. Duis gravida. Praesent eu nulla at sem molestie sodales.', '2023-08-30 09:55:09', 919738);
INSERT INTO public.video VALUES (6, 'http://whatsapp.com/sub', 57, 'pede. Nunc sed orci lobortis augue scelerisque mollis. Phasellus libero mauris, aliquam eu, accumsan sed, facilisis vitae,', '2022-05-14 15:20:35', 367720);
INSERT INTO public.video VALUES (7, 'https://pinterest.com/group/9', 27, 'Phasellus', '2024-03-20 19:11:49', 812134);
INSERT INTO public.video VALUES (8, 'https://google.com/en-us', 40, 'nunc sed libero. Proin sed turpis nec mauris blandit mattis. Cras eget nisi', '2022-08-19 00:03:23', 1027393);
INSERT INTO public.video VALUES (9, 'http://youtube.com/site', 46, 'odio, auctor vitae, aliquet nec, imperdiet nec,', '2023-10-19 01:06:16', 878989);
INSERT INTO public.video VALUES (10, 'http://guardian.co.uk/sub', 38, 'Duis volutpat nunc sit amet', '2022-10-06 21:06:30', 159769);
INSERT INTO public.video VALUES (11, 'https://guardian.co.uk/en-us', 48, 'placerat. Cras dictum ultricies ligula. Nullam', '2024-03-12 04:47:43', 281626);
INSERT INTO public.video VALUES (12, 'http://twitter.com/en-ca', 91, 'eu, ultrices sit amet, risus. Donec nibh enim, gravida sit amet, dapibus id, blandit at, nisi.', '2022-04-20 16:33:38', 583277);
INSERT INTO public.video VALUES (13, 'http://cnn.com/one', 74, 'a,', '2022-09-17 16:39:50', 1001164);
INSERT INTO public.video VALUES (14, 'http://ebay.com/en-ca', 88, 'sit amet risus. Donec egestas. Aliquam nec enim. Nunc ut erat.', '2022-05-19 03:57:30', 417899);
INSERT INTO public.video VALUES (15, 'http://naver.com/settings', 50, 'et libero. Proin mi. Aliquam gravida mauris ut mi. Duis risus odio, auctor vitae, aliquet nec, imperdiet nec, leo.', '2022-09-19 08:09:46', 526338);
INSERT INTO public.video VALUES (16, 'https://pinterest.com/fr', 29, 'egestas. Aliquam nec enim. Nunc ut erat. Sed nunc est, mollis non, cursus non, egestas a, dui. Cras pellentesque. Sed', '2023-08-25 10:50:03', 597760);
INSERT INTO public.video VALUES (17, 'http://google.com/user/110', 43, 'in consectetuer ipsum nunc id enim. Curabitur massa. Vestibulum accumsan neque et nunc.', '2023-10-06 13:34:46', 216254);
INSERT INTO public.video VALUES (18, 'http://yahoo.com/group/9', 41, 'ornare. In faucibus. Morbi vehicula. Pellentesque tincidunt tempus risus. Donec egestas. Duis ac arcu. Nunc mauris. Morbi non sapien molestie', '2023-07-21 07:04:52', 72726);
INSERT INTO public.video VALUES (19, 'http://yahoo.com/en-us', 80, 'tempor, est ac mattis semper, dui lectus rutrum urna, nec luctus felis purus ac tellus. Suspendisse sed dolor. Fusce', '2023-08-22 14:59:51', 962129);
INSERT INTO public.video VALUES (20, 'https://baidu.com/fr', 57, 'ante, iaculis', '2023-01-19 01:30:08', 329196);


--
-- Name: communities_id_seq; Type: SEQUENCE SET; Schema: public; Owner: gb_user
--

SELECT pg_catalog.setval('public.communities_id_seq', 20, true);


--
-- Name: friendship_id_seq; Type: SEQUENCE SET; Schema: public; Owner: gb_user
--

SELECT pg_catalog.setval('public.friendship_id_seq', 20, true);


--
-- Name: friendship_statuses_id_seq; Type: SEQUENCE SET; Schema: public; Owner: gb_user
--

SELECT pg_catalog.setval('public.friendship_statuses_id_seq', 3, true);


--
-- Name: messages_id_seq; Type: SEQUENCE SET; Schema: public; Owner: gb_user
--

SELECT pg_catalog.setval('public.messages_id_seq', 20, true);


--
-- Name: photo_id_seq; Type: SEQUENCE SET; Schema: public; Owner: gb_user
--

SELECT pg_catalog.setval('public.photo_id_seq', 100, true);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: gb_user
--

SELECT pg_catalog.setval('public.users_id_seq', 100, true);


--
-- Name: video_id_seq; Type: SEQUENCE SET; Schema: public; Owner: gb_user
--

SELECT pg_catalog.setval('public.video_id_seq', 20, true);


--
-- Name: communities communities_name_key; Type: CONSTRAINT; Schema: public; Owner: gb_user
--

ALTER TABLE ONLY public.communities
    ADD CONSTRAINT communities_name_key UNIQUE (name);


--
-- Name: communities communities_pkey; Type: CONSTRAINT; Schema: public; Owner: gb_user
--

ALTER TABLE ONLY public.communities
    ADD CONSTRAINT communities_pkey PRIMARY KEY (id);


--
-- Name: communities_users communities_users_pkey; Type: CONSTRAINT; Schema: public; Owner: gb_user
--

ALTER TABLE ONLY public.communities_users
    ADD CONSTRAINT communities_users_pkey PRIMARY KEY (community_id, user_id);


--
-- Name: followers_communities followers_communities_pkey; Type: CONSTRAINT; Schema: public; Owner: gb_user
--

ALTER TABLE ONLY public.followers_communities
    ADD CONSTRAINT followers_communities_pkey PRIMARY KEY (follower_user_id, community_id);


--
-- Name: followers_users followers_users_pkey; Type: CONSTRAINT; Schema: public; Owner: gb_user
--

ALTER TABLE ONLY public.followers_users
    ADD CONSTRAINT followers_users_pkey PRIMARY KEY (follower_user_id, user_id);


--
-- Name: friendship friendship_pkey; Type: CONSTRAINT; Schema: public; Owner: gb_user
--

ALTER TABLE ONLY public.friendship
    ADD CONSTRAINT friendship_pkey PRIMARY KEY (id);


--
-- Name: friendship_statuses friendship_statuses_name_key; Type: CONSTRAINT; Schema: public; Owner: gb_user
--

ALTER TABLE ONLY public.friendship_statuses
    ADD CONSTRAINT friendship_statuses_name_key UNIQUE (name);


--
-- Name: friendship_statuses friendship_statuses_pkey; Type: CONSTRAINT; Schema: public; Owner: gb_user
--

ALTER TABLE ONLY public.friendship_statuses
    ADD CONSTRAINT friendship_statuses_pkey PRIMARY KEY (id);


--
-- Name: messages messages_pkey; Type: CONSTRAINT; Schema: public; Owner: gb_user
--

ALTER TABLE ONLY public.messages
    ADD CONSTRAINT messages_pkey PRIMARY KEY (id);


--
-- Name: photo photo_pkey; Type: CONSTRAINT; Schema: public; Owner: gb_user
--

ALTER TABLE ONLY public.photo
    ADD CONSTRAINT photo_pkey PRIMARY KEY (id);


--
-- Name: photo photo_url_key; Type: CONSTRAINT; Schema: public; Owner: gb_user
--

ALTER TABLE ONLY public.photo
    ADD CONSTRAINT photo_url_key UNIQUE (url);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: gb_user
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: video video_pkey; Type: CONSTRAINT; Schema: public; Owner: gb_user
--

ALTER TABLE ONLY public.video
    ADD CONSTRAINT video_pkey PRIMARY KEY (id);


--
-- Name: video video_url_key; Type: CONSTRAINT; Schema: public; Owner: gb_user
--

ALTER TABLE ONLY public.video
    ADD CONSTRAINT video_url_key UNIQUE (url);


--
-- PostgreSQL database dump complete
--

