
-- Ejercicio 1
---------------

\c template1

drop database if exists ucasoft;

create database ucasoft;

\c ucasoft uca

drop table if exists proyecto cascade;
create table proyecto(
    codigo	char(10) not null,
    denominacion varchar(100) not null,
    tipo varchar(30) not null check (tipo in ('Web','Venta_almacen','ERP')),
    desc_txt text,
    desc_doc bytea,
    monto_acumulado money not null default 0,
    url varchar(100),
    constraint pk_proyecto primary key (codigo));

--a
--b
drop table if exists cliente cascade;
create table cliente(
    DUI	char(10) not null,
    pais CHAR(2) NOT NULL,
    denominacion varchar(100) not null,
    tipo varchar(30) not null check (tipo in ('Persona física','Empresa','ONG','Institución pública','Institución académica'))
    --constraint pk_cliente primary key (DUI,pais)
    ) 
    PARTITION BY LIST(pais);

--c
CREATE TABLE cliente_def PARTITION OF cliente DEFAULT;
    
drop table if exists departamento cascade;
create table departamento(
    denominacion varchar(100) not null,
    DUI_miembro_representante	char(10) not null,
    constraint pk_departamento primary key (denominacion));
-- foreign key a miembro(DUI) postergada hasta la creación de la tabla miembro por referencia circular

drop table if exists version cascade;
create table version(
    codigo_proyecto	char(10) not null,
    numero numeric(4,2) not null,
    descripcion text,
    constraint pk_version_proyecto primary key (codigo_proyecto,numero),
    constraint fk_version_proyecto foreign key (codigo_proyecto)
    references proyecto(codigo) on delete cascade on update cascade);

drop table if exists superpachanga cascade;
create table superpachanga(
    nombre varchar(100) not null,
    lema varchar(100) not null,
    anyo smallint unique not null check (anyo between 2015 and 2100),
    constraint pk_superpachanga primary key (nombre));
    
drop table if exists miembro cascade;
create table miembro(
    DUI	char(10) not null,
    nombre varchar(100) not null,
    denominacion_departamento varchar(100) not null,
    constraint pk_miembro primary key (DUI),
    constraint fk_miembro_departamento foreign key (denominacion_departamento) 
    references departamento(denominacion) on delete restrict on update cascade deferrable);

-- Ojo, se establece el siguiente FK en este momento por referencia circular entre tablas
alter table departamento add constraint fk_departamento_miembro foreign key (DUI_miembro_representante) references miembro(DUI) on delete restrict on update cascade;
    
drop table if exists asiste cascade;
create table asiste(
    nombre_superpachanga varchar(100) not null,
    DUI_miembro	char(10) not null,
    constraint pk_asiste primary key (nombre_superpachanga,DUI_miembro),
    constraint fk_asiste_superpachanga foreign key (nombre_superpachanga) references superpachanga(nombre) on delete cascade on update cascade,
    constraint fk_asiste_miembro foreign key (DUI_miembro) references miembro(DUI) on delete cascade on update cascade);
    
drop table if exists proyecto_parte cascade;
create table proyecto_parte(
    codigo_macroproyecto	char(10) not null,
    codigo_subproyecto	char(10) not null,
    constraint pk_proyecto_parte primary key (codigo_macroproyecto,codigo_subproyecto),
    constraint fk_macroproyecto_proyecto foreign key (codigo_macroproyecto)
    references proyecto(codigo) on delete cascade on update cascade,
    constraint fk_subproyecto_proyecto foreign key (codigo_subproyecto)
    references proyecto(codigo) on delete cascade on update cascade);

drop table if exists presenta cascade;
create table presenta(
    codigo_proyecto	char(10) not null,
    nombre_superpachanga varchar(100) not null,
    DUI_miembro	char(10) not null,
    constraint pk_presenta primary key (codigo_proyecto,nombre_superpachanga), -- no incluimos DUI_miembro en la PK a propósito
    constraint fk_presenta_proyecto foreign key (codigo_proyecto) references proyecto(codigo) on delete cascade on update cascade,
    constraint fk_presenta_superpachanga foreign key (nombre_superpachanga) references superpachanga(nombre) on delete cascade on update cascade,
    constraint fk_presenta_miembro foreign key (DUI_miembro) references miembro(DUI) on delete cascade on update cascade
    );	

