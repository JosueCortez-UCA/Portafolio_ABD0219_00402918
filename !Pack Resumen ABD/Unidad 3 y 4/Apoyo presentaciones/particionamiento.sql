
/* Particionamiento por rango */
DROP TABLE medida;
CREATE TABLE medida (
    fecha           DATE not null,
    temperatura     SMALLINT,
    ph              SMALLINT
) PARTITION BY RANGE (fecha);

CREATE TABLE medida_2016 PARTITION OF medida FOR VALUES FROM ('01/01/2016') TO ('01/01/2017');
CREATE TABLE medida_2017 PARTITION OF medida FOR VALUES FROM ('01/01/2017') TO ('01/01/2018');
CREATE TABLE medida_2018 PARTITION OF medida FOR VALUES FROM ('01/01/2018') TO ('01/01/2019');
CREATE TABLE medida_default PARTITION OF medida DEFAULT;

INSERT INTO medida VALUES ('30/10/2016', 36, 7); 
INSERT INTO medida VALUES ('30/10/2016', 36.5, 7); 
INSERT INTO medida VALUES ('30/10/2016', 36.6, 7.2); 
INSERT INTO medida VALUES ('30/10/2016', 34.5, 6); 
INSERT INTO medida VALUES ('30/10/2016', 35, 7); 
INSERT INTO medida VALUES ('30/10/2016', 36, 8); 
INSERT INTO medida VALUES ('30/10/2016 4:50', 36, 8); 
INSERT INTO medida VALUES ('31/12/2016 4:50', 36, 8); 
INSERT INTO medida VALUES ('1/1/2017 0:01', 37, 8); 
INSERT INTO medida VALUES ('11/5/2018 0:01', 37, 8); 
INSERT INTO medida VALUES ('25/9/2019 0:01', 35, 8); 

-- Si eliminamos la tabla padre se eliminan también sus particiones.
--DROP TABLE medida;

select * from medida;
-- Con este truco (cast de tableoid a regclass) podemos obtener en qué tabla se encuentran
select *,tableoid::regclass from medida;

-- Podemos conectar/desconectar particiones en caliente
CREATE TABLE medida_2019 (LIKE medida INCLUDING ALL);
ALTER TABLE medida ATTACH PARTITION medida_2019 FOR VALUES FROM ('01/01/2019') TO ('01/01/2020');
-- Ojo! si hay valores en DEFAULT habrá que moverlos previamente
WITH filas_movidas AS (
    DELETE FROM medida 
    WHERE fecha between '01/01/2019' and '31/12/2019'
    RETURNING medida.* 
)
INSERT INTO medida_2019 SELECT * FROM filas_movidas;

-- Desconectar es super fácil
ALTER TABLE medida DETACH PARTITION medida_2016;

-- Se puede subparticionar (p.e. por meses)

/* Particionamiento por lista */

DROP TABLE IF EXISTS clientes CASCADE;
CREATE TABLE clientes(
    id smallint NOT NULL,
    nombre varchar(32) NOT NULL,
    direccion text,
    pais CHAR(2) NOT NULL,
    CONSTRAINT pk_clientes PRIMARY KEY (id,pais)
    -- OJO; pais debe formar parte de la clave primaria!
) PARTITION BY LIST(pais);

CREATE TABLE clientes_sv PARTITION OF clientes FOR VALUES IN ('sv');
CREATE TABLE clientes_cr PARTITION OF clientes FOR VALUES IN ('cr');
CREATE TABLE clientes_gt PARTITION OF clientes FOR VALUES IN ('gt');
CREATE TABLE clientes_hn PARTITION OF clientes FOR VALUES IN ('hn');
CREATE TABLE clientes_ni PARTITION OF clientes FOR VALUES IN ('ni');
CREATE TABLE clientes_bz PARTITION OF clientes FOR VALUES IN ('bz');
CREATE TABLE clientes_def PARTITION OF clientes DEFAULT;


