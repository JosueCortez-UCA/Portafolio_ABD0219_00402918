/*
    Ejercicio 1
*/

-- Crear base
CREATE KEYSPACE taller3 WITH REPLICATION = { 'class' : 'SimpleStrategy', 'replication_factor' : 1 };

USE taller3;

-- Tablas o Column Family
CREATE TABLE alumno(
    NIE varchar,
    nombre varchar,
    PRIMARY KEY (NIE)
);

CREATE TYPE tipo_nota (
    calificacion_numerica decimal,
    calificacion_cualitativa varchar
);

CREATE TABLE inscripcion(
    NIE_alumno varchar,
    denominacion_nivel_grado_asignatura varchar,
    numero_grado_asignatura tinyint,
    numero_anyo_asignatura int,
    nombre_asignatura varchar,
    nombre_alumno varchar,   
    notas map <varchar,frozen <tipo_nota>>,
    PRIMARY KEY (numero_anyo_asignatura,denominacion_nivel_grado_asignatura,numero_grado_asignatura,nombre_asignatura,NIE_alumno)
);

-- Datos
INSERT INTO alumno (NIE, nombre) VALUES ('0000000-1', 'Pepito Perez');
INSERT INTO alumno (NIE, nombre) VALUES ('0000000-2', 'Juan Rodriguez');
INSERT INTO alumno (NIE, nombre) VALUES ('0000000-3', 'Sebastian Pancheco');
INSERT INTO alumno (NIE, nombre) VALUES ('0000000-4', 'Poncio Pilato');

INSERT INTO inscripcion (
    NIE_alumno,
    denominacion_nivel_grado_asignatura,
    numero_grado_asignatura,
    numero_anyo_asignatura,
    nombre_asignatura,
    nombre_alumno,
    notas
)
VALUES (
    '0000000-1',
    'bachiller',
    1,
    2019,
    'Matematicas',
    'Pepito Perez',
    {
        'actividad 1':{calificacion_numerica:8,calificacion_cualitativa:'B'},
        'actividad 2':{calificacion_numerica:7,calificacion_cualitativa:'C'},
        'actividad 3':{calificacion_numerica:8,calificacion_cualitativa:'B'},
        'examen 1':{calificacion_numerica:6,calificacion_cualitativa:'C'},
        'examen 2':{calificacion_numerica:9,calificacion_cualitativa:'B'},
        'examen 3':{calificacion_numerica:4,calificacion_cualitativa:'F'}
    }
);

INSERT INTO inscripcion (
    NIE_alumno,
    denominacion_nivel_grado_asignatura,
    numero_grado_asignatura,
    numero_anyo_asignatura,
    nombre_asignatura,
    nombre_alumno,
    notas
)
VALUES (
    '0000000-2',
    'bachiller',
    3,
    2019,
    'Estudio sociales',
    'Juan Rodriguez',
    {
        'actividad 1':{calificacion_numerica:8,calificacion_cualitativa:'B'},
        'actividad 2':{calificacion_numerica:10,calificacion_cualitativa:'A'},
        'actividad 3':{calificacion_numerica:9,calificacion_cualitativa:'B'},
        'examen 1':{calificacion_numerica:8,calificacion_cualitativa:'B'},
        'examen 2':{calificacion_numerica:8,calificacion_cualitativa:'B'},
        'examen 3':{calificacion_numerica:10,calificacion_cualitativa:'A'}
    }
);

INSERT INTO inscripcion (
    NIE_alumno,
    denominacion_nivel_grado_asignatura,
    numero_grado_asignatura,
    numero_anyo_asignatura,
    nombre_asignatura,
    nombre_alumno,
    notas
)
VALUES (
    '0000000-3',
    'bachiller',
    2,
    2019,
    'Estudio sociales',
    'Sebastian Pancheco',
    {
        'actividad 1':{calificacion_numerica:6,calificacion_cualitativa:'C'},
        'actividad 2':{calificacion_numerica:4,calificacion_cualitativa:'F'},
        'actividad 3':{calificacion_numerica:8,calificacion_cualitativa:'B'},
        'examen 1':{calificacion_numerica:6,calificacion_cualitativa:'C'},
        'examen 2':{calificacion_numerica:8,calificacion_cualitativa:'B'},
        'examen 3':{calificacion_numerica:10,calificacion_cualitativa:'A'}
    }
);

