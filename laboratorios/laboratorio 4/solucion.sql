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
