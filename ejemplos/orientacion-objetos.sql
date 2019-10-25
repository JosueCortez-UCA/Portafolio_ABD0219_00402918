
-- Tenemos una clase "padre"
DROP TABLE proyecto CASCADE; 
CREATE TABLE proyecto(
	codigo varchar(8) not null,
	denominacion varchar(80) not null,
	monto_acumulado numeric(10,2),
	descripcion_texto text,
	descripcion_bin bytea,
	URL varchar(80),
	CONSTRAINT pk_proyecto PRIMARY KEY (codigo));

-- Podemos definir ahora las hijas (herederas)

-- Ojo, las constraints primary, unique y foreign no se heredan, checks y not nulls sí
-- Ojo a la mezcla de columna URL

DROP TABLE web CASCADE; 
CREATE TABLE web(
	URL varchar(80) not null,
	num_pantallas smallint,
	num_tablas smallint,	
        CONSTRAINT pk_web PRIMARY KEY (codigo)
	) INHERITS (proyecto);


INSERT INTO web VALUES('W-2007-1','Guorpresh',1000000,'CMS de lo más chivo','','http://www.guorpresh.com',105,20);

DROP TABLE venta_almacen CASCADE; 
CREATE TABLE venta_almacen(
	num_clientes smallint not null,
	CONSTRAINT pk_venta_almacen PRIMARY KEY (codigo)
	) INHERITS (proyecto);

INSERT INTO venta_almacen VALUES('V-2007-1','PLATACTIL',900000,'Sistema de punto de ventas','','http://www.venta.com',38);

DROP TABLE erp CASCADE; 
CREATE TABLE erp(
	CONSTRAINT pk_erp PRIMARY KEY (codigo)
	) INHERITS (proyecto);

INSERT INTO erp VALUES('E-2006-1','OPEN-OLE',1200000,'Es lo mejor en soluciones libres para la empresa','','http://www.erp.com');
INSERT INTO erp VALUES('E-2008-1','OPEN-OLE-CRM',100000,'Complemento para relaciones simpáticas con los clientes','','http://www.erp.com');

-- No hay ningún problema en hacer referencias a los atributos heredados 
DROP TABLE modulo_erp CASCADE; 
CREATE TABLE modulo_erp(
	codigo_proyecto_erp varchar(8) not null,
	numero smallint not null,
	descripcion text not null,
	CONSTRAINT pk_modulo_erp PRIMARY KEY (codigo_proyecto_erp,numero),
	CONSTRAINT fk_modulo_erp_erp FOREIGN KEY (codigo_proyecto_erp)
	REFERENCES erp(codigo) ON DELETE CASCADE ON UPDATE CASCADE);

INSERT INTO modulo_erp VALUES('E-2006-1',1,'Autenticación');
INSERT INTO modulo_erp VALUES('E-2006-1',2,'Contabilidad');
INSERT INTO modulo_erp VALUES('E-2006-1',3,'Balanced Scorecard');
INSERT INTO modulo_erp VALUES('E-2006-1',4,'Proyectos');

-- Insert en la tabla padre... se queda ahí
INSERT INTO proyecto VALUES('O-2007-1','PREGULIMON',800000,'cosa seria en encuestas on-line');

--Pruebas:
select * from proyecto;

select * from venta_almacen;

select * from only proyecto;

--cómo puedo saber de qué hija vienen los resultados (si no tengo un atributo discriminador en la padre)
SELECT clase.relname, p.*
FROM proyecto p, pg_class clase
WHERE p.tableoid = clase.oid;

-- La misma consulta pero más fácil utilizando cast
SELECT codigo,tableoid::regclass
FROM proyecto;

-- OJO: No existe comprobación de redundancia entre padre e hijas: pueden repetirse dos tuplas en un select de la clase padre si hubiera un insert en cada tabla.

--qué sucede si altero la estructura de la tabla padre?
alter table proyecto add tipo varchar(20);

--debería haberse modificado la estructura de las hijas:
\d venta_almacen

--Y si borro/actualizo en la entidad padre... se borrará en las hijas?
delete from proyecto where codigo = 'V-2007-1';

