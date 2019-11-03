\c template1

drop database if exists taller2;

create database taller2;

\c taller2

drop table if exists alumno cascade;
create table alumno(
    NIE	char(10) not null,
    nombre varchar(100) not null,
    constraint pk_alumno primary key (NIE));

drop table if exists pago cascade;
create table pago(
    tipo	char(10) not null,
    numero smallint not null,
    constraint pk_pago primary key (tipo,numero));
    
drop table if exists año cascade;
create table año(
    numero	smallint not null,
    constraint pk_año primary key (numero));
    
drop table if exists talonario cascade;
create table talonario(
    NIE_alumno	char(10) not null,
    tipo_pago	char(10) not null,
    numero_pago smallint not null,
    numero_año  smallint not null,
    monto       money not null DEFAULT 0,
    fecha_emision   date not null,
    fecha_vencimiento date not null,
    fecha_pago  date,
    estado      char(10) not null check (estado IN ('Pendiente','Cancelado','Anulado')),
    constraint pk_talonario primary key (NIE_alumno,tipo_pago,numero_pago,numero_año),
    constraint fk_talonario_alumno foreign key (NIE_alumno)
    references alumno(NIE) on delete cascade on update cascade,
    constraint fk_talonario_pago foreign key (tipo_pago,numero_pago)
    references pago(tipo,numero) on delete cascade on update cascade,
    constraint fk_talonario_año foreign key (numero_año)
    references año(numero) on delete cascade on update cascade    
    );

-- Particiones de talonario
    
drop table if exists docente cascade;
create table docente(
    DUI	char(10) not null,
    nombre varchar(100) not null,
    constraint pk_docente primary key (DUI));
    
-- subclases profesor y estudiante 

drop table if exists responsable cascade;
create table responsable(
    DUI	char(10) not null,
    nombre varchar(100) not null,
    constraint pk_responsable primary key (DUI));
    
-- subclases empleado (oficina y teléfono UCA) y estudiante

drop table if exists nivel cascade;
create table nivel(
    denominacion	char(10) not null,
    constraint pk_nivel primary key (denominacion));

drop table if exists grado cascade;
create table grado(
    denominacion_nivel	char(10) not null,
    numero  SMALLINT not null,
    constraint pk_grado primary key (denominacion_nivel,numero),
    constraint fk_grado_nivel foreign key (denominacion_nivel)
    references nivel(denominacion) on delete cascade on update cascade
    );

drop table if exists seccion cascade;
create table seccion(
    denominacion_nivel_grado	char(10) not null,
    numero_grado  SMALLINT not null,
    letra       char(1) not null,
    constraint pk_seccion primary key (denominacion_nivel_grado,numero_grado,letra),
    constraint fk_seccion_grado foreign key (denominacion_nivel_grado,numero_grado)
    references grado(denominacion_nivel,numero) on delete cascade on update cascade
    );

drop table if exists seccionxaula cascade;
create table seccionxaula(
    denominacion_nivel_grado_seccion	char(10) not null,
    numero_grado_seccion  SMALLINT not null,
    letra_seccion       char(1) not null,
    constraint pk_seccionxaula primary key (denominacion_nivel_grado_seccion,numero_grado_seccion,letra_seccion),
    constraint fk_seccionxaula_seccion foreign key (denominacion_nivel_grado_seccion,numero_grado_seccion,letra_seccion)
    references seccion(denominacion_nivel_grado,numero_grado,letra) on delete cascade on update cascade
    );

drop table if exists seccionxasignatura cascade;
create table seccionxasignatura(
    denominacion_nivel_grado_seccion	char(10) not null,
    numero_grado_seccion  SMALLINT not null,
    letra_seccion       char(1) not null,
    constraint pk_seccionxasignatura primary key (denominacion_nivel_grado_seccion,numero_grado_seccion,letra_seccion),
    constraint fk_seccionxasignatura_seccion foreign key (denominacion_nivel_grado_seccion,numero_grado_seccion,letra_seccion)
    references seccion(denominacion_nivel_grado,numero_grado,letra) on delete cascade on update cascade
    );
    
drop table if exists matricula cascade;
create table matricula(
    NIE_alumno	char(10) not null,   
    denominacion_nivel_grado_seccion	char(10) not null,
    numero_grado_seccion  SMALLINT not null,
    letra_seccion       char(1) not null,
    numero_año smallint not null,
    constraint pk_matricula primary key (NIE_alumno,denominacion_nivel_grado_seccion,numero_grado_seccion,letra_seccion,numero_año),
    constraint fk_matricula_alumno foreign key (NIE_alumno)
    references alumno(NIE) on delete cascade on update cascade,
    constraint fk_matricula_seccion foreign key (denominacion_nivel_grado_seccion,numero_grado_seccion,letra_seccion)
    references seccion(denominacion_nivel_grado,numero_grado,letra) on delete cascade on update cascade,
    constraint fk_matricula_año foreign key (numero_año)
    references año(numero) on delete cascade on update cascade
    );

drop table if exists edificio cascade;
create table edificio(
    denominacion	char(10) not null,
    ubicación varchar(100) not null,
    constraint pk_edificio primary key (denominacion));

drop table if exists acceso cascade;
create table acceso(
    NIE_alumno	char(10) not null,
    denominacion_edificio	char(10) not null,
    fecha date not null,
    hora_entrada time,
    hora_salida time,
    constraint pk_acceso primary key (NIE_alumno,denominacion_edificio,fecha),
    constraint fk_acceso_alumno foreign key (NIE_alumno)
    references alumno(NIE) on delete cascade on update cascade,
    constraint fk_acceso_edificio foreign key (denominacion_edificio)
    references edificio(denominacion) on delete cascade on update cascade);
