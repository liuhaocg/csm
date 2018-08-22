--
-- PostgreSQL database dump
--

-- Dumped from database version 9.5.4
-- Dumped by pg_dump version 9.5.4

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: s_chat; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA s_chat;


ALTER SCHEMA s_chat OWNER TO postgres;

--
-- Name: s_doctor; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA s_doctor;


ALTER SCHEMA s_doctor OWNER TO postgres;

--
-- Name: s_medicine; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA s_medicine;


ALTER SCHEMA s_medicine OWNER TO postgres;

--
-- Name: s_push; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA s_push;


ALTER SCHEMA s_push OWNER TO postgres;

SET search_path = s_chat, pg_catalog;

--
-- Name: update_timestamp_when_created(); Type: FUNCTION; Schema: s_chat; Owner: postgres
--

CREATE FUNCTION update_timestamp_when_created() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
  declare
      t timestamptz;
  BEGIN
      t := now();
      NEW.created_at = t;
      NEW.updated_at = t;
      RETURN NEW;
  END;
  $$;


ALTER FUNCTION s_chat.update_timestamp_when_created() OWNER TO postgres;

--
-- Name: update_timestamp_when_updated(); Type: FUNCTION; Schema: s_chat; Owner: postgres
--

CREATE FUNCTION update_timestamp_when_updated() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
  BEGIN
      NEW.updated_at = now();
      RETURN NEW;
  END;
  $$;


ALTER FUNCTION s_chat.update_timestamp_when_updated() OWNER TO postgres;

SET search_path = s_doctor, pg_catalog;

--
-- Name: p_tz(timestamp with time zone); Type: FUNCTION; Schema: s_doctor; Owner: postgres
--

CREATE FUNCTION p_tz(t timestamp with time zone) RETURNS text
    LANGUAGE plpgsql
    AS $$
	BEGIN
		RETURN to_char(t, 'YYYY-MM-DD HH24:MI:SS.MS');
	END;
$$;


ALTER FUNCTION s_doctor.p_tz(t timestamp with time zone) OWNER TO postgres;

--
-- Name: update_timestamp_when_created(); Type: FUNCTION; Schema: s_doctor; Owner: postgres
--

CREATE FUNCTION update_timestamp_when_created() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
declare
    t timestamptz;
BEGIN
    t := now();
    NEW.created_at = t;
    NEW.updated_at = t;
    RETURN NEW;
END;
$$;


ALTER FUNCTION s_doctor.update_timestamp_when_created() OWNER TO postgres;

--
-- Name: update_timestamp_when_updated(); Type: FUNCTION; Schema: s_doctor; Owner: postgres
--

CREATE FUNCTION update_timestamp_when_updated() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    NEW.updated_at = now();
    RETURN NEW;
END;
$$;


ALTER FUNCTION s_doctor.update_timestamp_when_updated() OWNER TO postgres;

SET search_path = s_medicine, pg_catalog;

--
-- Name: update_timestamp_when_created(); Type: FUNCTION; Schema: s_medicine; Owner: postgres
--

CREATE FUNCTION update_timestamp_when_created() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
  declare
      t timestamptz;
  BEGIN
      t := now();
      NEW.created_at = t;
      NEW.updated_at = t;
      RETURN NEW;
  END;
  $$;


ALTER FUNCTION s_medicine.update_timestamp_when_created() OWNER TO postgres;

--
-- Name: update_timestamp_when_updated(); Type: FUNCTION; Schema: s_medicine; Owner: postgres
--

CREATE FUNCTION update_timestamp_when_updated() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
  BEGIN
      NEW.updated_at = now();
      RETURN NEW;
  END;
  $$;


ALTER FUNCTION s_medicine.update_timestamp_when_updated() OWNER TO postgres;

SET search_path = s_push, pg_catalog;

--
-- Name: update_timestamp_when_created(); Type: FUNCTION; Schema: s_push; Owner: postgres
--