drop table if exists web cascade;
create table web(
    codigo_proyecto	char(10) not null,
    url varchar(100) not null,
    num_tablas smallint not null check (num_tablas >0),
    num_pantallas smallint not null check (num_pantallas >0),
    constraint pk_web primary key (codigo_proyecto),
    constraint fk_web_proyecto foreign key (codigo_proyecto)
    references proyecto(codigo) on delete cascade on update cascade deferrable);

drop table if exists venta_almacen cascade;
create table venta_almacen(
    codigo_proyecto	char(10) not null,
    num_clientes smallint not null check (num_clientes>0),
    constraint pk_venta_almacen primary key (codigo_proyecto),
    constraint fk_venta_almacen_proyecto foreign key (codigo_proyecto)
    references proyecto(codigo) on delete cascade on update cascade deferrable);

drop table if exists erp cascade;
create table erp(
    codigo_proyecto	char(10) not null,
    constraint pk_erp primary key (codigo_proyecto),
    constraint fk_erp_proyecto foreign key (codigo_proyecto)
    references proyecto(codigo) on delete cascade on update cascade deferrable);

drop table if exists ingenieria cascade;
create table ingenieria(
    DUI_miembro	char(10) not null,
    constraint pk_ingenieria primary key (DUI_miembro),
    constraint fk_ingenieria_miembro foreign key (DUI_miembro) references miembro(DUI) on delete cascade on update cascade deferrable
    );

drop table if exists gestion cascade;
create table gestion(
    DUI_miembro	char(10) not null,
    constraint pk_gestion primary key (DUI_miembro),
    constraint fk_gestion_miembro foreign key (DUI_miembro) references miembro(DUI) on delete cascade on update cascade deferrable
    );

drop table if exists ventas cascade;
create table ventas(
    DUI_miembro	char(10) not null,
    constraint pk_ventas primary key (DUI_miembro),
    constraint fk_ventas_miembro foreign key (DUI_miembro) references miembro(DUI) on delete cascade on update cascade deferrable
    );

drop table if exists desarrolla cascade;
create table desarrolla(
    codigo_proyecto	char(10) not null,
    DUI_miembro_ingenieria	char(10) not null,
    labor text,
    constraint pk_desarrolla primary key (codigo_proyecto,DUI_miembro_ingenieria),
    constraint fk_desarrolla_proyecto foreign key (codigo_proyecto) references proyecto(codigo) on delete cascade on update cascade,
    constraint fk_desarrolla_miembro_ingenieria foreign key (DUI_miembro_ingenieria) references ingenieria(DUI_miembro) on delete cascade on update cascade
    );	
    
drop table if exists modulo_erp cascade;
create table modulo_erp(
    codigo_proyecto_erp	char(10) not null,
    numero smallint not null,
    descripcion varchar(100) not null,
    constraint pk_modulo_erp primary key (codigo_proyecto_erp,numero,descripcion),
    constraint fk_modulo_erp_erp foreign key (codigo_proyecto_erp)
    references erp(codigo_proyecto) on delete cascade on update cascade);

--d
--e
drop table if exists contrata cascade;
create table contrata(
    codigo_proyecto	char(10) not null,
    DUI_cliente	char(10) not null,
    pais_cliente char(2) not null,
    DUI_miembro_gestion	char(10) not null,
    descuento money not null default 0,
    implantacion_fecha_inicio date not null,
    implantacion_precio money not null,
    mantenimiento_periodicidad varchar(40) not null check (mantenimiento_periodicidad in ('Mensual','Bimestral','Trimestral','Cuatrimestral','Semestral','Anual')),
    mantenimiento_precio money not null
    --constraint pk_contrata primary key (codigo_proyecto,DUI_cliente,pais_cliente), -- DUI_miembro_gestion omitido a propósito
    --constraint fk_contrata_proyecto foreign key (codigo_proyecto) references proyecto(codigo) on delete cascade on update cascade,
    --constraint fk_contrata_cliente foreign key (DUI_cliente,pais_cliente) references cliente(DUI,pais) on delete cascade on update cascade,
    --constraint fk_contrata_miembro_gestion foreign key (DUI_miembro_gestion) references gestion(DUI_miembro) on delete cascade on update cascade
    ) PARTITION BY LIST(pais_cliente);	

--f
CREATE TABLE contrata_def PARTITION OF contrata DEFAULT;