INSERT INTO clientes VALUES (2039,'Pepe','Soya','sv');
INSERT INTO clientes VALUES (2040,'María','Guate City','gt');
INSERT INTO clientes VALUES (2041,'Alejandra','Alajuela','cr');
INSERT INTO clientes VALUES (2042,'Norman','León','ni');
INSERT INTO clientes VALUES (2043,'Emely','San Ignacio','bz');
INSERT INTO clientes VALUES (2044,'Pedro','Copán','hn');
INSERT INTO clientes VALUES (2045,'Lucia','Ouro Preto','br');
INSERT INTO clientes VALUES (2046,'Miguel','Guanajuato','mx');

-- Probemos!
select * from clientes_cr;
select *,tableoid::regclass from clientes;

--Qué pasará si actualizo un valor?
INSERT INTO clientes VALUES (2047,'Carlos','Heredia','cr');

-- Oh, Carlos se mudó
UPDATE clientes SET direccion='Cuscatancingo',pais='sv' where id=2047;

-- Puedo crear más particiones? sí, pero ojo si ya hay valores en la tabla por default
-- Sí funciona:
CREATE TABLE clientes_pa PARTITION OF clientes FOR VALUES IN ('pa');
INSERT INTO clientes VALUES (2048,'Mauro','Darién','pa');
-- No funciona (por tanto hay que sacar los datos antes y luego:
CREATE TABLE clientes_mx PARTITION OF clientes FOR VALUES IN ('mx');

-- Y los índices? si creo un índice en la tabla padre, también estará en las particiones
CREATE INDEX idx_clientes ON clientes (nombre);

/* Particionamiento por hash */

-- Tabla principal
DROP TABLE IF EXISTS clientes CASCADE;
CREATE TABLE clientes(
    dui varchar(10) NOT NULL,
    nombre varchar(32) NOT NULL,
    direccion text,
    pais CHAR(2) NOT NULL,
    CONSTRAINT pk_clientes PRIMARY KEY (dui)
) PARTITION BY HASH (dui);

-- ¿Cómo es el algoritmo con el que se calcula el hash? sinceramente no sé cuál es,
-- pero supuestamente garantiza una distribución homogénea en los buckets

CREATE TABLE clientes_0 PARTITION OF clientes FOR VALUES WITH (MODULUS 10, REMAINDER 0);
CREATE TABLE clientes_1 PARTITION OF clientes FOR VALUES WITH (MODULUS 10, REMAINDER 1);
CREATE TABLE clientes_2 PARTITION OF clientes FOR VALUES WITH (MODULUS 10, REMAINDER 2);
CREATE TABLE clientes_3 PARTITION OF clientes FOR VALUES WITH (MODULUS 10, REMAINDER 3);
CREATE TABLE clientes_4 PARTITION OF clientes FOR VALUES WITH (MODULUS 10, REMAINDER 4);
CREATE TABLE clientes_5 PARTITION OF clientes FOR VALUES WITH (MODULUS 10, REMAINDER 5);
CREATE TABLE clientes_6 PARTITION OF clientes FOR VALUES WITH (MODULUS 10, REMAINDER 6);
CREATE TABLE clientes_7 PARTITION OF clientes FOR VALUES WITH (MODULUS 10, REMAINDER 7);
CREATE TABLE clientes_8 PARTITION OF clientes FOR VALUES WITH (MODULUS 10, REMAINDER 8);
CREATE TABLE clientes_9 PARTITION OF clientes FOR VALUES WITH (MODULUS 10, REMAINDER 9);

INSERT INTO clientes VALUES ('20392039-9','Pepe','Soya','sv');
INSERT INTO clientes VALUES ('39202039-0','María','Guate City','gt');
INSERT INTO clientes VALUES ('20203939-1','Alejandra','Alajuela','cr');
INSERT INTO clientes VALUES ('03922039-2','Norman','León','ni');
INSERT INTO clientes VALUES ('20303939-3','Emely','San Ignacio','bz');
INSERT INTO clientes VALUES ('20390039-4','Pedro','Copán','hn');
INSERT INTO clientes VALUES ('20392039-5','Lucia','Ouro Preto','br');
INSERT INTO clientes VALUES ('39202039-6','Miguel','Guanajuato','mx');
INSERT INTO clientes VALUES ('20392020-7','Carlos','Heredia','cr');
INSERT INTO clientes VALUES ('20202039-8','Mauro','Darién','pa');

-- Probemos!
select *,tableoid::regclass from clientes;

