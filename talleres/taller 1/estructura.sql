--TABLA nivel
CREATE TABLE nivel(
    denominacion varchar(100) not null constraint pk_nivel primary key
);

--TABLA grado
CREATE TABLE grado(
    numero smallint not null constraint pk_grado primary key,
    denominacion_nivel varchar(100),
    constraint fk_nivel_grado foreign key(denominacion_nivel) references nivel(denominacion)
    ON delete cascade ON update cascade
);

--TABLA seccion
CREATE TABLE seccion(
    letra char(1) not null constraint pk_seccion primary key,
    grado smallint,
    constraint fk_grado_seccion foreign key(grado) references grado(numero)
    ON delete cascade ON update cascade
);

--TABLA edificio
CREATE TABLE edificio(
    denominacion varchar(100) not null constraint pk_edificio primary key
);

--TABLA aula
CREATE TABLE aula(
    nivel smallint not null,
    orden smallint not null,
    denominacion_edificio varchar(100),
    espacios int,
    constraint pk_aula primary key(nivel, orden),
    constraint fk_edificio_aula foreign key(denominacion_edificio) references edificio(denominacion)
    ON delete cascade ON update cascade
);

--TABLA clase
CREATE TABLE clase(
    codigo_aula smallint not null constraint pk_clase primary key
    constraint fk_aula_clase foreign key(codigo_aula) references aula()
    ON delete cascade ON update cascade
);

--TABLA lab-cc
CREATE TABLE lab-cc(
    codigo_aula smallint not null constraint pk_clase primary key
);

--TABLA docente
CREATE TABLE docente(
    dui char(10) not null constraint pk_docente primary key
);

--TABLA aulaXseccion
CREATE TABLE aulaxseccion(
);

--TABLA bitacora

--TABLA pago

--TABLA asignatura
CREATE TABLE asignatura(
    nombre varchar(30) not null constraint pk_asignatura primary key
);

--TABLA espacio
CREATE TABLE espacio(
    ident
);

--TABLA responsable

--TABLA empleado

--TABLA alumno

--TABLA subvencion

--TABLA pago

--TABLA semestre

--TABLA docente