CREATE FUNCTION update_timestamp_when_created() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
  declare
      t timestamptz;
  BEGIN
      t := now();
      NEW.created_at = t;
      NEW.updated_at = t;
      RETURN NEW;
  END;
  $$;


ALTER FUNCTION s_push.update_timestamp_when_created() OWNER TO postgres;

--
-- Name: update_timestamp_when_updated(); Type: FUNCTION; Schema: s_push; Owner: postgres
--

CREATE FUNCTION update_timestamp_when_updated() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
  BEGIN
      NEW.updated_at = now();
      RETURN NEW;
  END;
  $$;


ALTER FUNCTION s_push.update_timestamp_when_updated() OWNER TO postgres;

SET search_path = s_chat, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: t_chat; Type: TABLE; Schema: s_chat; Owner: postgres
--

CREATE TABLE t_chat (
    id bigint NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    deleted_at timestamp without time zone,
    sender bigint NOT NULL,
    receiver bigint NOT NULL,
    content text DEFAULT '{}'::text NOT NULL,
    read_at timestamp without time zone
);


ALTER TABLE t_chat OWNER TO postgres;

--
-- Name: t_chat_id_seq; Type: SEQUENCE; Schema: s_chat; Owner: postgres
--

CREATE SEQUENCE t_chat_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE t_chat_id_seq OWNER TO postgres;

--
-- Name: t_chat_id_seq; Type: SEQUENCE OWNED BY; Schema: s_chat; Owner: postgres
--

ALTER SEQUENCE t_chat_id_seq OWNED BY t_chat.id;


SET search_path = s_doctor, pg_catalog;

--
-- Name: t_assisant; Type: TABLE; Schema: s_doctor; Owner: postgres
--

CREATE TABLE t_assisant (
    user_id bigint NOT NULL,
    doctor_id bigint NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    deleted_at timestamp with time zone,
    id bigint NOT NULL
);


ALTER TABLE t_assisant OWNER TO postgres;

--
-- Name: t_assisant_id_seq; Type: SEQUENCE; Schema: s_doctor; Owner: postgres
--

CREATE SEQUENCE t_assisant_id_seq
    START WITH 10000
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE t_assisant_id_seq OWNER TO postgres;

--
-- Name: t_assisant_id_seq; Type: SEQUENCE OWNED BY; Schema: s_doctor; Owner: postgres
--

ALTER SEQUENCE t_assisant_id_seq OWNED BY t_assisant.id;


--
-- Name: t_doctor; Type: TABLE; Schema: s_doctor; Owner: postgres
--

CREATE TABLE t_doctor (
    user_id bigint NOT NULL,
    title text,
    biography text,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    deleted_at timestamp with time zone,
    id bigint NOT NULL
);


ALTER TABLE t_doctor OWNER TO postgres;

--
-- Name: COLUMN t_doctor.title; Type: COMMENT; Schema: s_doctor; Owner: postgres
--

COMMENT ON COLUMN t_doctor.title IS '医生职称';


--
-- Name: COLUMN t_doctor.biography; Type: COMMENT; Schema: s_doctor; Owner: postgres
--

COMMENT ON COLUMN t_doctor.biography IS '医生简介';


--
-- Name: t_doctor_id_seq; Type: SEQUENCE; Schema: s_doctor; Owner: postgres
--

CREATE SEQUENCE t_doctor_id_seq
    START WITH 10000
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE t_doctor_id_seq OWNER TO postgres;

--
-- Name: t_doctor_id_seq; Type: SEQUENCE OWNED BY; Schema: s_doctor; Owner: postgres
--

ALTER SEQUENCE t_doctor_id_seq OWNED BY t_doctor.id;


--
-- Name: t_user; Type: TABLE; Schema: s_doctor; Owner: postgres
--

CREATE TABLE t_user (
    name text NOT NULL,
    password text NOT NULL,
    birthday timestamp with time zone NOT NULL,
    sex smallint NOT NULL,
    type smallint NOT NULL,
    avatar text NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    deleted_at timestamp with time zone,
    id bigint NOT NULL,
    cell_phone text
);