--d
--g
drop table if exists atiende cascade;
create table atiende(
    codigo_proyecto	char(10) not null,
    DUI_cliente	char(10) not null,
    pais_cliente char(2) not null,
    DUI_miembro_ventas	char(10) not null,
    constraint pk_atiende primary key (codigo_proyecto,DUI_cliente,pais_cliente,DUI_miembro_ventas),
    constraint fk_atiende_proyecto foreign key (codigo_proyecto) references proyecto(codigo) on delete cascade on update cascade,
    --constraint fk_atiende_cliente foreign key (DUI_cliente,pais_cliente) references cliente(DUI,pais) on delete cascade on update cascade,
    constraint fk_atiende_miembro_ventas foreign key (DUI_miembro_ventas) references ventas(DUI_miembro) on delete cascade on update cascade
    );	


-- Ejercicio 2
---------------

\c template1 uca

drop database if exists ucasoft_sv;
create database ucasoft_sv;
drop database if exists ucasoft_cr;
create database ucasoft_cr;
drop database if exists ucasoft_bz;
create database ucasoft_bz;

-- Ejercicio 3
---------------

\c ucasoft_sv uca

drop table if exists cliente_sv cascade;
create table cliente_sv(
    DUI	char(10) not null,
    pais CHAR(2) NOT NULL check (pais IN ('sv')),
    denominacion varchar(100) not null,
    tipo varchar(30) not null check (tipo in ('Persona física','Empresa','ONG','Institución pública','Institución académica')),
    constraint pk_cliente_sv primary key (DUI,pais)) ;
    
drop table if exists contrata_sv cascade;
create table contrata_sv(
    codigo_proyecto	char(10) not null,
    DUI_cliente	char(10) not null,
    pais_cliente char(2) not null,
    DUI_miembro_gestion	char(10) not null,
    descuento money not null default 0,
    implantacion_fecha_inicio date not null,
    implantacion_precio money not null,
    mantenimiento_periodicidad varchar(40) not null check (mantenimiento_periodicidad in ('Mensual','Bimestral','Trimestral','Cuatrimestral','Semestral','Anual')),
    mantenimiento_precio money not null,
    constraint pk_contrata_sv primary key (codigo_proyecto,DUI_cliente,pais_cliente), -- DUI_miembro_gestion omitido a propósito
    --constraint fk_contrata_proyecto foreign key (codigo_proyecto) references proyecto(codigo) on delete cascade on update cascade,
    constraint fk_contrata_sv_cliente_sv foreign key (DUI_cliente,pais_cliente) references cliente_sv(DUI,pais) on delete cascade on update cascade
    --constraint fk_contrata_miembro_gestion foreign key (DUI_miembro_gestion) references gestion(DUI_miembro) on delete cascade on update cascade
    );    

\c ucasoft_cr uca

drop table if exists cliente_cr cascade;
create table cliente_cr(
    DUI	char(10) not null,
    pais CHAR(2) NOT NULL check (pais IN ('cr')),
    denominacion varchar(100) not null,
    tipo varchar(30) not null check (tipo in ('Persona física','Empresa','ONG','Institución pública','Institución académica')),
    constraint pk_cliente_cr primary key (DUI,pais)) ;
    
drop table if exists contrata_cr cascade;
create table contrata_cr(
    codigo_proyecto	char(10) not null,
    DUI_cliente	char(10) not null,
    pais_cliente char(2) not null,
    DUI_miembro_gestion	char(10) not null,
    descuento money not null default 0,
    implantacion_fecha_inicio date not null,
    implantacion_precio money not null,
    mantenimiento_periodicidad varchar(40) not null check (mantenimiento_periodicidad in ('Mensual','Bimestral','Trimestral','Cuatrimestral','Semestral','Anual')),
    mantenimiento_precio money not null,
    constraint pk_contrata_cr primary key (codigo_proyecto,DUI_cliente,pais_cliente), -- DUI_miembro_gestion omitido a propósito
    --constraint fk_contrata_proyecto foreign key (codigo_proyecto) references proyecto(codigo) on delete cascade on update cascade,
    constraint fk_contrata_cr_cliente_cr foreign key (DUI_cliente,pais_cliente) references cliente_cr(DUI,pais) on delete cascade on update cascade
    --constraint fk_contrata_miembro_gestion foreign key (DUI_miembro_gestion) references gestion(DUI_miembro) on delete cascade on update cascade
    );
    
\c ucasoft_bz uca

