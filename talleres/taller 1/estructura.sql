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
    nivel_aula smallint not null,
    orden_aula smallint not null,
    constraint pk_clase primary key(nivel_aula, orden_aula),
    constraint fk_aula_clase foreign key(nivel_aula, orden_aula) references aula(nivel, orden)
    ON delete cascade ON update cascade
);

--TABLA laboratorios y centro de computo
CREATE TABLE lab_cc(
    nivel_aula smallint not null,
    orden_aula smallint not null,
    constraint pk_lab_cc primary key(nivel_aula, orden_aula),
    constraint fk_aula_lab_cc foreign key(nivel_aula, orden_aula) references aula(nivel, orden)
    ON delete cascade ON update cascade
);

--TABLA año
CREATE TABLE annio(
    numero int constraint pk_annio primary key
);

--TABLA docente
CREATE TABLE docente(
    dui char(10) not null constraint pk_docente primary key,
    nombre varchar(50),
    apellido varchar(50),
    edad int
);

--TABLA profesor
CREATE TABLE profesor(
    id int not null constraint pk_profesor primary key,
    dui_docente char(10),
    constraint fk_docente_profesor foreign key (dui_docente) references docente(dui)
    ON delete cascade ON update cascade
);

--TABLA asignatura
CREATE TABLE asignatura(
    denominacion varchar(30) not null constraint pk_asignatura primary key,
    grado smallint,
    annio int not null,
    constraint fk_grado_asignatura foreign key (grado) references grado(numero)
    ON delete cascade ON update cascade,
    constraint fk_annio_asignatura foreign key (annio) references annio(numero)
    ON delete cascade ON update cascade
);

--TABLA semestre
CREATE TABLE semestre(
    orden smallint constraint pk_semestre primary key,
    annio int not null,
    constraint fk_annio_semestre foreign key (annio) references annio(numero)
    ON delete cascade ON update cascade
);

--TABLA reserva de labs y centro de computo
CREATE TABLE reserva(
    id int not null constraint pk_reserva primary key,
    nivel_aula smallint not null,
    orden_aula smallint not null,
    dui_docente char(10) not null,
    fecha date,
    hora_inicio time,
    hora_fin time,
    constraint fk_aula_reserva foreign key (nivel_aula, orden_aula) references aula(nivel, orden)
    ON delete cascade ON update cascade,
    constraint fk_docente_reserva foreign key (dui_docente) references docente(dui)
    ON delete cascade ON update cascade
);

--TABLA aulaXseccion
CREATE TABLE aulaxseccion(
    seccion char(1) not null constraint pk_aulaxseccion primary key,
    nivel_aula smallint not null,
    orden_aula smallint not null,
    annio int not null,
    constraint fk_seccion_aulaxseccion foreign key (seccion) references seccion(letra)
    ON delete cascade ON update cascade,
    constraint fk_aula_aulaxseccion foreign key(nivel_aula, orden_aula) references clase(nivel_aula, orden_aula)
    ON delete cascade ON update cascade,
    constraint fk_annio_aulaxseccion foreign key (annio) references annio(numero)
    ON delete cascade ON update cascade
);

--TABLA aulaXasignatura
CREATE TABLE aulaxasignatura(
    seccion char(1) not null constraint pk_aulaxasignatura primary key,
    nivel_aula smallint not null,
    orden_aula smallint not null,
    denominacion_asignatura varchar(100) not null,
    annio int not null,
    constraint fk_seccion_aulaxasignatura foreign key (seccion) references seccion(letra)
    ON delete cascade ON update cascade,
    constraint fk_aula_aulaxasignatura foreign key(nivel_aula, orden_aula) references clase(nivel_aula, orden_aula)
    ON delete cascade ON update cascade,
    constraint fk_asignatura_aulaxasignatura foreign key (denominacion_asignatura) references asignatura(denominacion)
    ON delete cascade ON update cascade,
    constraint fk_annio_aulaxasignatura foreign key (annio) references annio(numero)
    ON delete cascade ON update cascade
);

