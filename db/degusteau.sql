--
-- PostgreSQL database dump
--

-- Dumped from database version 13.3
-- Dumped by pg_dump version 13.3

-- Started on 2022-06-23 21:57:37

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
-- TOC entry 204 (class 1259 OID 65959)
-- Name: categoria; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.categoria (
    id integer NOT NULL,
    nome character varying NOT NULL,
    tipo character varying NOT NULL
);


ALTER TABLE public.categoria OWNER TO postgres;

--
-- TOC entry 200 (class 1259 OID 57747)
-- Name: estabelecimento; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.estabelecimento (
    id integer NOT NULL,
    nome character varying NOT NULL,
    local_logradouro character varying,
    local_numero character varying,
    geolocalizacao_lat double precision,
    geolocalizacao_long double precision,
    id_municipio integer
);


ALTER TABLE public.estabelecimento OWNER TO postgres;

--
-- TOC entry 201 (class 1259 OID 57755)
-- Name: ingrediente; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.ingrediente (
    id integer NOT NULL,
    nome character varying
);


ALTER TABLE public.ingrediente OWNER TO postgres;

--
-- TOC entry 206 (class 1259 OID 65985)
-- Name: ingrediente_categoria; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.ingrediente_categoria (
    id_ingrediente integer NOT NULL,
    id_categoria integer NOT NULL
);


ALTER TABLE public.ingrediente_categoria OWNER TO postgres;

--
-- TOC entry 205 (class 1259 OID 65967)
-- Name: ingrediente_estabelecimento; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.ingrediente_estabelecimento (
    id_ingrediente integer NOT NULL,
    id_estabelecimento integer NOT NULL,
    valor numeric NOT NULL,
    unidade character varying NOT NULL
);


ALTER TABLE public.ingrediente_estabelecimento OWNER TO postgres;

--
-- TOC entry 207 (class 1259 OID 66000)
-- Name: ingrediente_receita; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.ingrediente_receita (
    id_ingrediente integer NOT NULL,
    id_receita integer NOT NULL,
    quantidade numeric,
    unidade character varying NOT NULL
);


ALTER TABLE public.ingrediente_receita OWNER TO postgres;

--
-- TOC entry 202 (class 1259 OID 65938)
-- Name: municipio; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.municipio (
    id integer NOT NULL,
    nome character varying NOT NULL
);


ALTER TABLE public.municipio OWNER TO postgres;

--
-- TOC entry 203 (class 1259 OID 65951)
-- Name: receita; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.receita (
    id integer NOT NULL,
    nome character varying NOT NULL,
    tempo_preparo character varying NOT NULL,
    modo_preparo character varying NOT NULL
);


ALTER TABLE public.receita OWNER TO postgres;

--
-- TOC entry 208 (class 1259 OID 66026)
-- Name: receita_categoria; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.receita_categoria (
    id_receita integer NOT NULL,
    id_categoria integer NOT NULL
);


ALTER TABLE public.receita_categoria OWNER TO postgres;

--
-- TOC entry 3048 (class 0 OID 65959)
-- Dependencies: 204
-- Data for Name: categoria; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.categoria VALUES (1, 'brasileira', 'PREF');
INSERT INTO public.categoria VALUES (2, 'japonesa', 'PREF');
INSERT INTO public.categoria VALUES (3, 'vegana', 'PREF');
INSERT INTO public.categoria VALUES (4, 'doces', 'PREF');
INSERT INTO public.categoria VALUES (5, 'frangos', 'PREF');
INSERT INTO public.categoria VALUES (6, 'bebidas', 'PREF');
INSERT INTO public.categoria VALUES (1000, 'laticínios', 'CAT');
INSERT INTO public.categoria VALUES (1001, 'vegetais', 'CAT');


--
-- TOC entry 3044 (class 0 OID 57747)
-- Dependencies: 200
-- Data for Name: estabelecimento; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.estabelecimento VALUES (1, 'Pão de Açucar', 'Av. Bezerra de Menezes', '1498/1548', -3.7334107604864073, -38.55866651536758, 1);
INSERT INTO public.estabelecimento VALUES (2, 'Supermercado Compre Max', 'Av. Mister Hull', '5380', -3.7394596016548878, -38.592588536220156, 1);


