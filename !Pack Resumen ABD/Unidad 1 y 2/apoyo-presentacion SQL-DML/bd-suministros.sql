drop table if exists suministrador cascade;
create table suministrador(
	id_s	varchar(10) not null,
	nombre_s varchar(100) not null,
	direccion text,
	ciudad	varchar(40) not null,
	constraint pk_suministrador primary key(id_s));

drop table if exists pieza cascade;
create table pieza(
	id_p	varchar(10) not null,
	nombre_p varchar(100) not null,
	peso	numeric(6,2),
	cantidad numeric(6) not null,
	constraint pk_pieza primary key (id_p));

drop table if exists suministro;
create table suministro(
	pieza_id_p varchar(10) not null,
	suministrador_id_s varchar(10) not null,
	constraint pk_suministro primary key(pieza_id_p,suministrador_id_s),
	constraint fk_suministro_suministrador foreign key (suministrador_id_s)
	references suministrador(id_s) on delete cascade on update cascade,
	constraint fk_suministro_pieza foreign key (pieza_id_p)
	references pieza(id_p) on delete cascade on update cascade);

drop table if exists departamento cascade;
create table departamento(
	codigo	char(5) not null,
	nombre varchar(100) not null,
	constraint pk_departamento primary key(codigo));
	
drop table if exists empleado cascade;
create table empleado(
	DUI	char(10) not null,
	nombre varchar(100) not null,
	salario money not null default 300,
	DUI_supervisor char(10), -- relación recursiva supervisa
	codigo_departamento char(5) not null, -- relación trabaja
	constraint pk_empleado primary key(DUI),
	constraint fk_empleado_supervisor foreign key (DUI_supervisor)
	references empleado(DUI) on delete restrict on update cascade,
	constraint fk_empleado_departamento foreign key (codigo_departamento)
	references departamento(codigo) on delete restrict on update cascade);

DROP VIEW SumiNombres;
CREATE OR REPLACE VIEW SumiNombres AS (
    SELECT nombre_s, nombre_p
    FROM Suministro,Suministrador,Pieza
    WHERE suministrador_id_s=id_s AND pieza_id_p=id_p);
  
DROP VIEW CantiSumin;  
CREATE OR REPLACE VIEW Cantidad (nombre_p,NumSumin)	AS (
    SELECT nombre_p, COUNT(*)
    FROM Suministro, Pieza
    WHERE pieza_id_p=id_p 
    GROUP BY nombre_p);
