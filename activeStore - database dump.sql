--
-- PostgreSQL database dump
--

-- Dumped from database version 11.1
-- Dumped by pg_dump version 11.1

-- Started on 2019-01-19 19:13:26

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 213 (class 1255 OID 16520)
-- Name: naruciArtikle(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public."naruciArtikle"() RETURNS void
    LANGUAGE plpgsql
    AS $$
	BEGIN
	-- Routine body goes here...

	RETURN;
END
$$;


ALTER FUNCTION public."naruciArtikle"() OWNER TO postgres;

--
-- TOC entry 227 (class 1255 OID 16545)
-- Name: naruci_artikle(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.naruci_artikle() RETURNS trigger
    LANGUAGE plpgsql
    AS $$		DECLARE naruciti Integer;
		
		BEGIN
			/*Promjena kolicine u dnevnik*/
			INSERT INTO "Dnevnik" VALUES (DEFAULT, 1, NEW."ID_knjiga", CONCAT('Promjena količine knjige na skladistu: ', NEW."Kolicina"), date_trunc('second'::text, CURRENT_TIMESTAMP));
		
			IF NEW."Kolicina" < 20 THEN
				/*Izracun narudzbe   (((razlika do 20) / 10) +1) *10  = kolicina za narucit*/
				SELECT ((((20-(NEW."Kolicina")::int)/10)::int+1)::int*10)::int INTO naruciti;																											 
																															 
				/*Izrada narudžbe*/
				INSERT INTO "Narudzba" VALUES (DEFAULT, NEW."ID_knjiga", ceil(random()*3), naruciti, date_trunc('second'::text, CURRENT_TIMESTAMP), date_trunc('second'::text, CURRENT_TIMESTAMP + INTERVAL '1 day')); /* odmah je zaprimamo (interval +1 dan za evidenciju*/
				/*evidencija izradene narudzbe*/
				INSERT INTO "Dnevnik" VALUES (DEFAULT, 2, NEW."ID_knjiga", CONCAT('Izrađena narudžba za sljedeći broj artikala knjige: ', naruciti), date_trunc('second'::text, CURRENT_TIMESTAMP));
		
				/*evidencija pristigle primke*/
				INSERT INTO "Dnevnik" VALUES (DEFAULT, 3, NEW."ID_knjiga", CONCAT('Izrađena primka za sljedeći broj artikala knjige: ', naruciti), date_trunc('second'::text, CURRENT_TIMESTAMP));
				UPDATE "Skladiste" SET "Kolicina"="Kolicina"+naruciti WHERE "ID_knjiga"=NEW."ID_knjiga";
				
				RETURN NEW;
			END IF;
			RETURN NEW;
		END;
	$$;


ALTER FUNCTION public.naruci_artikle() OWNER TO postgres;

--
-- TOC entry 226 (class 1255 OID 16540)
-- Name: provjera_kolicine(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.provjera_kolicine() RETURNS trigger
    LANGUAGE plpgsql
    AS $$		BEGIN
			IF NEW."Kolicina" < 0 THEN                
				RAISE EXCEPTION 'Na skladištu nije dostupna tražena količina! Dostupno je % komada artikla.', OLD."Kolicina";
				RETURN OLD;
			END IF;
			NEW."Posljednja_promjena" = date_trunc('second'::text, CURRENT_TIMESTAMP);
			RETURN NEW;        
		END;    
	$$;


ALTER FUNCTION public.provjera_kolicine() OWNER TO postgres;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 197 (class 1259 OID 16396)
-- Name: Autor; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Autor" (
    "ID" smallint NOT NULL,
    "ImePrezime" character varying(50) NOT NULL,
    "Drzavljanstvo" character varying(100) NOT NULL,
    "Url" character varying(100) NOT NULL,
    "Datum_rodenja" date NOT NULL
);


ALTER TABLE public."Autor" OWNER TO postgres;

--
-- TOC entry 196 (class 1259 OID 16394)
-- Name: Autor_ID_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Autor_ID_seq"
    AS smallint
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Autor_ID_seq" OWNER TO postgres;

--
-- TOC entry 2916 (class 0 OID 0)
-- Dependencies: 196
-- Name: Autor_ID_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Autor_ID_seq" OWNED BY public."Autor"."ID";


--
-- TOC entry 206 (class 1259 OID 16433)
-- Name: Dnevnik; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Dnevnik" (
    "ID" smallint NOT NULL,
    vk_tip smallint NOT NULL,
    vk_knjiga smallint NOT NULL,
    "Tekst" character varying(100) NOT NULL,
    "Datum" timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public."Dnevnik" OWNER TO postgres;

--
-- TOC entry 205 (class 1259 OID 16431)
-- Name: Dnevnik_ID_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Dnevnik_ID_seq"
    AS smallint
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Dnevnik_ID_seq" OWNER TO postgres;

--
-- TOC entry 2917 (class 0 OID 0)
-- Dependencies: 205
-- Name: Dnevnik_ID_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Dnevnik_ID_seq" OWNED BY public."Dnevnik"."ID";


--
-- TOC entry 210 (class 1259 OID 16450)
-- Name: Dobavljac; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Dobavljac" (
    "ID" smallint NOT NULL,
    "Naziv" character varying(30) NOT NULL,
    "Adresa" character varying(150) NOT NULL,
    "Email" character varying(50) NOT NULL,
    "Telefon" character varying(30) NOT NULL
);


ALTER TABLE public."Dobavljac" OWNER TO postgres;

--
-- TOC entry 209 (class 1259 OID 16448)
-- Name: Dobavljac_ID_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Dobavljac_ID_seq"
    AS smallint
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Dobavljac_ID_seq" OWNER TO postgres;

--
-- TOC entry 2918 (class 0 OID 0)
-- Dependencies: 209
-- Name: Dobavljac_ID_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Dobavljac_ID_seq" OWNED BY public."Dobavljac"."ID";


--
-- TOC entry 199 (class 1259 OID 16404)
-- Name: Izdavac; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Izdavac" (
    "ID" smallint NOT NULL,
    "Naziv" character varying(50) NOT NULL,
    "Adresa" character varying(150) NOT NULL,
    "Email" character varying(50) NOT NULL,
    "Telefon" character varying(50) NOT NULL
);


ALTER TABLE public."Izdavac" OWNER TO postgres;

--
-- TOC entry 198 (class 1259 OID 16402)
-- Name: Izdavac_ID_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Izdavac_ID_seq"
    AS smallint
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Izdavac_ID_seq" OWNER TO postgres;

--
-- TOC entry 2919 (class 0 OID 0)
-- Dependencies: 198
-- Name: Izdavac_ID_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Izdavac_ID_seq" OWNED BY public."Izdavac"."ID";


--
-- TOC entry 201 (class 1259 OID 16412)
-- Name: Knjiga; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Knjiga" (
    "ID" smallint NOT NULL,
    "Naslov" character varying(50) NOT NULL,
    "Godina_izdavanja" smallint NOT NULL,
    "Stranice" smallint NOT NULL,
    "Cijena" real NOT NULL,
    vk_autor smallint NOT NULL,
    vk_izdavac smallint NOT NULL,
    vk_zanr smallint NOT NULL
);


ALTER TABLE public."Knjiga" OWNER TO postgres;

--
-- TOC entry 200 (class 1259 OID 16410)
-- Name: Knjiga_ID_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Knjiga_ID_seq"
    AS smallint
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Knjiga_ID_seq" OWNER TO postgres;

--
-- TOC entry 2920 (class 0 OID 0)
-- Dependencies: 200
-- Name: Knjiga_ID_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Knjiga_ID_seq" OWNED BY public."Knjiga"."ID";


--
-- TOC entry 212 (class 1259 OID 16458)
-- Name: Narudzba; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Narudzba" (
    "ID" smallint NOT NULL,
    vk_knjiga smallint NOT NULL,
    vk_dobavljac smallint NOT NULL,
    "Kolicina" smallint NOT NULL,
    "Datum_nastanka" timestamp without time zone DEFAULT date_trunc('second'::text, CURRENT_TIMESTAMP) NOT NULL,
    "Datum_zaprimanja" timestamp without time zone
);


ALTER TABLE public."Narudzba" OWNER TO postgres;

--
-- TOC entry 211 (class 1259 OID 16456)
-- Name: Narudzba_ID_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Narudzba_ID_seq"
    AS smallint
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Narudzba_ID_seq" OWNER TO postgres;

--
-- TOC entry 2921 (class 0 OID 0)
-- Dependencies: 211
-- Name: Narudzba_ID_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Narudzba_ID_seq" OWNED BY public."Narudzba"."ID";


--
-- TOC entry 204 (class 1259 OID 16426)
-- Name: Skladiste; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Skladiste" (
    "ID_knjiga" smallint NOT NULL,
    "Kolicina" smallint NOT NULL,
    "Posljednja_promjena" timestamp without time zone DEFAULT date_trunc('second'::text, CURRENT_TIMESTAMP) NOT NULL
);


ALTER TABLE public."Skladiste" OWNER TO postgres;

--
-- TOC entry 208 (class 1259 OID 16442)
-- Name: Tip; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Tip" (
    "ID" smallint NOT NULL,
    "Naziv" character varying(20) NOT NULL,
    "Opis" character varying(120) NOT NULL
);


ALTER TABLE public."Tip" OWNER TO postgres;

--
-- TOC entry 207 (class 1259 OID 16440)
-- Name: Tip_ID_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Tip_ID_seq"
    AS smallint
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Tip_ID_seq" OWNER TO postgres;

--
-- TOC entry 2922 (class 0 OID 0)
-- Dependencies: 207
-- Name: Tip_ID_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Tip_ID_seq" OWNED BY public."Tip"."ID";


--
-- TOC entry 203 (class 1259 OID 16420)
-- Name: Zanr; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Zanr" (
    "ID" smallint NOT NULL,
    "Naziv" character varying(30) NOT NULL,
    "Opis" character varying(120) NOT NULL
);


ALTER TABLE public."Zanr" OWNER TO postgres;

--
-- TOC entry 202 (class 1259 OID 16418)
-- Name: Zanr_ID_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Zanr_ID_seq"
    AS smallint
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Zanr_ID_seq" OWNER TO postgres;

--
-- TOC entry 2923 (class 0 OID 0)
-- Dependencies: 202
-- Name: Zanr_ID_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Zanr_ID_seq" OWNED BY public."Zanr"."ID";


--
-- TOC entry 2734 (class 2604 OID 16399)
-- Name: Autor ID; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Autor" ALTER COLUMN "ID" SET DEFAULT nextval('public."Autor_ID_seq"'::regclass);


--
-- TOC entry 2739 (class 2604 OID 16436)
-- Name: Dnevnik ID; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Dnevnik" ALTER COLUMN "ID" SET DEFAULT nextval('public."Dnevnik_ID_seq"'::regclass);


--
-- TOC entry 2742 (class 2604 OID 16453)
-- Name: Dobavljac ID; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Dobavljac" ALTER COLUMN "ID" SET DEFAULT nextval('public."Dobavljac_ID_seq"'::regclass);


--
-- TOC entry 2735 (class 2604 OID 16407)
-- Name: Izdavac ID; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Izdavac" ALTER COLUMN "ID" SET DEFAULT nextval('public."Izdavac_ID_seq"'::regclass);


--
-- TOC entry 2736 (class 2604 OID 16415)
-- Name: Knjiga ID; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Knjiga" ALTER COLUMN "ID" SET DEFAULT nextval('public."Knjiga_ID_seq"'::regclass);