drop table if exists cliente_bz cascade;
create table cliente_bz(
    DUI	char(10) not null,
    pais CHAR(2) NOT NULL check (pais IN ('bz')),
    denominacion varchar(100) not null,
    tipo varchar(30) not null check (tipo in ('Persona física','Empresa','ONG','Institución pública','Institución académica')),
    constraint pk_cliente_bz primary key (DUI,pais)) ;
    
drop table if exists contrata_bz cascade;
create table contrata_bz(
    codigo_proyecto	char(10) not null,
    DUI_cliente	char(10) not null,
    pais_cliente char(2) not null,
    DUI_miembro_gestion	char(10) not null,
    descuento money not null default 0,
    implantacion_fecha_inicio date not null,
    implantacion_precio money not null,
    mantenimiento_periodicidad varchar(40) not null check (mantenimiento_periodicidad in ('Mensual','Bimestral','Trimestral','Cuatrimestral','Semestral','Anual')),
    mantenimiento_precio money not null,
    constraint pk_contrata_bz primary key (codigo_proyecto,DUI_cliente,pais_cliente), -- DUI_miembro_gestion omitido a propósito
    --constraint fk_contrata_proyecto foreign key (codigo_proyecto) references proyecto(codigo) on delete cascade on update cascade,
    constraint fk_contrata_bz_cliente_bz foreign key (DUI_cliente,pais_cliente) references cliente_bz(DUI,pais) on delete cascade on update cascade
    --constraint fk_contrata_miembro_gestion foreign key (DUI_miembro_gestion) references gestion(DUI_miembro) on delete cascade on update cascade
    );
    
-- Ejercicio 4
---------------

\c - postgres

CREATE USER fdw_user WITH PASSWORD 'secretito';

\c ucasoft_sv uca
GRANT SELECT, INSERT, UPDATE, DELETE ON TABLE cliente_sv,contrata_sv TO fdw_user;

\c ucasoft_cr uca
GRANT SELECT, INSERT, UPDATE, DELETE ON TABLE cliente_cr,contrata_cr TO fdw_user;

\c ucasoft_bz uca
GRANT SELECT, INSERT, UPDATE, DELETE ON TABLE cliente_bz,contrata_bz TO fdw_user;

-- Ejercicio 5
---------------

\c ucasoft postgres

-- a
CREATE EXTENSION postgres_fdw;

-- b
GRANT USAGE ON FOREIGN DATA WRAPPER postgres_fdw TO uca;

-- c
CREATE SERVER remoto_sv FOREIGN DATA WRAPPER postgres_fdw OPTIONS (dbname 'ucasoft_sv', host 'localhost', port '5432');
CREATE SERVER remoto_cr FOREIGN DATA WRAPPER postgres_fdw OPTIONS (dbname 'ucasoft_cr', host 'localhost', port '5432');
CREATE SERVER remoto_bz FOREIGN DATA WRAPPER postgres_fdw OPTIONS (dbname 'ucasoft_bz', host 'localhost', port '5432');

-- d
GRANT USAGE ON FOREIGN SERVER remoto_sv TO uca;
GRANT USAGE ON FOREIGN SERVER remoto_cr TO uca;
GRANT USAGE ON FOREIGN SERVER remoto_bz TO uca;

-- e
CREATE USER MAPPING FOR uca SERVER remoto_sv OPTIONS (user 'fdw_user', password 'secretito');
CREATE USER MAPPING FOR uca SERVER remoto_cr OPTIONS (user 'fdw_user', password 'secretito');
CREATE USER MAPPING FOR uca SERVER remoto_bz OPTIONS (user 'fdw_user', password 'secretito');

-- Ejercicio 6
---------------

\c ucasoft uca

CREATE FOREIGN TABLE cliente_sv PARTITION OF cliente FOR VALUES IN ('sv') SERVER remoto_sv;
CREATE FOREIGN TABLE cliente_cr PARTITION OF cliente FOR VALUES IN ('cr') SERVER remoto_cr;
CREATE FOREIGN TABLE cliente_bz PARTITION OF cliente FOR VALUES IN ('bz') SERVER remoto_bz;

CREATE FOREIGN TABLE contrata_sv PARTITION OF contrata FOR VALUES IN ('sv') SERVER remoto_sv;
CREATE FOREIGN TABLE contrata_cr PARTITION OF contrata FOR VALUES IN ('cr') SERVER remoto_cr;
CREATE FOREIGN TABLE contrata_bz PARTITION OF contrata FOR VALUES IN ('bz') SERVER remoto_bz;


-- Ejercicio 7
---------------
    
