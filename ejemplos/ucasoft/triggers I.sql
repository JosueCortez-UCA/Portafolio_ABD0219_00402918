
-- Ejemplo 1: "Atributos calculados"
/* 
 Cuando tengo un atributo calculado normalmente debo actualizar su valor con datos que proceden de las inserciones, actualizaciones y borrado de datos de otras tablas. 
*/

CREATE OR REPLACE FUNCTION monto_acumulado_proyecto() RETURNS trigger AS $$
DECLARE
	monto_a_sumar proyecto.monto_acumulado%TYPE;
	monto_a_restar proyecto.monto_acumulado%TYPE;
	monto_a_actualizar proyecto.monto_acumulado%TYPE;
BEGIN
	IF TG_OP = 'INSERT' THEN
		-- Cuando contratamos un nuevo proyecto, los montos de implantación y mantenimiento
		-- menos el descuento deben ser sumados al monto acumulado
		monto_a_sumar := NEW.implantacion_precio+NEW.mantenimiento_precio-NEW.descuento;
		UPDATE proyecto SET monto_acumulado=monto_acumulado+monto_a_sumar WHERE codigo=NEW.codigo_proyecto;
		RAISE NOTICE 'Debido a la nueva contratación por el cliente %, se va a sumar al proyecto % el monto de %',NEW.DUI_cliente,NEW.codigo_proyecto,monto_a_sumar;
		RETURN NEW;
	ELSIF TG_OP = 'UPDATE' THEN 
		monto_a_actualizar := NEW.implantacion_precio+NEW.mantenimiento_precio-NEW.descuento - (OLD.implantacion_precio+OLD.mantenimiento_precio-OLD.descuento);
		UPDATE proyecto SET monto_acumulado=monto_acumulado+monto_a_actualizar WHERE codigo=NEW.codigo_proyecto;
		RAISE NOTICE 'Debido a la actualización del contrato del cliente %, se va a actualizar al proyecto % el monto de %',NEW.DUI_cliente,NEW.codigo_proyecto,monto_a_actualizar;
		RETURN NEW;
	ELSE
		monto_a_restar := OLD.implantacion_precio+OLD.mantenimiento_precio-OLD.descuento;
		UPDATE proyecto SET monto_acumulado=monto_acumulado-monto_a_restar WHERE codigo=OLD.codigo_proyecto;
		RAISE NOTICE 'Debido a la eliminación del contrato del cliente %, se va a restar al proyecto % el monto de %',OLD.DUI_cliente,OLD.codigo_proyecto,monto_a_restar;
		RETURN OLD;
	END IF;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER actualiza_monto_acumulado_proyecto BEFORE INSERT OR UPDATE OR DELETE ON contrata FOR EACH ROW EXECUTE PROCEDURE monto_acumulado_proyecto();

-- Pruebas
insert into contrata values ('W-2018-2','11234567-8','22329787-2',0,'11/9/2019',5000,'Trimestral',200);

update contrata set implantacion_precio=6000 where codigo_proyecto = 'W-2018-2' and dui_cliente='11234567-8';

delete from contrata where codigo_proyecto = 'W-2018-2' and dui_cliente='11234567-8';



-- Ejemplo 2: "Relaciones relacionadas"
/* 
 Cuando, a nivel conceptual, una relación tiene que ver con otra, es difícil mantener la coherencia en  el nivel relacional dado que no hay ninguna relación de integridad referencial entre las estructuras creadas al traducir las relaciones. En este sentido se deben hacer ciertas comprobaciones cuando se  realizan inserciones, actualizaciones y borrados en ambas tablas.
 */
CREATE OR REPLACE FUNCTION presenta_asiste() RETURNS trigger AS $$
DECLARE
	prueba RECORD;
BEGIN
	IF (TG_RELNAME = 'presenta' AND (TG_OP = 'INSERT' OR TG_OP = 'UPDATE')) THEN
		-- En el momento que introduzcamos a alguien como presentador debemos introducirlo en asiste, si es que no
		-- estaba ya dentro
		SELECT INTO prueba * FROM asiste WHERE DUI_miembro=NEW.DUI_miembro AND  nombre_superpachanga=NEW.nombre_superpachanga;
		-- No está en asiste, así que hacemos el favor de meterlo
		IF prueba.DUI_miembro IS NULL THEN
			INSERT INTO asiste VALUES (NEW.nombre_superpachanga,NEW.DUI_miembro);
			RAISE NOTICE 'Introduje en asiste al presentador % de la superpachanga %', NEW.DUI_miembro,NEW.nombre_superpachanga;
		END IF;
		RETURN NEW;
	ELSE 
		IF (TG_RELNAME = 'asiste' AND TG_OP = 'DELETE') THEN
			-- Es borrado de asiste , entonces debemos borrarlo de presenta si está ahí
			SELECT INTO prueba DUI_miembro FROM presenta WHERE DUI_miembro=OLD.DUI_miembro AND  nombre_superpachanga=OLD.nombre_superpachanga;
			-- Está en presenta, así que hacemos el favor de borrarlo
			IF prueba.DUI_miembro IS NOT NULL THEN
				DELETE FROM presenta WHERE DUI_miembro=OLD.DUI_miembro AND  nombre_superpachanga=OLD.nombre_superpachanga;
				RAISE NOTICE 'Como ya no asiste % a la superpachanga %, lo borré de presenta', OLD.DUI_miembro,OLD.nombre_superpachanga;
			END IF;
		END IF;
		RETURN OLD;
	END IF;