INSERT INTO inscripcion (
    NIE_alumno,
    denominacion_nivel_grado_asignatura,
    numero_grado_asignatura,
    numero_anyo_asignatura,
    nombre_asignatura,
    nombre_alumno,
    notas
)
VALUES (
    '0000000-4',
    'basica',
    3,
    2019,
    'Artistica',
    'Poncio Pilato',
    {
        'actividad 1':{calificacion_numerica:10,calificacion_cualitativa:'A'},
        'actividad 2':{calificacion_numerica:10,calificacion_cualitativa:'A'},
        'actividad 3':{calificacion_numerica:10,calificacion_cualitativa:'A'},
        'examen 1':{calificacion_numerica:10,calificacion_cualitativa:'A'},
        'examen 2':{calificacion_numerica:10,calificacion_cualitativa:'A'},
        'examen 3':{calificacion_numerica:10,calificacion_cualitativa:'A'}
    }
);

-- Ver datos
    -- Ver todos los alumnos
SELECT * FROM alumno;

    -- Ver todos los datos de inscripcion
SELECT * FROM inscripcion;

    -- listar los alimnos inscritos en bachillerato, y ver cual estan cursando
SELECT nombre_alumno, numero_grado_asignatura FROM inscripcion WHERE denominacion_nivel_grado_asignatura='bachiller' allow filtering;

    -- ver las notas del alumno con nie 0000000-3
SELECT notas FROM inscripcion WHERE NIE_alumno='0000000-3' allow filtering;

/*
    Ejercicio 2
*/

CREATE TABLE notas(
    NIE_alumno varchar,
    denominacion_nivel_grado_asignatura varchar,
    numero_grado_asignatura tinyint,
    numero_anyo_asignatura int,
    nombre_asignatura varchar,
    nombre_alumno varchar,   
    nota_promedio decimal,
    PRIMARY KEY (numero_anyo_asignatura,denominacion_nivel_grado_asignatura,numero_grado_asignatura,nombre_asignatura,NIE_alumno)
);


    -- 1
INSERT INTO notas (NIE_alumno,denominacion_nivel_grado_asignatura,numero_grado_asignatura,numero_anyo_asignatura,nombre_asignatura,nombre_alumno,nota_promedio)
VALUES ('0000001-1','basica',6,2018,'Artistica','Poncio Pilato',8);

    -- 2
INSERT INTO notas (NIE_alumno,denominacion_nivel_grado_asignatura,numero_grado_asignatura,numero_anyo_asignatura,nombre_asignatura,nombre_alumno,nota_promedio)
VALUES ('0000002-2','basica',6,2018,'Educacion Fisica','Pepito Perez',7.);

    -- 3
INSERT INTO notas (NIE_alumno,denominacion_nivel_grado_asignatura,numero_grado_asignatura,numero_anyo_asignatura,nombre_asignatura,nombre_alumno,nota_promedio)
VALUES ('0000003-7','basica',8,2018,'Sociales','David Cerna',8.7);

    -- 4
INSERT INTO notas (NIE_alumno,denominacion_nivel_grado_asignatura,numero_grado_asignatura,numero_anyo_asignatura,nombre_asignatura,nombre_alumno,nota_promedio)
VALUES ('0000004-4','basica',8,2018,'Matematicas','Pablito Clavito',6.77);

    -- 5
INSERT INTO notas (NIE_alumno,denominacion_nivel_grado_asignatura,numero_grado_asignatura,numero_anyo_asignatura,nombre_asignatura,nombre_alumno,nota_promedio)
VALUES ('0000005-7','bachiller',2,2018,'Matematicas','Jose Luis',8.44);

    -- 6
INSERT INTO notas (NIE_alumno,denominacion_nivel_grado_asignatura,numero_grado_asignatura,numero_anyo_asignatura,nombre_asignatura,nombre_alumno,nota_promedio)
VALUES ('0000006-4','bachiller',2,2018,'Sociales','Oscar Aguilar',9.6);

    -- 7
