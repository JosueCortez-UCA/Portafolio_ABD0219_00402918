-- Ejercicio 1
sudo mkdir /mnt/saas/
sudo chown postgres /mnt/saas

sudo su
su postgres
psql

CREATE TABLESPACE SAAS LOCATION '/mnt/saas';
SET default_tablespace = SAAS;

-- Ejercicio 2
CREATE ROLE powerrepuestos WITH LOGIN CREATEDB;
CREATE ROLE laatencao WITH LOGIN CREATEDB;
CREATE ROLE simon WITH LOGIN CREATEDB;
CREATE ROLE moonbucks WITH LOGIN CREATEDB;

-- Ejercicio 3
CREATE DATABASE powerrepuestos WITH OWNER powerrepuestos;

CREATE DATABASE laatencao WITH OWNER laatencao;

CREATE DATABASE simon WITH OWNER simon;

CREATE DATABASE moonbucks WITH OWNER moonbucks;
