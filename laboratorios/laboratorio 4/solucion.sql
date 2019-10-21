/*
    Ejercicio 1
*/
sudo mkdir /mnt/saas/
sudo chown postgres /mnt/saas

sudo su
su postgres
psql

CREATE TABLESPACE SAAS LOCATION '/mnt/saas';
SET default_tablespace = SAAS;

/*
    Ejercicio 2
*/
CREATE USER powerrepuestos WITH PASSWORD '0000' CREATEDB;
CREATE USER laatencao WITH PASSWORD '0000' CREATEDB;
CREATE USER simon WITH PASSWORD '0000' CREATEDB;
CREATE USER moonbucks WITH PASSWORD '0000' CREATEDB;

/*
    Ejercicio 3
*/
CREATE DATABASE powerrepuestos WITH OWNER powerrepuestos;

CREATE DATABASE laatencao WITH OWNER laatencao;

CREATE DATABASE simon WITH OWNER simon;

CREATE DATABASE moonbucks WITH OWNER moonbucks;

/*
    Ejercicio 4 y 5
    password para todos = 0000
    acceder a la carpeta que contenga los archivos y ejecutar desde ahi
*/
\q
psql powerrepuestos powerrepuestos
\i estructura-ucasoft.sql
\i datos-ucasoft.sql
\i herencia.sql

\q
psql laatencao laatencao
\i estructura-ucasoft.sql
\i datos-ucasoft.sql
\i herencia.sql

\q
psql simon simon
\i estructura-ucasoft.sql
\i datos-ucasoft.sql
\i herencia.sql

\q
psql moonbucks moonbucks
\i estructura-ucasoft.sql
\i datos-ucasoft.sql
\i herencia.sql

-- Consultar herencias en cada base con este codigo
SELECT clase.relname, p.*
FROM proyecto p, pg_class clase
WHERE p.tableoid = clase.oid;

/*
    Ejercicio 6
*/
\q
psql
CREATE USER uca WITH PASSWORD 'wii' CREATEDB;
GRANT CONNECT ON DATABASE powerrepuestos TO uca;
GRANT CONNECT ON DATABASE laatencao TO uca;
GRANT CONNECT ON DATABASE simon TO uca;
GRANT CONNECT ON DATABASE moonbucks TO uca;

/*
    Ejercicio 7
*/
GRANT USAGE ON SCHEMA PUBLIC TO uca;

/*
    Ejercicio 8
*/
ALTER USER uca WITH SUPERUSER;

/*
    Ejercicio 9
*/
\q
psql ucasoft uca
CREATE SCHEMA gestion;

\q
psql powerrepuestos uca
CREATE SCHEMA gestion;

\q
psql laatencao uca
CREATE SCHEMA gestion;

\q
psql simon uca
CREATE SCHEMA gestion;

\q
psql moonbucks uca
CREATE SCHEMA gestion;

/*
    Ejercicio 10
    hacer esto por cada base
*/
CREATE TYPE gestion.clase AS ENUM ('select','insert','delete','update');

CREATE TYPE gestion.tipo_sentencia AS (
    clase clase,
    cadena text
);

/*
    Ejercicio 11
*/
CREATE TABLE gestion.auditoria(
    fechahora timestamp not null constraint pk_auditoria primary key,
    sentencia gestion.tipo_sentencia,
    pantalla text[]
);

/*
    Ejercicio 12
*/
DROP TABLE gestion.auditoria;
CREATE TABLE gestion.auditoria(
    fechahora timestamp not null,
    sentencia gestion.tipo_sentencia,
    pantalla text[]
) PARTITION BY RANGE (fechahora);

CREATE TABLE gestion.auditoria_2019 PARTITION OF gestion.auditoria FOR VALUES FROM ('01/01/2019') TO ('01/01/2020');
CREATE TABLE gestion.auditoria_2020 PARTITION OF gestion.auditoria FOR VALUES FROM ('01/01/2020') TO ('01/01/2021');
-- da error el "default" CREATE TABLE gestion.auditoria_default PARTITION OF gestion.auditoria DEFAULT;

/*
    Ejercicio 13
*/
INSERT INTO gestion.auditoria VALUES(
    generate_series('01-01-2019 00:00'::timestamp,'31-12-2020 12:00','2 hours'),
    ('select', 'la cadena de texto'),
    '{"pantalla1", "pantalla2"}'
);