insert into proyecto values ('W-2016-1','Web DEI','Web',null,null,1500,'http://dei.uca.edu.sv');
insert into proyecto values ('W-2017-1','Web UCA','Web',null,null,3500,'http://www.uca.edu.sv');
insert into proyecto values ('W-2017-2','Web salud.gob.sv','Web',null,null,3000,'http://www.salud.gob.sv');
insert into proyecto values ('W-2018-1','Web superpachanga.ucasoft.com','Web',null,null,0,'http://superpachanga.ucasoft.com');
insert into proyecto values ('W-2018-2','aulavirt','Web',null,null,18000,'http://dei.uca.edu.sv/aulavirt');
insert into proyecto values ('V-2017-1','teubi.co','Venta_almacen',null,null,1000,null);
insert into proyecto values ('V-2018-1','supernoelecto','Venta_almacen',null,null,80000,null);
insert into proyecto values ('V-2018-2','ualmar','Venta_almacen',null,null,50000,null);
insert into proyecto values ('V-2018-3','despensadedoñaines','Venta_almacen',null,null,20000,null);
insert into proyecto values ('E-2018-1','powerrepuestos','ERP',null,null,40000,null);
insert into proyecto values ('E-2018-2','laatencao','ERP',null,null,50000,null);
insert into proyecto values ('E-2019-1','simon','ERP',null,null,90000,null);
insert into proyecto values ('E-2019-2','moonbucks','ERP',null,null,45000,null);

insert into cliente values ('01234567-8','sv','Carlos Juarez','Institución académica');
insert into cliente values ('12345678-9','es','Andreu Oliva','Institución académica');
insert into cliente values ('23456789-0','sv','María Isabel Rodríguez','Institución pública');
insert into cliente values ('34567890-1','hn','Guillermo Pérez','Empresa');
insert into cliente values ('45678901-2','ni','Mario Gómez','Empresa');
insert into cliente values ('56789012-3','bz','Charly Alley','Empresa');
insert into cliente values ('67890123-4','cr','Eduardo Solórzano','Empresa');
insert into cliente values ('78901234-5','cr','Manuel Goreiro','Empresa');
insert into cliente values ('89012345-6','pa','Kevin Ojst','Empresa');
insert into cliente values ('90123456-7','gt','Mario Simon','Empresa');
insert into cliente values ('01123456-7','ni','Yey Yey Simon','Empresa');
insert into cliente values ('11234567-8','bz','Kevin Jimson','Empresa');

insert into version values ('W-2016-1',01.00);
insert into version values ('W-2016-1',01.10);
insert into version values ('W-2016-1',02.00);
insert into version values ('W-2017-1',01.00);
insert into version values ('W-2017-1',02.00);
insert into version values ('W-2017-2',01.00);
insert into version values ('W-2018-1',01.00);
insert into version values ('W-2018-2',01.00);
insert into version values ('W-2018-2',01.10);
insert into version values ('W-2018-2',01.20);
insert into version values ('V-2017-1',01.00);
insert into version values ('V-2017-1',01.10);
insert into version values ('V-2017-1',01.20);
insert into version values ('V-2017-1',02.00);
insert into version values ('V-2018-1',01.00);
insert into version values ('V-2018-2',01.00);
insert into version values ('V-2018-3',01.00);
insert into version values ('E-2018-1',01.00);
insert into version values ('E-2018-2',01.00);
insert into version values ('E-2019-1',01.00);
insert into version values ('E-2019-1',02.00);
insert into version values ('E-2019-1',03.00);
insert into version values ('E-2019-1',03.20);
insert into version values ('E-2019-2',01.00);
    
insert into superpachanga values('El gran despije','Mañana no existe',2015);
insert into superpachanga values('Still alive','Siempre insensato, nunca ininsensato',2016);
insert into superpachanga values('La vida es una tómbola','De luz y de coloooor',2017);
insert into superpachanga values('Secret level unlocked','Lets play!',2018);
insert into superpachanga values('Más madera','Dijo Groucho',2019);

-- Transacción necesaria por referencia circular.
BEGIN;

SET CONSTRAINTS fk_miembro_departamento DEFERRED;