--
-- TOC entry 2743 (class 2604 OID 16461)
-- Name: Narudzba ID; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Narudzba" ALTER COLUMN "ID" SET DEFAULT nextval('public."Narudzba_ID_seq"'::regclass);


--
-- TOC entry 2741 (class 2604 OID 16445)
-- Name: Tip ID; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Tip" ALTER COLUMN "ID" SET DEFAULT nextval('public."Tip_ID_seq"'::regclass);


--
-- TOC entry 2737 (class 2604 OID 16423)
-- Name: Zanr ID; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Zanr" ALTER COLUMN "ID" SET DEFAULT nextval('public."Zanr_ID_seq"'::regclass);


--
-- TOC entry 2895 (class 0 OID 16396)
-- Dependencies: 197
-- Data for Name: Autor; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."Autor" ("ID", "ImePrezime", "Drzavljanstvo", "Url", "Datum_rodenja") VALUES (2, 'Miguel de Cervantes', 'Španjolsko', 'https://hr.wikipedia.org/wiki/Miguel_de_Cervantes', '1574-09-29');
INSERT INTO public."Autor" ("ID", "ImePrezime", "Drzavljanstvo", "Url", "Datum_rodenja") VALUES (3, 'Marcel Proust', 'Francusko', 'https://hr.wikipedia.org/wiki/Marcel_Proust', '1871-07-10');
INSERT INTO public."Autor" ("ID", "ImePrezime", "Drzavljanstvo", "Url", "Datum_rodenja") VALUES (4, 'James Joyce', 'Irsko', 'https://hr.wikipedia.org/wiki/James_Joyce', '1882-02-02');
INSERT INTO public."Autor" ("ID", "ImePrezime", "Drzavljanstvo", "Url", "Datum_rodenja") VALUES (5, 'Mark Twain', 'Američko', 'https://hr.wikipedia.org/wiki/Mark_Twain', '1835-11-30');
INSERT INTO public."Autor" ("ID", "ImePrezime", "Drzavljanstvo", "Url", "Datum_rodenja") VALUES (6, 'Isco', 'Španjolsko', 'https://en.wikipedia.org/wiki/Isco', '1992-04-21');