ALTER TABLE t_user OWNER TO postgres;

--
-- Name: t_user_id_seq; Type: SEQUENCE; Schema: s_doctor; Owner: postgres
--

CREATE SEQUENCE t_user_id_seq
    START WITH 10000
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE t_user_id_seq OWNER TO postgres;

--
-- Name: t_user_id_seq; Type: SEQUENCE OWNED BY; Schema: s_doctor; Owner: postgres
--

ALTER SEQUENCE t_user_id_seq OWNED BY t_user.id;


SET search_path = s_medicine, pg_catalog;

--
-- Name: t_medicine; Type: TABLE; Schema: s_medicine; Owner: postgres
--

CREATE TABLE t_medicine (
    id bigint NOT NULL,
    approval_no text NOT NULL,
    name text NOT NULL,
    eng_name text NOT NULL,
    commodity_name text DEFAULT ''::text NOT NULL,
    dosage_form text NOT NULL,
    strength text NOT NULL,
    company text NOT NULL,
    address text NOT NULL,
    type text NOT NULL,
    orig_apv_no text DEFAULT ''::text NOT NULL,
    approval_date date,
    drug_code text NOT NULL,
    drug_code_note text DEFAULT ''::text NOT NULL,
    country text DEFAULT ''::text NOT NULL,
    end_date date,
    pkg_strength text DEFAULT ''::text NOT NULL,
    cfda_id text NOT NULL,
    imported smallint DEFAULT 0 NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    deleted_at timestamp with time zone,
    note text DEFAULT ''::text NOT NULL
);


ALTER TABLE t_medicine OWNER TO postgres;

--
-- Name: TABLE t_medicine; Type: COMMENT; Schema: s_medicine; Owner: postgres
--

COMMENT ON TABLE t_medicine IS '药品表,详细见https://git.xzlcorp.com/corp/mas-service/wikis/db-schema';


--
-- Name: COLUMN t_medicine.id; Type: COMMENT; Schema: s_medicine; Owner: postgres
--

COMMENT ON COLUMN t_medicine.id IS '药品id';


--
-- Name: COLUMN t_medicine.approval_no; Type: COMMENT; Schema: s_medicine; Owner: postgres
--

COMMENT ON COLUMN t_medicine.approval_no IS '批准文号/注册证号';


--
-- Name: COLUMN t_medicine.name; Type: COMMENT; Schema: s_medicine; Owner: postgres
--

COMMENT ON COLUMN t_medicine.name IS '产品名称';


--
-- Name: COLUMN t_medicine.eng_name; Type: COMMENT; Schema: s_medicine; Owner: postgres
--

COMMENT ON COLUMN t_medicine.eng_name IS '英文名称';


--
-- Name: COLUMN t_medicine.commodity_name; Type: COMMENT; Schema: s_medicine; Owner: postgres
--

COMMENT ON COLUMN t_medicine.commodity_name IS '商品名称';


--
-- Name: COLUMN t_medicine.dosage_form; Type: COMMENT; Schema: s_medicine; Owner: postgres
--

COMMENT ON COLUMN t_medicine.dosage_form IS '剂型';


--
-- Name: COLUMN t_medicine.strength; Type: COMMENT; Schema: s_medicine; Owner: postgres
--

COMMENT ON COLUMN t_medicine.strength IS '规格';


--
-- Name: COLUMN t_medicine.company; Type: COMMENT; Schema: s_medicine; Owner: postgres
--

COMMENT ON COLUMN t_medicine.company IS '生产单位';


--
-- Name: COLUMN t_medicine.address; Type: COMMENT; Schema: s_medicine; Owner: postgres
--

COMMENT ON COLUMN t_medicine.address IS '生产地址';


--
-- Name: COLUMN t_medicine.type; Type: COMMENT; Schema: s_medicine; Owner: postgres
--

