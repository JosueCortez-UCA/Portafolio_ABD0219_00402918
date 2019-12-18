--1
-- Estos comandos los debe ejecutar el usuario postgres
CREATE TABLESPACE saas LOCATION '/mnt/saas'; 

SET default_tablespace = saas;

--2
CREATE USER powerrepuestos PASSWORD 'powerrepuestos' CREATEDB;
CREATE USER laatencao PASSWORD 'laatencao' CREATEDB;
CREATE USER simon PASSWORD 'simon' CREATEDB;
CREATE USER moonbucks PASSWORD 'moonbucks' CREATEDB;

--3
\c - powerrepuestos
CREATE DATABASE powerrepuestos;

\c - laatencao
CREATE DATABASE laatencao;

\c - simon
CREATE DATABASE simon;

\c - moonbucks
CREATE DATABASE moonbucks;

--4
--> Ver archivo lab4-estructura-ucasoft.sql

--5
\c powerrepuestos powerrepuestos
\i lab4-estructura-ucasoft.sql
\i lab4-datos-ucasoft.sql

\c laatencao laatencao
\i lab4-estructura-ucasoft.sql
\i lab4-datos-ucasoft.sql

\c simon simon
\i lab4-estructura-ucasoft.sql
\i lab4-datos-ucasoft.sql

\c moonbucks moonbucks
\i lab4-estructura-ucasoft.sql
\i lab4-datos-ucasoft.sql

--6
-- Estos comandos los puede ejecutar postgres o cada dueño
GRANT CREATE,CONNECT ON DATABASE powerrepuestos TO uca;
GRANT CREATE,CONNECT ON DATABASE laatencao TO uca;
GRANT CREATE,CONNECT ON DATABASE simon TO uca;
GRANT CREATE,CONNECT ON DATABASE moonbucks TO uca;

--7
-- Estos comandos los ejecuta postgres que es el dueño actual de los esquemas public, si se quiere ejecutar con el dueño de la BD hay que cambiar el dueño del esquema:
\c powerrepuestos
alter SCHEMA public owner to powerrepuestos;

-- pero si es postgres no problem
\c powerrepuestos
GRANT USAGE ON SCHEMA public TO uca;

\c laatencao
GRANT USAGE ON SCHEMA public TO uca;

\c simon
GRANT USAGE ON SCHEMA public TO uca;

\c moonbucks
GRANT USAGE ON SCHEMA public TO uca;

--8
\c powerrepuestos
GRANT ALL ON ALL TABLES IN SCHEMA public TO uca;

\c laatencao
GRANT ALL ON ALL TABLES IN SCHEMA public TO uca;

\c simon
GRANT ALL ON ALL TABLES IN SCHEMA public TO uca;

\c moonbucks
GRANT ALL ON ALL TABLES IN SCHEMA public TO uca;

--9
\c - uca

\c powerrepuestos
CREATE SCHEMA gestion;

\c laatencao
CREATE SCHEMA gestion;

\c simon
CREATE SCHEMA gestion;

\c moonbucks
CREATE SCHEMA gestion;

--10
\c powerrepuestos
CREATE TYPE gestion.tipo_clasesentencia AS ENUM ('select','insert','delete','update');
CREATE TYPE gestion.tipo_sentencia AS ( 
  clase gestion.tipo_clasesentencia,
  cadena TEXT
);

\c laatencao
CREATE TYPE gestion.tipo_clasesentencia AS ENUM ('select','insert','delete','update');
CREATE TYPE gestion.tipo_sentencia AS ( 
  clase gestion.tipo_clasesentencia,
  cadena TEXT
);

\c simon
CREATE TYPE gestion.tipo_clasesentencia AS ENUM ('select','insert','delete','update');
CREATE TYPE gestion.tipo_sentencia AS ( 
  clase gestion.tipo_clasesentencia,
  cadena TEXT
);

\c moonbucks
CREATE TYPE gestion.tipo_clasesentencia AS ENUM ('select','insert','delete','update');
CREATE TYPE gestion.tipo_sentencia AS ( 
  clase gestion.tipo_clasesentencia,
  cadena TEXT
);

--11
\c powerrepuestos
CREATE TABLE gestion.auditoria(
    fechahora TIMESTAMP NOT NULL,
    sentencia gestion.tipo_sentencia,
    info text[],
    CONSTRAINT pk_auditoria PRIMARY KEY (fechahora)
);

\c laatencao
CREATE TABLE gestion.auditoria(
    fechahora TIMESTAMP NOT NULL,
    sentencia gestion.tipo_sentencia,
    info text[],
    CONSTRAINT pk_auditoria PRIMARY KEY (fechahora)
);

