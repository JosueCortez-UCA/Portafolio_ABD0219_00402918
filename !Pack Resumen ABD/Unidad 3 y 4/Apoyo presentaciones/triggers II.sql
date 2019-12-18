
-- Ejemplo 4: "Construcción de un identificador incremental complejo"
/* Se ha decidido estandarizar los códigos de los proyectos de forma tal que puedan ser distinguibles de un vistazo en el código. Para ello se ha propuesto la siguiente estructura: (Letra-Año-Iterativo) donde 
  Letra = E (ERP), V (Ventas), W (Web) y O (Otros)
  Año = año de la creación, 4 dígitos
  Iterativo = número incremental según coincidencia de Letra-Año
  Ejemplo: E-2008-4

  Para hacer más robusta esta construcción se debe introducir en la Base de Datos una función que sea capaz de crear un código a partir de un tipo de proyecto dado así como comprobar con un trigger que, ante una inserción/actualización, no se está violando el formato elegido. Se da por supuesto que la tabla proyecto ya tiene todos los proyectos con el código correcto.
*/
CREATE OR REPLACE FUNCTION nuevo_codigo_proyecto(tipo_proyecto varchar) RETURNS varchar AS $$
DECLARE
	numero smallint;
	codigocons VARCHAR(8);
	anio CHAR(4);
BEGIN
	IF (tipo_proyecto='E' OR tipo_proyecto='V' OR tipo_proyecto='W' OR tipo_proyecto='O')
	THEN
		-- Seleccionamos el año en curso
		SELECT INTO anio extract(year FROM CURRENT_DATE);

		-- Seleccionamos el número máximo de los proyectos de ese tipo en este año (dígitos tras el último guión)	
		SELECT max(substring(codigo FROM '-.*-(.*)$')::smallint) INTO numero FROM proyecto WHERE codigo LIKE tipo_proyecto || '-' || anio || '%';

		IF numero IS NULL THEN
            numero:=1; -- Primer proyecto del año en curso
		ELSE
            numero:=numero+1;
        END IF;
	
		codigocons:=tipo_proyecto || '-' || anio || '-' || numero;
		
		RAISE NOTICE 'Nuevo código: %',codigocons;
		RETURN codigocons;
	ELSE
		RAISE EXCEPTION 'El tipo de proyecto % no es válido', tipo_proyecto;
	END IF;
END;
$$ LANGUAGE plpgsql;

-- Podemos ejecutar la función anterior usando lo siguiente:
select * from nuevo_codigo_proyecto('E');
select * from nuevo_codigo_proyecto('K');

-- Función para comprobar la corrección del código ante inserción o actualización
CREATE OR REPLACE FUNCTION codigo_proyecto_correcto() RETURNS trigger AS $$
DECLARE
	anio smallint;
	anioact smallint;
	tipo VARCHAR;
	codigocons VARCHAR(8);
	partenumero VARCHAR;
	numero smallint;
	codigo_proyecto proyecto.codigo%TYPE;
BEGIN
    -- ¿split_part? sí, seguramente más fácil que usar expresiones regulares ;)
	tipo:=split_part(NEW.codigo, '-', 1); 
	IF (char_length(tipo)!=1 OR (tipo!='E' AND tipo!='V' AND tipo!='W' AND tipo!='O'))
	THEN
		RAISE EXCEPTION 'El tipo de proyecto % no es válido', tipo;
	ELSE
		-- Obtenemos el año actual
		SELECT INTO anioact extract(year from CURRENT_DATE); 
		
		-- Obtenemos el año de la nueva fila
		anio:=split_part(NEW.codigo, '-', 2)::smallint; 

		-- El año tiene que ser el presente o bien alguno de los que ya esté dentro (más antiguos)
		-- Solo nos interesa si se encontró algo o no
		SELECT INTO codigo_proyecto codigo FROM proyecto WHERE anio=split_part(codigo, '-', 2)::smallint LIMIT 1;

		-- ojo al uso de NOT FOUND, es otra manera de ver si una consulta no devolvió resultados
		IF (NOT FOUND OR anio!=anioact)
		THEN
			RAISE EXCEPTION 'El año del proyecto % no es válido', anio;
		ELSE
			partenumero:=split_part(NEW.codigo, '-', 3);
			-- No nos preocupa si la longitud es > 1 porque la restricción de longitud de la
			-- columna (definida como varchar(8)) junto con las otras comprobaciones va a obligar
			-- a que sea un solo caracter, pero 
			BEGIN
				numero:=to_number(partenumero,'9');
                -- Si la función falla es porque no es un número
                EXCEPTION WHEN data_exception THEN
				RAISE EXCEPTION 'El numero incremental de proyecto % no es válido', partenumero;
			END;
		END IF;
	END IF;
	RETURN NEW;
END;
$$ LANGUAGE plpgsql;

create trigger codigo_proyecto_correcto BEFORE INSERT OR UPDATE ON proyecto FOR EACH ROW EXECUTE PROCEDURE codigo_proyecto_correcto();

