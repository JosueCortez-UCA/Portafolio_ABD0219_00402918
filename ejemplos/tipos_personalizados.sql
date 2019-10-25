/* Dominios */

-- Qué tal si creamos un dominio para correo que compruebe si es correcto
DROP DOMAIN email;
CREATE DOMAIN email AS VARCHAR(200)
  CHECK ( value ~ '^[a-zA-Z0-9.!#$%&''*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$' );

-- Probemos
SELECT 'kadejo@gmail.com'::email;
SELECT 'kadejo@g mail.com'::email;
SELECT 'kad@ejo@gmail.com'::email;

-- Ya podemos utilizarlo donde queramos
DROP TABLE IF EXISTS clientes CASCADE;
CREATE TABLE clientes(
    id smallint NOT NULL,
    nombre varchar(32) NOT NULL,
    direccion text,
    correo email,
    pais CHAR(2) NOT NULL,
    CONSTRAINT pk_clientes PRIMARY KEY (id)
);

INSERT INTO clientes VALUES (2039,'Pepe','Soya','pepe@pepe.com','sv');

/* Tipo compuesto */
DROP TYPE tipo_direccion;
CREATE TYPE tipo_direccion AS ( 
  casa         VARCHAR (100),
  calle        VARCHAR (100),
  colonia      VARCHAR (100),
  canton       VARCHAR (100),
  municipio    VARCHAR (80),
  departamento VARCHAR(40) 
);

-- Ya podemos utilizarlo donde queramos
DROP TABLE IF EXISTS clientes CASCADE;
CREATE TABLE clientes(
    id smallint NOT NULL,
    nombre varchar(32) NOT NULL,
    direccion tipo_direccion,
    correo email,
    pais CHAR(2) NOT NULL,
    CONSTRAINT pk_clientes PRIMARY KEY (id)
);

INSERT INTO clientes VALUES (2039,'Pepe',('#28J','Pasaje 10','Reparto Montecarmelo','San Luis Mariona','Cuscatancingo','San Salvador'),'pepe@pepe.com','sv');

-- Para consultar una parte del tipo compuesto se tiene que poner entre () la columna.parte 
select nombre,(direccion).canton from clientes ;
select nombre,(direccion).* from clientes ;

/* Tipo enumerado */
DROP TYPE satisfaccion;
CREATE TYPE satisfaccion AS ENUM ('Horrible','Regulinchi','Nifunifa','Contentillo','Feliz de la vida');

DROP TABLE IF EXISTS clientes CASCADE;
CREATE TABLE clientes(
    id smallint NOT NULL,
    nombre varchar(32) NOT NULL,
    ciudad varchar(30) NOT NULL,
    pais CHAR(2) NOT NULL,
    estado satisfaccion,
    CONSTRAINT pk_clientes PRIMARY KEY (id)
);

INSERT INTO clientes VALUES (2039,'Pepe','Soya','sv','Horrible');
INSERT INTO clientes VALUES (2040,'María','Guate City','gt','Regulinchi');
INSERT INTO clientes VALUES (2041,'Alejandra','Alajuela','cr','Nifunifa');
INSERT INTO clientes VALUES (2042,'Norman','León','ni','Contentillo');
INSERT INTO clientes VALUES (2043,'Emely','San Ignacio','bz','Feliz de la vida');

-- Lo más divertido de los enumerados es que son ordenados! eso habilita consultas interesantes
SELECT * FROM clientes WHERE estado < 'Contentillo';
SELECT * FROM clientes WHERE estado = (SELECT MIN(estado) FROM clientes);

/* Tipo array */

DROP TABLE IF EXISTS clientes CASCADE;
CREATE TABLE clientes(
    id smallint NOT NULL,
    nombre varchar(32) NOT NULL,
    ciudad varchar(30) NOT NULL,
    pais CHAR(2) NOT NULL,
    telefonos CHAR(12)[],  -- Puede ser multidimensional!
    CONSTRAINT pk_clientes PRIMARY KEY (id)
);

INSERT INTO clientes VALUES (2039,'Pepe','Soya','sv','{"+50370395051","+34952801159"}');
INSERT INTO clientes VALUES (2040,'María','Guate City','gt',ARRAY ['+50370331234','+50477882121']);

-- Podemos consultar alguno en particular (ojo, empieza desde 1, no 0)
SELECT nombre,telefonos [1] FROM clientes;
SELECT * FROM clientes WHERE telefonos[2]='+50477882121';
UPDATE clientes SET telefonos[2]='+50512345678' WHERE id=2039;
-- Consulta especial de búsqueda (ANY / ALL)
SELECT * FROM clientes WHERE '+50477882121' = ANY (telefonos);
-- Consulta para desplegar el array en filas
SELECT nombre,unnest(telefonos) FROM clientes;

-- Funciones de arrays 
-- https://www.postgresql.org/docs/current/functions-array.html
-- array_prepend, array_append, array_cat o ||