insert into miembro values('04926243-5','Ana Ramírez','Ventas');
insert into miembro values('12345678-1','Manolo Lama','Ventas');
insert into miembro values('34345578-2','Esmeralda Alonso','Ventas');
insert into miembro values('54235576-4','Juan Luque','Ventas');
insert into miembro values('02112463-5','Susana Cantor','Gestión');
insert into miembro values('53463278-1','Pedro Santos','Gestión');
insert into miembro values('34531178-8','Carolina Flores','Gestión');
insert into miembro values('22329787-2','Lucio Suárez','Gestión');
insert into miembro values('89326243-7','Martín Deras','Ingeniería');
insert into miembro values('72234278-3','Ramón Pérez','Ingeniería');
insert into miembro values('24455578-6','Clara Datas','Ingeniería');
insert into miembro values('54232478-2','Magdalena Díaz','Ingeniería');
insert into miembro values('42334528-3','Antonio López','Ingeniería');	
    
insert into departamento values ('Ventas','04926243-5');
insert into departamento values ('Gestión','34531178-8');
insert into departamento values ('Ingeniería','24455578-6');

COMMIT;
    
insert into asiste values('El gran despije','04926243-5');
insert into asiste values('El gran despije','12345678-1');
insert into asiste values('El gran despije','34345578-2');
insert into asiste values('El gran despije','54235576-4');
insert into asiste values('El gran despije','02112463-5');
insert into asiste values('El gran despije','53463278-1');
insert into asiste values('El gran despije','34531178-8');
insert into asiste values('El gran despije','22329787-2');
insert into asiste values('El gran despije','89326243-7');
insert into asiste values('El gran despije','72234278-3');
insert into asiste values('El gran despije','24455578-6');
insert into asiste values('El gran despije','54232478-2');
insert into asiste values('El gran despije','42334528-3');
insert into asiste values('Still alive','04926243-5');
insert into asiste values('Still alive','12345678-1');
insert into asiste values('Still alive','54235576-4');
insert into asiste values('Still alive','02112463-5');
insert into asiste values('Still alive','53463278-1');
insert into asiste values('Still alive','34531178-8');
insert into asiste values('Still alive','22329787-2');
insert into asiste values('Still alive','89326243-7');
insert into asiste values('Still alive','72234278-3');
insert into asiste values('Still alive','24455578-6');
insert into asiste values('Still alive','54232478-2');
insert into asiste values('Still alive','42334528-3');
insert into asiste values('La vida es una tómbola','04926243-5');
insert into asiste values('La vida es una tómbola','12345678-1');
insert into asiste values('La vida es una tómbola','54235576-4');
insert into asiste values('La vida es una tómbola','02112463-5');
insert into asiste values('La vida es una tómbola','53463278-1');
insert into asiste values('La vida es una tómbola','22329787-2');
insert into asiste values('La vida es una tómbola','89326243-7');
insert into asiste values('La vida es una tómbola','72234278-3');
insert into asiste values('La vida es una tómbola','54232478-2');
insert into asiste values('La vida es una tómbola','42334528-3');
insert into asiste values('Secret level unlocked','04926243-5');
insert into asiste values('Secret level unlocked','12345678-1');
insert into asiste values('Secret level unlocked','34345578-2');
insert into asiste values('Secret level unlocked','54235576-4');
insert into asiste values('Secret level unlocked','02112463-5');
insert into asiste values('Secret level unlocked','53463278-1');
insert into asiste values('Secret level unlocked','72234278-3');
insert into asiste values('Secret level unlocked','24455578-6');
insert into asiste values('Secret level unlocked','54232478-2');
insert into asiste values('Secret level unlocked','42334528-3');
insert into asiste values('Más madera','04926243-5');
insert into asiste values('Más madera','54235576-4');
insert into asiste values('Más madera','02112463-5');
insert into asiste values('Más madera','53463278-1');
insert into asiste values('Más madera','34531178-8');
insert into asiste values('Más madera','22329787-2');
insert into asiste values('Más madera','89326243-7');
insert into asiste values('Más madera','54232478-2');
insert into asiste values('Más madera','42334528-3');

insert into proyecto_parte values ('W-2017-1','W-2016-1');
insert into proyecto_parte values ('W-2016-1','W-2018-2');
insert into proyecto_parte values ('V-2018-1','V-2017-1');
insert into proyecto_parte values ('V-2018-1','V-2018-2');
insert into proyecto_parte values ('E-2018-2','E-2018-1');
insert into proyecto_parte values ('V-2018-3','E-2019-1');

insert into presenta values('W-2017-1','El gran despije','02112463-5');
insert into presenta values('V-2018-3','Still alive','24455578-6');
insert into presenta values('V-2018-1','La vida es una tómbola','42334528-3');
insert into presenta values('E-2018-2','Secret level unlocked','53463278-1');
insert into presenta values('W-2018-2','Más madera','02112463-5');
    