COMMENT ON COLUMN t_medicine.type IS '产品类别';


--
-- Name: COLUMN t_medicine.orig_apv_no; Type: COMMENT; Schema: s_medicine; Owner: postgres
--

COMMENT ON COLUMN t_medicine.orig_apv_no IS '原批准文号/原注册证号';


--
-- Name: COLUMN t_medicine.approval_date; Type: COMMENT; Schema: s_medicine; Owner: postgres
--

COMMENT ON COLUMN t_medicine.approval_date IS '批准日期/发证日期';


--
-- Name: COLUMN t_medicine.drug_code; Type: COMMENT; Schema: s_medicine; Owner: postgres
--

COMMENT ON COLUMN t_medicine.drug_code IS '药品本位码';


--
-- Name: COLUMN t_medicine.drug_code_note; Type: COMMENT; Schema: s_medicine; Owner: postgres
--

COMMENT ON COLUMN t_medicine.drug_code_note IS '药品本文码备注';


--
-- Name: COLUMN t_medicine.country; Type: COMMENT; Schema: s_medicine; Owner: postgres
--

COMMENT ON COLUMN t_medicine.country IS '厂商国家';


--
-- Name: COLUMN t_medicine.end_date; Type: COMMENT; Schema: s_medicine; Owner: postgres
--

COMMENT ON COLUMN t_medicine.end_date IS '有效截止日期';


--
-- Name: COLUMN t_medicine.pkg_strength; Type: COMMENT; Schema: s_medicine; Owner: postgres
--

COMMENT ON COLUMN t_medicine.pkg_strength IS '包装规格';


--
-- Name: COLUMN t_medicine.cfda_id; Type: COMMENT; Schema: s_medicine; Owner: postgres
--

COMMENT ON COLUMN t_medicine.cfda_id IS '药品在CFDA库中ID';


--
-- Name: COLUMN t_medicine.imported; Type: COMMENT; Schema: s_medicine; Owner: postgres
--

COMMENT ON COLUMN t_medicine.imported IS '是否进口药品';


--
-- Name: COLUMN t_medicine.created_at; Type: COMMENT; Schema: s_medicine; Owner: postgres
--

COMMENT ON COLUMN t_medicine.created_at IS '创建时间';


--
-- Name: COLUMN t_medicine.updated_at; Type: COMMENT; Schema: s_medicine; Owner: postgres
--

COMMENT ON COLUMN t_medicine.updated_at IS '信息更新时间';


--
-- Name: COLUMN t_medicine.deleted_at; Type: COMMENT; Schema: s_medicine; Owner: postgres
--

COMMENT ON COLUMN t_medicine.deleted_at IS '删除时间';


--
-- Name: COLUMN t_medicine.note; Type: COMMENT; Schema: s_medicine; Owner: postgres
--

COMMENT ON COLUMN t_medicine.note IS '备注';


--
-- Name: t_medicine_id_seq; Type: SEQUENCE; Schema: s_medicine; Owner: postgres
--

CREATE SEQUENCE t_medicine_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE t_medicine_id_seq OWNER TO postgres;

--
-- Name: t_medicine_id_seq; Type: SEQUENCE OWNED BY; Schema: s_medicine; Owner: postgres
--

ALTER SEQUENCE t_medicine_id_seq OWNED BY t_medicine.id;


SET search_path = s_push, pg_catalog;

--
-- Name: t_device; Type: TABLE; Schema: s_push; Owner: postgres
--

CREATE TABLE t_device (
    id integer NOT NULL,
    created_at time with time zone NOT NULL,
    updated_at time with time zone NOT NULL,
    deleted_at time with time zone,
    type text NOT NULL,
    object_id text NOT NULL,
    token text NOT NULL
);


ALTER TABLE t_device OWNER TO postgres;

--
-- Name: t_device_id_seq; Type: SEQUENCE; Schema: s_push; Owner: postgres
--

CREATE SEQUENCE t_device_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE t_device_id_seq OWNER TO postgres;