--TABLA docenteXasignatura
CREATE TABLE docentexasignatura(
    dui_docente char(10) not null,
    denominacion_asignatura varchar(100) not null,
    annio int not null,
    rol varchar(30),
    constraint pk_docentexasignatura primary key (dui_docente, denominacion_asignatura),
    constraint fk_docente_docentexasignatura foreign key (dui_docente) references docente(dui)
    ON delete cascade ON update cascade,
    constraint fk_asignatura_docentexasignatura foreign key (denominacion_asignatura) references asignatura(denominacion)
    ON delete cascade ON update cascade,
    constraint fk_annio_docentexasignatura foreign key (annio) references annio(numero)
    ON delete cascade ON update cascade
);

--TABLA responsable de seccion
CREATE TABLE responsable_seccion(
    dui_docente char(10) not null,
    seccion char(1) not null,
    semestre smallint not null,
    constraint pk_responsable_seccion primary key (dui_docente, seccion, semestre),
    constraint fk_docente_responsable foreign key (dui_docente) references docente(dui)
    ON delete cascade ON update cascade,
    constraint fk_seccion_responsable foreign key (seccion) references seccion(letra)
    ON delete cascade ON update cascade,
    constraint fk_semestre_responsable foreign key (semestre) references semestre(orden)
    ON delete cascade ON update cascade
);

--TABLA alumno
CREATE TABLE alumno(
    nie int not null constraint pk_alumno primary key,
    nombre varchar(50),
    apellido varchar(50),
    edad int
);

--TABLA inscribe
CREATE TABLE inscribe(
    id int not null constraint pk_inscribe primary key,
    nie_alumno int not null,
    denominacion_asignatura varchar(100) not null,
    constraint fk_alumno_inscribe foreign key (nie_alumno) references alumno(nie)
    ON delete cascade ON update cascade,
    constraint fk_asignatura_inscribe foreign key (denominacion_asignatura) references asignatura(denominacion)
    ON delete cascade ON update cascade
);

--TABLA notas
CREATE TABLE nota(
    id_inscripcion int not null,
    nota_cualitativa char(1),
    nota_numerica smallint,
    constraint pk_nota primary key (id_inscripcion, nota_cualitativa, nota_numerica),
    constraint fk_inscribe_nota foreign key (id_inscripcion) references inscribe(id)
    ON delete cascade ON update cascade
);

--TABLA responsable de alumno
CREATE TABLE responsable_alumno(
    dui char(10) not null constraint pk_responsable_alumno primary key,
    nombre varchar(50),
    apellido varchar(50),
    edad int
);

--TABLA empleado
CREATE TABLE empleado(
    id int not null constraint pk_empleado primary key,
    dui_responsable char(10),
    oficina int,
    telefono int,
    constraint fk_responsable_empleado foreign key (dui_responsable) references responsable_alumno(dui)
    ON delete cascade ON update cascade
);

--TABLA estudiante, tabla "hija" que compartiran tanto RESPONSABLE_ALUMNO como DOCENTE
CREATE TABLE estudiante(
    id int not null constraint pk_estudiante primary key,
    dui_responsable char(10),
    dui_docente char(10),
    constraint fk_responsable_estudiante foreign key (dui_responsable) references responsable_alumno(dui)
    ON delete cascade ON update cascade,
    constraint fk_docente_estudiante foreign key (dui_docente) references docente(dui)
    ON delete cascade ON update cascade
);

--TABLA carrera
CREATE TABLE carrera(
    denominacion varchar(100) not null constraint pk_carrera primary key
);

--TABLA estudia
CREATE TABLE estudia(
    id_estudiante int not null,
    denominacion_carrera varchar(100),
    constraint pk_estudia primary key (id_estudiante, denominacion_carrera),
    constraint fk_estudiante_estudia foreign key (id_estudiante) references estudiante(id)
    ON delete cascade ON update cascade,
    constraint fk_carrera_estudia foreign key (denominacion_carrera) references carrera(denominacion)
    ON delete cascade ON update cascade
);

--TABLA subvencion
CREATE TABLE subvencion(
    id int not null constraint pk_subvencion primary key,
    cantidad money not null default 0
);