insert into web values ('W-2016-1','http://dei.uca.edu.sv',35,20);
insert into web values ('W-2017-1','http://www.uca.edu.sv',45,50);
insert into web values ('W-2017-2','http://www.salud.gob.sv',43,40);
insert into web values ('W-2018-1','http://superpachanga.ucasoft.com',10,6);
insert into web values ('W-2018-2','http://dei.uca.edu.sv/aulavirt',60,30);

insert into venta_almacen values ('V-2017-1',10);
insert into venta_almacen values ('V-2018-1',400);
insert into venta_almacen values ('V-2018-2',20);
insert into venta_almacen values ('V-2018-3',4);
    
insert into erp values ('E-2018-1');
insert into erp values ('E-2018-2');
insert into erp values ('E-2019-1');
insert into erp values ('E-2019-2');

insert into ingenieria values('89326243-7');
insert into ingenieria values('72234278-3');
insert into ingenieria values('24455578-6');
insert into ingenieria values('54232478-2');
insert into ingenieria values('42334528-3');	

insert into gestion values('02112463-5');
insert into gestion values('53463278-1');
insert into gestion values('34531178-8');
insert into gestion values('22329787-2');

insert into ventas values('04926243-5');
insert into ventas values('12345678-1');
insert into ventas values('34345578-2');
insert into ventas values('54235576-4');

insert into desarrolla values ('W-2016-1','89326243-7','Coordinación');
insert into desarrolla values ('W-2016-1','72234278-3','Desarrollo');
insert into desarrolla values ('W-2016-1','42334528-3','Testing');
insert into desarrolla values ('W-2017-1','89326243-7','Coordinación');
insert into desarrolla values ('W-2017-1','24455578-6','Desarrollo');
insert into desarrolla values ('W-2017-1','42334528-3','Testing');
insert into desarrolla values ('W-2017-2','89326243-7','Coordinación');
insert into desarrolla values ('W-2017-2','72234278-3','Desarrollo');
insert into desarrolla values ('W-2018-1','54232478-2','Coordinación');
insert into desarrolla values ('W-2018-1','24455578-6','Desarrollo');
insert into desarrolla values ('W-2018-2','89326243-7','Coordinación');
insert into desarrolla values ('W-2018-2','72234278-3','Desarrollo');
insert into desarrolla values ('W-2018-2','24455578-6','Desarrollo');
insert into desarrolla values ('W-2018-2','54232478-2','Testing');
insert into desarrolla values ('V-2017-1','72234278-3','Coordinación');
insert into desarrolla values ('V-2017-1','24455578-6','Desarrollo');
insert into desarrolla values ('V-2017-1','42334528-3','Testing');
insert into desarrolla values ('V-2018-1','24455578-6','Coordinación');
insert into desarrolla values ('V-2018-1','54232478-2','Desarrollo');
insert into desarrolla values ('V-2018-2','89326243-7','Coordinación');
insert into desarrolla values ('V-2018-2','54232478-2','Desarrollo');
insert into desarrolla values ('V-2018-2','42334528-3','Testing');
insert into desarrolla values ('V-2018-3','54232478-2','Coordinación');
insert into desarrolla values ('V-2018-3','89326243-7','Desarrollo');
insert into desarrolla values ('E-2018-1','89326243-7','Coordinación');
insert into desarrolla values ('E-2018-1','72234278-3','Desarrollo');
insert into desarrolla values ('E-2018-1','54232478-2','Testing');
insert into desarrolla values ('E-2018-2','42334528-3','Coordinación');
insert into desarrolla values ('E-2018-2','24455578-6','Desarrollo');
insert into desarrolla values ('E-2019-1','89326243-7','Coordinación');
insert into desarrolla values ('E-2019-1','72234278-3','Desarrollo');
insert into desarrolla values ('E-2019-1','42334528-3','Testing');
insert into desarrolla values ('E-2019-2','72234278-3','Coordinación');
insert into desarrolla values ('E-2019-2','24455578-6','Desarrollo');
insert into desarrolla values ('E-2019-2','54232478-2','Testing');
    