--
-- TOC entry 3045 (class 0 OID 57755)
-- Dependencies: 201
-- Data for Name: ingrediente; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.ingrediente VALUES (1, 'leite');
INSERT INTO public.ingrediente VALUES (2, 'ovos');
INSERT INTO public.ingrediente VALUES (3, 'açucar');
INSERT INTO public.ingrediente VALUES (4, 'sal');
INSERT INTO public.ingrediente VALUES (5, 'manteiga');
INSERT INTO public.ingrediente VALUES (6, 'queijo');
INSERT INTO public.ingrediente VALUES (7, 'pão');
INSERT INTO public.ingrediente VALUES (8, 'presunto');
INSERT INTO public.ingrediente VALUES (9, 'tomate');
INSERT INTO public.ingrediente VALUES (10, 'cebola');


--
-- TOC entry 3050 (class 0 OID 65985)
-- Dependencies: 206
-- Data for Name: ingrediente_categoria; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.ingrediente_categoria VALUES (1, 1000);
INSERT INTO public.ingrediente_categoria VALUES (6, 1000);
INSERT INTO public.ingrediente_categoria VALUES (9, 1001);
INSERT INTO public.ingrediente_categoria VALUES (10, 1001);


--
-- TOC entry 3049 (class 0 OID 65967)
-- Dependencies: 205
-- Data for Name: ingrediente_estabelecimento; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.ingrediente_estabelecimento VALUES (1, 1, 4.00, 'litro');
INSERT INTO public.ingrediente_estabelecimento VALUES (2, 1, 0.50, 'unidade');
INSERT INTO public.ingrediente_estabelecimento VALUES (3, 1, 2.40, 'kg');
INSERT INTO public.ingrediente_estabelecimento VALUES (4, 1, 2.00, 'kg');
INSERT INTO public.ingrediente_estabelecimento VALUES (5, 1, 9.50, '500g');
INSERT INTO public.ingrediente_estabelecimento VALUES (6, 2, 45.9, 'kg');
INSERT INTO public.ingrediente_estabelecimento VALUES (7, 2, 4.50, 'pacote');
INSERT INTO public.ingrediente_estabelecimento VALUES (8, 2, 39.9, 'kg');
INSERT INTO public.ingrediente_estabelecimento VALUES (9, 2, 4.20, 'unidade');
INSERT INTO public.ingrediente_estabelecimento VALUES (10, 2, 4.50, 'unidade');
INSERT INTO public.ingrediente_estabelecimento VALUES (1, 2, 3.89, 'litro');
INSERT INTO public.ingrediente_estabelecimento VALUES (5, 2, 9.60, '500g');


--
-- TOC entry 3051 (class 0 OID 66000)
-- Dependencies: 207
-- Data for Name: ingrediente_receita; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.ingrediente_receita VALUES (2, 1, 2, 'unidades');
INSERT INTO public.ingrediente_receita VALUES (4, 1, NULL, 'a gosto');
INSERT INTO public.ingrediente_receita VALUES (5, 1, 1, 'colher');
INSERT INTO public.ingrediente_receita VALUES (5, 2, 1, 'colher');
INSERT INTO public.ingrediente_receita VALUES (6, 2, 1, 'fatia');
INSERT INTO public.ingrediente_receita VALUES (7, 2, 2, 'fatias');
INSERT INTO public.ingrediente_receita VALUES (8, 2, 1, 'fatia');


--
-- TOC entry 3046 (class 0 OID 65938)
-- Dependencies: 202
-- Data for Name: municipio; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.municipio VALUES (1, 'Fortaleza');
INSERT INTO public.municipio VALUES (2, 'Caucaia');


--
-- TOC entry 3047 (class 0 OID 65951)
-- Dependencies: 203
-- Data for Name: receita; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.receita VALUES (1, 'Omelete', '5 minutos', 'Passo 1: quebrar os ovos /nPasso 2: fritar');
INSERT INTO public.receita VALUES (2, 'Misto quente', '5 minutos', 'Passo 1: abra o pão /nPasso 2: passe manteiga');


--
-- TOC entry 3052 (class 0 OID 66026)
-- Dependencies: 208
-- Data for Name: receita_categoria; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.receita_categoria VALUES (1, 1);
INSERT INTO public.receita_categoria VALUES (2, 1);
INSERT INTO public.receita_categoria VALUES (1, 2);


--
-- TOC entry 2896 (class 2606 OID 65966)
-- Name: categoria categoria_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categoria
    ADD CONSTRAINT categoria_pkey PRIMARY KEY (id);


--
-- TOC entry 2888 (class 2606 OID 57754)
-- Name: estabelecimento estabelecimento_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.estabelecimento
    ADD CONSTRAINT estabelecimento_pkey PRIMARY KEY (id);