\c simon
CREATE TABLE gestion.auditoria(
    fechahora TIMESTAMP NOT NULL,
    sentencia gestion.tipo_sentencia,
    info text[],
    CONSTRAINT pk_auditoria PRIMARY KEY (fechahora)
);

\c moonbucks
CREATE TABLE gestion.auditoria(
    fechahora TIMESTAMP NOT NULL,
    sentencia gestion.tipo_sentencia,
    info text[],
    CONSTRAINT pk_auditoria PRIMARY KEY (fechahora)
);

--12
\c powerrepuestos
DROP TABLE IF EXISTS gestion.auditoria;
CREATE TABLE gestion.auditoria(
    fechahora TIMESTAMP NOT NULL,
    sentencia gestion.tipo_sentencia,
    info text[],
    CONSTRAINT pk_auditoria PRIMARY KEY (fechahora)
) PARTITION BY RANGE (fechahora);

CREATE TABLE gestion.auditoria_2019 PARTITION OF gestion.auditoria FOR VALUES FROM ('01/01/2019') TO ('01/01/2020');
CREATE TABLE gestion.auditoria_2020 PARTITION OF gestion.auditoria FOR VALUES FROM ('01/01/2020') TO ('01/01/2021');
CREATE TABLE gestion.auditoria_default PARTITION OF gestion.auditoria DEFAULT;

\c laatencao
DROP TABLE IF EXISTS gestion.auditoria;
CREATE TABLE gestion.auditoria(
    fechahora TIMESTAMP NOT NULL,
    sentencia gestion.tipo_sentencia,
    info text[],
    CONSTRAINT pk_auditoria PRIMARY KEY (fechahora)
) PARTITION BY RANGE (fechahora);

CREATE TABLE gestion.auditoria_2019 PARTITION OF gestion.auditoria FOR VALUES FROM ('01/01/2019') TO ('01/01/2020');
CREATE TABLE gestion.auditoria_2020 PARTITION OF gestion.auditoria FOR VALUES FROM ('01/01/2020') TO ('01/01/2021');
CREATE TABLE gestion.auditoria_default PARTITION OF gestion.auditoria DEFAULT;

\c simon
DROP TABLE IF EXISTS gestion.auditoria;
CREATE TABLE gestion.auditoria(
    fechahora TIMESTAMP NOT NULL,
    sentencia gestion.tipo_sentencia,
    info text[],
    CONSTRAINT pk_auditoria PRIMARY KEY (fechahora)
) PARTITION BY RANGE (fechahora);

CREATE TABLE gestion.auditoria_2019 PARTITION OF gestion.auditoria FOR VALUES FROM ('01/01/2019') TO ('01/01/2020');
CREATE TABLE gestion.auditoria_2020 PARTITION OF gestion.auditoria FOR VALUES FROM ('01/01/2020') TO ('01/01/2021');
CREATE TABLE gestion.auditoria_default PARTITION OF gestion.auditoria DEFAULT;

\c moonbucks
DROP TABLE IF EXISTS gestion.auditoria;
CREATE TABLE gestion.auditoria(
    fechahora TIMESTAMP NOT NULL,
    sentencia gestion.tipo_sentencia,
    info text[],
    CONSTRAINT pk_auditoria PRIMARY KEY (fechahora)
) PARTITION BY RANGE (fechahora);

CREATE TABLE gestion.auditoria_2019 PARTITION OF gestion.auditoria FOR VALUES FROM ('01/01/2019') TO ('01/01/2020');
CREATE TABLE gestion.auditoria_2020 PARTITION OF gestion.auditoria FOR VALUES FROM ('01/01/2020') TO ('01/01/2021');
CREATE TABLE gestion.auditoria_default PARTITION OF gestion.auditoria DEFAULT;

--13

\c powerrepuestos
INSERT INTO gestion.auditoria SELECT generate_series('2019-01-01 00:00'::timestamp,'2021-12-31 12:00','2 hours');
SELECT count(*),tableoid::regclass FROM gestion.auditoria GROUP BY tableoid;

\c laatencao
INSERT INTO gestion.auditoria SELECT generate_series('2019-01-01 00:00'::timestamp,'2021-12-31 12:00','2 hours');
SELECT count(*),tableoid::regclass FROM gestion.auditoria GROUP BY tableoid;


\c simon
INSERT INTO gestion.auditoria SELECT generate_series('2019-01-01 00:00'::timestamp,'2021-12-31 12:00','2 hours');
SELECT count(*),tableoid::regclass FROM gestion.auditoria GROUP BY tableoid;


\c moonbucks
INSERT INTO gestion.auditoria SELECT generate_series('2019-01-01 00:00'::timestamp,'2021-12-31 12:00','2 hours');
SELECT count(*),tableoid::regclass FROM gestion.auditoria GROUP BY tableoid;