--
-- TOC entry 2904 (class 0 OID 16433)
-- Dependencies: 206
-- Data for Name: Dnevnik; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4591, 1, 1, 'Promjena količine knjige na skladistu: 19', '2019-01-11 16:29:49');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4592, 2, 1, 'Izrađena narudžba za sljedeći broj artikala knjige: 10', '2019-01-11 16:29:49');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4593, 3, 1, 'Izrađena primka za sljedeći broj artikala knjige: 10', '2019-01-11 16:29:49');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4594, 1, 1, 'Promjena količine knjige na skladistu: 29', '2019-01-11 16:29:49');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4595, 1, 1, 'Promjena količine knjige na skladistu: 0', '2019-01-11 16:31:00');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4596, 2, 1, 'Izrađena narudžba za sljedeći broj artikala knjige: 30', '2019-01-11 16:31:00');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4597, 3, 1, 'Izrađena primka za sljedeći broj artikala knjige: 30', '2019-01-11 16:31:00');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4598, 1, 1, 'Promjena količine knjige na skladistu: 30', '2019-01-11 16:31:00');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4599, 1, 4, 'Promjena količine knjige na skladistu: 4', '2019-01-11 16:35:40');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4600, 2, 4, 'Izrađena narudžba za sljedeći broj artikala knjige: 20', '2019-01-11 16:35:40');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4601, 3, 4, 'Izrađena primka za sljedeći broj artikala knjige: 20', '2019-01-11 16:35:40');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4602, 1, 4, 'Promjena količine knjige na skladistu: 24', '2019-01-11 16:35:40');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4603, 1, 4, 'Promjena količine knjige na skladistu: 14', '2019-01-11 16:35:44');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4604, 2, 4, 'Izrađena narudžba za sljedeći broj artikala knjige: 10', '2019-01-11 16:35:44');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4605, 3, 4, 'Izrađena primka za sljedeći broj artikala knjige: 10', '2019-01-11 16:35:44');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4606, 1, 4, 'Promjena količine knjige na skladistu: 24', '2019-01-11 16:35:44');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4607, 1, 4, 'Promjena količine knjige na skladistu: 19', '2019-01-11 16:35:47');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4608, 2, 4, 'Izrađena narudžba za sljedeći broj artikala knjige: 10', '2019-01-11 16:35:47');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4609, 3, 4, 'Izrađena primka za sljedeći broj artikala knjige: 10', '2019-01-11 16:35:47');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4610, 1, 4, 'Promjena količine knjige na skladistu: 29', '2019-01-11 16:35:47');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4611, 1, 5, 'Promjena količine knjige na skladistu: 0', '2019-01-11 16:36:14');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4612, 2, 5, 'Izrađena narudžba za sljedeći broj artikala knjige: 30', '2019-01-11 16:36:14');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4613, 3, 5, 'Izrađena primka za sljedeći broj artikala knjige: 30', '2019-01-11 16:36:14');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4614, 1, 5, 'Promjena količine knjige na skladistu: 30', '2019-01-11 16:36:14');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4615, 1, 4, 'Promjena količine knjige na skladistu: 8', '2019-01-11 16:42:22');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4616, 2, 4, 'Izrađena narudžba za sljedeći broj artikala knjige: 20', '2019-01-11 16:42:22');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4617, 3, 4, 'Izrađena primka za sljedeći broj artikala knjige: 20', '2019-01-11 16:42:22');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4618, 1, 4, 'Promjena količine knjige na skladistu: 28', '2019-01-11 16:42:22');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4619, 1, 4, 'Promjena količine knjige na skladistu: 15', '2019-01-11 16:42:26');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4620, 2, 4, 'Izrađena narudžba za sljedeći broj artikala knjige: 10', '2019-01-11 16:42:26');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4621, 3, 4, 'Izrađena primka za sljedeći broj artikala knjige: 10', '2019-01-11 16:42:26');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4622, 1, 4, 'Promjena količine knjige na skladistu: 25', '2019-01-11 16:42:26');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4623, 1, 4, 'Promjena količine knjige na skladistu: 14', '2019-01-11 16:42:29');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4624, 2, 4, 'Izrađena narudžba za sljedeći broj artikala knjige: 10', '2019-01-11 16:42:29');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4625, 3, 4, 'Izrađena primka za sljedeći broj artikala knjige: 10', '2019-01-11 16:42:29');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4626, 1, 4, 'Promjena količine knjige na skladistu: 24', '2019-01-11 16:42:29');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4627, 1, 4, 'Promjena količine knjige na skladistu: 6', '2019-01-11 16:42:33');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4628, 2, 4, 'Izrađena narudžba za sljedeći broj artikala knjige: 20', '2019-01-11 16:42:33');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4629, 3, 4, 'Izrađena primka za sljedeći broj artikala knjige: 20', '2019-01-11 16:42:33');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4630, 1, 4, 'Promjena količine knjige na skladistu: 26', '2019-01-11 16:42:33');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4631, 1, 3, 'Promjena količine knjige na skladistu: 14', '2019-01-11 16:42:55');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4632, 2, 3, 'Izrađena narudžba za sljedeći broj artikala knjige: 10', '2019-01-11 16:42:55');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4633, 3, 3, 'Izrađena primka za sljedeći broj artikala knjige: 10', '2019-01-11 16:42:55');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4634, 1, 3, 'Promjena količine knjige na skladistu: 24', '2019-01-11 16:42:55');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4635, 1, 1, 'Promjena količine knjige na skladistu: 0', '2019-01-11 16:42:59');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4636, 2, 1, 'Izrađena narudžba za sljedeći broj artikala knjige: 30', '2019-01-11 16:42:59');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4637, 3, 1, 'Izrađena primka za sljedeći broj artikala knjige: 30', '2019-01-11 16:42:59');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4638, 1, 1, 'Promjena količine knjige na skladistu: 30', '2019-01-11 16:42:59');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4639, 1, 5, 'Promjena količine knjige na skladistu: 17', '2019-01-11 16:43:04');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4640, 2, 5, 'Izrađena narudžba za sljedeći broj artikala knjige: 10', '2019-01-11 16:43:04');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4641, 3, 5, 'Izrađena primka za sljedeći broj artikala knjige: 10', '2019-01-11 16:43:04');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4642, 1, 5, 'Promjena količine knjige na skladistu: 27', '2019-01-11 16:43:04');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4643, 1, 3, 'Promjena količine knjige na skladistu: 23', '2019-01-11 17:17:49');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4644, 1, 3, 'Promjena količine knjige na skladistu: 24', '2019-01-11 18:04:28');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4645, 1, 4, 'Promjena količine knjige na skladistu: 27', '2019-01-11 18:04:30');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4646, 1, 4, 'Promjena količine knjige na skladistu: 28', '2019-01-11 18:04:33');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4647, 1, 3, 'Promjena količine knjige na skladistu: 25', '2019-01-11 18:05:39');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4648, 1, 1, 'Promjena količine knjige na skladistu: 35', '2019-01-11 18:05:41');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4649, 1, 1, 'Promjena količine knjige na skladistu: 40', '2019-01-11 18:05:43');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4650, 1, 1, 'Promjena količine knjige na skladistu: 45', '2019-01-11 18:05:53');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4651, 1, 1, 'Promjena količine knjige na skladistu: 50', '2019-01-11 18:05:53');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4652, 1, 1, 'Promjena količine knjige na skladistu: 51', '2019-01-11 18:05:56');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4653, 1, 1, 'Promjena količine knjige na skladistu: 50', '2019-01-11 18:12:08');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4654, 1, 1, 'Promjena količine knjige na skladistu: 49', '2019-01-11 18:12:10');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4655, 1, 1, 'Promjena količine knjige na skladistu: 48', '2019-01-11 18:12:11');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4656, 1, 1, 'Promjena količine knjige na skladistu: 47', '2019-01-11 18:12:12');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4657, 1, 1, 'Promjena količine knjige na skladistu: 46', '2019-01-11 18:12:12');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4574, 1, 5, 'Promjena količine knjige na skladistu: 27', '2019-01-11 16:27:45');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4575, 1, 5, 'Promjena količine knjige na skladistu: 21', '2019-01-11 16:27:57');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4576, 1, 5, 'Promjena količine knjige na skladistu: 9', '2019-01-11 16:28:12');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4577, 2, 5, 'Izrađena narudžba za sljedeći broj artikala knjige: 20', '2019-01-11 16:28:12');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4578, 3, 5, 'Izrađena primka za sljedeći broj artikala knjige: 20', '2019-01-11 16:28:12');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4579, 1, 5, 'Promjena količine knjige na skladistu: 29', '2019-01-11 16:28:12');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4580, 1, 4, 'Promjena količine knjige na skladistu: 24', '2019-01-11 16:28:45');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4581, 1, 3, 'Promjena količine knjige na skladistu: 14', '2019-01-11 16:28:49');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4582, 2, 3, 'Izrađena narudžba za sljedeći broj artikala knjige: 10', '2019-01-11 16:28:49');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4583, 3, 3, 'Izrađena primka za sljedeći broj artikala knjige: 10', '2019-01-11 16:28:49');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4584, 1, 3, 'Promjena količine knjige na skladistu: 24', '2019-01-11 16:28:49');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4585, 1, 1, 'Promjena količine knjige na skladistu: 35', '2019-01-11 16:28:57');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4586, 1, 1, 'Promjena količine knjige na skladistu: 17', '2019-01-11 16:29:01');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4587, 2, 1, 'Izrađena narudžba za sljedeći broj artikala knjige: 10', '2019-01-11 16:29:01');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4588, 3, 1, 'Izrađena primka za sljedeći broj artikala knjige: 10', '2019-01-11 16:29:01');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4589, 1, 1, 'Promjena količine knjige na skladistu: 27', '2019-01-11 16:29:01');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4590, 1, 1, 'Promjena količine knjige na skladistu: 23', '2019-01-11 16:29:18');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4658, 1, 1, 'Promjena količine knjige na skladistu: 45', '2019-01-11 18:12:15');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4659, 1, 1, 'Promjena količine knjige na skladistu: 44', '2019-01-11 18:12:21');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4660, 1, 1, 'Promjena količine knjige na skladistu: 45', '2019-01-11 18:13:21');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4661, 1, 1, 'Promjena količine knjige na skladistu: 46', '2019-01-11 18:13:22');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4662, 1, 1, 'Promjena količine knjige na skladistu: 47', '2019-01-11 18:13:22');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4663, 1, 1, 'Promjena količine knjige na skladistu: 48', '2019-01-11 18:13:28');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4664, 1, 1, 'Promjena količine knjige na skladistu: 53', '2019-01-11 18:14:05');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4665, 1, 1, 'Promjena količine knjige na skladistu: 54', '2019-01-11 18:20:39');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4666, 1, 1, 'Promjena količine knjige na skladistu: 59', '2019-01-11 18:20:40');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4667, 1, 1, 'Promjena količine knjige na skladistu: 64', '2019-01-11 18:20:40');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4668, 1, 1, 'Promjena količine knjige na skladistu: 65', '2019-01-11 18:20:41');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4669, 1, 1, 'Promjena količine knjige na skladistu: 64', '2019-01-11 18:21:27');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4670, 1, 1, 'Promjena količine knjige na skladistu: 63', '2019-01-11 18:21:28');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4671, 1, 1, 'Promjena količine knjige na skladistu: 62', '2019-01-11 18:21:28');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4672, 1, 1, 'Promjena količine knjige na skladistu: 61', '2019-01-11 18:21:29');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4673, 1, 1, 'Promjena količine knjige na skladistu: 60', '2019-01-11 18:21:30');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4674, 1, 1, 'Promjena količine knjige na skladistu: 59', '2019-01-11 18:21:31');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4675, 1, 1, 'Promjena količine knjige na skladistu: 58', '2019-01-11 18:21:32');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4676, 1, 1, 'Promjena količine knjige na skladistu: 57', '2019-01-11 18:21:32');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4677, 1, 1, 'Promjena količine knjige na skladistu: 56', '2019-01-11 18:21:34');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4678, 1, 1, 'Promjena količine knjige na skladistu: 55', '2019-01-11 18:21:35');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4679, 1, 1, 'Promjena količine knjige na skladistu: 54', '2019-01-11 18:21:35');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4680, 1, 1, 'Promjena količine knjige na skladistu: 53', '2019-01-11 18:21:36');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4681, 1, 1, 'Promjena količine knjige na skladistu: 52', '2019-01-11 18:21:36');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4682, 1, 1, 'Promjena količine knjige na skladistu: 51', '2019-01-11 18:21:37');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4683, 1, 1, 'Promjena količine knjige na skladistu: 50', '2019-01-11 18:21:38');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4684, 1, 4, 'Promjena količine knjige na skladistu: 27', '2019-01-11 18:22:02');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4685, 1, 4, 'Promjena količine knjige na skladistu: 26', '2019-01-11 18:22:04');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4686, 1, 1, 'Promjena količine knjige na skladistu: 49', '2019-01-11 18:22:04');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4687, 1, 4, 'Promjena količine knjige na skladistu: 31', '2019-01-11 18:22:08');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4688, 1, 1, 'Promjena količine knjige na skladistu: 54', '2019-01-11 18:25:50');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4689, 1, 1, 'Promjena količine knjige na skladistu: 55', '2019-01-11 18:26:11');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4690, 1, 1, 'Promjena količine knjige na skladistu: 50', '2019-01-11 18:28:31');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4691, 1, 1, 'Promjena količine knjige na skladistu: 45', '2019-01-11 18:28:33');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4692, 1, 1, 'Promjena količine knjige na skladistu: 40', '2019-01-11 18:28:33');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4693, 1, 1, 'Promjena količine knjige na skladistu: 35', '2019-01-11 18:28:34');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4694, 1, 1, 'Promjena količine knjige na skladistu: 30', '2019-01-11 18:28:34');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4695, 1, 1, 'Promjena količine knjige na skladistu: 25', '2019-01-11 18:28:36');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4696, 1, 1, 'Promjena količine knjige na skladistu: 20', '2019-01-11 18:28:36');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4697, 1, 1, 'Promjena količine knjige na skladistu: 15', '2019-01-11 18:28:37');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4698, 2, 1, 'Izrađena narudžba za sljedeći broj artikala knjige: 10', '2019-01-11 18:28:37');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4699, 3, 1, 'Izrađena primka za sljedeći broj artikala knjige: 10', '2019-01-11 18:28:37');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4700, 1, 1, 'Promjena količine knjige na skladistu: 25', '2019-01-11 18:28:37');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4701, 1, 1, 'Promjena količine knjige na skladistu: 24', '2019-01-11 18:28:40');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4702, 1, 1, 'Promjena količine knjige na skladistu: 23', '2019-01-11 18:28:40');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4703, 1, 1, 'Promjena količine knjige na skladistu: 22', '2019-01-11 18:28:41');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4704, 1, 1, 'Promjena količine knjige na skladistu: 21', '2019-01-11 18:28:42');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4705, 1, 1, 'Promjena količine knjige na skladistu: 20', '2019-01-11 18:28:42');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4706, 1, 1, 'Promjena količine knjige na skladistu: 19', '2019-01-11 18:28:43');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4707, 2, 1, 'Izrađena narudžba za sljedeći broj artikala knjige: 10', '2019-01-11 18:28:43');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4708, 3, 1, 'Izrađena primka za sljedeći broj artikala knjige: 10', '2019-01-11 18:28:43');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4709, 1, 1, 'Promjena količine knjige na skladistu: 29', '2019-01-11 18:28:43');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4710, 1, 1, 'Promjena količine knjige na skladistu: 24', '2019-01-11 18:28:46');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4711, 1, 1, 'Promjena količine knjige na skladistu: 20', '2019-01-11 18:31:41');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4712, 1, 3, 'Promjena količine knjige na skladistu: 18', '2019-01-11 18:31:45');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4713, 2, 3, 'Izrađena narudžba za sljedeći broj artikala knjige: 10', '2019-01-11 18:31:45');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4714, 3, 3, 'Izrađena primka za sljedeći broj artikala knjige: 10', '2019-01-11 18:31:45');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4715, 1, 3, 'Promjena količine knjige na skladistu: 28', '2019-01-11 18:31:45');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4716, 1, 3, 'Promjena količine knjige na skladistu: 27', '2019-01-11 18:31:58');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4717, 1, 3, 'Promjena količine knjige na skladistu: 22', '2019-01-11 18:32:00');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4718, 1, 3, 'Promjena količine knjige na skladistu: 19', '2019-01-11 18:32:07');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4719, 2, 3, 'Izrađena narudžba za sljedeći broj artikala knjige: 10', '2019-01-11 18:32:07');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4720, 3, 3, 'Izrađena primka za sljedeći broj artikala knjige: 10', '2019-01-11 18:32:07');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4721, 1, 3, 'Promjena količine knjige na skladistu: 29', '2019-01-11 18:32:07');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4722, 1, 4, 'Promjena količine knjige na skladistu: 26', '2019-01-11 19:03:17');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4723, 1, 6, 'Promjena količine knjige na skladistu: 31', '2019-01-11 19:05:42');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4724, 1, 7, 'Promjena količine knjige na skladistu: 56', '2019-01-11 19:06:08');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4725, 1, 8, 'Promjena količine knjige na skladistu: 24', '2019-01-11 19:06:15');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4726, 1, 9, 'Promjena količine knjige na skladistu: 234', '2019-01-11 19:06:22');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4727, 1, 10, 'Promjena količine knjige na skladistu: 87', '2019-01-11 19:06:32');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4728, 1, 11, 'Promjena količine knjige na skladistu: 34', '2019-01-11 19:21:32');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4729, 1, 1, 'Promjena količine knjige na skladistu: 15', '2019-01-11 19:27:57');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4730, 2, 1, 'Izrađena narudžba za sljedeći broj artikala knjige: 10', '2019-01-11 19:27:57');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4731, 3, 1, 'Izrađena primka za sljedeći broj artikala knjige: 10', '2019-01-11 19:27:57');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4732, 1, 1, 'Promjena količine knjige na skladistu: 25', '2019-01-11 19:27:57');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4733, 1, 1, 'Promjena količine knjige na skladistu: 30', '2019-01-11 20:15:18');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4734, 1, 4, 'Promjena količine knjige na skladistu: 25', '2019-01-11 20:15:21');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4735, 1, 6, 'Promjena količine knjige na skladistu: 32', '2019-01-11 21:45:28');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4736, 1, 6, 'Promjena količine knjige na skladistu: 33', '2019-01-11 21:45:30');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4737, 1, 6, 'Promjena količine knjige na skladistu: 20', '2019-01-11 21:47:51');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4738, 1, 6, 'Promjena količine knjige na skladistu: 12', '2019-01-11 21:47:56');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4739, 2, 6, 'Izrađena narudžba za sljedeći broj artikala knjige: 10', '2019-01-11 21:47:56');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4740, 3, 6, 'Izrađena primka za sljedeći broj artikala knjige: 10', '2019-01-11 21:47:56');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4741, 1, 6, 'Promjena količine knjige na skladistu: 22', '2019-01-11 21:47:56');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4742, 1, 8, 'Promjena količine knjige na skladistu: 23', '2019-01-11 21:48:20');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4743, 1, 8, 'Promjena količine knjige na skladistu: 18', '2019-01-11 21:48:22');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4744, 2, 8, 'Izrađena narudžba za sljedeći broj artikala knjige: 10', '2019-01-11 21:48:22');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4745, 3, 8, 'Izrađena primka za sljedeći broj artikala knjige: 10', '2019-01-11 21:48:22');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4746, 1, 8, 'Promjena količine knjige na skladistu: 28', '2019-01-11 21:48:22');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4747, 1, 9, 'Promjena količine knjige na skladistu: 46', '2019-01-11 23:08:09');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4748, 1, 1, 'Promjena količine knjige na skladistu: 0', '2019-01-11 23:32:09');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4749, 2, 1, 'Izrađena narudžba za sljedeći broj artikala knjige: 30', '2019-01-11 23:32:09');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4750, 3, 1, 'Izrađena primka za sljedeći broj artikala knjige: 30', '2019-01-11 23:32:09');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4751, 1, 1, 'Promjena količine knjige na skladistu: 30', '2019-01-11 23:32:09');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4752, 1, 8, 'Promjena količine knjige na skladistu: 0', '2019-01-11 23:32:54');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4753, 2, 8, 'Izrađena narudžba za sljedeći broj artikala knjige: 30', '2019-01-11 23:32:54');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4754, 3, 8, 'Izrađena primka za sljedeći broj artikala knjige: 30', '2019-01-11 23:32:54');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4755, 1, 8, 'Promjena količine knjige na skladistu: 30', '2019-01-11 23:32:54');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4756, 1, 8, 'Promjena količine knjige na skladistu: 2', '2019-01-11 23:32:58');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4757, 2, 8, 'Izrađena narudžba za sljedeći broj artikala knjige: 20', '2019-01-11 23:32:58');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4758, 3, 8, 'Izrađena primka za sljedeći broj artikala knjige: 20', '2019-01-11 23:32:58');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4759, 1, 8, 'Promjena količine knjige na skladistu: 22', '2019-01-11 23:32:58');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4760, 1, 8, 'Promjena količine knjige na skladistu: 9', '2019-01-11 23:33:02');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4761, 2, 8, 'Izrađena narudžba za sljedeći broj artikala knjige: 20', '2019-01-11 23:33:02');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4762, 3, 8, 'Izrađena primka za sljedeći broj artikala knjige: 20', '2019-01-11 23:33:02');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4763, 1, 8, 'Promjena količine knjige na skladistu: 29', '2019-01-11 23:33:02');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4764, 1, 9, 'Promjena količine knjige na skladistu: 15', '2019-01-11 23:33:28');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4765, 2, 9, 'Izrađena narudžba za sljedeći broj artikala knjige: 10', '2019-01-11 23:33:28');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4766, 3, 9, 'Izrađena primka za sljedeći broj artikala knjige: 10', '2019-01-11 23:33:28');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4767, 1, 9, 'Promjena količine knjige na skladistu: 25', '2019-01-11 23:33:28');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4768, 1, 5, 'Promjena količine knjige na skladistu: 18', '2019-01-11 23:33:32');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4769, 2, 5, 'Izrađena narudžba za sljedeći broj artikala knjige: 10', '2019-01-11 23:33:32');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4770, 3, 5, 'Izrađena primka za sljedeći broj artikala knjige: 10', '2019-01-11 23:33:32');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4771, 1, 5, 'Promjena količine knjige na skladistu: 28', '2019-01-11 23:33:32');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4772, 1, 6, 'Promjena količine knjige na skladistu: 0', '2019-01-11 23:33:37');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4773, 2, 6, 'Izrađena narudžba za sljedeći broj artikala knjige: 30', '2019-01-11 23:33:37');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4774, 3, 6, 'Izrađena primka za sljedeći broj artikala knjige: 30', '2019-01-11 23:33:37');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4775, 1, 6, 'Promjena količine knjige na skladistu: 30', '2019-01-11 23:33:37');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4776, 1, 10, 'Promjena količine knjige na skladistu: 0', '2019-01-11 23:33:58');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4777, 2, 10, 'Izrađena narudžba za sljedeći broj artikala knjige: 30', '2019-01-11 23:33:58');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4778, 3, 10, 'Izrađena primka za sljedeći broj artikala knjige: 30', '2019-01-11 23:33:58');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4779, 1, 10, 'Promjena količine knjige na skladistu: 30', '2019-01-11 23:33:58');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4780, 1, 10, 'Promjena količine knjige na skladistu: 0', '2019-01-11 23:34:02');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4781, 2, 10, 'Izrađena narudžba za sljedeći broj artikala knjige: 30', '2019-01-11 23:34:02');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4782, 3, 10, 'Izrađena primka za sljedeći broj artikala knjige: 30', '2019-01-11 23:34:02');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4783, 1, 10, 'Promjena količine knjige na skladistu: 30', '2019-01-11 23:34:02');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4784, 1, 10, 'Promjena količine knjige na skladistu: 87', '2019-01-11 23:34:05');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4785, 1, 7, 'Promjena količine knjige na skladistu: 0', '2019-01-11 23:34:09');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4786, 2, 7, 'Izrađena narudžba za sljedeći broj artikala knjige: 30', '2019-01-11 23:34:09');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4787, 3, 7, 'Izrađena primka za sljedeći broj artikala knjige: 30', '2019-01-11 23:34:09');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4788, 1, 7, 'Promjena količine knjige na skladistu: 30', '2019-01-11 23:34:09');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4789, 1, 7, 'Promjena količine knjige na skladistu: 64', '2019-01-11 23:34:13');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4790, 1, 2, 'Promjena količine knjige na skladistu: 17', '2019-01-11 23:35:16');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4791, 2, 2, 'Izrađena narudžba za sljedeći broj artikala knjige: 10', '2019-01-11 23:35:16');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4792, 3, 2, 'Izrađena primka za sljedeći broj artikala knjige: 10', '2019-01-11 23:35:16');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4793, 1, 2, 'Promjena količine knjige na skladistu: 27', '2019-01-11 23:35:16');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4794, 1, 2, 'Promjena količine knjige na skladistu: 0', '2019-01-11 23:35:20');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4795, 2, 2, 'Izrađena narudžba za sljedeći broj artikala knjige: 30', '2019-01-11 23:35:20');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4796, 3, 2, 'Izrađena primka za sljedeći broj artikala knjige: 30', '2019-01-11 23:35:20');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4797, 1, 2, 'Promjena količine knjige na skladistu: 30', '2019-01-11 23:35:20');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4798, 1, 2, 'Promjena količine knjige na skladistu: 32', '2019-01-11 23:35:23');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4799, 1, 12, 'Promjena količine knjige na skladistu: 6', '2019-01-11 23:39:26');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4800, 2, 12, 'Izrađena narudžba za sljedeći broj artikala knjige: 20', '2019-01-11 23:39:26');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4801, 3, 12, 'Izrađena primka za sljedeći broj artikala knjige: 20', '2019-01-11 23:39:26');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4802, 1, 12, 'Promjena količine knjige na skladistu: 26', '2019-01-11 23:39:26');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4803, 1, 13, 'Promjena količine knjige na skladistu: 1', '2019-01-11 23:39:32');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4804, 2, 13, 'Izrađena narudžba za sljedeći broj artikala knjige: 20', '2019-01-11 23:39:32');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4805, 3, 13, 'Izrađena primka za sljedeći broj artikala knjige: 20', '2019-01-11 23:39:32');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4806, 1, 13, 'Promjena količine knjige na skladistu: 21', '2019-01-11 23:39:32');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4807, 1, 14, 'Promjena količine knjige na skladistu: 9', '2019-01-11 23:39:40');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4808, 2, 14, 'Izrađena narudžba za sljedeći broj artikala knjige: 20', '2019-01-11 23:39:40');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4809, 3, 14, 'Izrađena primka za sljedeći broj artikala knjige: 20', '2019-01-11 23:39:40');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4810, 1, 14, 'Promjena količine knjige na skladistu: 29', '2019-01-11 23:39:40');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4811, 1, 11, 'Promjena količine knjige na skladistu: 4', '2019-01-11 23:41:39');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4812, 2, 11, 'Izrađena narudžba za sljedeći broj artikala knjige: 20', '2019-01-11 23:41:39');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4813, 3, 11, 'Izrađena primka za sljedeći broj artikala knjige: 20', '2019-01-11 23:41:39');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4814, 1, 11, 'Promjena količine knjige na skladistu: 24', '2019-01-11 23:41:39');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4815, 1, 11, 'Promjena količine knjige na skladistu: 34', '2019-01-11 23:41:43');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4816, 1, 9, 'Promjena količine knjige na skladistu: 32', '2019-01-12 00:12:06');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4817, 1, 9, 'Promjena količine knjige na skladistu: 29', '2019-01-12 00:12:16');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4818, 1, 2, 'Promjena količine knjige na skladistu: 309', '2019-01-12 00:23:18');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4819, 1, 2, 'Promjena količine knjige na skladistu: 32', '2019-01-12 00:23:28');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4820, 1, 15, 'Promjena količine knjige na skladistu: 17', '2019-01-12 01:01:11');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4821, 2, 15, 'Izrađena narudžba za sljedeći broj artikala knjige: 10', '2019-01-12 01:01:11');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4822, 3, 15, 'Izrađena primka za sljedeći broj artikala knjige: 10', '2019-01-12 01:01:11');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4823, 1, 15, 'Promjena količine knjige na skladistu: 27', '2019-01-12 01:01:11');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4824, 1, 16, 'Promjena količine knjige na skladistu: 24', '2019-01-12 01:13:35');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4825, 1, 17, 'Promjena količine knjige na skladistu: 29', '2019-01-12 01:13:42');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4826, 1, 18, 'Promjena količine knjige na skladistu: 41', '2019-01-12 01:13:48');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4827, 1, 19, 'Promjena količine knjige na skladistu: 25', '2019-01-12 01:13:54');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4828, 1, 20, 'Promjena količine knjige na skladistu: 28', '2019-01-12 01:14:09');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4829, 1, 21, 'Promjena količine knjige na skladistu: 31', '2019-01-12 01:14:17');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4830, 1, 22, 'Promjena količine knjige na skladistu: 22', '2019-01-12 01:14:21');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4831, 1, 3, 'Promjena količine knjige na skladistu: 30', '2019-01-12 01:26:11');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4832, 1, 3, 'Promjena količine knjige na skladistu: 35', '2019-01-12 01:26:13');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4833, 1, 3, 'Promjena količine knjige na skladistu: 25', '2019-01-12 01:26:20');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4834, 1, 21, 'Promjena količine knjige na skladistu: 30', '2019-01-12 02:02:41');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4835, 1, 21, 'Promjena količine knjige na skladistu: 25', '2019-01-12 02:02:44');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4836, 1, 12, 'Promjena količine knjige na skladistu: 19', '2019-01-12 02:02:52');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4837, 2, 12, 'Izrađena narudžba za sljedeći broj artikala knjige: 10', '2019-01-12 02:02:52');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4838, 3, 12, 'Izrađena primka za sljedeći broj artikala knjige: 10', '2019-01-12 02:02:52');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4839, 1, 12, 'Promjena količine knjige na skladistu: 29', '2019-01-12 02:02:52');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4840, 1, 13, 'Promjena količine knjige na skladistu: 18', '2019-01-12 02:02:58');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4841, 2, 13, 'Izrađena narudžba za sljedeći broj artikala knjige: 10', '2019-01-12 02:02:58');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4842, 3, 13, 'Izrađena primka za sljedeći broj artikala knjige: 10', '2019-01-12 02:02:58');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4843, 1, 13, 'Promjena količine knjige na skladistu: 28', '2019-01-12 02:02:58');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4844, 1, 22, 'Promjena količine knjige na skladistu: 12', '2019-01-12 02:03:07');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4845, 2, 22, 'Izrađena narudžba za sljedeći broj artikala knjige: 10', '2019-01-12 02:03:07');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4846, 3, 22, 'Izrađena primka za sljedeći broj artikala knjige: 10', '2019-01-12 02:03:07');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4847, 1, 22, 'Promjena količine knjige na skladistu: 22', '2019-01-12 02:03:07');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4848, 1, 20, 'Promjena količine knjige na skladistu: 25', '2019-01-12 02:03:17');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4849, 1, 4, 'Promjena količine knjige na skladistu: 30', '2019-01-12 02:25:06');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4850, 1, 4, 'Promjena količine knjige na skladistu: 25', '2019-01-12 02:25:14');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4851, 1, 4, 'Promjena količine knjige na skladistu: 12', '2019-01-12 02:25:23');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4852, 2, 4, 'Izrađena narudžba za sljedeći broj artikala knjige: 10', '2019-01-12 02:25:23');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4853, 3, 4, 'Izrađena primka za sljedeći broj artikala knjige: 10', '2019-01-12 02:25:23');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4854, 1, 4, 'Promjena količine knjige na skladistu: 22', '2019-01-12 02:25:23');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4855, 1, 5, 'Promjena količine knjige na skladistu: 27', '2019-01-12 02:27:00');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4856, 1, 4, 'Promjena količine knjige na skladistu: 19', '2019-01-12 02:27:29');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4857, 2, 4, 'Izrađena narudžba za sljedeći broj artikala knjige: 10', '2019-01-12 02:27:29');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4858, 3, 4, 'Izrađena primka za sljedeći broj artikala knjige: 10', '2019-01-12 02:27:29');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4859, 1, 4, 'Promjena količine knjige na skladistu: 29', '2019-01-12 02:27:29');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4860, 1, 4, 'Promjena količine knjige na skladistu: 1', '2019-01-12 02:28:10');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4861, 2, 4, 'Izrađena narudžba za sljedeći broj artikala knjige: 20', '2019-01-12 02:28:10');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4862, 3, 4, 'Izrađena primka za sljedeći broj artikala knjige: 20', '2019-01-12 02:28:10');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4863, 1, 4, 'Promjena količine knjige na skladistu: 21', '2019-01-12 02:28:10');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4864, 1, 4, 'Promjena količine knjige na skladistu: 14', '2019-01-12 16:10:28');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4865, 2, 4, 'Izrađena narudžba za sljedeći broj artikala knjige: 10', '2019-01-12 16:10:28');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4866, 3, 4, 'Izrađena primka za sljedeći broj artikala knjige: 10', '2019-01-12 16:10:28');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4867, 1, 4, 'Promjena količine knjige na skladistu: 24', '2019-01-12 16:10:28');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4868, 1, 1, 'Promjena količine knjige na skladistu: 22', '2019-01-12 16:10:33');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4869, 1, 1, 'Promjena količine knjige na skladistu: 13', '2019-01-12 16:10:38');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4870, 2, 1, 'Izrađena narudžba za sljedeći broj artikala knjige: 10', '2019-01-12 16:10:38');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4871, 3, 1, 'Izrađena primka za sljedeći broj artikala knjige: 10', '2019-01-12 16:10:38');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4872, 1, 1, 'Promjena količine knjige na skladistu: 23', '2019-01-12 16:10:38');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4873, 1, 1, 'Promjena količine knjige na skladistu: 22', '2019-01-12 16:10:43');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4874, 1, 2, 'Promjena količine knjige na skladistu: 30', '2019-01-12 16:10:48');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4875, 1, 2, 'Promjena količine knjige na skladistu: 27', '2019-01-12 16:10:53');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4876, 1, 4, 'Promjena količine knjige na skladistu: 25', '2019-01-13 17:43:32');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4877, 1, 4, 'Promjena količine knjige na skladistu: 30', '2019-01-13 17:43:35');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4878, 1, 1, 'Promjena količine knjige na skladistu: 14', '2019-01-13 17:43:49');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4879, 2, 1, 'Izrađena narudžba za sljedeći broj artikala knjige: 10', '2019-01-13 17:43:49');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4880, 3, 1, 'Izrađena primka za sljedeći broj artikala knjige: 10', '2019-01-13 17:43:49');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4881, 1, 1, 'Promjena količine knjige na skladistu: 24', '2019-01-13 17:43:49');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4882, 1, 18, 'Promjena količine knjige na skladistu: 37', '2019-01-13 17:53:19');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4883, 1, 15, 'Promjena količine knjige na skladistu: 25', '2019-01-13 17:53:21');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4884, 1, 11, 'Promjena količine knjige na skladistu: 33', '2019-01-13 17:53:23');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4885, 1, 1, 'Promjena količine knjige na skladistu: 21', '2019-01-13 17:53:25');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4886, 1, 4, 'Promjena količine knjige na skladistu: 23', '2019-01-13 17:53:27');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4887, 1, 1, 'Promjena količine knjige na skladistu: 15', '2019-01-13 17:53:29');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4888, 2, 1, 'Izrađena narudžba za sljedeći broj artikala knjige: 10', '2019-01-13 17:53:29');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4889, 3, 1, 'Izrađena primka za sljedeći broj artikala knjige: 10', '2019-01-13 17:53:29');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4890, 1, 1, 'Promjena količine knjige na skladistu: 25', '2019-01-13 17:53:29');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4891, 1, 19, 'Promjena količine knjige na skladistu: 20', '2019-01-13 17:53:31');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4892, 1, 15, 'Promjena količine knjige na skladistu: 22', '2019-01-13 17:53:33');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4893, 1, 12, 'Promjena količine knjige na skladistu: 27', '2019-01-13 17:53:35');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4894, 1, 8, 'Promjena količine knjige na skladistu: 20', '2019-01-13 17:53:37');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4895, 1, 5, 'Promjena količine knjige na skladistu: 19', '2019-01-13 17:53:39');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4896, 2, 5, 'Izrađena narudžba za sljedeći broj artikala knjige: 10', '2019-01-13 17:53:39');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4897, 3, 5, 'Izrađena primka za sljedeći broj artikala knjige: 10', '2019-01-13 17:53:39');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4898, 1, 5, 'Promjena količine knjige na skladistu: 29', '2019-01-13 17:53:39');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4899, 1, 1, 'Promjena količine knjige na skladistu: 18', '2019-01-13 17:53:41');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4900, 2, 1, 'Izrađena narudžba za sljedeći broj artikala knjige: 10', '2019-01-13 17:53:41');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4901, 3, 1, 'Izrađena primka za sljedeći broj artikala knjige: 10', '2019-01-13 17:53:41');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4902, 1, 1, 'Promjena količine knjige na skladistu: 28', '2019-01-13 17:53:41');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4903, 1, 19, 'Promjena količine knjige na skladistu: 15', '2019-01-13 17:53:43');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4904, 2, 19, 'Izrađena narudžba za sljedeći broj artikala knjige: 10', '2019-01-13 17:53:43');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4905, 3, 19, 'Izrađena primka za sljedeći broj artikala knjige: 10', '2019-01-13 17:53:43');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4906, 1, 19, 'Promjena količine knjige na skladistu: 25', '2019-01-13 17:53:43');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4907, 1, 2, 'Promjena količine knjige na skladistu: 32', '2019-01-13 17:53:44');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4908, 1, 16, 'Promjena količine knjige na skladistu: 20', '2019-01-13 17:53:45');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4909, 1, 12, 'Promjena količine knjige na skladistu: 24', '2019-01-13 17:53:47');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4910, 1, 9, 'Promjena količine knjige na skladistu: 28', '2019-01-13 17:53:49');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4911, 1, 1, 'Promjena količine knjige na skladistu: 33', '2019-01-16 19:40:21');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4912, 1, 3, 'Promjena količine knjige na skladistu: 15', '2019-01-19 01:59:02');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4913, 2, 3, 'Izrađena narudžba za sljedeći broj artikala knjige: 10', '2019-01-19 01:59:02');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4914, 3, 3, 'Izrađena primka za sljedeći broj artikala knjige: 10', '2019-01-19 01:59:02');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4915, 1, 3, 'Promjena količine knjige na skladistu: 25', '2019-01-19 01:59:02');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4916, 1, 20, 'Promjena količine knjige na skladistu: 13', '2019-01-19 02:00:08');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4917, 2, 20, 'Izrađena narudžba za sljedeći broj artikala knjige: 10', '2019-01-19 02:00:08');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4918, 3, 20, 'Izrađena primka za sljedeći broj artikala knjige: 10', '2019-01-19 02:00:08');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4919, 1, 20, 'Promjena količine knjige na skladistu: 23', '2019-01-19 02:00:08');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4920, 1, 22, 'Promjena količine knjige na skladistu: 14', '2019-01-19 02:04:33');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4921, 2, 22, 'Izrađena narudžba za sljedeći broj artikala knjige: 10', '2019-01-19 02:04:33');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4922, 3, 22, 'Izrađena primka za sljedeći broj artikala knjige: 10', '2019-01-19 02:04:33');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4923, 1, 22, 'Promjena količine knjige na skladistu: 24', '2019-01-19 02:04:33');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4924, 1, 6, 'Promjena količine knjige na skladistu: 15', '2019-01-19 02:07:29');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4925, 2, 6, 'Izrađena narudžba za sljedeći broj artikala knjige: 10', '2019-01-19 02:07:29');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4926, 3, 6, 'Izrađena primka za sljedeći broj artikala knjige: 10', '2019-01-19 02:07:29');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4927, 1, 6, 'Promjena količine knjige na skladistu: 25', '2019-01-19 02:07:29');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4928, 1, 4, 'Promjena količine knjige na skladistu: 19', '2019-01-19 03:38:58');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4929, 2, 4, 'Izrađena narudžba za sljedeći broj artikala knjige: 10', '2019-01-19 03:38:58');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4930, 3, 4, 'Izrađena primka za sljedeći broj artikala knjige: 10', '2019-01-19 03:38:58');
INSERT INTO public."Dnevnik" ("ID", vk_tip, vk_knjiga, "Tekst", "Datum") VALUES (4931, 1, 4, 'Promjena količine knjige na skladistu: 29', '2019-01-19 03:38:58');