-- pruebas
-- mal
insert into proyecto values ('00014','lakafe','ERP',null,null,5000,null);
-- bien
insert into proyecto values (nuevo_codigo_proyecto('E'),'lakafe','ERP',null,null,5000,null);

-- Ejemplo 5: "Comprobación de cardinalidad específica en tablas que representan relaciones"
/*
 En el EER es muy sencillo imponer restricciones de cardinalidad explícitas diferentes a 1 o N, pero eso implica un control totalmente manual. Por suerte la programación relacionada a tal restricción de integridad semántica no es muy compleja.
 */

-- Supongamos que en el diseño EER para la relación "atiende" queremos limitar a 6 la cantidad de proyectos-clientes que un mismo miembro de ventas atiende para garantizar la calidad de dicha atención.

-- Comprobaremos la cantidad de datos ya existentes, permitiendo hasta 6 inserciones/actualizaciones y rechazando a partir de ahí. Tomemos en cuenta que el trigger se lanzará BEFORE, es decir, aún no se ha ejecutado el insert.

CREATE OR REPLACE FUNCTION comprueba_cardinalidad_atiende() RETURNS trigger AS $$
DECLARE
	numero_atiende smallint;
BEGIN
    SELECT INTO numero_atiende count(*) FROM atiende
    WHERE DUI_miembro_ventas=NEW.DUI_miembro_ventas;
    
    RAISE INFO 'El miembro de ventas % administra % ventas de proyectos en clientes', NEW.DUI_miembro_ventas,numero_atiende;

	IF numero_atiende = 6 
	THEN
		RAISE EXCEPTION 'Lamentablemente el miembro % ya atiende 6 proyectos en clientes. Considere asignar la labor a otro miembro de ventas', NEW.DUI_miembro_ventas;
	END IF;
	RETURN NEW;
END;
$$ LANGUAGE plpgsql;

create trigger limita_atiende BEFORE INSERT OR UPDATE ON atiende FOR EACH ROW EXECUTE PROCEDURE comprueba_cardinalidad_atiende();

-- pruebas

select dui_miembro_ventas,count(*) from atiende group by dui_miembro_ventas;

-- agreguemos otro proyecto-cliente a alguien que todavía puedan
insert into atiende values('W-2018-2','89012345-6','34345578-2');

-- agreguemos otro proyecto-cliente a alguien que ya está al tope
insert into atiende values('E-2018-1','12345678-9','04926243-5');


-- Ejemplo 6: "Comprobación de participación total en relaciones" 
/*
 Es fácil diseñar en EER (con líneas dobles) que todas las instancias de una entidad deben estar participando en una (o varias relaciones), pero en la práctica eso implica una inserción simultánea en todas las tablas involucradas (o el uso de datos ya existentes). Lo más habitual será valorar con el usuario final si tal diseño es realmente mandatorio en todo momento, o si es apenas una espectativa no instantánea: en este caso no habría problema al disociar la entrada de datos en las tablas de las entidades participantes y en otro momento insertar la información en la tabla correspondiente a la relación. En caso de que sea un requisito obligatorio de integridad semántica, definitivamente deberemos programar.
 */
 
-- La tabla desarrolla modela una relación N:M entre proyecto y miembros de ingeniería, según el diseño ¡ambas entidades participan totalmente! por lo que no puede existir un proyecto sin miembros de ingeniería que lo desarrollen ni miembros de ingeniería que no desarrollen proyectos.

-- Cada vez que haya una inserción o una actualización en miembro_ingenieria o en proyecto necesariamente deberá establecerse su ingreso en desarrolla. Igual que en el caso de la especialización total habría una dependencia circular con los foreign keys que apuntan a las entidades participantes. En este caso vamos a utilizar un trigger de tipo CONSTRAINT para que lo podamos hacer diferible (los triggers de tipo constraint solo pueden utilizarse AFTER, pero esto no es problema porque al lanzar un EXCEPTION se abortará toda la transacción y se anulará el insert o update).

CREATE OR REPLACE FUNCTION comprueba_proyectos_ingenieria_desarrolla() RETURNS trigger AS $$
DECLARE
	prueba_desarrolla RECORD;
BEGIN
	IF TG_RELNAME = 'proyecto' THEN
        SELECT INTO prueba_desarrolla * FROM desarrolla WHERE codigo_proyecto=NEW.codigo;
        IF (prueba_desarrolla.codigo_proyecto IS NULL)
        THEN
            RAISE EXCEPTION 'El proyecto % no ha sido previamente vinculado con personal de ingeniería', NEW.codigo;
        END IF;    
    ELSE
    -- llamada por nuevo miembro de ingeniería
        SELECT INTO prueba_desarrolla * FROM desarrolla WHERE DUI_miembro_ingenieria=NEW.DUI_miembro;
        IF (prueba_desarrolla.DUI_miembro_ingenieria IS NULL)
        THEN
            RAISE EXCEPTION 'El miembro de ingeniería % no ha sido previamente vinculado con un proyecto', NEW.DUI_miembro;
        END IF;    
	END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;
 
create CONSTRAINT trigger desarrolla_participacion_total_proyecto AFTER INSERT OR UPDATE ON proyecto DEFERRABLE FOR EACH ROW EXECUTE PROCEDURE comprueba_proyectos_ingenieria_desarrolla();

