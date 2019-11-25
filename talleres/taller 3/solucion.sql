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