--TABLA otorga
CREATE TABLE otorga(
    nie_alumno int not null,
    id_subvencion int not null,
    annio int not null,
    constraint pk_otorga primary key (nie_alumno, id_subvencion),
    constraint fk_alumno_otorga foreign key (nie_alumno) references alumno(nie)
    ON delete cascade ON update cascade,
    constraint fk_subvencion_otorga foreign key (id_subvencion) references subvencion(id)
    ON delete cascade ON update cascade,
    constraint fk_annio_otorga foreign key (annio) references annio(numero)
    ON delete cascade ON update cascade
);

--TABLA matricula
CREATE TABLE matricula(
    nie_alumno int not null,
    seccion char(1) not null,
    annio int not null,
    constraint pk_matricula primary key (nie_alumno, seccion),
    constraint fk_alumno_matricula foreign key (nie_alumno) references alumno(nie)
    ON delete cascade ON update cascade,
    constraint fk_seccion_matricula foreign key (seccion) references seccion(letra)
    ON delete cascade ON update cascade,
    constraint fk_annio_matricula foreign key (annio) references annio(numero)
    ON delete cascade ON update cascade
);

--TABLA pago
CREATE TABLE pago(
    id int not null constraint pk_pago primary key,
    denominacion_tipo varchar(30) not null,
    denominacion_numero int
);

--TABLA talonario
CREATE TABLE talonario(
    nie_alumno int not null,
    id_pago int not null,
    monto money not null default 0,
    fecha_emision date,
    fecha_vencimiento date,
    constraint pk_talonario primary key (nie_alumno, id_pago),
    constraint fk_alumno_talonario foreign key (nie_alumno) references alumno(nie)
    ON delete cascade ON update cascade,
    constraint fk_pago_talonario foreign key (id_pago) references pago(id)
    ON delete cascade ON update cascade
);

--TABLA accede
CREATE TABLE accede(
    nie_alumno int not null,
    denominacion_edificio varchar(100) not null,
    hora_entrada time,
    hora_salida time,
    fecha date,
    constraint fk_alumno_accede foreign key (nie_alumno) references alumno(nie)
    ON delete cascade ON update cascade,
    constraint fk_edificio_accede foreign key(denominacion_edificio) references edificio(denominacion)
    ON delete cascade ON update cascade
);

--TABLA bitacora
CREATE TABLE bitacora(
    correlativo int not null constraint pk_bitacora primary key,
    nie_alumno int not null,
    fecha_hora timestamp without time zone,
    tipo varchar(50),
    comentario text,
    constraint fk_alumno_bitacora foreign key (nie_alumno) references alumno(nie)
    ON delete cascade ON update cascade
);

--TABLA bitacora parte
CREATE TABLE bitacora_parte(
    correlativo_macrobitacora int not null,
	correlativo_subbitacora int not null,
	constraint pk_bitacora_parte primary key (correlativo_macrobitacora,correlativo_subbitacora),
	constraint fk_macrobitacora foreign key (correlativo_macrobitacora)
	references bitacora(correlativo) on delete cascade on update cascade,
	constraint fk_subbitacora foreign key (correlativo_subbitacora)
	references bitacora(correlativo) on delete cascade on update cascade
);

--TABLA anota
CREATE TABLE anota(
    correlativo int not null,
    dui_docente char(10) not null,
    constraint pk_anota primary key (correlativo, dui_docente),
    constraint fk_correlativo_anota foreign key (correlativo) references bitacora(correlativo)
    ON delete cascade ON update cascade,
    constraint fk_docente_anota foreign key (dui_docente) references docente(dui)
    ON delete cascade ON update cascade
);

--TABLA acuerda
CREATE TABLE acuerda(
    correlativo int not null,
    dui_responsable char(10) not null,
    constraint pk_acuerda primary key (correlativo, dui_responsable),
    constraint fk_correlativo_acuerda foreign key (correlativo) references bitacora(correlativo)
    ON delete cascade ON update cascade,
    constraint fk_responsable_acuerda foreign key (dui_responsable) references responsable_alumno(dui)
    ON delete cascade ON update cascade
);

