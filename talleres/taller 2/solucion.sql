-- 1. Estructuras de herencia las especializaciones de Responsable y Docente.

    -- Docente
drop table if exists docente cascade;
create table docente(
    DUI	char(10)    not null,
    nombre varchar(100) not null,
    constraint pk_docente primary key (DUI)
);

drop table if exists profesor cascade;
create table profesor(
    constraint pk_profesor primary key (DUI)
) INHERITS (docente);

drop table if exists estudiante cascade;
create table estudiante(
    constraint pk_estudiante primary key (DUI)
) INHERITS (docente);

    -- Responsable
drop table if exists responsable cascade;
create table responsable(
    DUI	char(10) not null,
    nombre varchar(100) not null,
    constraint pk_responsable primary key (DUI)
);

drop table if exists estudiante_responsable cascade;
create table estudiante_responsable(
    constraint pk_estudiante_responsable primary key (DUI)
) INHERITS (responsable);

drop table if exists empleado_responsable cascade;
create table empleado_responsable(
    oficina VARCHAR(40) not null,
    telefono VARCHAR(10),
    constraint pk_empleado_responsable primary key (DUI)
) INHERITS (responsable);
