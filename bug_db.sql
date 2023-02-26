--
-- PostgreSQL database dump
--

-- Dumped from database version 14.4 (Debian 14.4-1.pgdg110+1)
-- Dumped by pg_dump version 15.1

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

--
-- Name: public; Type: SCHEMA; Schema: -; Owner: postgres
--

-- *not* creating schema, since initdb creates it


ALTER SCHEMA public OWNER TO postgres;

--
-- Name: add_first_log(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.add_first_log() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
error_id integer := (SELECT currval('errors_id_seq'));
creator varchar(20) := (SELECT username FROM errors WHERE id=error_id);
BEGIN
INSERT INTO logs (action, comment, username, id)
VALUES ('Ввод', 'Ошибка введена в систему', creator, error_id);
RETURN NULL;
END;
$$;


ALTER FUNCTION public.add_first_log() OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: errors; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.errors (
    id integer NOT NULL,
    datetime timestamp without time zone DEFAULT now() NOT NULL,
    short_desc character varying(150) NOT NULL,
    detailed_desc text NOT NULL,
    username character(20),
    status character varying(10) DEFAULT 'Новая'::character varying NOT NULL,
    urgency character varying(20) NOT NULL,
    criticality character varying(25) NOT NULL,
    CONSTRAINT errors_criticality_check CHECK (((criticality)::text = ANY ((ARRAY['Авария'::character varying, 'Критичная'::character varying, 'Некритичная'::character varying, 'Запрос на изменения'::character varying])::text[]))),
    CONSTRAINT errors_status_check CHECK (((status)::text = ANY ((ARRAY['Новая'::character varying, 'Открытая'::character varying, 'Решенная'::character varying, 'Закрытая'::character varying])::text[]))),
    CONSTRAINT errors_urgency_check CHECK (((urgency)::text = ANY ((ARRAY['Очень срочно'::character varying, 'Срочно'::character varying, 'Несрочно'::character varying, 'Совсем несрочно'::character varying])::text[])))
);


ALTER TABLE public.errors OWNER TO postgres;

--
-- Name: errors_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.errors_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.errors_id_seq OWNER TO postgres;

--
-- Name: errors_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.errors_id_seq OWNED BY public.errors.id;


--
-- Name: logs; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.logs (
    datetime timestamp without time zone DEFAULT now() NOT NULL,
    action character varying(15) NOT NULL,
    comment text NOT NULL,
    username character(20),
    id integer NOT NULL,
    CONSTRAINT logs_action_check CHECK (((action)::text = ANY ((ARRAY['Ввод'::character varying, 'Открытие'::character varying, 'Решение'::character varying, 'Закрытие'::character varying])::text[])))
);


ALTER TABLE public.logs OWNER TO postgres;

--
-- Name: logs_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.logs_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.logs_id_seq OWNER TO postgres;

--
-- Name: logs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.logs_id_seq OWNED BY public.logs.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    username character(20) NOT NULL,
    name text NOT NULL,
    surname text NOT NULL,
    password text NOT NULL
);


ALTER TABLE public.users OWNER TO postgres;

--
-- Name: errors id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.errors ALTER COLUMN id SET DEFAULT nextval('public.errors_id_seq'::regclass);


