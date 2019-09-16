--TABLA proyecto
CREATE TABLE proyecto(
	codigo char(5) not null constraint pk_proyecto primary key,
	denominacion varchar(100) not null,
	tipo varchar(30) not null check(tipo in ('Web', 'Venta_almacen', 'ERP')),
	desc_txt text,
	desc_doc bytea,
	monto_acumulado money not null default 0,
	url varchar(100)
);

--TABLA cliente
CREATE TABLE cliente(
	dui char(10) not null constraint pk_cliente primary key,
	denominacion varchar(100) not null,
	tipo varchar(40) not null check (tipo in ('Persona física','Empresa','ONG','Institución pública','Institución académica'))
);

--TABLA departamento
CREATE TABLE departamento(
	denominacion varchar(100) not null constraint pk_departamento primary key,
	dui_miembro_representante char(10) not null
);

--TABLA miembro
CREATE TABLE miembro(
	dui char(10) not null constraint pk_miembro primary key,
	nombre varchar(50) not null,
	denominacion_departamento varchar(100) not null
);

--ALTER llaves secundarias entre departamento y miembro
ALTER TABLE departamento
	ADD constraint fk_departamento_miembro foreign key(dui_miembro_representante) references miembro(dui)
	ON delete restrict
	ON update cascade deferrable
;

ALTER TABLE miembro
	ADD constraint fk_miembro_departamento foreign key(denominacion_departamento) references departamento(denominacion)
	ON delete restrict
	ON update cascade deferrable
;

--TABLA version
CREATE TABLE version(
	codigo_proyecto char(5) not null,
	numero numeric(4,2) not null,
	descripcion text,
	constraint pk_version primary key(codigo_proyecto, numero),
	constraint fk_version_proyecto foreign key(codigo_proyecto) references proyecto(codigo)
	ON delete cascade ON update cascade
);

--TABLA superpachanga
CREATE TABLE superpachanga(
	nombre varchar(50) not null constraint pk_superpachanga primary key,
	lema varchar(50),
	anio smallint not null
);

--TABLA asiste
CREATE TABLE asiste(
	nombre_superpachanga varchar(50) not null,
	dui_miembro char(10) not null,
	constraint pk_asiste primary key(nombre_superpachanga, dui_miembro),
	constraint fk_asiste_superpachanga foreign key(nombre_superpachanga) references superpachanga(nombre)
	ON delete cascade ON update cascade,
	constraint fk_asiste_miembro foreign key(dui_miembro) references miembro(dui)
	ON delete cascade ON update cascade
);

--TABLA proyecto_parte
CREATE TABLE proyecto_parte(
	codigo_macroproyecto char(5) not null,
	codigo_subproyecto char(5) not null,
	constraint pk_proyecto_parte primary key(codigo_macroproyecto, codigo_subproyecto),
	constraint fk_macroproyecto foreign key(codigo_macroproyecto) references proyecto(codigo)
	ON delete cascade ON update cascade,
	constraint fk_subproyecto foreign key(codigo_subproyecto) references proyecto(codigo)
	ON delete cascade ON update cascade
);

--TABLA presenta
CREATE TABLE presenta(
	codigo_proyecto char(5) not null,
	nombre_superpachanga varchar(50) not null,
	dui_miembro char(10) not null,
	constraint pk_presenta primary key(codigo_proyecto, nombre_superpachanga),
	constraint fk_presenta_proyecto foreign key(codigo_proyecto) references proyecto(codigo)
	ON delete cascade ON update cascade,
	constraint fk_presenta_superpachanga foreign key(nombre_superpachanga) references superpachanga(nombre)
	ON delete cascade ON update cascade,
	constraint fk_presenta_miembro foreign key(dui_miembro) references miembro(dui)
	ON delete cascade ON update cascade
);

--TABLA web
CREATE TABLE web(
	codigo_proyecto char(5) not null constraint pk_web primary key,
	url varchar(100) not null,
	num_tablas integer,
	num_pantallas integer,
	constraint fk_web_proyecto foreign key(codigo_proyecto) references proyecto(codigo)
	ON delete cascade ON update cascade
);

