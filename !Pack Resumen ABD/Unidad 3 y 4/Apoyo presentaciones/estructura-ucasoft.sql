
\c template1

drop database if exists ucasoft;

create database ucasoft;

\c ucasoft

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

drop table if exists cliente cascade;
create table cliente(
    DUI	char(10) not null,
    denominacion varchar(100) not null,
    tipo varchar(30) not null check (tipo in ('Persona física','Empresa','ONG','Institución pública','Institución académica')),
    constraint pk_cliente primary key (DUI));

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

drop table if exists contrata cascade;
create table contrata(
    codigo_proyecto	char(10) not null,
    DUI_cliente	char(10) not null,
    DUI_miembro_gestion	char(10) not null,
    descuento money not null default 0,
    implantacion_fecha_inicio date not null,
    implantacion_precio money not null,
    mantenimiento_periodicidad varchar(40) not null check (mantenimiento_periodicidad in ('Mensual','Bimestral','Trimestral','Cuatrimestral','Semestral','Anual')),
    mantenimiento_precio money not null,
    constraint pk_contrata primary key (codigo_proyecto,DUI_cliente), -- DUI_miembro_gestion omitido a propósito
    constraint fk_contrata_proyecto foreign key (codigo_proyecto) references proyecto(codigo) on delete cascade on update cascade,
    constraint fk_contrata_cliente foreign key (DUI_cliente) references cliente(DUI) on delete cascade on update cascade,
    constraint fk_contrata_miembro_gestion foreign key (DUI_miembro_gestion) references gestion(DUI_miembro) on delete cascade on update cascade
    );	

drop table if exists atiende cascade;
create table atiende(
    codigo_proyecto	char(10) not null,
    DUI_cliente	char(10) not null,
    DUI_miembro_ventas	char(10) not null,
    constraint pk_atiende primary key (codigo_proyecto,DUI_cliente,DUI_miembro_ventas),
    constraint fk_atiende_proyecto foreign key (codigo_proyecto) references proyecto(codigo) on delete cascade on update cascade,
    constraint fk_atiende_cliente foreign key (DUI_cliente) references cliente(DUI) on delete cascade on update cascade,
    constraint fk_atiende_miembro_ventas foreign key (DUI_miembro_ventas) references ventas(DUI_miembro) on delete cascade on update cascade
    );	
