-- 1. Estructuras de herencia las especializaciones de Responsable y Docente.

    -- Docente
    drop table if exists docente cascade;
    create table docente(
        DUI	char(10)    not null,
        nombre varchar(100) not null,
        constraint pk_docente primary key (DUI)
    );

    drop table if exists profesor cascade;
    create table profesor(
        constraint pk_profesor primary key (DUI)
    ) INHERITS (docente);

    drop table if exists estudiante cascade;
    create table estudiante(
        constraint pk_estudiante primary key (DUI)
    ) INHERITS (docente);

    -- Responsable
    drop table if exists responsable cascade;
    create table responsable(
        DUI	char(10) not null,
        nombre varchar(100) not null,
        constraint pk_responsable primary key (DUI)
    );

    drop table if exists estudiante_responsable cascade;
    create table estudiante_responsable(
        constraint pk_estudiante_responsable primary key (DUI)
    ) INHERITS (responsable);

    drop table if exists empleado_responsable cascade;
    create table empleado_responsable(
        oficina VARCHAR(40) not null,
        telefono VARCHAR(10),
        constraint pk_empleado_responsable primary key (DUI)
    ) INHERITS (responsable);

-- 2. La tabla dedicada a registrar los pagos (Talonario) se prevé que crezca enormemente. Realice el particionamiento de dicha tabla por rango (considere 3 particiones, una para cada año, 2020, 2021, 2022 y otra por default).

drop table if exists talonario cascade;
create table talonario(
    NIE_alumno  char(10) not null,
    tipo_pago	char(10) not null,
    numero_pago smallint not null,
    numero_año  smallint not null,
    monto       money not null DEFAULT 0,
    fecha_emision   date not null,
    fecha_vencimiento date not null,
    fecha_pago  date,
    estado      char(10) not null check (estado IN ('Pendiente','Cancelado','Anulado')),
    constraint pk_talonario primary key (NIE_alumno,tipo_pago,numero_pago,numero_año),
    constraint fk_talonario_alumno foreign key (NIE_alumno)
    references alumno(NIE) on delete cascade on update cascade,
    constraint fk_talonario_pago foreign key (tipo_pago,numero_pago)
    references pago(tipo,numero) on delete cascade on update cascade,
    constraint fk_talonario_año foreign key (numero_año)
    references año(numero) on delete cascade on update cascade
) PARTITION BY LIST (numero_año);

CREATE TABLE talonario_2020 PARTITION OF talonario FOR VALUES IN (2020);
CREATE TABLE talonario_2021 PARTITION OF talonario FOR VALUES IN (2021);
CREATE TABLE talonario_2022 PARTITION OF talonario FOR VALUES IN (2022);
CREATE TABLE talonario_default PARTITION OF talonario DEFAULT;