END;
$$ LANGUAGE plpgsql;

create trigger si_presenta_debe_asistir BEFORE INSERT OR UPDATE ON presenta FOR EACH ROW EXECUTE PROCEDURE presenta_asiste();
create trigger si_no_asiste_no_presenta AFTER DELETE ON asiste FOR EACH ROW EXECUTE PROCEDURE presenta_asiste();

-- pruebas
-- Esto desencadena un borrado en presenta
delete from asiste where dui_miembro ='02112463-5' and nombre_superpachanga='El gran despije';
-- Esto inserta automáticamente en asiste
insert into presenta values('W-2017-1','El gran despije','02112463-5');

-- Ejemplo 3: "Especialización disjunta y total" 
/*
 Algo absolutamente imposible de controlar por la estructura relacional es la traducción de una especialización disjunta (no pueden existir instancias de una subclase en otra), y para mayor dificultad, cuando la especialización es total TODAS las instancias de la clase padre deben estar en alguna de las subclases (si la especialización es disjunta, entonces sólo puede ser una).
*/
 
-- Primero: comprobación de la totalidad.
--=======================================

-- Opción 1: podemos crear una función que ejecutemos cada cierto tiempo para comprobar la coherencia de la base de datos... (solución chambona tipo al más no haber).

CREATE OR REPLACE FUNCTION miembro_no_esta_en_ninguna_subclase() RETURNS integer AS $$
DECLARE
	prueba_ingenieria RECORD;
	prueba_gestion RECORD;
	prueba_ventas RECORD;
	fila_miembro miembro%ROWTYPE;
	filas_mal integer := 0;
BEGIN
	FOR fila_miembro IN SELECT * FROM miembro LOOP
		SELECT INTO prueba_ingenieria * FROM ingenieria WHERE DUI_miembro=fila_miembro.DUI;
		SELECT INTO prueba_gestion * FROM gestion WHERE DUI_miembro=fila_miembro.DUI;
		SELECT INTO prueba_ventas * FROM ventas WHERE DUI_miembro=fila_miembro.DUI;
		IF (prueba_ingenieria.DUI_miembro IS NULL AND prueba_gestion.DUI_miembro IS NULL AND prueba_ventas.DUI_miembro IS NULL)
		THEN
			RAISE NOTICE 'El miembro % no se ha introducido en ninguna subclase', fila_miembro.DUI;
			filas_mal:=filas_mal+1;
		END IF;
	END LOOP;
	RETURN filas_mal;
END;
$$ LANGUAGE plpgsql;

-- Podemos ejecutar la función anterior usando lo siguiente:
select * from miembro_no_esta_en_ninguna_subclase();

-- Opción 2: 
/*
 Lo correcto es programar un trigger que impida el insert (o el update) directo en la superclase de un objeto que no haya sido insertado/exista previamente en alguna de las subclases, ¡pero esto es un gallo-gallina! porque los foreign keys protestarían: sí, esto implicará que un insert (o el update) debe ser a la vez en las dos tablas, superclase y subclase, con una transacción en la que deberán diferirse los foreign keys hasta el final de la transacción.
*/

CREATE OR REPLACE FUNCTION comprueba_miembro_subclase() RETURNS trigger AS $$
DECLARE
	prueba_ingenieria RECORD;
	prueba_gestion RECORD;
	prueba_ventas RECORD;
BEGIN				
    SELECT INTO prueba_ingenieria * FROM ingenieria WHERE DUI_miembro=NEW.DUI;
	SELECT INTO prueba_gestion * FROM gestion WHERE DUI_miembro=NEW.DUI;
	SELECT INTO prueba_ventas * FROM ventas WHERE DUI_miembro=NEW.DUI;
    IF (prueba_ingenieria.DUI_miembro IS NULL AND prueba_gestion.DUI_miembro IS NULL AND prueba_ventas.DUI_miembro IS NULL)
	THEN
		RAISE EXCEPTION 'El  miembro % no está introducido en ninguna subclase', NEW.DUI;
    ELSE
        RETURN NEW;
	END IF;
END;
$$ LANGUAGE plpgsql;

create trigger miembro_en_subclase BEFORE INSERT OR UPDATE ON miembro FOR EACH ROW EXECUTE PROCEDURE comprueba_miembro_subclase();

-- Pruebas

insert into miembro values ('04926244-5','Carlos','Ingeniería'); -- El trigger protesta

-- Veamos si furula el truco de la transacción

BEGIN;

SET CONSTRAINTS fk_ingenieria_miembro DEFERRED;

insert into ingenieria values ('04926244-5'); -- No grita la FK porque la diferimos :p
insert into miembro values ('04926244-5','Carlos','Ingeniería'); -- ¡Sí funca!