--
-- TOC entry 2908 (class 0 OID 16450)
-- Dependencies: 210
-- Data for Name: Dobavljac; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."Dobavljac" ("ID", "Naziv", "Adresa", "Email", "Telefon") VALUES (1, 'BedEx', 'Ulica u Zagrebu 12, 10 000 Zagreb', 'bedex@bedex.hr', '095 323 3232');
INSERT INTO public."Dobavljac" ("ID", "Naziv", "Adresa", "Email", "Telefon") VALUES (2, 'WillDeliver', 'Bowery 7, New York', 'contact@wdeliver.org', '555 326 4365');
INSERT INTO public."Dobavljac" ("ID", "Naziv", "Adresa", "Email", "Telefon") VALUES (3, 'NoRefunds Inc.', 'Canal Street 1A, New York', 'spam.me@norefunds.org', '555 999 3232');


--
-- TOC entry 2897 (class 0 OID 16404)
-- Dependencies: 199
-- Data for Name: Izdavac; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."Izdavac" ("ID", "Naziv", "Adresa", "Email", "Telefon") VALUES (1, 'Narodne novine', 'Ulica nardonih novina 12, 10 000 Zagreb', 'contact@nn.hr', '091 234 567');
INSERT INTO public."Izdavac" ("ID", "Naziv", "Adresa", "Email", "Telefon") VALUES (2, 'PrintPage Inc.', 'Wall Street 16A, New York', 'contact@printpage.org', '555 344 5454');
INSERT INTO public."Izdavac" ("ID", "Naziv", "Adresa", "Email", "Telefon") VALUES (3, 'ReadMe Ltd.', 'Broadway 22C, New York', 'contact@readme.org', '555 265 3244');


