/*
    1
*/
--TABLA cliente
DROP TABLE cliente CASCADE;
CREATE TABLE cliente(
	dui char(10) not null,
	denominacion varchar(100) not null,
	tipo varchar(40) not null check (tipo in ('Persona física','Empresa','ONG','Institución pública','Institución académica')),
	pais char(2)
)PARTITION BY LIST(pais);

CREATE TABLE clientes_def PARTITION OF clientes DEFAULT;

--TABLA contrata
DROP TABLE contrata CASCADE;
CREATE TABLE contrata(
	codigo_proyecto char(5) not null,
	dui_cliente char(10) not null,
	dui_miembro_gestion char(10) not null,
	descuento money not null default 0,
	implantacion_fecha_inicio date not null,
	implantacion_precio money not null default 0,
	mantenimiento_periodicidad varchar(30) not null,
	mantenimiento_precio money not null default 0,
    pais char(2)
)PARTITION BY LIST(pais);

CREATE TABLE contrata_def PARTITION OF contrata DEFAULT;

--TABLA atiende
DROP TABLE atiende CASCADE;
CREATE TABLE atiende(
	codigo_proyecto char(5) not null,
	dui_cliente char(10) not null,
	dui_miembro_ventas char(10),
    pais char(2),
	constraint pk_atiende primary key(codigo_proyecto, dui_cliente, dui_miembro_ventas),
	constraint fk_atiende_proyecto foreign key(codigo_proyecto) references proyecto(codigo)
	ON delete cascade ON update cascade,
	constraint fk_atiende_miembro_ventas foreign key(dui_miembro_ventas) references ventas(dui_miembro)
	ON delete cascade ON update cascade
);

/*
    2
*/
CREATE DATABASE ucasoft_sv;

CREATE DATABASE ucasoft_cr;

CREATE DATABASE ucasoft_bz;

/*
	3
*/
\c ucasoft_sv
--TABLA cliente
CREATE TABLE cliente_sv(
	dui char(10) not null constraint pk_cliente primary key,
	denominacion varchar(100) not null,
	tipo varchar(40) not null check (tipo in ('Persona física','Empresa','ONG','Institución pública','Institución académica')),
	pais char(2) not null check (tipo in ('sv'))
);

--TABLA contrata
CREATE TABLE contrata_sv(
	codigo_proyecto char(5) not null,
	dui_cliente char(10) not null,
	dui_miembro_gestion char(10) not null,
	descuento money not null default 0,
	implantacion_fecha_inicio date not null,
	implantacion_precio money not null default 0,
	mantenimiento_periodicidad varchar(30) not null,
	mantenimiento_precio money not null default 0,
	pais char(2),
	constraint pk_contrata primary key(codigo_proyecto, dui_cliente),
	constraint fk_contrata_cliente foreign key(dui_cliente) references cliente_sv(dui)
	ON delete cascade ON update cascade
);

\c ucasoft_cr
--TABLA cliente
CREATE TABLE cliente_cr(
	dui char(10) not null constraint pk_cliente primary key,
	denominacion varchar(100) not null,
	tipo varchar(40) not null check (tipo in ('Persona física','Empresa','ONG','Institución pública','Institución académica')),
	pais char(2) not null check (tipo in ('cr'))
);

--TABLA contrata
CREATE TABLE contrata_cr(
	codigo_proyecto char(5) not null,
	dui_cliente char(10) not null,
	dui_miembro_gestion char(10) not null,
	descuento money not null default 0,
	implantacion_fecha_inicio date not null,
	implantacion_precio money not null default 0,
	mantenimiento_periodicidad varchar(30) not null,
	mantenimiento_precio money not null default 0,
	pais char(2),
	constraint pk_contrata primary key(codigo_proyecto, dui_cliente),
	constraint fk_contrata_cliente foreign key(dui_cliente) references cliente_cr(dui)
	ON delete cascade ON update cascade
);

\c ucasoft_bz
--TABLA cliente
CREATE TABLE cliente_bz(
	dui char(10) not null constraint pk_cliente primary key,
	denominacion varchar(100) not null,
	tipo varchar(40) not null check (tipo in ('Persona física','Empresa','ONG','Institución pública','Institución académica')),
	pais char(2) not null check (tipo in ('bz'))
);

--TABLA contrata
CREATE TABLE contrata_bz(
	codigo_proyecto char(5) not null,
	dui_cliente char(10) not null,
	dui_miembro_gestion char(10) not null,
	descuento money not null default 0,
	implantacion_fecha_inicio date not null,
	implantacion_precio money not null default 0,
	mantenimiento_periodicidad varchar(30) not null,
	mantenimiento_precio money not null default 0,
	pais char(2),
	constraint pk_contrata primary key(codigo_proyecto, dui_cliente),
	constraint fk_contrata_cliente foreign key(dui_cliente) references cliente_bz(dui)
	ON delete cascade ON update cascade
);

/*
	4
*/
CREATE USER fdw_ucasoft WITH PASSWORD 'pass';

\c ucasoft_sv
GRANT SELECT, INSERT, UPDATE, DELETE ON cliente_sv TO fdw_ucasoft;
GRANT SELECT, INSERT, UPDATE, DELETE ON contrata_sv TO fdw_ucasoft;

\c ucasoft_cr
GRANT SELECT, INSERT, UPDATE, DELETE ON cliente_cr TO fdw_ucasoft;
GRANT SELECT, INSERT, UPDATE, DELETE ON contrata_cr TO fdw_ucasoft;

\c ucasoft_bz
GRANT SELECT, INSERT, UPDATE, DELETE ON cliente_bz TO fdw_ucasoft;
GRANT SELECT, INSERT, UPDATE, DELETE ON contrata_bz TO fdw_ucasoft;
