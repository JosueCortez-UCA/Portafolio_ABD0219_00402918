-- ===========
-- Ejercicio 1
-- ===========
/*
Desarrollar una función que valide un DUI que se le pase como parámetro y que devuelva verdadero si es correcto o falso si no lo es. Deberá validar longitud (10 caracteres), formato (todos dígitos numéricos con solo un guión en la 9 posición) y el dígito de comprobación debe ser correcto utilizando el algoritmo siguiente:

Ejemplo: 01771967-8 -> Dígito verificador: 8

Posición -> 9     8     7     6     5     4     3      2
DUI      -> 0     1     7     7     1     9     6      7

suma  = (9*0)+(8*1)+(7*7)+(6*7)+(5*1)+(4*9)+(3*6)+(2*7) => 172
resto = suma MÓDULO 10 => MOD(172,10) = 2
resta = 10 - resto => 10 - 2 = 8
Dígito verificador=Resta (8=8) => DUI valido.
*/

CREATE OR REPLACE FUNCTION valida_DUI(DUI VARCHAR) RETURNS BOOLEAN AS $$
DECLARE
    chequeo_s CHAR(1);
    numero_s CHAR(9);
    chequeo SMALLINT;
    numero INTEGER;
    suma INTEGER;
    posicion smallint;
    digito smallint;
    resto SMALLINT;
BEGIN
    IF length(DUI)!=10 THEN
        RAISE NOTICE 'La longitud del DUI % es incorrecta', DUI;
        RETURN false;
    ELSIF position('-' in DUI)!=9 THEN
        RAISE NOTICE 'La posición del guión en el DUI % es incorrecta', DUI;       
        RETURN false;
    END IF;
    
    numero_s:=substring(DUI from 1 for 8); 
    chequeo_s:=substring(DUI from 10 for 1); 
 
    BEGIN
        chequeo:=chequeo_s::SMALLINT;
        numero:=numero_s::INTEGER;
    EXCEPTION WHEN data_exception THEN
        RAISE NOTICE 'El DUI % contiene caracteres no numéricos', DUI ;
        RETURN false;
    END;
    
    RAISE INFO 'Formato OK. Calculando checksum...';
    posicion:=1;
    suma:=0;
    
    FOR multiplicador IN REVERSE 9..2 LOOP
        digito:=substring(DUI from posicion for 1)::SMALLINT;
        suma:=suma+multiplicador*digito::smallint;
        RAISE INFO 'posicion %, digito %, multiplicador %, suma %',posicion, digito,multiplicador, suma;
        posicion:=posicion+1;
    END LOOP;
    
    resto:=10-mod(suma,10);
 
    IF resto=chequeo THEN
        RETURN true;
    ELSE
        RAISE NOTICE 'El DUI % es inválido según dígito de chequeo % != %',DUI,chequeo,resto;
        RETURN false;
    END IF;
END;
$$ LANGUAGE plpgsql;

-- Pruebas

select valida_DUI('049262044-5');
select valida_DUI('04-2620425');
select valida_DUI('04a26244-5');
select valida_DUI('04926243-5');
select valida_DUI('04926244-5');

select dui,valida_DUI(dui) from miembro;

-- ===========
-- Ejercicio 2
-- ===========
/*
Existe una relación entre los miembros y el departamento en el que trabajan, y otra en sentido contrario para aquellos miembros que son representantes del departamento. Una persona representante de un departamento no puede trabajar para otro departamento.
    
Por un lado, la función deberá rechazar la inserción o actualización de un departamento con un representante que no trabaje para dicho departamento, por otro lado, si hubiera una actualización del departamento en el que un miembro trabaja, ésta deberá rechazarse si resultara que el miembro es el representante del mismo. 
*/
CREATE OR REPLACE FUNCTION representa_trabaja() RETURNS trigger AS $$
DECLARE
 departamento miembro.denominacion_departamento%TYPE;