--
-- TOC entry 2899 (class 0 OID 16412)
-- Dependencies: 201
-- Data for Name: Knjiga; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."Knjiga" ("ID", "Naslov", "Godina_izdavanja", "Stranice", "Cijena", vk_autor, vk_izdavac, vk_zanr) VALUES (1, 'Don Quixote', 2018, 992, 110.989998, 2, 1, 11);
INSERT INTO public."Knjiga" ("ID", "Naslov", "Godina_izdavanja", "Stranice", "Cijena", vk_autor, vk_izdavac, vk_zanr) VALUES (2, 'Uliks', 2017, 412, 99.9000015, 4, 2, 6);
INSERT INTO public."Knjiga" ("ID", "Naslov", "Godina_izdavanja", "Stranice", "Cijena", vk_autor, vk_izdavac, vk_zanr) VALUES (3, 'Random title', 2015, 342, 79.9899979, 3, 3, 4);
INSERT INTO public."Knjiga" ("ID", "Naslov", "Godina_izdavanja", "Stranice", "Cijena", vk_autor, vk_izdavac, vk_zanr) VALUES (4, 'Hunt Them All', 2018, 444, 89.9899979, 5, 2, 10);
INSERT INTO public."Knjiga" ("ID", "Naslov", "Godina_izdavanja", "Stranice", "Cijena", vk_autor, vk_izdavac, vk_zanr) VALUES (5, 'Program Me', 2019, 19534, 599.97998, 2, 3, 11);
INSERT INTO public."Knjiga" ("ID", "Naslov", "Godina_izdavanja", "Stranice", "Cijena", vk_autor, vk_izdavac, vk_zanr) VALUES (6, 'Not Gonna Make It', 2019, 313, 49.9900017, 4, 1, 3);
INSERT INTO public."Knjiga" ("ID", "Naslov", "Godina_izdavanja", "Stranice", "Cijena", vk_autor, vk_izdavac, vk_zanr) VALUES (7, 'Story About Me', 2015, 543, 87.7699966, 2, 3, 2);
INSERT INTO public."Knjiga" ("ID", "Naslov", "Godina_izdavanja", "Stranice", "Cijena", vk_autor, vk_izdavac, vk_zanr) VALUES (8, 'StackOverflow Pocket Edition', 2019, 9999, 199.990005, 3, 2, 5);
INSERT INTO public."Knjiga" ("ID", "Naslov", "Godina_izdavanja", "Stranice", "Cijena", vk_autor, vk_izdavac, vk_zanr) VALUES (9, 'C# For Dummies', 2018, 367, 59.9900017, 5, 1, 3);
INSERT INTO public."Knjiga" ("ID", "Naslov", "Godina_izdavanja", "Stranice", "Cijena", vk_autor, vk_izdavac, vk_zanr) VALUES (10, 'How Not To', 2017, 5331, 110.989998, 4, 2, 6);
INSERT INTO public."Knjiga" ("ID", "Naslov", "Godina_izdavanja", "Stranice", "Cijena", vk_autor, vk_izdavac, vk_zanr) VALUES (11, 'Debug Time', 2015, 3342, 19.9899998, 4, 3, 7);
INSERT INTO public."Knjiga" ("ID", "Naslov", "Godina_izdavanja", "Stranice", "Cijena", vk_autor, vk_izdavac, vk_zanr) VALUES (12, 'Bulding Sockets', 2016, 233, 49.9900017, 3, 2, 5);
INSERT INTO public."Knjiga" ("ID", "Naslov", "Godina_izdavanja", "Stranice", "Cijena", vk_autor, vk_izdavac, vk_zanr) VALUES (13, 'Rocket Engineering', 2018, 3553, 359.98999, 5, 2, 6);
INSERT INTO public."Knjiga" ("ID", "Naslov", "Godina_izdavanja", "Stranice", "Cijena", vk_autor, vk_izdavac, vk_zanr) VALUES (14, 'Catch Me Like Exception', 2015, 343, 25.9899998, 3, 3, 9);
INSERT INTO public."Knjiga" ("ID", "Naslov", "Godina_izdavanja", "Stranice", "Cijena", vk_autor, vk_izdavac, vk_zanr) VALUES (15, 'Keep Coding', 2018, 213, 78.9800034, 3, 2, 4);
INSERT INTO public."Knjiga" ("ID", "Naslov", "Godina_izdavanja", "Stranice", "Cijena", vk_autor, vk_izdavac, vk_zanr) VALUES (16, 'Hit It', 2017, 342, 99.9899979, 6, 1, 5);
INSERT INTO public."Knjiga" ("ID", "Naslov", "Godina_izdavanja", "Stranice", "Cijena", vk_autor, vk_izdavac, vk_zanr) VALUES (17, 'Center Field', 2017, 567, 65.9899979, 6, 1, 5);
INSERT INTO public."Knjiga" ("ID", "Naslov", "Godina_izdavanja", "Stranice", "Cijena", vk_autor, vk_izdavac, vk_zanr) VALUES (18, 'Goals Galore', 2018, 532, 89.9499969, 6, 2, 8);
INSERT INTO public."Knjiga" ("ID", "Naslov", "Godina_izdavanja", "Stranice", "Cijena", vk_autor, vk_izdavac, vk_zanr) VALUES (19, 'One More Goal', 2018, 123, 119.989998, 6, 3, 9);
INSERT INTO public."Knjiga" ("ID", "Naslov", "Godina_izdavanja", "Stranice", "Cijena", vk_autor, vk_izdavac, vk_zanr) VALUES (20, 'Not So Green Grass', 2018, 244, 18.9899998, 6, 1, 8);
INSERT INTO public."Knjiga" ("ID", "Naslov", "Godina_izdavanja", "Stranice", "Cijena", vk_autor, vk_izdavac, vk_zanr) VALUES (21, 'Two Left Legs', 2019, 133, 79.9899979, 6, 3, 6);
INSERT INTO public."Knjiga" ("ID", "Naslov", "Godina_izdavanja", "Stranice", "Cijena", vk_autor, vk_izdavac, vk_zanr) VALUES (22, 'My F*KN Number', 2019, 325, 199.990005, 6, 2, 3);