--
-- Data for Name: errors; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.errors (id, datetime, short_desc, detailed_desc, username, status, urgency, criticality) FROM stdin;
42	2023-02-26 03:48:40.531419	Не работает кнопка выхода	Не работает кнопка выхода при нажатии с главной страницы	admin               	Новая	Срочно	Критичная
44	2023-02-26 03:51:10.13744	Добавить изменение идентификатора	Добавить изменение идентификатора пользователя	admin               	Решенная	Несрочно	Некритичная
46	2023-02-26 03:58:57.410699	Тест	Тест Тест Тест Тест Тест Тест Тест Тест Тест Тест Тест Тест Тест Тест Тест Тест Тест Тест Тест Тест Тест Тест Тест Тест Тест Тест Тест Тест Тест Тест Тест Тест Тест Тест Тест Тест Тест Тест Тест Тест Тест Тест Тест Тест Тест Тест Тест Тест Тест Тест Тест Тест Тест Тест Тест Тест Тест Тест Тест Тест Тест Тест Тест Тест Тест Тест Тест Тест Тест Тест Тест Тест Тест Тест Тест Тест Тест Тест Тест Тест Тест Тест Тест Тест Тест Тест Тест Тест Тест Тест Тест Тест Тест Тест Тест Тест Тест Тест Тест Тест Тест Тест Тест Тест Тест Тест Тест Тест Тест Тест Тест Тест Тест Тест Тест Тест Тест Тест Тест Тест Тест Тест Тест Тест Тест Тест Тест Тест Тест Тест Тест Тест Тест Тест Тест Тест Тест Тест Тест Тест Тест Тест Тест Тест Тест Тест Тест Тест Тест Тест Тест Тест Тест Тест Тест Тест Тест Тест Тест Тест Тест Тест Тест Тест Тест Тест Тест Тест Тест Тест Тест Тест Тест Тест Тест Тест Тест Тест Тест Тест 	Egor                	Закрытая	Срочно	Некритичная
43	2023-02-26 03:49:04.426511	Некорректный вывод результата	Некорректный вывод результата	admin               	Открытая	Несрочно	Некритичная
\.


--
-- Data for Name: logs; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.logs (datetime, action, comment, username, id) FROM stdin;
2023-02-26 03:48:40.531419	Ввод	Ошибка введена в систему	admin               	42
2023-02-26 03:49:04.426511	Ввод	Ошибка введена в систему	admin               	43
2023-02-26 03:51:10.13744	Ввод	Ошибка введена в систему	admin               	44
2023-02-26 03:58:57.410699	Ввод	Ошибка введена в систему	Egor                	46
2023-02-26 03:59:55.138982	Открытие	Открываем!	Egor                	46
2023-02-26 04:00:02.333908	Решение	Решаем	Egor                	46
2023-02-26 04:00:09.578893	Открытие	Опять открываем	Egor                	46
2023-02-26 04:00:15.627756	Решение	Опять решаем	Egor                	46
2023-02-26 04:00:20.994075	Закрытие	Закрываем	Egor                	46
2023-02-26 04:00:31.876554	Открытие	Открыл	Egor                	44
2023-02-26 04:00:55.902634	Решение	Решил	admin               	44
2023-02-26 04:01:05.594571	Открытие	Тест	admin               	43
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (username, name, surname, password) FROM stdin;
admin               	admin	admin	8C6976E5B5410415BDE908BD4DEE15DFB167A9C873FC4BB8A81F6F2AB448A918
Ivan                	Ivan	Ivanov	CD0B9452FC376FC4C35A60087B366F70D883FC901524DAF1F122FBD319384F6A
A.Petrov            	Александр	Петров	03AC674216F3E15C761EE1A5E255F067953623C8B388B4459E13F978D7C846F4
Egor                	Egor	Afanasov	5994471ABB01112AFCC18159F6CC74B4F511B99806DA59B3CAF5A9C173CACFC5
TestUser            	Test	User	94EE059335E587E501CC4BF90613E0814F00A7B08BC7C648FD865A2AF6A22CC2
\.


--
-- Name: errors_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.errors_id_seq', 46, true);


--
-- Name: logs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.logs_id_seq', 1, false);


--
-- Name: errors errors_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.errors
    ADD CONSTRAINT errors_pkey PRIMARY KEY (id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (username);


--
-- Name: errors new_error; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER new_error AFTER INSERT ON public.errors FOR EACH STATEMENT EXECUTE FUNCTION public.add_first_log();


--
-- Name: errors errors_username_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.errors
    ADD CONSTRAINT errors_username_fkey FOREIGN KEY (username) REFERENCES public.users(username) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: logs fk_error_logs; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.logs
    ADD CONSTRAINT fk_error_logs FOREIGN KEY (id) REFERENCES public.errors(id) ON DELETE CASCADE;


--
-- Name: logs logs_username_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.logs
    ADD CONSTRAINT logs_username_fkey FOREIGN KEY (username) REFERENCES public.users(username) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE USAGE ON SCHEMA public FROM PUBLIC;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