COMMIT;

-- Lo que sí podemos hacer sin ningún tipo de problemas es que cuando se elimine a algún elemento de
-- la subclase se le elimine automáticamente de la superclase
CREATE OR REPLACE FUNCTION borra_miembro_superclase() RETURNS trigger AS $$
BEGIN				
	DELETE FROM miembro WHERE DUI=OLD.DUI_miembro;
	RAISE NOTICE 'Al borrar a % de % lo hemos borrado como miembro', OLD.DUI_miembro,TG_RELNAME;
	RETURN OLD;
END;
$$ LANGUAGE plpgsql;

create trigger miembro_ingenieria AFTER DELETE ON ingenieria FOR EACH ROW EXECUTE PROCEDURE borra_miembro_superclase();
create trigger miembro_gestion AFTER DELETE ON gestion FOR EACH ROW EXECUTE PROCEDURE borra_miembro_superclase();
create trigger miembro_ventas AFTER DELETE ON ventas FOR EACH ROW EXECUTE PROCEDURE borra_miembro_superclase();

-- Pruebas
delete from ingenieria where dui_miembro = '04926244-5';

-- Segundo: validación de disyunción
--==================================
/*
 En una especialización disjunta no pueden existir el mismo objeto en más de una subclase, y eso sí que lo podemos vigilar mediante triggers en inserciones y actualizaciones.
*/

CREATE OR REPLACE FUNCTION miembro_ya_esta_en_otra_subclase() RETURNS trigger AS $$
DECLARE
	prueba_ingenieria RECORD;
	prueba_gestion RECORD;
	prueba_ventas RECORD;
BEGIN
	IF TG_RELNAME = 'ingenieria' THEN
		SELECT INTO prueba_gestion * FROM gestion WHERE DUI_miembro=NEW.DUI_miembro;
		IF (prueba_gestion.DUI_miembro IS NOT NULL) THEN
			RAISE EXCEPTION 'El  miembro % ya pertenece a gestión', NEW.DUI_miembro;
		END IF;
		SELECT INTO prueba_ventas * FROM ventas WHERE DUI_miembro=NEW.DUI_miembro;
		IF (prueba_ventas.DUI_miembro IS NOT NULL) THEN
			RAISE EXCEPTION 'El  miembro % ya pertenece a ventas', NEW.DUI_miembro;
		END IF;
	ELSIF TG_RELNAME = 'gestion' THEN
		SELECT INTO prueba_ingenieria * FROM ingenieria WHERE DUI_miembro=NEW.DUI_miembro;
		IF (prueba_ingenieria.DUI_miembro IS NOT NULL) THEN
			RAISE EXCEPTION 'El  miembro % ya pertenece a ingeniería', NEW.DUI_miembro;
		END IF;
		SELECT INTO prueba_ventas * FROM ventas WHERE DUI_miembro=NEW.DUI_miembro;
		IF (prueba_ventas.DUI_miembro IS NOT NULL) THEN
			RAISE EXCEPTION 'El  miembro % ya pertenece a ventas', NEW.DUI_miembro;
		END IF;
	ELSE -- comprobación de ventas
		SELECT INTO prueba_gestion * FROM gestion WHERE DUI_miembro=NEW.DUI_miembro;
		IF (prueba_gestion.DUI_miembro IS NOT NULL) THEN
			RAISE EXCEPTION 'El  miembro % ya pertenece a gestión', NEW.DUI_miembro;
		END IF;
		SELECT INTO prueba_ingenieria * FROM ingenieria WHERE DUI_miembro=NEW.DUI_miembro;
		IF (prueba_ingenieria.DUI_miembro IS NOT NULL) THEN
			RAISE EXCEPTION 'El  miembro % ya pertenece a ingeniería', NEW.DUI_miembro;
		END IF;
	END IF;
	RETURN NEW;
END;
$$ LANGUAGE plpgsql;

create trigger miembro_ingenieria_no_en_otras BEFORE INSERT OR UPDATE ON ingenieria FOR EACH ROW EXECUTE PROCEDURE miembro_ya_esta_en_otra_subclase();
create trigger miembro_ventas_no_en_otras BEFORE INSERT OR UPDATE ON ventas FOR EACH ROW EXECUTE PROCEDURE miembro_ya_esta_en_otra_subclase();
create trigger miembro_gestion_no_en_otras BEFORE INSERT OR UPDATE ON gestion FOR EACH ROW EXECUTE PROCEDURE miembro_ya_esta_en_otra_subclase();

-- Insertemos de nuevo a Carlos en Ingeniería
BEGIN;

SET CONSTRAINTS fk_ingenieria_miembro DEFERRED;

insert into ingenieria values ('04926244-5'); -- No grita la FK porque la diferimos :p
insert into miembro values ('04926244-5','Carlos','Ingeniería'); -- ¡Sí funca!

COMMIT;

-- Si intentamos también asignarlo a ventas (no es necesaria la transacción porque ya está en miembro)...
insert into ventas values ('04926244-5');
