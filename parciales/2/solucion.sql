-- 1.1
CREATE DOMAIN numero_telefono AS VARCHAR(20)
CHECK (value ~ '^[+]*[-\s\./0-9]*$')
;

-- 1.2
CREATE TYPE clase_telefono AS ENUM ('celular','casa','trabajo');

-- 1.3
CREATE TYPE tipo_telefono AS ( 
  clase clase_telefono,
  numero numero_telefono
);

-- 1.4
ALTER TABLE cliente ADD COLUMN telefonos tipo_telefono[];
insert into cliente values ('01234567-8','Carlos Juarez','{"(celular,56485648)"}');--si
insert into cliente values ('01234567-8','Carlos Juarez','{"(celurlar,56485648)"}');--no

-- 2
DROP TABLE contrata CASCADE;
CREATE TABLE contrata(
	codigo_proyecto	char(10) not null,
	DUI_cliente	char(10) not null,
	DUI_miembro_gestion	char(10) not null,
	descuento money not null default 0,
	implantacion_fecha_inicio date not null,
	implantacion_precio money not null,
	mantenimiento_periodicidad varchar(40) not null check (mantenimiento_periodicidad in ('Mensual','Bimestral','Trimestral','Cuatrimestral','Semestral','Anual')),
	mantenimiento_precio money not null,
	constraint pk_contrata primary key (codigo_proyecto,DUI_cliente,implantacion_fecha_inicio), -- DUI_miembro_gestion omitido a propósito
	constraint fk_contrata_proyecto foreign key (codigo_proyecto) references proyecto(codigo) on delete cascade on update cascade,
	constraint fk_contrata_cliente foreign key (DUI_cliente) references cliente(DUI) on delete cascade on update cascade,
	constraint fk_contrata_miembro_gestion foreign key (DUI_miembro_gestion) references gestion(DUI_miembro) on delete cascade on update cascade
)PARTITION BY RANGE (implantacion_fecha_inicio);

CREATE TABLE contrata_2015 PARTITION OF contrata FOR VALUES FROM ('01/01/2015') TO ('01/01/2016');
CREATE TABLE contrata_2016 PARTITION OF contrata FOR VALUES FROM ('01/01/2016') TO ('01/01/2017');
CREATE TABLE contrata_2017 PARTITION OF contrata FOR VALUES FROM ('01/01/2017') TO ('01/01/2018');
CREATE TABLE contrata_2018 PARTITION OF contrata FOR VALUES FROM ('01/01/2018') TO ('01/01/2019');
CREATE TABLE contrata_2019 PARTITION OF contrata FOR VALUES FROM ('01/01/2019') TO ('01/01/2020');
CREATE TABLE contrata_default PARTITION OF contrata DEFAULT;

insert into contrata values ('W-2016-1','01234567-8','02112463-5',0,'3/10/2015',1500,'Trimestral',200);
insert into contrata values ('W-2017-1','01234567-8','02112463-5',0,'18/1/2017',1500,'Bimestral',200);
insert into contrata values ('W-2018-2','01234567-8','53463278-1',0,'5/4/2017',18000,'Mensual',200);

-- 3
DROP TABLE cliente CASCADE;
CREATE TABLE cliente(
	dui char(10) not null constraint pk_cliente primary key,
	denominacion varchar(100) not null
);

    -- Persona fisica
CREATE TABLE persona_fisica(
	email varchar(200),
    CONSTRAINT pk_pesona_fisica PRIMARY KEY (email)
) INHERITS (cliente);

insert into persona_fisica values ('01234567-8','Carlos Juarez','email@example.com');

    -- Empresa
CREATE TABLE empresa(
	num_registro varchar(20),
    CONSTRAINT pk_empresa PRIMARY KEY (num_registro)
) INHERITS (cliente);

insert into empresa values ('11234567-8','Kevin Jimson','99394939');

    -- ONG
CREATE TABLE ong(
	num_asociacion varchar(20),
    CONSTRAINT pk_ong PRIMARY KEY (num_asociacion)
) INHERITS (cliente);

insert into ong values ('90123456-7','Mario Simon','893294839');

    -- Institucion publica
CREATE TABLE institucion_publica(
	num_gob varchar(30),
    CONSTRAINT pk_institucion_publica PRIMARY KEY (num_gob)
) INHERITS (cliente);

insert into institucion_publica values ('23456789-0','María Isabel Rodríguez','num gob example :D');

    -- Institucion academica
CREATE TABLE institucion_academica(
	codigo varchar(5),
    CONSTRAINT pk_institucion_academica PRIMARY KEY (codigo)
) INHERITS (cliente);

insert into institucion_academica values ('56789012-3','Charly Alley','02545');

    -- test
SELECT clase.relname, c.*
FROM cliente c, pg_class clase
WHERE c.tableoid = clase.oid;

-- 4
CREATE OR REPLACE FUNCTION comprueba_tipo_proyecto() RETURNS trigger AS $$
DECLARE
	tipo VARCHAR;
	codigocons VARCHAR(8);
	codigo_proyecto proyecto.codigo%TYPE;
BEGIN
	tipo := split_part(NEW.codigo, '-', 1);
    
	IF (char_length(tipo)!=1 OR (tipo!='E' AND tipo!='V' AND tipo!='W'))
	THEN
		RAISE EXCEPTION 'El tipo de proyecto % no es válido', tipo;
    ELSE
        RETURN NEW;
    END IF;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER comprueba_tipo_proyecto BEFORE INSERT OR UPDATE ON proyecto FOR EACH ROW EXECUTE PROCEDURE comprueba_tipo_proyecto();

    -- test
insert into proyecto values ('E-013','moonbucks','ERP',null,null,45000,null); --si
insert into proyecto values ('00013','moonbucks','ERP',null,null,45000,null); --no