create CONSTRAINT trigger desarrolla_participacion_total_ingenieria AFTER INSERT OR UPDATE ON ingenieria DEFERRABLE FOR EACH ROW EXECUTE PROCEDURE comprueba_proyectos_ingenieria_desarrolla();

-- Pruebas

-- Los datos actualmente cumplen la condición?
select codigo from proyecto except select distinct codigo_proyecto from desarrolla;
select DUI_miembro from ingenieria except select distinct DUI_miembro_ingenieria from desarrolla;

-- auch, no habíamos creado el trigger a tiempo
insert into desarrolla values('E-2019-3','04926244-5','Desarrollo');

-- Ahora sí: probemos esto para hacer gritar al trigger
insert into proyecto values (nuevo_codigo_proyecto('E'),'laterrassa','ERP',null,null,5000,null);

-- Esto hace también lo hace gritar
BEGIN;

SET CONSTRAINTS fk_ingenieria_miembro DEFERRED;

insert into ingenieria values ('08822144-5'); 
insert into miembro values ('08822144-5','Carolina','Ingeniería'); 

COMMIT;

-- Pero esto es otro pisto: un solo pack de inserts (y postergación de validaciones hasta el final de la transacción)

BEGIN;

SET CONSTRAINTS fk_ingenieria_miembro,desarrolla_participacion_total_proyecto,desarrolla_participacion_total_ingenieria DEFERRED;

-- Se puede usar un bloque de PL/PgSQL dentro de para declarar una variable den.
DO $$
DECLARE
    codigo_proyecto VARCHAR;
BEGIN
    insert into ingenieria values ('08822144-5'); 

    insert into miembro values ('08822144-5','Carolina','Ingeniería'); 

    codigo_proyecto:=nuevo_codigo_proyecto('E');

    insert into proyecto values (codigo_proyecto,'laterrassa','ERP',null,null,2000,null);

    insert into desarrolla values (codigo_proyecto,'08822144-5','Desarrollo');
END $$;

COMMIT;


-- También puede suceder que al eliminar un objeto en desarrolla dejemos a algún miembro de ingeniería sin proyecto, o un proyecto sin miembros de ingeniería, lo cual no debe permitirse. La comprobación tendrá que comprobarse después de haber ejecutado el delete.

CREATE OR REPLACE FUNCTION comprueba_desarrolla_proyecto_ingenieria() RETURNS trigger AS $$
DECLARE
	prueba_desarrolla_proyecto RECORD;
	prueba_desarrolla_ingenieria RECORD;
	prueba_proyecto RECORD;
	prueba_ingenieria RECORD;
BEGIN
    SELECT INTO prueba_desarrolla_proyecto * FROM desarrolla WHERE codigo_proyecto=OLD.codigo_proyecto;
    SELECT INTO prueba_desarrolla_ingenieria * FROM desarrolla WHERE DUI_miembro_ingenieria=OLD.DUI_miembro_ingenieria;
    
    -- Comprobamos que el borrado en desarrolla no viene de la ejecución de los FK por borrado en las tablas referentes, en cuyo caso no hay problema
    SELECT INTO prueba_proyecto * FROM proyecto WHERE codigo=OLD.codigo_proyecto;
    SELECT INTO prueba_ingenieria * FROM ingenieria WHERE DUI_miembro=OLD.DUI_miembro_ingenieria;
    IF (prueba_desarrolla_proyecto.codigo_proyecto IS NULL AND prueba_proyecto IS NOT NULL)
    THEN
        RAISE EXCEPTION 'El proyecto % quedaría sin vinculos con personal de ingeniería. Asigne previamente otros miembros de ingeniería al desarrollo del mismo.', OLD.codigo_proyecto;
    ELSIF (prueba_desarrolla_ingenieria.DUI_miembro_ingenieria IS NULL AND prueba_ingenieria IS NOT NULL) 
    THEN
        RAISE EXCEPTION 'El miembro de ingeniería % quedaría sin vinculos con proyectos. Asigne previamente el desarrollo de otro proyecto al miembro de ingeniería.', OLD.DUI_miembro_ingenieria;
    ELSE
        RETURN OLD;
	END IF;
END;
$$ LANGUAGE plpgsql;
 
create trigger desarrolla_participacion_total_desarrolla AFTER DELETE ON desarrolla FOR EACH ROW EXECUTE PROCEDURE comprueba_desarrolla_proyecto_ingenieria();

-- Pruebas
-- Intentemos borrar de desarrolla
select * from desarrolla where codigo_proyecto ='W-2017-2';

delete from desarrolla where codigo_proyecto ='W-2017-2';
 
delete from desarrolla where codigo_proyecto ='W-2017-2' and DUI_miembro_ingenieria='72234278-3';

select * from desarrolla where dui_miembro_ingenieria='72234278-3';

delete from desarrolla where dui_miembro_ingenieria='72234278-3';

delete from desarrolla where codigo_proyecto ='W-2018-2' and DUI_miembro_ingenieria='72234278-3';