--
-- TOC entry 2910 (class 0 OID 16458)
-- Dependencies: 212
-- Data for Name: Narudzba; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."Narudzba" ("ID", vk_knjiga, vk_dobavljac, "Kolicina", "Datum_nastanka", "Datum_zaprimanja") VALUES (1525, 4, 1, 10, '2019-01-11 16:17:27', '2019-01-12 16:17:27');
INSERT INTO public."Narudzba" ("ID", vk_knjiga, vk_dobavljac, "Kolicina", "Datum_nastanka", "Datum_zaprimanja") VALUES (1526, 4, 1, 10, '2019-01-11 16:17:37', '2019-01-12 16:17:37');
INSERT INTO public."Narudzba" ("ID", vk_knjiga, vk_dobavljac, "Kolicina", "Datum_nastanka", "Datum_zaprimanja") VALUES (1527, 4, 1, 10, '2019-01-11 16:18:34', '2019-01-12 16:18:34');
INSERT INTO public."Narudzba" ("ID", vk_knjiga, vk_dobavljac, "Kolicina", "Datum_nastanka", "Datum_zaprimanja") VALUES (1528, 5, 1, 10, '2019-01-11 16:28:12', '2019-01-12 16:28:12');
INSERT INTO public."Narudzba" ("ID", vk_knjiga, vk_dobavljac, "Kolicina", "Datum_nastanka", "Datum_zaprimanja") VALUES (1529, 3, 1, 10, '2019-01-11 16:28:49', '2019-01-12 16:28:49');
INSERT INTO public."Narudzba" ("ID", vk_knjiga, vk_dobavljac, "Kolicina", "Datum_nastanka", "Datum_zaprimanja") VALUES (1530, 1, 1, 10, '2019-01-11 16:29:01', '2019-01-12 16:29:01');
INSERT INTO public."Narudzba" ("ID", vk_knjiga, vk_dobavljac, "Kolicina", "Datum_nastanka", "Datum_zaprimanja") VALUES (1531, 1, 1, 10, '2019-01-11 16:29:49', '2019-01-12 16:29:49');
INSERT INTO public."Narudzba" ("ID", vk_knjiga, vk_dobavljac, "Kolicina", "Datum_nastanka", "Datum_zaprimanja") VALUES (1532, 1, 1, 10, '2019-01-11 16:31:00', '2019-01-12 16:31:00');
INSERT INTO public."Narudzba" ("ID", vk_knjiga, vk_dobavljac, "Kolicina", "Datum_nastanka", "Datum_zaprimanja") VALUES (1533, 4, 1, 20, '2019-01-11 16:35:40', '2019-01-12 16:35:40');
INSERT INTO public."Narudzba" ("ID", vk_knjiga, vk_dobavljac, "Kolicina", "Datum_nastanka", "Datum_zaprimanja") VALUES (1534, 4, 1, 10, '2019-01-11 16:35:44', '2019-01-12 16:35:44');
INSERT INTO public."Narudzba" ("ID", vk_knjiga, vk_dobavljac, "Kolicina", "Datum_nastanka", "Datum_zaprimanja") VALUES (1535, 4, 1, 10, '2019-01-11 16:35:47', '2019-01-12 16:35:47');
INSERT INTO public."Narudzba" ("ID", vk_knjiga, vk_dobavljac, "Kolicina", "Datum_nastanka", "Datum_zaprimanja") VALUES (1536, 5, 1, 30, '2019-01-11 16:36:14', '2019-01-12 16:36:14');
INSERT INTO public."Narudzba" ("ID", vk_knjiga, vk_dobavljac, "Kolicina", "Datum_nastanka", "Datum_zaprimanja") VALUES (1537, 4, 1, 20, '2019-01-11 16:42:22', '2019-01-12 16:42:22');
INSERT INTO public."Narudzba" ("ID", vk_knjiga, vk_dobavljac, "Kolicina", "Datum_nastanka", "Datum_zaprimanja") VALUES (1538, 4, 2, 10, '2019-01-11 16:42:26', '2019-01-12 16:42:26');
INSERT INTO public."Narudzba" ("ID", vk_knjiga, vk_dobavljac, "Kolicina", "Datum_nastanka", "Datum_zaprimanja") VALUES (1539, 4, 2, 10, '2019-01-11 16:42:29', '2019-01-12 16:42:29');
INSERT INTO public."Narudzba" ("ID", vk_knjiga, vk_dobavljac, "Kolicina", "Datum_nastanka", "Datum_zaprimanja") VALUES (1540, 4, 1, 20, '2019-01-11 16:42:33', '2019-01-12 16:42:33');
INSERT INTO public."Narudzba" ("ID", vk_knjiga, vk_dobavljac, "Kolicina", "Datum_nastanka", "Datum_zaprimanja") VALUES (1541, 3, 1, 10, '2019-01-11 16:42:55', '2019-01-12 16:42:55');
INSERT INTO public."Narudzba" ("ID", vk_knjiga, vk_dobavljac, "Kolicina", "Datum_nastanka", "Datum_zaprimanja") VALUES (1542, 1, 2, 30, '2019-01-11 16:42:59', '2019-01-12 16:42:59');
INSERT INTO public."Narudzba" ("ID", vk_knjiga, vk_dobavljac, "Kolicina", "Datum_nastanka", "Datum_zaprimanja") VALUES (1543, 5, 3, 10, '2019-01-11 16:43:04', '2019-01-12 16:43:04');
INSERT INTO public."Narudzba" ("ID", vk_knjiga, vk_dobavljac, "Kolicina", "Datum_nastanka", "Datum_zaprimanja") VALUES (1544, 1, 3, 10, '2019-01-11 18:28:37', '2019-01-12 18:28:37');
INSERT INTO public."Narudzba" ("ID", vk_knjiga, vk_dobavljac, "Kolicina", "Datum_nastanka", "Datum_zaprimanja") VALUES (1545, 1, 1, 10, '2019-01-11 18:28:43', '2019-01-12 18:28:43');
INSERT INTO public."Narudzba" ("ID", vk_knjiga, vk_dobavljac, "Kolicina", "Datum_nastanka", "Datum_zaprimanja") VALUES (1546, 3, 1, 10, '2019-01-11 18:31:45', '2019-01-12 18:31:45');
INSERT INTO public."Narudzba" ("ID", vk_knjiga, vk_dobavljac, "Kolicina", "Datum_nastanka", "Datum_zaprimanja") VALUES (1547, 3, 3, 10, '2019-01-11 18:32:07', '2019-01-12 18:32:07');
INSERT INTO public."Narudzba" ("ID", vk_knjiga, vk_dobavljac, "Kolicina", "Datum_nastanka", "Datum_zaprimanja") VALUES (1548, 1, 3, 10, '2019-01-11 19:27:57', '2019-01-12 19:27:57');
INSERT INTO public."Narudzba" ("ID", vk_knjiga, vk_dobavljac, "Kolicina", "Datum_nastanka", "Datum_zaprimanja") VALUES (1549, 6, 3, 10, '2019-01-11 21:47:56', '2019-01-12 21:47:56');
INSERT INTO public."Narudzba" ("ID", vk_knjiga, vk_dobavljac, "Kolicina", "Datum_nastanka", "Datum_zaprimanja") VALUES (1550, 8, 3, 10, '2019-01-11 21:48:22', '2019-01-12 21:48:22');
INSERT INTO public."Narudzba" ("ID", vk_knjiga, vk_dobavljac, "Kolicina", "Datum_nastanka", "Datum_zaprimanja") VALUES (1551, 1, 2, 30, '2019-01-11 23:32:09', '2019-01-12 23:32:09');
INSERT INTO public."Narudzba" ("ID", vk_knjiga, vk_dobavljac, "Kolicina", "Datum_nastanka", "Datum_zaprimanja") VALUES (1552, 8, 3, 30, '2019-01-11 23:32:54', '2019-01-12 23:32:54');
INSERT INTO public."Narudzba" ("ID", vk_knjiga, vk_dobavljac, "Kolicina", "Datum_nastanka", "Datum_zaprimanja") VALUES (1553, 8, 2, 20, '2019-01-11 23:32:58', '2019-01-12 23:32:58');
INSERT INTO public."Narudzba" ("ID", vk_knjiga, vk_dobavljac, "Kolicina", "Datum_nastanka", "Datum_zaprimanja") VALUES (1554, 8, 1, 20, '2019-01-11 23:33:02', '2019-01-12 23:33:02');
INSERT INTO public."Narudzba" ("ID", vk_knjiga, vk_dobavljac, "Kolicina", "Datum_nastanka", "Datum_zaprimanja") VALUES (1555, 9, 1, 10, '2019-01-11 23:33:28', '2019-01-12 23:33:28');
INSERT INTO public."Narudzba" ("ID", vk_knjiga, vk_dobavljac, "Kolicina", "Datum_nastanka", "Datum_zaprimanja") VALUES (1556, 5, 1, 10, '2019-01-11 23:33:32', '2019-01-12 23:33:32');
INSERT INTO public."Narudzba" ("ID", vk_knjiga, vk_dobavljac, "Kolicina", "Datum_nastanka", "Datum_zaprimanja") VALUES (1557, 6, 3, 30, '2019-01-11 23:33:37', '2019-01-12 23:33:37');
INSERT INTO public."Narudzba" ("ID", vk_knjiga, vk_dobavljac, "Kolicina", "Datum_nastanka", "Datum_zaprimanja") VALUES (1558, 10, 1, 30, '2019-01-11 23:33:58', '2019-01-12 23:33:58');
INSERT INTO public."Narudzba" ("ID", vk_knjiga, vk_dobavljac, "Kolicina", "Datum_nastanka", "Datum_zaprimanja") VALUES (1559, 10, 2, 30, '2019-01-11 23:34:02', '2019-01-12 23:34:02');
INSERT INTO public."Narudzba" ("ID", vk_knjiga, vk_dobavljac, "Kolicina", "Datum_nastanka", "Datum_zaprimanja") VALUES (1560, 7, 2, 30, '2019-01-11 23:34:09', '2019-01-12 23:34:09');
INSERT INTO public."Narudzba" ("ID", vk_knjiga, vk_dobavljac, "Kolicina", "Datum_nastanka", "Datum_zaprimanja") VALUES (1561, 2, 2, 10, '2019-01-11 23:35:16', '2019-01-12 23:35:16');
INSERT INTO public."Narudzba" ("ID", vk_knjiga, vk_dobavljac, "Kolicina", "Datum_nastanka", "Datum_zaprimanja") VALUES (1562, 2, 1, 30, '2019-01-11 23:35:20', '2019-01-12 23:35:20');
INSERT INTO public."Narudzba" ("ID", vk_knjiga, vk_dobavljac, "Kolicina", "Datum_nastanka", "Datum_zaprimanja") VALUES (1563, 12, 1, 20, '2019-01-11 23:39:26', '2019-01-12 23:39:26');
INSERT INTO public."Narudzba" ("ID", vk_knjiga, vk_dobavljac, "Kolicina", "Datum_nastanka", "Datum_zaprimanja") VALUES (1564, 13, 3, 20, '2019-01-11 23:39:32', '2019-01-12 23:39:32');
INSERT INTO public."Narudzba" ("ID", vk_knjiga, vk_dobavljac, "Kolicina", "Datum_nastanka", "Datum_zaprimanja") VALUES (1565, 14, 2, 20, '2019-01-11 23:39:40', '2019-01-12 23:39:40');
INSERT INTO public."Narudzba" ("ID", vk_knjiga, vk_dobavljac, "Kolicina", "Datum_nastanka", "Datum_zaprimanja") VALUES (1566, 11, 1, 20, '2019-01-11 23:41:39', '2019-01-12 23:41:39');
INSERT INTO public."Narudzba" ("ID", vk_knjiga, vk_dobavljac, "Kolicina", "Datum_nastanka", "Datum_zaprimanja") VALUES (1567, 15, 3, 10, '2019-01-12 01:01:11', '2019-01-13 01:01:11');
INSERT INTO public."Narudzba" ("ID", vk_knjiga, vk_dobavljac, "Kolicina", "Datum_nastanka", "Datum_zaprimanja") VALUES (1568, 12, 1, 10, '2019-01-12 02:02:52', '2019-01-13 02:02:52');
INSERT INTO public."Narudzba" ("ID", vk_knjiga, vk_dobavljac, "Kolicina", "Datum_nastanka", "Datum_zaprimanja") VALUES (1569, 13, 2, 10, '2019-01-12 02:02:58', '2019-01-13 02:02:58');
INSERT INTO public."Narudzba" ("ID", vk_knjiga, vk_dobavljac, "Kolicina", "Datum_nastanka", "Datum_zaprimanja") VALUES (1570, 22, 3, 10, '2019-01-12 02:03:07', '2019-01-13 02:03:07');
INSERT INTO public."Narudzba" ("ID", vk_knjiga, vk_dobavljac, "Kolicina", "Datum_nastanka", "Datum_zaprimanja") VALUES (1571, 4, 2, 10, '2019-01-12 02:25:23', '2019-01-13 02:25:23');
INSERT INTO public."Narudzba" ("ID", vk_knjiga, vk_dobavljac, "Kolicina", "Datum_nastanka", "Datum_zaprimanja") VALUES (1572, 4, 2, 10, '2019-01-12 02:27:29', '2019-01-13 02:27:29');
INSERT INTO public."Narudzba" ("ID", vk_knjiga, vk_dobavljac, "Kolicina", "Datum_nastanka", "Datum_zaprimanja") VALUES (1573, 4, 3, 20, '2019-01-12 02:28:10', '2019-01-13 02:28:10');
INSERT INTO public."Narudzba" ("ID", vk_knjiga, vk_dobavljac, "Kolicina", "Datum_nastanka", "Datum_zaprimanja") VALUES (1574, 4, 3, 10, '2019-01-12 16:10:28', '2019-01-13 16:10:28');
INSERT INTO public."Narudzba" ("ID", vk_knjiga, vk_dobavljac, "Kolicina", "Datum_nastanka", "Datum_zaprimanja") VALUES (1575, 1, 1, 10, '2019-01-12 16:10:38', '2019-01-13 16:10:38');
INSERT INTO public."Narudzba" ("ID", vk_knjiga, vk_dobavljac, "Kolicina", "Datum_nastanka", "Datum_zaprimanja") VALUES (1576, 1, 1, 10, '2019-01-13 17:43:49', '2019-01-14 17:43:49');
INSERT INTO public."Narudzba" ("ID", vk_knjiga, vk_dobavljac, "Kolicina", "Datum_nastanka", "Datum_zaprimanja") VALUES (1577, 1, 3, 10, '2019-01-13 17:53:29', '2019-01-14 17:53:29');
INSERT INTO public."Narudzba" ("ID", vk_knjiga, vk_dobavljac, "Kolicina", "Datum_nastanka", "Datum_zaprimanja") VALUES (1578, 5, 3, 10, '2019-01-13 17:53:39', '2019-01-14 17:53:39');
INSERT INTO public."Narudzba" ("ID", vk_knjiga, vk_dobavljac, "Kolicina", "Datum_nastanka", "Datum_zaprimanja") VALUES (1579, 1, 3, 10, '2019-01-13 17:53:41', '2019-01-14 17:53:41');
INSERT INTO public."Narudzba" ("ID", vk_knjiga, vk_dobavljac, "Kolicina", "Datum_nastanka", "Datum_zaprimanja") VALUES (1580, 19, 2, 10, '2019-01-13 17:53:43', '2019-01-14 17:53:43');
INSERT INTO public."Narudzba" ("ID", vk_knjiga, vk_dobavljac, "Kolicina", "Datum_nastanka", "Datum_zaprimanja") VALUES (1581, 3, 1, 10, '2019-01-19 01:59:02', '2019-01-20 01:59:02');
INSERT INTO public."Narudzba" ("ID", vk_knjiga, vk_dobavljac, "Kolicina", "Datum_nastanka", "Datum_zaprimanja") VALUES (1582, 20, 2, 10, '2019-01-19 02:00:08', '2019-01-20 02:00:08');
INSERT INTO public."Narudzba" ("ID", vk_knjiga, vk_dobavljac, "Kolicina", "Datum_nastanka", "Datum_zaprimanja") VALUES (1583, 22, 2, 10, '2019-01-19 02:04:33', '2019-01-20 02:04:33');
INSERT INTO public."Narudzba" ("ID", vk_knjiga, vk_dobavljac, "Kolicina", "Datum_nastanka", "Datum_zaprimanja") VALUES (1584, 6, 2, 10, '2019-01-19 02:07:29', '2019-01-20 02:07:29');
INSERT INTO public."Narudzba" ("ID", vk_knjiga, vk_dobavljac, "Kolicina", "Datum_nastanka", "Datum_zaprimanja") VALUES (1585, 4, 1, 10, '2019-01-19 03:38:58', '2019-01-20 03:38:58');