-- 3. La cantidad de triggers que habrá que programar es enorme en esta BD, pero por el momento se necesitan:
    /*
    a) Triggers que controlen la especialización disjunta y total de Sección.
    */

    -- Comprueba totalidad
    CREATE OR REPLACE FUNCTION comprueba_seccion_subclase() RETURNS trigger AS $$
    DECLARE
        count_seccionxaula smallint;
        count_seccionxasignatura smallint;
    BEGIN
        count_seccionxaula := (
            SELECT COUNT(*)
            FROM seccionxaula
            WHERE denominacion_nivel_grado_seccion = NEW.denominacion_nivel_grado
            AND numero_grado_seccion = NEW.numero_grado
            AND letra_seccion = NEW.letra
        );

        count_seccionxasignatura := (
            SELECT COUNT(*)
            FROM seccionxasignatura
            WHERE denominacion_nivel_grado_seccion = NEW.denominacion_nivel_grado
            AND numero_grado_seccion = NEW.numero_grado
            AND letra_seccion = NEW.letra
        );
        
        IF (count_seccionxaula = 0 AND count_seccionxasignatura = 0)
        THEN
            RAISE EXCEPTION 'la seccion no esta registrada en ninguna subclase';
        ELSE
            RETURN NEW;
        END IF;
    END;
    $$ LANGUAGE plpgsql;

    create trigger seccion_en_subclase BEFORE INSERT OR UPDATE ON seccion FOR EACH ROW EXECUTE PROCEDURE comprueba_seccion_subclase();

        -- Pruebas
        -- Error
            INSERT INTO public.seccion(denominacion_nivel_grado, numero_grado, letra) VALUES ('a123456789', 2, 'a');

        -- Funciona
            BEGIN;

            SET CONSTRAINTS fk_seccionxaula_seccion DEFERRED;

            insert into seccionxaula values ('a123456789', 2, 'a'); -- No grita la FK porque la diferimos :p
            insert into seccion values ('a123456789', 2, 'a'); -- ¡Sí funca!

            COMMIT;

    -- Elimina de las tablas hijas
    CREATE OR REPLACE FUNCTION borra_seccion_superclase() RETURNS trigger AS $$
    BEGIN				
        DELETE FROM seccion
        WHERE denominacion_nivel_grado = OLD.denominacion_nivel_grado_seccion
        AND numero_grado = OLD.numero_grado_seccion
        AND letra = OLD.letra_seccion
        ;

        RAISE NOTICE 'Se ha eliminado la seccion de la superclase tambien';
        RETURN OLD;
    END;
    $$ LANGUAGE plpgsql;

    create trigger delete_seccion_seccionxaula AFTER DELETE ON seccionxaula FOR EACH ROW EXECUTE PROCEDURE borra_seccion_superclase();
    create trigger delete_seccion_seccionxasignatura AFTER DELETE ON seccionxasignatura FOR EACH ROW EXECUTE PROCEDURE borra_seccion_superclase();

        -- Prueba
        delete from seccionxaula where denominacion_nivel_grado_seccion = 'a123456789' and numero_grado_seccion = 2 and letra_seccion = 'a';

    -- Validación de disyunción
    CREATE OR REPLACE FUNCTION seccion_en_otra_subclase() RETURNS trigger AS $$
    DECLARE
        count_seccionxaula smallint;
        count_seccionxasignatura smallint;
    BEGIN
        IF TG_RELNAME = 'seccionxasignatura' THEN
            count_seccionxaula := (
                SELECT COUNT(*) FROM seccionxaula WHERE denominacion_nivel_grado_seccion = NEW.denominacion_nivel_grado_seccion AND numero_grado_seccion = NEW.numero_grado_seccion AND letra_seccion = NEW.letra_seccion
            );

            IF (count_seccionxaula > 0) THEN
                RAISE EXCEPTION 'La seccion que intenta registrar ya pertenece a seccionxaula';
            END IF;
        ELSIF TG_RELNAME = 'seccionxaula' THEN
            count_seccionxasignatura := (
                SELECT COUNT(*) FROM seccionxasignatura WHERE denominacion_nivel_grado_seccion = NEW.denominacion_nivel_grado_seccion AND numero_grado_seccion = NEW.numero_grado_seccion AND letra_seccion = NEW.letra_seccion
            );

            IF (count_seccionxasignatura > 0) THEN
                RAISE EXCEPTION 'La seccion que intenta registrar ya pertenece a seccionxasignatura';
            END IF;
        END IF;
        RETURN NEW;
    END;
    $$ LANGUAGE plpgsql;

    create trigger seccionxaula_en_otra_subclase BEFORE INSERT OR UPDATE ON seccionxaula FOR EACH ROW EXECUTE PROCEDURE seccion_en_otra_subclase();
    create trigger seccionxasignatura_en_otra_subclase BEFORE INSERT OR UPDATE ON seccionxasignatura FOR EACH ROW EXECUTE PROCEDURE seccion_en_otra_subclase();

    /*
    b) Un trigger que impida la inserción de datos en la tabla Acceso si se comprueba que el alumno no está matriculado ese año, lo cual deberá comprobarse extrayendo el año de la fecha en la que el estudiante está entrando en el edificio y la existencia de una fila en la tabla de Matrícula (entre Alumno y Sección) para ese año.
    */

    CREATE OR REPLACE FUNCTION comprueba_matricula_acceso() RETURNS trigger AS $$
    DECLARE
        prueba RECORD;
    BEGIN
        SELECT INTO prueba * FROM matricula WHERE NIE_alumno = NEW.NIE_alumno AND  numero_año = EXTRACT(year from NEW.fecha);
        IF (NOT FOUND) THEN
            RAISE EXCEPTION 'Está intentando acceder al edificio % el alumno de NIE %, sin embargo no está matriculado en el año %', NEW.denominacion_edificio,NEW.NIE_alumno,EXTRACT (year from NEW.fecha);
        END IF;
        RETURN NEW;
    END;
    $$ LANGUAGE plpgsql;

    create trigger comprueba_matricula_acceso BEFORE INSERT OR UPDATE ON acceso FOR EACH ROW EXECUTE PROCEDURE comprueba_matricula_acceso();