INSERT INTO notas (NIE_alumno,denominacion_nivel_grado_asignatura,numero_grado_asignatura,numero_anyo_asignatura,nombre_asignatura,nombre_alumno,nota_promedio)
VALUES ('0000007-4','bachiller',3,2018,'Talleres','Gabriela Cortez',8.44);

    -- 8
INSERT INTO notas (NIE_alumno,denominacion_nivel_grado_asignatura,numero_grado_asignatura,numero_anyo_asignatura,nombre_asignatura,nombre_alumno,nota_promedio)
VALUES ('0000008-4','bachiller',3,2018,'Ciencias Naturales','Walter Solorsano',8.6);

    -- 9
INSERT INTO notas (NIE_alumno,denominacion_nivel_grado_asignatura,numero_grado_asignatura,numero_anyo_asignatura,nombre_asignatura,nombre_alumno,nota_promedio)
VALUES ('0000009-4','basica',4,2019,'Matematicas','Abbigail Yanes',8.56);

    -- 10
INSERT INTO notas (NIE_alumno,denominacion_nivel_grado_asignatura,numero_grado_asignatura,numero_anyo_asignatura,nombre_asignatura,nombre_alumno,nota_promedio)
VALUES ('0000010-4','basica',4,2019,'Sociales','Dionisio Lemus',8.89);

    -- 11
INSERT INTO notas (NIE_alumno,denominacion_nivel_grado_asignatura,numero_grado_asignatura,numero_anyo_asignatura,nombre_asignatura,nombre_alumno,nota_promedio)
VALUES ('0000011-4','basica',5,2019,'Sociales','Andrea Portillo',8.7);

    -- 12
INSERT INTO notas (NIE_alumno,denominacion_nivel_grado_asignatura,numero_grado_asignatura,numero_anyo_asignatura,nombre_asignatura,nombre_alumno,nota_promedio)
VALUES ('0000012-4','basica',5,2019,'Lenguaje','Nombre Apellido',7.8);

    -- 13
INSERT INTO notas (NIE_alumno,denominacion_nivel_grado_asignatura,numero_grado_asignatura,numero_anyo_asignatura,nombre_asignatura,nombre_alumno,nota_promedio)
VALUES ('0000013-4','bachiller',1,2019,'Informatica','Alguien Alguno',4.33);

    -- 14
INSERT INTO notas (NIE_alumno,denominacion_nivel_grado_asignatura,numero_grado_asignatura,numero_anyo_asignatura,nombre_asignatura,nombre_alumno,nota_promedio)
VALUES ('0000014-4','bachiller',1,2019,'Talleres','Juan Lopez',9.4);

    -- 15
INSERT INTO notas (NIE_alumno,denominacion_nivel_grado_asignatura,numero_grado_asignatura,numero_anyo_asignatura,nombre_asignatura,nombre_alumno,nota_promedio)
VALUES ('0000015-4','bachiller',3,2019,'Ciencias','Carlos Edgardo',8.6);

    -- 16
INSERT INTO notas (NIE_alumno,denominacion_nivel_grado_asignatura,numero_grado_asignatura,numero_anyo_asignatura,nombre_asignatura,nombre_alumno,nota_promedio)
VALUES ('0000016-4','bachiller',3,2019,'Seminario','Flor Valencia',7.44);


    -- Todo
SELECT * FROM notas;

    -- Los del anyio 2018
SELECT * FROM notas WHERE numero_anyo_asignatura=2018;

    -- Los de bachillerato del anyo 2019
SELECT * FROM notas WHERE numero_anyo_asignatura=2018 AND denominacion_nivel_grado_asignatura='bachiller';

    -- Los que estudian Talleres en bachillerato
SELECT * FROM notas WHERE nombre_asignatura='Talleres' AND denominacion_nivel_grado_asignatura='bachiller' allow filtering;

    -- Nota promedio de todas las notas
SELECT avg(nota_promedio) FROM notas;

    -- Nota promedio en 2018 y otra para 2019
SELECT avg(nota_promedio) FROM notas WHERE numero_anyo_asignatura=2018;
SELECT avg(nota_promedio) FROM notas WHERE numero_anyo_asignatura=2019;

/*
    Ejercicio 3
*/