--
-- TOC entry 2902 (class 0 OID 16426)
-- Dependencies: 204
-- Data for Name: Skladiste; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."Skladiste" ("ID_knjiga", "Kolicina", "Posljednja_promjena") VALUES (1, 33, '2019-01-16 19:40:21');
INSERT INTO public."Skladiste" ("ID_knjiga", "Kolicina", "Posljednja_promjena") VALUES (3, 25, '2019-01-19 01:59:02');
INSERT INTO public."Skladiste" ("ID_knjiga", "Kolicina", "Posljednja_promjena") VALUES (20, 23, '2019-01-19 02:00:08');
INSERT INTO public."Skladiste" ("ID_knjiga", "Kolicina", "Posljednja_promjena") VALUES (17, 29, '2019-01-12 01:13:42');
INSERT INTO public."Skladiste" ("ID_knjiga", "Kolicina", "Posljednja_promjena") VALUES (22, 24, '2019-01-19 02:04:33');
INSERT INTO public."Skladiste" ("ID_knjiga", "Kolicina", "Posljednja_promjena") VALUES (6, 25, '2019-01-19 02:07:29');
INSERT INTO public."Skladiste" ("ID_knjiga", "Kolicina", "Posljednja_promjena") VALUES (21, 25, '2019-01-12 02:02:44');
INSERT INTO public."Skladiste" ("ID_knjiga", "Kolicina", "Posljednja_promjena") VALUES (4, 29, '2019-01-19 03:38:58');
INSERT INTO public."Skladiste" ("ID_knjiga", "Kolicina", "Posljednja_promjena") VALUES (13, 28, '2019-01-12 02:02:58');
INSERT INTO public."Skladiste" ("ID_knjiga", "Kolicina", "Posljednja_promjena") VALUES (10, 87, '2019-01-11 23:34:05');
INSERT INTO public."Skladiste" ("ID_knjiga", "Kolicina", "Posljednja_promjena") VALUES (7, 64, '2019-01-11 23:34:13');
INSERT INTO public."Skladiste" ("ID_knjiga", "Kolicina", "Posljednja_promjena") VALUES (14, 29, '2019-01-11 23:39:40');
INSERT INTO public."Skladiste" ("ID_knjiga", "Kolicina", "Posljednja_promjena") VALUES (18, 37, '2019-01-13 17:53:19');
INSERT INTO public."Skladiste" ("ID_knjiga", "Kolicina", "Posljednja_promjena") VALUES (11, 33, '2019-01-13 17:53:23');
INSERT INTO public."Skladiste" ("ID_knjiga", "Kolicina", "Posljednja_promjena") VALUES (15, 22, '2019-01-13 17:53:33');
INSERT INTO public."Skladiste" ("ID_knjiga", "Kolicina", "Posljednja_promjena") VALUES (8, 20, '2019-01-13 17:53:37');
INSERT INTO public."Skladiste" ("ID_knjiga", "Kolicina", "Posljednja_promjena") VALUES (5, 29, '2019-01-13 17:53:39');
INSERT INTO public."Skladiste" ("ID_knjiga", "Kolicina", "Posljednja_promjena") VALUES (19, 25, '2019-01-13 17:53:43');
INSERT INTO public."Skladiste" ("ID_knjiga", "Kolicina", "Posljednja_promjena") VALUES (2, 32, '2019-01-13 17:53:44');
INSERT INTO public."Skladiste" ("ID_knjiga", "Kolicina", "Posljednja_promjena") VALUES (16, 20, '2019-01-13 17:53:45');
INSERT INTO public."Skladiste" ("ID_knjiga", "Kolicina", "Posljednja_promjena") VALUES (12, 24, '2019-01-13 17:53:47');
INSERT INTO public."Skladiste" ("ID_knjiga", "Kolicina", "Posljednja_promjena") VALUES (9, 28, '2019-01-13 17:53:49');