BEGIN
    IF (TG_RELNAME = 'departamento' AND (TG_OP = 'INSERT' OR TG_OP = 'UPDATE')) THEN
        -- En el momento que introduzcamos/actualicemos un departamento debemos comprobar que el representante previamente trabaja en dicho departamento
        SELECT INTO departamento denominacion_departamento FROM miembro WHERE DUI=NEW.DUI_miembro_representante;
        -- Si la denominación de los departamentos no es igual, rechazamos la inserción/actualización
        IF departamento!=NEW.denominacion THEN
            RAISE EXCEPTION 'El miembro de DUI % no puede representar %, porque trabaja actualmente para %', NEW.DUI_miembro_representante,NEW.denominacion,departamento;
        END IF;
    ELSE 
        IF (TG_RELNAME = 'miembro' AND TG_OP = 'UPDATE') THEN
            -- No pueden cambiar el departamento de miembro si dicho miembro representa al departamento donde actualmente trabaja
            SELECT INTO departamento denominacion FROM departamento WHERE DUI_miembro_representante=NEW.DUI;
            -- Si la denominación de los departamentos no es igual, rechazamos la inserción/actualización
            IF departamento IS NOT NULL AND departamento!=NEW.denominacion_departamento THEN
                RAISE EXCEPTION 'El miembro de DUI % no puede cambiar al departamento %, porque está representando actualmente %. Debe cambiar de representante primero.', NEW.DUI,NEW.denominacion_departamento,departamento;
            END IF;
        END IF;
    END IF;
    RETURN NEW;
END;

CREATE TRIGGER si_representa_debe_trabajar BEFORE INSERT OR UPDATE ON departamento FOR EACH ROW EXECUTE PROCEDURE representa_trabaja();
CREATE TRIGGER si_representa_no_cambia_trabajo BEFORE UPDATE ON miembro FOR EACH ROW EXECUTE PROCEDURE representa_trabaja();

-- Pruebas
update miembro set denominacion_departamento ='Ventas' where dui ='34531178-8';
update departamento set dui_miembro_representante = '34531178-8' where denominacion='Ventas';
update departamento set dui_miembro_representante = '02112463-5' where denominacion='Gestión';

-- ===========
-- Ejercicio 3
-- ===========
/*
Existe un potencial problema de incoherencia entre la clasificación de miembro en sus subclases y el atributo denominacion_departamento... por ejemplo, sería incorrecto que un miembro de la subclase ingenieria tuviera en el atributo mencionado en la superclase "ventas". En tal sentido hay que desarrollar una función (y un trigger que la ejecute) que haga lo siguiente:
1) Cuando se inserte en la tabla miembro debe comprobarse la coincidencia del departamento expresado en el atributo con la existencia de este miembro en la subclase correcta. Si no está, se debe rechazar la inserción.
2) Cuando se actualice el atributo departamento de miembro, entonces debe moverse al miembro a la subclase que corresponda. Esto implica borrar el miembro de la subclase y reinsertarlo donde corresponde. Se debe tomar en cuenta:
    a) ya existe un trigger que al borrar de una subclase (ingenieria, ventas o gestion) borra automáticamente de la superclase miembro, 
    b) hay otro trigger que impide que se inserte directo en la superclase para validar la totalidad de esa especialización así como que se respete que
    la especialización es disjunta: esto implica que dentro de la función cuando se quiera insertar en una subclase tendrá que hacerse una transacción con el correspondiente FK diferido.
*/

CREATE OR REPLACE FUNCTION miembro_subclase_trabaja() RETURNS trigger AS $$
DECLARE
 departamento miembro.denominacion_departamento%TYPE;
 DUI miembro.dui%TYPE;