insert into modulo_erp values ('E-2018-1',1,'RRHH');
insert into modulo_erp values ('E-2018-1',2,'CRM');
insert into modulo_erp values ('E-2018-1',3,'Finanzas');
insert into modulo_erp values ('E-2018-2',1,'RRHH');
insert into modulo_erp values ('E-2018-2',2,'CRM');
insert into modulo_erp values ('E-2019-1',2,'CRM');
insert into modulo_erp values ('E-2019-1',3,'Finanzas');
insert into modulo_erp values ('E-2019-2',1,'RRHH');
insert into modulo_erp values ('E-2019-2',2,'CRM');
insert into modulo_erp values ('E-2019-2',3,'Finanzas');
    
insert into contrata values ('W-2016-1','01234567-8','sv','02112463-5',0,'3/10/2015',1500,'Trimestral',200);
insert into contrata values ('W-2017-1','01234567-8','sv','02112463-5',0,'18/1/2017',1500,'Bimestral',200);
insert into contrata values ('W-2017-1','12345678-9','es','02112463-5',0,'23/12/2018',2000,'Trimestral',250);
insert into contrata values ('W-2017-2','23456789-0','sv','53463278-1',0,'17/2/2016',3000,'Trimestral',200);
insert into contrata values ('W-2018-1','34567890-1','hn','02112463-5',0,'1/4/2016',0,'Anual',0);
insert into contrata values ('W-2018-2','01234567-8','sv','53463278-1',0,'5/4/2017',18000,'Mensual',200);
insert into contrata values ('V-2017-1','45678901-2','ni','34531178-8',0,'8/3/2018',1000,'Semestral',200);
insert into contrata values ('V-2018-1','56789012-3','bz','34531178-8',0,'10/6/2015',80000,'Bimestral',2000);
insert into contrata values ('V-2018-2','67890123-4','cr','34531178-8',0,'2/11/2016',50000,'Mensual',2500);
insert into contrata values ('V-2018-3','78901234-5','cr','34531178-8',0,'25/10/2016',20000,'Trimestral',1500);
insert into contrata values ('E-2018-1','89012345-6','pa','53463278-1',0,'23/12/2017',40000,'Bimestral',1500);
insert into contrata values ('E-2018-2','90123456-7','gt','53463278-1',0,'7/9/2018',50000,'Semestral',4000);
insert into contrata values ('E-2019-1','01123456-7','ni','22329787-2',0,'9/5/2019',90000,'Trimestral',2000);
insert into contrata values ('E-2019-2','11234567-8','bz','22329787-2',0,'11/1/2019',45000,'Trimestral',1000);

insert into atiende values ('W-2016-1','01234567-8','sv','04926243-5');
insert into atiende values ('W-2017-1','01234567-8','sv','04926243-5');
insert into atiende values ('W-2017-1','12345678-9','es','04926243-5');
insert into atiende values ('W-2017-2','23456789-0','sv','04926243-5');
insert into atiende values ('W-2017-2','23456789-0','sv','12345678-1');
insert into atiende values ('W-2018-1','34567890-1','hn','04926243-5');
insert into atiende values ('W-2018-2','01234567-8','sv','04926243-5');
insert into atiende values ('W-2018-2','01234567-8','sv','12345678-1');
insert into atiende values ('V-2017-1','45678901-2','ni','34345578-2');
insert into atiende values ('V-2018-1','56789012-3','bz','34345578-2');
insert into atiende values ('V-2018-2','67890123-4','cr','34345578-2');
insert into atiende values ('V-2018-3','78901234-5','cr','34345578-2');
insert into atiende values ('E-2018-1','89012345-6','pa','54235576-4');
insert into atiende values ('E-2018-1','89012345-6','pa','12345678-1');
insert into atiende values ('E-2018-2','90123456-7','gt','54235576-4');
insert into atiende values ('E-2018-2','90123456-7','gt','12345678-1');
insert into atiende values ('E-2019-1','01123456-7','ni','54235576-4');
insert into atiende values ('E-2019-1','01123456-7','ni','12345678-1');
insert into atiende values ('E-2019-2','11234567-8','bz','54235576-4');
insert into atiende values ('E-2019-2','11234567-8','bz','12345678-1');

\c ucasoft_sv
select * from contrata;
select * from cliente;

\c ucasoft_cr
select * from contrata;
select * from cliente;

\c ucasoft_bz
select * from contrata;
select * from cliente;

-- prueba de inserción abortada por violación de FK definida en la tabla remota
insert into contrata values ('E-2019-2','11234567-8','sv','22329787-2',0,'11/1/2019',45000,'Trimestral',1000);