--
-- TOC entry 2906 (class 0 OID 16442)
-- Dependencies: 208
-- Data for Name: Tip; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."Tip" ("ID", "Naziv", "Opis") VALUES (1, 'Promjena količine', 'Tip zapisa u dnevniku koji označava promjenu količine artikla na skladištu.');
INSERT INTO public."Tip" ("ID", "Naziv", "Opis") VALUES (2, 'Narudžba', 'Tip zapisa u dnevniku koji označava izradu narudžbe.');
INSERT INTO public."Tip" ("ID", "Naziv", "Opis") VALUES (3, 'Primka', 'Tip zapisa u dnevniku koji označava pristiglu primku.');


--
-- TOC entry 2901 (class 0 OID 16420)
-- Dependencies: 203
-- Data for Name: Zanr; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."Zanr" ("ID", "Naziv", "Opis") VALUES (1, 'Autobiografija', 'Pisani prikaz života pisca.');
INSERT INTO public."Zanr" ("ID", "Naziv", "Opis") VALUES (2, 'Biografija', 'Pisani zapis o životu neke osobe.');
INSERT INTO public."Zanr" ("ID", "Naziv", "Opis") VALUES (3, 'Fantazija', 'Priče ispunjene imaginarnim i nerealnim elementima.');
INSERT INTO public."Zanr" ("ID", "Naziv", "Opis") VALUES (4, 'Fikcija', 'Žanr koji uključuje mitove, bajke, priče, povijesne događaje, znanstvenu fantastiku i slično.');
INSERT INTO public."Zanr" ("ID", "Naziv", "Opis") VALUES (5, 'Triler', 'Triler karakterizira dinamika, neprestalna akcija i vješti junaci.');
INSERT INTO public."Zanr" ("ID", "Naziv", "Opis") VALUES (6, 'Drama', 'Žanr koji ponajviše ovisi o unutarnjem razvoju likova koji se suočavaju sa emocijalnim temama.');
INSERT INTO public."Zanr" ("ID", "Naziv", "Opis") VALUES (7, 'Komedija', 'Žanr koji odlikuje veselim sadržajem, prikazuje smiješne strane u životu ljudi.');
INSERT INTO public."Zanr" ("ID", "Naziv", "Opis") VALUES (8, 'Tragedija', 'Žanr koji se ozbiljno bavi žalosnim padom protagonista.');
INSERT INTO public."Zanr" ("ID", "Naziv", "Opis") VALUES (9, 'Basna', 'Kratki oblik epike u kojem su glavni likovi uglavnom životinje koje nose ljudske osobine.');
INSERT INTO public."Zanr" ("ID", "Naziv", "Opis") VALUES (10, 'Kriminalistički', 'Karakterizira ga odnos kriminalca i policije u raznim varijacijama.');
INSERT INTO public."Zanr" ("ID", "Naziv", "Opis") VALUES (11, 'Avanturistički', 'Vrsta romana u kojem se radnja sastoji od niza uzbudljivih radnji i događaja.');


--
-- TOC entry 2924 (class 0 OID 0)
-- Dependencies: 196
-- Name: Autor_ID_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Autor_ID_seq"', 6, true);


--
-- TOC entry 2925 (class 0 OID 0)
-- Dependencies: 205
-- Name: Dnevnik_ID_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Dnevnik_ID_seq"', 4931, true);


--
-- TOC entry 2926 (class 0 OID 0)
-- Dependencies: 209
-- Name: Dobavljac_ID_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Dobavljac_ID_seq"', 3, true);


--
-- TOC entry 2927 (class 0 OID 0)
-- Dependencies: 198
-- Name: Izdavac_ID_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Izdavac_ID_seq"', 3, true);


--
-- TOC entry 2928 (class 0 OID 0)
-- Dependencies: 200
-- Name: Knjiga_ID_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Knjiga_ID_seq"', 22, true);


--
-- TOC entry 2929 (class 0 OID 0)
-- Dependencies: 211
-- Name: Narudzba_ID_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Narudzba_ID_seq"', 1585, true);


--
-- TOC entry 2930 (class 0 OID 0)
-- Dependencies: 207
-- Name: Tip_ID_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Tip_ID_seq"', 3, true);


--
-- TOC entry 2931 (class 0 OID 0)
-- Dependencies: 202
-- Name: Zanr_ID_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Zanr_ID_seq"', 11, true);


--
-- TOC entry 2746 (class 2606 OID 16401)
-- Name: Autor Autor_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Autor"
    ADD CONSTRAINT "Autor_pkey" PRIMARY KEY ("ID");


--
-- TOC entry 2756 (class 2606 OID 16439)
-- Name: Dnevnik Dnevnik_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Dnevnik"
    ADD CONSTRAINT "Dnevnik_pkey" PRIMARY KEY ("ID");


--
-- TOC entry 2760 (class 2606 OID 16455)
-- Name: Dobavljac Dobavljac_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Dobavljac"
    ADD CONSTRAINT "Dobavljac_pkey" PRIMARY KEY ("ID");


--
-- TOC entry 2748 (class 2606 OID 16409)
-- Name: Izdavac Izdavac_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Izdavac"
    ADD CONSTRAINT "Izdavac_pkey" PRIMARY KEY ("ID");


--
-- TOC entry 2750 (class 2606 OID 16417)
-- Name: Knjiga Knjiga_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Knjiga"
    ADD CONSTRAINT "Knjiga_pkey" PRIMARY KEY ("ID");


--
-- TOC entry 2762 (class 2606 OID 16465)
-- Name: Narudzba Narudzba_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Narudzba"
    ADD CONSTRAINT "Narudzba_pkey" PRIMARY KEY ("ID");


--
-- TOC entry 2754 (class 2606 OID 16430)
-- Name: Skladiste Skladiste_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Skladiste"
    ADD CONSTRAINT "Skladiste_pkey" PRIMARY KEY ("ID_knjiga");


--
-- TOC entry 2758 (class 2606 OID 16447)
-- Name: Tip Tip_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Tip"
    ADD CONSTRAINT "Tip_pkey" PRIMARY KEY ("ID");


--
-- TOC entry 2752 (class 2606 OID 16425)
-- Name: Zanr Zanr_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Zanr"
    ADD CONSTRAINT "Zanr_pkey" PRIMARY KEY ("ID");


--
-- TOC entry 2772 (class 2620 OID 16560)
-- Name: Skladiste naruci_artikle; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER naruci_artikle AFTER INSERT OR UPDATE ON public."Skladiste" FOR EACH ROW EXECUTE PROCEDURE public.naruci_artikle();


--
-- TOC entry 2771 (class 2620 OID 16541)
-- Name: Skladiste provjera_kolicine; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER provjera_kolicine BEFORE INSERT OR UPDATE ON public."Skladiste" FOR EACH ROW EXECUTE PROCEDURE public.provjera_kolicine();


--
-- TOC entry 2768 (class 2606 OID 16491)
-- Name: Dnevnik fk_Dnevnik_Knjiga_1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Dnevnik"
    ADD CONSTRAINT "fk_Dnevnik_Knjiga_1" FOREIGN KEY (vk_knjiga) REFERENCES public."Knjiga"("ID");


--
-- TOC entry 2767 (class 2606 OID 16486)
-- Name: Dnevnik fk_Dnevnik_Tip_1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Dnevnik"
    ADD CONSTRAINT "fk_Dnevnik_Tip_1" FOREIGN KEY (vk_tip) REFERENCES public."Tip"("ID");


--
-- TOC entry 2763 (class 2606 OID 16466)
-- Name: Knjiga fk_Knjiga_Autor_1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Knjiga"
    ADD CONSTRAINT "fk_Knjiga_Autor_1" FOREIGN KEY (vk_autor) REFERENCES public."Autor"("ID");


--
-- TOC entry 2764 (class 2606 OID 16471)
-- Name: Knjiga fk_Knjiga_Izdavac_1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Knjiga"
    ADD CONSTRAINT "fk_Knjiga_Izdavac_1" FOREIGN KEY (vk_izdavac) REFERENCES public."Izdavac"("ID");


--
-- TOC entry 2765 (class 2606 OID 16476)
-- Name: Knjiga fk_Knjiga_Zanr_1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Knjiga"
    ADD CONSTRAINT "fk_Knjiga_Zanr_1" FOREIGN KEY (vk_zanr) REFERENCES public."Zanr"("ID");


--
-- TOC entry 2770 (class 2606 OID 16501)
-- Name: Narudzba fk_Narudzba_Dobavljac_1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Narudzba"
    ADD CONSTRAINT "fk_Narudzba_Dobavljac_1" FOREIGN KEY (vk_dobavljac) REFERENCES public."Dobavljac"("ID");


--
-- TOC entry 2769 (class 2606 OID 16496)
-- Name: Narudzba fk_Narudzba_Knjiga_1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Narudzba"
    ADD CONSTRAINT "fk_Narudzba_Knjiga_1" FOREIGN KEY (vk_knjiga) REFERENCES public."Knjiga"("ID");


--
-- TOC entry 2766 (class 2606 OID 16481)
-- Name: Skladiste fk_Skladiste_Knjiga_1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Skladiste"
    ADD CONSTRAINT "fk_Skladiste_Knjiga_1" FOREIGN KEY ("ID_knjiga") REFERENCES public."Knjiga"("ID");


-- Completed on 2019-01-19 19:13:26

--
-- PostgreSQL database dump complete
--