--TABLA venta_almacen
CREATE TABLE venta_almacen(
	codigo_proyecto char(5) not null constraint pk_venta_almacen primary key,
	num_clientes integer not null,
	constraint fk_venta_almacen_proyecto foreign key(codigo_proyecto) references proyecto(codigo)
	ON delete cascade ON update cascade
);

--TABLA erp
CREATE TABLE erp(
	codigo_proyecto char(5) not null constraint pk_erp primary key,
	constraint fk_erp_proyecto foreign key(codigo_proyecto) references proyecto(codigo)
	ON delete cascade ON update cascade
);

--TABLA ingenieria
CREATE TABLE ingenieria(
	dui_miembro char(10) not null constraint pk_ingenieria primary key,
	constraint fk_ingenieria_miembro foreign key(dui_miembro) references miembro(dui)
	ON delete cascade ON update cascade
);

--TABLA gestion
CREATE TABLE gestion(
	dui_miembro char(10) not null constraint pk_gestion primary key,
	constraint fk_gestion_miembro foreign key(dui_miembro) references miembro(dui)
	ON delete cascade ON update cascade
);

--TABLA ventas
CREATE TABLE ventas(
	dui_miembro char(10) not null constraint pk_ventas primary key,
	constraint fk_ventas_miembro foreign key(dui_miembro) references miembro(dui)
	ON delete cascade ON update cascade
);

--TABLA desarrolla
CREATE TABLE desarrolla(
	codigo_proyecto char(5) not null,
	dui_miembro_ingenieria char(10) not null,
	labor varchar(30),
	constraint pk_desarrolla primary key(codigo_proyecto, dui_miembro_ingenieria),
	constraint fk_desarrolla_proyecto foreign key(codigo_proyecto) references proyecto(codigo)
	ON delete cascade ON update cascade,
	constraint fk_desarrolla_miembro_ingenieria foreign key(dui_miembro_ingenieria) references ingenieria(dui_miembro)
	ON delete cascade ON update cascade
);

--TABLA modulo erp
CREATE TABLE modulo_erp(
	codigo_proyecto char(5) not null,
	numero integer,
	descripcion varchar(30),
	constraint pk_modulo_erp primary key(codigo_proyecto, numero, descripcion),
	constraint fk_modulo_erp_proyecto foreign key(codigo_proyecto) references proyecto(codigo)
	ON delete cascade ON update cascade
);

--TABLA contrata
CREATE TABLE contrata(
	codigo_proyecto char(5) not null,
	dui_cliente char(10) not null,
	dui_miembro_gestion char(10) not null,
	descuento money not null default 0,
	implantación_fecha_inicio date not null,
	implantación_precio money not null default 0,
	mantenimiento_periodicidad varchar(30) not null,
	mantenimiento_precio money not null default 0,
	constraint pk_contrata primary key(codigo_proyecto, dui_cliente),
	constraint fk_contrata_proyecto foreign key(codigo_proyecto) references proyecto(codigo)
	ON delete cascade ON update cascade,
	constraint fk_contrata_cliente foreign key(dui_cliente) references cliente(dui)
	ON delete cascade ON update cascade,
	constraint fk_contrata_miembro_gestion foreign key(dui_miembro_gestion) references gestion(dui_miembro)
	ON delete cascade ON update cascade
);

--TABLA atiende
CREATE TABLE atiende(
	codigo_proyecto char(5) not null,
	dui_cliente char(10) not null,
	dui_miembro_ventas char(10),
	constraint pk_atiende primary key(codigo_proyecto, dui_cliente, dui_miembro_ventas),
	constraint fk_atiende_proyecto foreign key(codigo_proyecto) references proyecto(codigo)
	ON delete cascade ON update cascade,
	constraint fk_atiende_cliente foreign key(dui_cliente) references cliente(dui)
	ON delete cascade ON update cascade,
	constraint fk_atiende_miembro_ventas foreign key(dui_miembro_ventas) references ventas(dui_miembro)
	ON delete cascade ON update cascade
);