BEGIN
    IF (TG_OP = 'INSERT') THEN
        IF (NEW.denominacion_departamento = 'Ingeniería') THEN
            -- En el momento que introduzcamos a alguien en ingenieria debemos comprobar que previamente está en dicha subclase
            -- Si la denominación de los departamentos no es igual, rechazamos la inserción
            SELECT INTO DUI DUI_miembro FROM ingenieria WHERE DUI_miembro=NEW.DUI;
            RAISE INFO 'Chequeo miembro de DUI % en ingenieria', NEW.DUI;
            IF (NOT FOUND) THEN
                RAISE EXCEPTION 'El miembro de DUI % no está previamente en la tabla de ingenieria', NEW.DUI;
            END IF;
        ELSIF NEW.denominacion_departamento='Ventas' THEN
            -- En el momento que introduzcamos a alguien en ventas debemos comprobar que previamente está en dicha subclase
            -- Si la denominación de los departamentos no es igual, rechazamos la inserción
            SELECT INTO DUI FROM ventas WHERE DUI_miembro=NEW.DUI;
            RAISE INFO 'Chequeo miembro de DUI % en ventas', NEW.DUI;
            IF (NOT FOUND) THEN
                RAISE EXCEPTION 'El miembro de DUI % no está previamente en la tabla de ventas', NEW.DUI;
            END IF;
        ELSE
            -- En el momento que introduzcamos a alguien en gestion debemos comprobar que previamente está en dicha subclase
            -- Si la denominación de los departamentos no es igual, rechazamos la inserción
            SELECT INTO DUI FROM gestion WHERE DUI_miembro=NEW.DUI;
            RAISE INFO 'Chequeo miembro de DUI % en gestion', NEW.DUI;
            IF (NOT FOUND) THEN
                RAISE EXCEPTION 'El miembro de DUI % no está previamente en la tabla de gestion', NEW.DUI;
            END IF;
        END IF;
    ELSE 
        -- Están actualizando el departamento en la tabla miembro, por tanto debo trasladar al miembro de la subclase antigua a la nueva
        -- Hay un trigger que elimina de miembro, por lo que después del delete hay que hacer un insert con transacción
        IF (OLD.denominacion_departamento='Ingeniería') THEN
            DELETE FROM ingenieria WHERE DUI_miembro=OLD.DUI;
        ELSIF (OLD.denominacion_departamento='Ventas') THEN
            DELETE FROM ventas WHERE DUI_miembro=OLD.DUI;
        ELSE -- Es Gestión
            DELETE FROM gestion WHERE DUI_miembro=OLD.DUI;
        END IF;
  
        IF (NEW.denominacion_departamento='Ingeniería') THEN
            BEGIN
                SET CONSTRAINTS fk_ingenieria_miembro DEFERRED;
                insert into ingenieria values (NEW.DUI); 
                insert into miembro values (NEW.DUI,NEW.nombre,NEW.denominacion_departamento); 
            END;
        ELSIF (NEW.denominacion_departamento='Ventas') THEN
            BEGIN
                SET CONSTRAINTS fk_ventas_miembro DEFERRED;
                insert into ventas values (NEW.DUI); 
                insert into miembro values (NEW.DUI,NEW.nombre,NEW.denominacion_departamento); 
            END;
        ELSE -- Es Gestión
            BEGIN
                SET CONSTRAINTS fk_gestion_miembro DEFERRED;
                insert into gestion values (NEW.DUI); 
                insert into miembro values (NEW.DUI,NEW.nombre,NEW.denominacion_departamento); 
            END;
        END IF;
        RAISE NOTICE 'Se ha trasladado al miembro de DUI % de % a %',NEW.DUI,OLD.denominacion_departamento,NEW.denominacion_departamento;
    END IF;
    RETURN NEW;
END;

CREATE TRIGGER miembro_trabaja_subclases AFTER INSERT OR UPDATE ON miembro FOR EACH ROW EXECUTE PROCEDURE miembro_subclase_trabaja();

-- Pruebas

-- Fallo por haber insertado en gestión y luego indicar que era de ventas:

BEGIN;

SET CONSTRAINTS fk_gestion_miembro DEFERRED;

insert into gestion values ('08872144-5'); 
insert into miembro values ('08872144-5','Astrid','Ventas'); 

COMMIT;

-- Caso correcto

BEGIN;

SET CONSTRAINTS fk_gestion_miembro DEFERRED;

insert into gestion values ('08872144-5'); 
insert into miembro values ('08872144-5','Astrid','Gestión'); 

COMMIT;

-- Prueba de actualización de subclase:
    
update miembro set denominacion_departamento = 'Ventas' where DUI='08872144-5';

-- ===========
-- Ejercicio 4
-- ===========
/*
Especialización disjunta parcial: la superclase proyectos y sus subclases, web, erp y venta_almacen.

Como es disjunta hay que asegurar la independencia de los miembros de subclases de proyectos, y también la eliminación en la superclase tras el borrado en la subclase.
Como la especialización no es total, en este caso sí puede haber objetos solamente en la superclase, pero atención, éstos deben tener código de  tipo 'O' o se deberá rechazar la inserción, también se debe validar con los otros códigos que los objetos deben estar previamente en las subclases correspondientes, o se debe rechazar la operación. Por suerte ya hay un trigger que impide el ingreso de un proyecto cuyo código no sea válido, así que nos podemos ahorrar ese trabajo.
*/

-- Primera parte: Una función que cuando se elimine un elemento de las subclases lo eliminen automáticamente de la superclase

CREATE OR REPLACE FUNCTION borra_proyecto_superclase() RETURNS trigger AS $$
BEGIN
    DELETE FROM proyecto WHERE codigo=OLD.codigo_proyecto;
    RAISE NOTICE 'Al borrar % de % lo hemos borrado de la tabla de proyectos', OLD.codigo_proyecto,TG_RELNAME;
    RETURN OLD;
END;


