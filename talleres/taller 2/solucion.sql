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

-- 2. La tabla dedicada a registrar los pagos (Talonario) se prevé que crezca enormemente. Realice el particionamiento de dicha tabla por rango (considere 3 particiones, una para cada año, 2020, 2021, 2022 y otra por default).

drop table if exists talonario cascade;
create table talonario(
    NIE_alumno  char(10) not null,
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
) PARTITION BY LIST (numero_año);

CREATE TABLE talonario_2020 PARTITION OF talonario FOR VALUES IN (2020);
CREATE TABLE talonario_2021 PARTITION OF talonario FOR VALUES IN (2021);
CREATE TABLE talonario_2022 PARTITION OF talonario FOR VALUES IN (2022);
CREATE TABLE talonario_default PARTITION OF talonario DEFAULT;