--
-- TOC entry 2900 (class 2606 OID 65989)
-- Name: ingrediente_categoria ingrediente_categoria_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ingrediente_categoria
    ADD CONSTRAINT ingrediente_categoria_pkey PRIMARY KEY (id_ingrediente, id_categoria);


--
-- TOC entry 2898 (class 2606 OID 65974)
-- Name: ingrediente_estabelecimento ingrediente_estabelecimento_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ingrediente_estabelecimento
    ADD CONSTRAINT ingrediente_estabelecimento_pkey PRIMARY KEY (id_ingrediente, id_estabelecimento);


--
-- TOC entry 2890 (class 2606 OID 57762)
-- Name: ingrediente ingrediente_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ingrediente
    ADD CONSTRAINT ingrediente_pkey PRIMARY KEY (id);


--
-- TOC entry 2902 (class 2606 OID 66007)
-- Name: ingrediente_receita ingrediente_receita_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ingrediente_receita
    ADD CONSTRAINT ingrediente_receita_pkey PRIMARY KEY (id_ingrediente, id_receita);


--
-- TOC entry 2892 (class 2606 OID 65945)
-- Name: municipio municipio_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.municipio
    ADD CONSTRAINT municipio_pkey PRIMARY KEY (id);


--
-- TOC entry 2904 (class 2606 OID 66030)
-- Name: receita_categoria receita_categoria_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.receita_categoria
    ADD CONSTRAINT receita_categoria_pkey PRIMARY KEY (id_receita, id_categoria);


--
-- TOC entry 2894 (class 2606 OID 65958)
-- Name: receita receita_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.receita
    ADD CONSTRAINT receita_pkey PRIMARY KEY (id);


--
-- TOC entry 2905 (class 2606 OID 65946)
-- Name: estabelecimento estabelecimento_id_municipio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.estabelecimento
    ADD CONSTRAINT estabelecimento_id_municipio_fkey FOREIGN KEY (id_municipio) REFERENCES public.municipio(id) ON UPDATE CASCADE ON DELETE SET NULL NOT VALID;


--
-- TOC entry 2909 (class 2606 OID 65995)
-- Name: ingrediente_categoria ingrediente_categoria_id_categoria_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ingrediente_categoria
    ADD CONSTRAINT ingrediente_categoria_id_categoria_fkey FOREIGN KEY (id_categoria) REFERENCES public.categoria(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2908 (class 2606 OID 65990)
-- Name: ingrediente_categoria ingrediente_categoria_id_ingrediente_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ingrediente_categoria
    ADD CONSTRAINT ingrediente_categoria_id_ingrediente_fkey FOREIGN KEY (id_ingrediente) REFERENCES public.ingrediente(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2907 (class 2606 OID 65980)
-- Name: ingrediente_estabelecimento ingrediente_estabelecimento_id_estabelecimento_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ingrediente_estabelecimento
    ADD CONSTRAINT ingrediente_estabelecimento_id_estabelecimento_fkey FOREIGN KEY (id_estabelecimento) REFERENCES public.estabelecimento(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2906 (class 2606 OID 65975)
-- Name: ingrediente_estabelecimento ingrediente_estabelecimento_id_ingrediente_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ingrediente_estabelecimento
    ADD CONSTRAINT ingrediente_estabelecimento_id_ingrediente_fkey FOREIGN KEY (id_ingrediente) REFERENCES public.ingrediente(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2910 (class 2606 OID 66008)
-- Name: ingrediente_receita ingrediente_receita_id_ingrediente_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ingrediente_receita
    ADD CONSTRAINT ingrediente_receita_id_ingrediente_fkey FOREIGN KEY (id_ingrediente) REFERENCES public.ingrediente(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2911 (class 2606 OID 66013)
-- Name: ingrediente_receita ingrediente_receita_id_receita_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ingrediente_receita
    ADD CONSTRAINT ingrediente_receita_id_receita_fkey FOREIGN KEY (id_receita) REFERENCES public.receita(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2913 (class 2606 OID 66036)
-- Name: receita_categoria receita_categoria_id_categoria_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.receita_categoria
    ADD CONSTRAINT receita_categoria_id_categoria_fkey FOREIGN KEY (id_categoria) REFERENCES public.categoria(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2912 (class 2606 OID 66031)
-- Name: receita_categoria receita_categoria_id_receita_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.receita_categoria
    ADD CONSTRAINT receita_categoria_id_receita_fkey FOREIGN KEY (id_receita) REFERENCES public.receita(id) ON UPDATE CASCADE ON DELETE RESTRICT;


-- Completed on 2022-06-23 21:57:39

--
-- PostgreSQL database dump complete
--