CREATE TRIGGER proyecto_erp AFTER DELETE ON erp FOR EACH ROW EXECUTE PROCEDURE borra_proyecto_superclase();
CREATE TRIGGER proyecto_web AFTER DELETE ON web FOR EACH ROW EXECUTE PROCEDURE borra_proyecto_superclase();
CREATE TRIGGER proyecto_venta_almacen AFTER DELETE ON venta_almacen FOR EACH ROW EXECUTE PROCEDURE borra_proyecto_superclase();

-- Pruebas
    
delete from web where codigo_proyecto ='W-2018-2';

-- Segunda parte: Una función que, dado que la especialización es disjunta, garantice que no pueda existir el mismo objeto en más de una subclase

CREATE OR REPLACE FUNCTION proyecto_ya_esta_en_otra_subclase() RETURNS trigger AS $$
DECLARE
 prueba_erp RECORD;
 prueba_web RECORD;
 prueba_venta_almacen RECORD;
BEGIN
    IF TG_RELNAME = 'erp' THEN
        SELECT INTO prueba_web * FROM web WHERE codigo_proyecto=NEW.codigo_proyecto;
        IF (prueba_web.codigo_proyecto IS NOT NULL) THEN
            RAISE EXCEPTION 'El  proyecto % ya pertenece a web', NEW.codigo_proyecto;
        END IF;
        SELECT INTO prueba_venta_almacen * FROM venta_almacen WHERE codigo_proyecto=NEW.codigo_proyecto;
        IF (prueba_venta_almacen.codigo_proyecto IS NOT NULL) THEN
            RAISE EXCEPTION 'El  proyecto % ya pertenece a venta_almacen', NEW.codigo_proyecto;
        END IF;
    ELSIF TG_RELNAME = 'web' THEN
        SELECT INTO prueba_erp * FROM erp WHERE codigo_proyecto=NEW.codigo_proyecto;
        IF (prueba_erp.codigo_proyecto IS NOT NULL) THEN
            RAISE EXCEPTION 'El  proyecto % ya pertenece a erp', NEW.codigo_proyecto;
        END IF;
        SELECT INTO prueba_venta_almacen * FROM venta_almacen WHERE codigo_proyecto=NEW.codigo_proyecto;
        IF (prueba_venta_almacen.codigo_proyecto IS NOT NULL) THEN
            RAISE EXCEPTION 'El  proyecto % ya pertenece a venta_almacen', NEW.codigo_proyecto;
        END IF;
    ELSE -- comprobación de venta_almacen
        SELECT INTO prueba_web * FROM web WHERE codigo_proyecto=NEW.codigo_proyecto;
        IF (prueba_web.codigo_proyecto IS NOT NULL) THEN
            RAISE EXCEPTION 'El  proyecto % ya pertenece a web', NEW.codigo_proyecto;
        END IF;
        SELECT INTO prueba_erp * FROM erp WHERE codigo_proyecto=NEW.codigo_proyecto;
        IF (prueba_erp.codigo_proyecto IS NOT NULL) THEN
            RAISE EXCEPTION 'El  proyecto % ya pertenece a erp', NEW.codigo_proyecto;
        END IF;
    END IF;
    RETURN NEW;
END;

CREATE TRIGGER proyecto_erp_no_en_otras BEFORE INSERT OR UPDATE ON erp FOR EACH ROW EXECUTE PROCEDURE proyecto_ya_esta_en_otra_subclase();
CREATE TRIGGER proyecto_venta_almacen_no_en_otras BEFORE INSERT OR UPDATE ON venta_almacen FOR EACH ROW EXECUTE PROCEDURE proyecto_ya_esta_en_otra_subclase();
CREATE TRIGGER proyecto_web_no_en_otras BEFORE INSERT OR UPDATE ON web FOR EACH ROW EXECUTE PROCEDURE proyecto_ya_esta_en_otra_subclase();

-- Pruebas

-- Rechazada porque ese proyecto ya está en la subclase Web
    
insert into erp values ('W-2018-1');

-- Tercera parte: Una función para comprobación de que los proyectos están siendo introducidos en la subclase correcta. Es importante notar que aunque la especialización es parcial, si los proyectos son de tipo Web, Venta_almacen o ERP, deben ser a la vez introducidos en la subclase correspondiente y en proyecto, como si fuera total. Para ello debe tomarse en cuenta que los respectivos FK de las subclases a la superclase son diferibles.

CREATE OR REPLACE FUNCTION comprueba_proyecto_subclase() RETURNS trigger AS $$
DECLARE
 prueba_web RECORD;
 prueba_venta_almacen RECORD;
 prueba_erp RECORD;
 tipo CHAR;