--
-- Name: t_device_id_seq; Type: SEQUENCE OWNED BY; Schema: s_push; Owner: postgres
--

ALTER SEQUENCE t_device_id_seq OWNED BY t_device.id;


SET search_path = s_chat, pg_catalog;

--
-- Name: id; Type: DEFAULT; Schema: s_chat; Owner: postgres
--

ALTER TABLE ONLY t_chat ALTER COLUMN id SET DEFAULT nextval('t_chat_id_seq'::regclass);


SET search_path = s_doctor, pg_catalog;

--
-- Name: id; Type: DEFAULT; Schema: s_doctor; Owner: postgres
--

ALTER TABLE ONLY t_assisant ALTER COLUMN id SET DEFAULT nextval('t_assisant_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: s_doctor; Owner: postgres
--

ALTER TABLE ONLY t_doctor ALTER COLUMN id SET DEFAULT nextval('t_doctor_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: s_doctor; Owner: postgres
--

ALTER TABLE ONLY t_user ALTER COLUMN id SET DEFAULT nextval('t_user_id_seq'::regclass);


SET search_path = s_medicine, pg_catalog;

--
-- Name: id; Type: DEFAULT; Schema: s_medicine; Owner: postgres
--

ALTER TABLE ONLY t_medicine ALTER COLUMN id SET DEFAULT nextval('t_medicine_id_seq'::regclass);


SET search_path = s_push, pg_catalog;

--
-- Name: id; Type: DEFAULT; Schema: s_push; Owner: postgres
--

ALTER TABLE ONLY t_device ALTER COLUMN id SET DEFAULT nextval('t_device_id_seq'::regclass);


SET search_path = s_chat, pg_catalog;

--
-- Name: t_chat_pkey; Type: CONSTRAINT; Schema: s_chat; Owner: postgres
--

ALTER TABLE ONLY t_chat
    ADD CONSTRAINT t_chat_pkey PRIMARY KEY (id);


SET search_path = s_doctor, pg_catalog;

--
-- Name: t_assisant_pkey; Type: CONSTRAINT; Schema: s_doctor; Owner: postgres
--

ALTER TABLE ONLY t_assisant
    ADD CONSTRAINT t_assisant_pkey PRIMARY KEY (id);


--
-- Name: t_doctor_pkey; Type: CONSTRAINT; Schema: s_doctor; Owner: postgres
--

ALTER TABLE ONLY t_doctor
    ADD CONSTRAINT t_doctor_pkey PRIMARY KEY (id);


--
-- Name: t_user_pkey; Type: CONSTRAINT; Schema: s_doctor; Owner: postgres
--

ALTER TABLE ONLY t_user
    ADD CONSTRAINT t_user_pkey PRIMARY KEY (id);


SET search_path = s_medicine, pg_catalog;

--
-- Name: t_medicine_pkey; Type: CONSTRAINT; Schema: s_medicine; Owner: postgres
--

ALTER TABLE ONLY t_medicine
    ADD CONSTRAINT t_medicine_pkey PRIMARY KEY (id);


SET search_path = s_push, pg_catalog;

--
-- Name: t_device_pkey; Type: CONSTRAINT; Schema: s_push; Owner: postgres
--

ALTER TABLE ONLY t_device
    ADD CONSTRAINT t_device_pkey PRIMARY KEY (id);


SET search_path = s_chat, pg_catalog;

--
-- Name: t_chat_created_at_idx; Type: INDEX; Schema: s_chat; Owner: postgres
--

CREATE INDEX t_chat_created_at_idx ON t_chat USING btree (created_at);


--
-- Name: t_chat_from_idx; Type: INDEX; Schema: s_chat; Owner: postgres
--

CREATE INDEX t_chat_from_idx ON t_chat USING btree (sender);


--
-- Name: t_chat_to_idx; Type: INDEX; Schema: s_chat; Owner: postgres
--

CREATE INDEX t_chat_to_idx ON t_chat USING btree (receiver);


SET search_path = s_doctor, pg_catalog;

--
-- Name: t_assisant_created_at_idx; Type: INDEX; Schema: s_doctor; Owner: postgres
--

CREATE INDEX t_assisant_created_at_idx ON t_assisant USING btree (created_at);


--
-- Name: t_assisant_deleted_at_idx; Type: INDEX; Schema: s_doctor; Owner: postgres
--

CREATE INDEX t_assisant_deleted_at_idx ON t_assisant USING btree (deleted_at);


--
-- Name: t_assisant_doctor_id_idx; Type: INDEX; Schema: s_doctor; Owner: postgres
--

CREATE INDEX t_assisant_doctor_id_idx ON t_assisant USING btree (doctor_id);


--
-- Name: t_assisant_user_id_idx; Type: INDEX; Schema: s_doctor; Owner: postgres
--

CREATE INDEX t_assisant_user_id_idx ON t_assisant USING btree (user_id);


--
-- Name: t_doctor_created_at_idx; Type: INDEX; Schema: s_doctor; Owner: postgres
--

CREATE INDEX t_doctor_created_at_idx ON t_doctor USING btree (created_at);


--
-- Name: t_doctor_deleted_at_idx; Type: INDEX; Schema: s_doctor; Owner: postgres
--

CREATE INDEX t_doctor_deleted_at_idx ON t_doctor USING btree (deleted_at);


--
-- Name: t_doctor_user_id_idx; Type: INDEX; Schema: s_doctor; Owner: postgres
--

CREATE INDEX t_doctor_user_id_idx ON t_doctor USING btree (user_id);


--
-- Name: t_user_cell_phone_idx; Type: INDEX; Schema: s_doctor; Owner: postgres
--

CREATE UNIQUE INDEX t_user_cell_phone_idx ON t_user USING btree (cell_phone);


--
-- Name: t_user_created_at_idx; Type: INDEX; Schema: s_doctor; Owner: postgres
--

CREATE INDEX t_user_created_at_idx ON t_user USING btree (created_at);


--
-- Name: t_user_deleted_at_idx; Type: INDEX; Schema: s_doctor; Owner: postgres
--

CREATE INDEX t_user_deleted_at_idx ON t_user USING btree (deleted_at);


SET search_path = s_medicine, pg_catalog;

--
-- Name: t_medicine_cfda_idx; Type: INDEX; Schema: s_medicine; Owner: postgres
--

CREATE INDEX t_medicine_cfda_idx ON t_medicine USING btree (cfda_id);


--
-- Name: t_medicine_name_idx; Type: INDEX; Schema: s_medicine; Owner: postgres
--

CREATE INDEX t_medicine_name_idx ON t_medicine USING gin (name s_mas.gin_trgm_ops);


SET search_path = s_push, pg_catalog;

--
-- Name: t_device_token_uindex; Type: INDEX; Schema: s_push; Owner: postgres
--

CREATE UNIQUE INDEX t_device_token_uindex ON t_device USING btree (token);


SET search_path = s_chat, pg_catalog;

--
-- Name: s_chat_t_chat_create; Type: TRIGGER; Schema: s_chat; Owner: postgres
--

CREATE TRIGGER s_chat_t_chat_create BEFORE INSERT ON t_chat FOR EACH ROW EXECUTE PROCEDURE update_timestamp_when_created();


--
-- Name: s_chat_t_chat_update; Type: TRIGGER; Schema: s_chat; Owner: postgres
--

CREATE TRIGGER s_chat_t_chat_update BEFORE UPDATE ON t_chat FOR EACH ROW EXECUTE PROCEDURE update_timestamp_when_updated();


SET search_path = s_doctor, pg_catalog;

--
-- Name: s_doctor_t_assisant_create; Type: TRIGGER; Schema: s_doctor; Owner: postgres
--

CREATE TRIGGER s_doctor_t_assisant_create BEFORE INSERT ON t_assisant FOR EACH ROW EXECUTE PROCEDURE update_timestamp_when_created();


--
-- Name: s_doctor_t_assisant_update; Type: TRIGGER; Schema: s_doctor; Owner: postgres
--

CREATE TRIGGER s_doctor_t_assisant_update BEFORE UPDATE ON t_assisant FOR EACH ROW EXECUTE PROCEDURE update_timestamp_when_updated();


--
-- Name: s_doctor_t_doctor_create; Type: TRIGGER; Schema: s_doctor; Owner: postgres
--

CREATE TRIGGER s_doctor_t_doctor_create BEFORE INSERT ON t_doctor FOR EACH ROW EXECUTE PROCEDURE update_timestamp_when_created();


--
-- Name: s_doctor_t_doctor_update; Type: TRIGGER; Schema: s_doctor; Owner: postgres
--

CREATE TRIGGER s_doctor_t_doctor_update BEFORE UPDATE ON t_doctor FOR EACH ROW EXECUTE PROCEDURE update_timestamp_when_updated();


--
-- Name: s_doctor_t_user_create; Type: TRIGGER; Schema: s_doctor; Owner: postgres
--

CREATE TRIGGER s_doctor_t_user_create BEFORE INSERT ON t_user FOR EACH ROW EXECUTE PROCEDURE update_timestamp_when_created();


--
-- Name: s_doctor_t_user_update; Type: TRIGGER; Schema: s_doctor; Owner: postgres
--

CREATE TRIGGER s_doctor_t_user_update BEFORE UPDATE ON t_user FOR EACH ROW EXECUTE PROCEDURE update_timestamp_when_updated();


SET search_path = s_medicine, pg_catalog;

--
-- Name: s_medicine_t_medicine_create; Type: TRIGGER; Schema: s_medicine; Owner: postgres
--

CREATE TRIGGER s_medicine_t_medicine_create BEFORE INSERT ON t_medicine FOR EACH ROW EXECUTE PROCEDURE update_timestamp_when_created();


--
-- Name: s_medicine_t_medicine_update; Type: TRIGGER; Schema: s_medicine; Owner: postgres
--

CREATE TRIGGER s_medicine_t_medicine_update BEFORE UPDATE ON t_medicine FOR EACH ROW EXECUTE PROCEDURE update_timestamp_when_updated();


SET search_path = s_push, pg_catalog;

--
-- Name: s_push_t_device_create; Type: TRIGGER; Schema: s_push; Owner: postgres
--

CREATE TRIGGER s_push_t_device_create BEFORE INSERT ON t_device FOR EACH ROW EXECUTE PROCEDURE update_timestamp_when_created();


--
-- Name: s_push_t_device_update; Type: TRIGGER; Schema: s_push; Owner: postgres
--

CREATE TRIGGER s_push_t_device_update BEFORE UPDATE ON t_device FOR EACH ROW EXECUTE PROCEDURE update_timestamp_when_updated();


SET search_path = s_doctor, pg_catalog;

--
-- Name: t_assisant; Type: ACL; Schema: s_doctor; Owner: postgres
--

REVOKE ALL ON TABLE t_assisant FROM PUBLIC;
REVOKE ALL ON TABLE t_assisant FROM postgres;
GRANT ALL ON TABLE t_assisant TO postgres;


--
-- Name: t_doctor; Type: ACL; Schema: s_doctor; Owner: postgres
--

REVOKE ALL ON TABLE t_doctor FROM PUBLIC;
REVOKE ALL ON TABLE t_doctor FROM postgres;
GRANT ALL ON TABLE t_doctor TO postgres;


--
-- Name: t_user; Type: ACL; Schema: s_doctor; Owner: postgres
--

REVOKE ALL ON TABLE t_user FROM PUBLIC;
REVOKE ALL ON TABLE t_user FROM postgres;
GRANT ALL ON TABLE t_user TO postgres;


--
-- PostgreSQL database dump complete
--
