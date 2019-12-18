create table alumno(
    NIE char(10) not null,
    nombre varchar(100) not null,
    constraint pk_alumno primary key (NIE));
    
create table año(
    numero  smallint not null,
    constraint pk_año primary key (numero));

create table nivel(
    denominacion    char(10) not null,
    constraint pk_nivel primary key (denominacion));

create table grado(
    denominacion_nivel char(10) not null,
    numero  smallint not null,
    constraint pk_grado primary key (denominacion_nivel,numero),
    constraint fk_grado_nivel foreign key (denominacion_nivel)
    references nivel(denominacion) on delete cascade on update cascade
    );

create table asignatura(
    denominacion_nivel_grado char(10) not null,
    numero_grado smallint not null,
    numero_año smallint not null,
    nombre varchar(100) not null,
    constraint pk_asignatura primary key (denominacion_nivel_grado,numero_grado,numero_año,nombre),
    constraint fk_asignatura_grado foreign key (denominacion_nivel_grado,numero_grado)
    references grado(denominacion_nivel,numero) on delete restrict on update cascade,
    constraint fk_asignatura_año foreign key (numero_año)
    references año(numero) on delete restrict on update cascade
    );
    
create type tipo_nota as (
    numerica smallint,
    cualitativa varchar(20)
);

create table inscripcion(
    NIE_alumno char(10) not null,   
    denominacion_nivel_grado_asignatura char(10) not null,
    numero_grado_asignatura smallint not null,
    numero_año_asignatura smallint not null,
    nombre_asignatura varchar(100) not null,
    notas tipo_nota[],
    constraint pk_inscripcion primary key (NIE_alumno,denominacion_nivel_grado_asignatura,numero_grado_asignatura,numero_año_asignatura,nombre_asignatura),
    constraint fk_inscripcion_alumno foreign key (NIE_alumno)
    references alumno(NIE) on delete restrict on update cascade,
    constraint fk_inscripcion_asignatura foreign key (denominacion_nivel_grado_asignatura,numero_grado_asignatura,numero_año_asignatura,nombre_asignatura)
    references asignatura(denominacion_nivel_grado,numero_grado,numero_año,nombre) on delete restrict on update cascade
);