BEGIN
    -- No me preocupo por validar que el código de un proyecto es correcto porque ya hay un trigger que lo hace
    tipo:=split_part(NEW.codigo, '-', 1); 
    SELECT INTO prueba_web * FROM web WHERE codigo_proyecto=NEW.codigo;
    SELECT INTO prueba_erp * FROM erp WHERE codigo_proyecto=NEW.codigo;
    SELECT INTO prueba_venta_almacen * FROM venta_almacen WHERE codigo_proyecto=NEW.codigo;
 
    RAISE INFO 'Chequeo de inserción en subclase para proyecto de tipo %',tipo;
 
    IF (tipo='O' AND (prueba_web.codigo_proyecto IS NOT NULL OR prueba_erp.codigo_proyecto IS NOT NULL OR prueba_venta_almacen.codigo_proyecto IS NOT NULL)) THEN
        RAISE EXCEPTION 'El proyecto % es de tipo Otro pero ha sido introducido en una subclase cuando no debería', NEW.codigo;
    ELSIF tipo='W' AND prueba_web.codigo_proyecto IS NULL THEN
        RAISE EXCEPTION 'El proyecto % es de tipo Web pero no ha sido previamente introducido en la subclase correcta', NEW.codigo;
    ELSIF tipo='E' AND prueba_erp.codigo_proyecto IS NULL THEN
        RAISE EXCEPTION 'El proyecto % es de tipo ERP pero no ha sido previamente introducido en la subclase correcta', NEW.codigo;
    ELSIF tipo='V' AND prueba_venta_almacen.codigo_proyecto IS NULL THEN
        RAISE EXCEPTION 'El proyecto % es de tipo Venta_almacen pero no ha sido previamente introducido en la subclase correcta', NEW.codigo;    
    ELSE
        RETURN NEW;
    END IF;
END;

CREATE TRIGGER proyecto_en_subclase BEFORE INSERT OR UPDATE ON proyecto FOR EACH ROW EXECUTE PROCEDURE comprueba_proyecto_subclase();

-- Pruebas

-- Fallo por no realizar inserción en subclase.

BEGIN;

SET CONSTRAINTS fk_ingenieria_miembro,desarrolla_participacion_total_proyecto,desarrolla_participacion_total_ingenieria,fk_web_proyecto DEFERRED;

DO $$
DECLARE
    codigo_proyecto VARCHAR;
BEGIN
    insert into ingenieria values ('08822144-5'); 
    insert into miembro values ('08822144-5','Carolina','Ingeniería'); 
    codigo_proyecto:=nuevo_codigo_proyecto('W');
    insert into proyecto values (codigo_proyecto,'phppgadmindecente','Web',null,null,1000,'http://dei2.uca.edu.sv/phppgadmin');    
    insert into desarrolla values (codigo_proyecto,'08822144-5','Desarrollo');
END $$;

COMMIT;

-- Inserción en subclase incorrecta

BEGIN;

SET CONSTRAINTS fk_ingenieria_miembro,desarrolla_participacion_total_proyecto,desarrolla_participacion_total_ingenieria,fk_web_proyecto DEFERRED;

DO $$
DECLARE
    codigo_proyecto VARCHAR;
BEGIN
    insert into ingenieria values ('08822144-5'); 
    insert into miembro values ('08822144-5','Carolina','Ingeniería'); 
    codigo_proyecto:=nuevo_codigo_proyecto('O');
    insert into web values (codigo_proyecto,'http://dei2.uca.edu.sv/phppgadmin',80,40);
    insert into proyecto values (codigo_proyecto,'phppgadmindecente','Web',null,null,1000,'http://dei2.uca.edu.sv/phppgadmin');    
    insert into desarrolla values (codigo_proyecto,'08822144-5','Desarrollo');
END $$;

COMMIT;

-- Caso correcto.

BEGIN;

SET CONSTRAINTS fk_ingenieria_miembro,desarrolla_participacion_total_proyecto,desarrolla_participacion_total_ingenieria,fk_web_proyecto DEFERRED;

DO $$
DECLARE
    codigo_proyecto VARCHAR;
BEGIN
    insert into ingenieria values ('08822144-5'); 
    insert into miembro values ('08822144-5','Carolina','Ingeniería'); 
    codigo_proyecto:=nuevo_codigo_proyecto('W');
    insert into web values (codigo_proyecto,'http://dei2.uca.edu.sv/phppgadmin',80,40);
    insert into proyecto values (codigo_proyecto,'phppgadmindecente','Web',null,null,1000,'http://dei2.uca.edu.sv/phppgadmin');    
    insert into desarrolla values (codigo_proyecto,'08822144-5','Desarrollo');
END $$;

COMMIT;
