
\c template1

drop database if exists ucasoft;

create database ucasoft;

\c ucasoft

drop table if exists proyecto cascade;
create table proyecto(
	codigo	char(5) not null,
	denominacion varchar(100) not null,
	tipo varchar(30) not null check (tipo in ('Web','Venta_almacen','ERP')),
	desc_txt text,
	desc_doc bytea,
	monto_acumulado money not null default 0,
	url varchar(100),
	constraint pk_proyecto primary key (codigo));
	
insert into proyecto values ('00001','Web DEI','Web',null,null,1500,'http://dei.uca.edu.sv');
insert into proyecto values ('00002','Web UCA','Web',null,null,3500,'http://www.uca.edu.sv');
insert into proyecto values ('00003','Web salud.gob.sv','Web',null,null,3000,'http://www.salud.gob.sv');
insert into proyecto values ('00004','Web superpachanga.ucasoft.com','Web',null,null,0,'http://superpachanga.ucasoft.com');
insert into proyecto values ('00005','aulavirt','Web',null,null,18000,'http://dei.uca.edu.sv/aulavirt');
insert into proyecto values ('00006','teubi.co','Venta_almacen',null,null,1000,null);
insert into proyecto values ('00007','supernoelecto','Venta_almacen',null,null,80000,null);
insert into proyecto values ('00008','ualmar','Venta_almacen',null,null,50000,null);
insert into proyecto values ('00009','despensadedoñaines','Venta_almacen',null,null,20000,null);
insert into proyecto values ('00010','powerrepuestos','ERP',null,null,40000,null);
insert into proyecto values ('00011','laatencao','ERP',null,null,50000,null);
insert into proyecto values ('00012','simon','ERP',null,null,90000,null);
insert into proyecto values ('00013','moonbucks','ERP',null,null,45000,null);

drop table if exists cliente cascade;
create table cliente(
	DUI	char(10) not null,
	denominacion varchar(100) not null,
	tipo varchar(30) not null check (tipo in ('Persona física','Empresa','ONG','Institución pública','Institución académica')),
	constraint pk_cliente primary key (DUI));

insert into cliente values ('01234567-8','Carlos Juarez','Institución académica');
insert into cliente values ('12345678-9','Andreu Oliva','Institución académica');
insert into cliente values ('23456789-0','María Isabel Rodríguez','Institución pública');
insert into cliente values ('34567890-1','Guillermo Pérez','Empresa');
insert into cliente values ('45678901-2','Mario Gómez','Empresa');
insert into cliente values ('56789012-3','Charly Alley','Empresa');
insert into cliente values ('67890123-4','Eduardo Solórzano','Empresa');
insert into cliente values ('78901234-5','Manuel Goreiro','Empresa');
insert into cliente values ('89012345-6','Kevin Ojst','Empresa');
insert into cliente values ('90123456-7','Mario Simon','Empresa');
insert into cliente values ('01123456-7','Yey Yey Simon','Empresa');
insert into cliente values ('11234567-8','Kevin Jimson','Empresa');

drop table if exists departamento cascade;
create table departamento(
	denominacion varchar(100) not null,
	DUI_miembro_representante	char(10) not null,
	constraint pk_departamento primary key (denominacion));
-- foreign key a miembro(DUI) postergada hasta la creación de la tabla miembro

drop table if exists version cascade;
create table version(
	codigo_proyecto	char(5) not null,
	numero numeric(4,2) not null,
	descripcion text,
	constraint pk_version_proyecto primary key (codigo_proyecto,numero),
	constraint fk_version_proyecto foreign key (codigo_proyecto)
	references proyecto(codigo) on delete cascade on update cascade);

insert into version values ('00001',01.00);
insert into version values ('00001',01.10);
insert into version values ('00001',02.00);
insert into version values ('00002',01.00);
insert into version values ('00002',02.00);
insert into version values ('00003',01.00);
insert into version values ('00004',01.00);
insert into version values ('00005',01.00);
insert into version values ('00005',01.10);
insert into version values ('00005',01.20);
insert into version values ('00006',01.00);
insert into version values ('00006',01.10);
insert into version values ('00006',01.20);
insert into version values ('00006',02.00);
insert into version values ('00007',01.00);
insert into version values ('00008',01.00);
insert into version values ('00009',01.00);
insert into version values ('00010',01.00);
insert into version values ('00011',01.00);
insert into version values ('00012',01.00);
insert into version values ('00012',02.00);
insert into version values ('00012',03.00);
insert into version values ('00012',03.20);
insert into version values ('00013',01.00);
	
drop table if exists superpachanga cascade;
create table superpachanga(
	nombre varchar(100) not null,
	lema varchar(100) not null,
	anyo smallint unique not null check (anyo between 2015 and 2100),
	constraint pk_superpachanga primary key (nombre));
	
insert into superpachanga values('El gran despije','Mañana no existe',2015);
insert into superpachanga values('Still alive','Siempre insensato, nunca ininsensato',2016);
insert into superpachanga values('La vida es una tómbola','De luz y de coloooor',2017);
insert into superpachanga values('Secret level unlocked','Lets play!',2018);
insert into superpachanga values('Más madera','Dijo Groucho',2019);

drop table if exists miembro cascade;
create table miembro(
	DUI	char(10) not null,
	nombre varchar(100) not null,
	denominacion_departamento varchar(100) not null,
	constraint pk_miembro primary key (DUI),
	constraint fk_miembro_departamento foreign key (denominacion_departamento) 
	references departamento(denominacion) on delete restrict on update cascade deferrable);

-- Ojo, se establece en este momento por referencia circular entre tablas
alter table departamento add constraint fk_departamento_miembro foreign key (DUI_miembro_representante) references miembro(DUI) on delete restrict on update cascade;

-- Transacción necesaria por referencia circular.
BEGIN;

SET CONSTRAINTS fk_miembro_departamento DEFERRED;

insert into miembro values('04926243-5','Ana Ramírez','Ventas');
insert into miembro values('12345678-1','Manolo Lama','Ventas');
insert into miembro values('34345578-2','Esmeralda Alonso','Ventas');
insert into miembro values('54235576-4','Juan Luque','Ventas');
insert into miembro values('02112463-5','Susana Cantor','Gestión');
insert into miembro values('53463278-1','Pedro Santos','Gestión');
insert into miembro values('34531178-8','Carolina Flores','Gestión');
insert into miembro values('22329787-2','Lucio Suárez','Gestión');
insert into miembro values('89326243-7','Martín Deras','Ingeniería');
insert into miembro values('72234278-3','Ramón Pérez','Ingeniería');
insert into miembro values('24455578-6','Clara Datas','Ingeniería');
insert into miembro values('54232478-2','Magdalena Díaz','Ingeniería');
insert into miembro values('42334528-3','Antonio López','Ingeniería');	
	
insert into departamento values ('Ventas','04926243-5');
insert into departamento values ('Gestión','34531178-8');
insert into departamento values ('Ingeniería','24455578-6');

COMMIT;
	
drop table if exists asiste cascade;
create table asiste(
	nombre_superpachanga varchar(100) not null,
	DUI_miembro	char(10) not null,
	constraint pk_asiste primary key (nombre_superpachanga,DUI_miembro),
	constraint fk_asiste_superpachanga foreign key (nombre_superpachanga) references superpachanga(nombre) on delete cascade on update cascade,
	constraint fk_asiste_miembro foreign key (DUI_miembro) references miembro(DUI) on delete cascade on update cascade);

insert into asiste values('El gran despije','04926243-5');
insert into asiste values('El gran despije','12345678-1');
insert into asiste values('El gran despije','34345578-2');
insert into asiste values('El gran despije','54235576-4');
insert into asiste values('El gran despije','02112463-5');
insert into asiste values('El gran despije','53463278-1');
insert into asiste values('El gran despije','34531178-8');
insert into asiste values('El gran despije','22329787-2');
insert into asiste values('El gran despije','89326243-7');
insert into asiste values('El gran despije','72234278-3');
insert into asiste values('El gran despije','24455578-6');
insert into asiste values('El gran despije','54232478-2');
insert into asiste values('El gran despije','42334528-3');
insert into asiste values('Still alive','04926243-5');
insert into asiste values('Still alive','12345678-1');
insert into asiste values('Still alive','54235576-4');
insert into asiste values('Still alive','02112463-5');
insert into asiste values('Still alive','53463278-1');
insert into asiste values('Still alive','34531178-8');
insert into asiste values('Still alive','22329787-2');
insert into asiste values('Still alive','89326243-7');
insert into asiste values('Still alive','72234278-3');
insert into asiste values('Still alive','24455578-6');
insert into asiste values('Still alive','54232478-2');
insert into asiste values('Still alive','42334528-3');
insert into asiste values('La vida es una tómbola','04926243-5');
insert into asiste values('La vida es una tómbola','12345678-1');
insert into asiste values('La vida es una tómbola','54235576-4');
insert into asiste values('La vida es una tómbola','02112463-5');
insert into asiste values('La vida es una tómbola','53463278-1');
insert into asiste values('La vida es una tómbola','22329787-2');
insert into asiste values('La vida es una tómbola','89326243-7');
insert into asiste values('La vida es una tómbola','72234278-3');
insert into asiste values('La vida es una tómbola','54232478-2');
insert into asiste values('La vida es una tómbola','42334528-3');
insert into asiste values('Secret level unlocked','04926243-5');
insert into asiste values('Secret level unlocked','12345678-1');
insert into asiste values('Secret level unlocked','34345578-2');
insert into asiste values('Secret level unlocked','54235576-4');
insert into asiste values('Secret level unlocked','02112463-5');
insert into asiste values('Secret level unlocked','53463278-1');
insert into asiste values('Secret level unlocked','72234278-3');
insert into asiste values('Secret level unlocked','24455578-6');
insert into asiste values('Secret level unlocked','54232478-2');
insert into asiste values('Secret level unlocked','42334528-3');
insert into asiste values('Más madera','04926243-5');
insert into asiste values('Más madera','54235576-4');
insert into asiste values('Más madera','02112463-5');
insert into asiste values('Más madera','53463278-1');
insert into asiste values('Más madera','34531178-8');
insert into asiste values('Más madera','22329787-2');
insert into asiste values('Más madera','89326243-7');
insert into asiste values('Más madera','54232478-2');
insert into asiste values('Más madera','42334528-3');

	
drop table if exists proyecto_parte cascade;
create table proyecto_parte(
	codigo_macroproyecto	char(5) not null,
	codigo_subproyecto	char(5) not null,
	constraint pk_proyecto_parte primary key (codigo_macroproyecto,codigo_subproyecto),
	constraint fk_macroproyecto_proyecto foreign key (codigo_macroproyecto)
	references proyecto(codigo) on delete cascade on update cascade,
	constraint fk_subproyecto_proyecto foreign key (codigo_subproyecto)
	references proyecto(codigo) on delete cascade on update cascade);

insert into proyecto_parte values ('00002','00001');
insert into proyecto_parte values ('00001','00005');
insert into proyecto_parte values ('00007','00006');
insert into proyecto_parte values ('00007','00008');
insert into proyecto_parte values ('00011','00010');
insert into proyecto_parte values ('00009','00012');


drop table if exists presenta cascade;
create table presenta(
	codigo_proyecto	char(5) not null,
	nombre_superpachanga varchar(100) not null,
	DUI_miembro	char(10) not null,
	constraint pk_presenta primary key (codigo_proyecto,nombre_superpachanga), -- no incluimos DUI_miembro en la PK a propósito
	constraint fk_presenta_proyecto foreign key (codigo_proyecto) references proyecto(codigo) on delete cascade on update cascade,
	constraint fk_presenta_superpachanga foreign key (nombre_superpachanga) references superpachanga(nombre) on delete cascade on update cascade,
	constraint fk_presenta_miembro foreign key (DUI_miembro) references miembro(DUI) on delete cascade on update cascade
	);	

insert into presenta values('00002','El gran despije','02112463-5');
insert into presenta values('00009','Still alive','24455578-6');
insert into presenta values('00007','La vida es una tómbola','42334528-3');
insert into presenta values('00011','Secret level unlocked','53463278-1');
insert into presenta values('00005','Más madera','02112463-5');
	
drop table if exists web cascade;
create table web(
	codigo_proyecto	char(5) not null,
	url varchar(100) not null,
	num_tablas smallint not null check (num_tablas >0),
	num_pantallas smallint not null check (num_pantallas >0),
	constraint pk_web primary key (codigo_proyecto),
	constraint fk_web_proyecto foreign key (codigo_proyecto)
	references proyecto(codigo) on delete cascade on update cascade);

insert into web values ('00001','http://dei.uca.edu.sv',35,20);
insert into web values ('00002','http://www.uca.edu.sv',45,50);
insert into web values ('00003','http://www.salud.gob.sv',43,40);
insert into web values ('00004','http://superpachanga.ucasoft.com',10,6);
insert into web values ('00005','http://dei.uca.edu.sv/aulavirt',60,30);

drop table if exists venta_almacen cascade;
create table venta_almacen(
	codigo_proyecto	char(5) not null,
	num_clientes smallint not null check (num_clientes>0),
	constraint pk_venta_almacen primary key (codigo_proyecto),
	constraint fk_venta_almacen_proyecto foreign key (codigo_proyecto)
	references proyecto(codigo) on delete cascade on update cascade);

insert into venta_almacen values ('00006',10);
insert into venta_almacen values ('00007',400);
insert into venta_almacen values ('00008',20);
insert into venta_almacen values ('00009',4);
	
drop table if exists erp cascade;
create table erp(
	codigo_proyecto	char(5) not null,
	constraint pk_erp primary key (codigo_proyecto),
	constraint fk_erp_proyecto foreign key (codigo_proyecto)
	references proyecto(codigo) on delete cascade on update cascade);

insert into erp values ('00010');
insert into erp values ('00011');
insert into erp values ('00012');
insert into erp values ('00013');

drop table if exists ingenieria cascade;
create table ingenieria(
	DUI_miembro	char(10) not null,
	constraint pk_ingenieria primary key (DUI_miembro),
	constraint fk_ingenieria_miembro foreign key (DUI_miembro) references miembro(DUI) on delete cascade on update cascade
	);

insert into ingenieria values('89326243-7');
insert into ingenieria values('72234278-3');
insert into ingenieria values('24455578-6');
insert into ingenieria values('54232478-2');
insert into ingenieria values('42334528-3');	

drop table if exists gestion cascade;
create table gestion(
	DUI_miembro	char(10) not null,
	constraint pk_gestion primary key (DUI_miembro),
	constraint fk_gestion_miembro foreign key (DUI_miembro) references miembro(DUI) on delete cascade on update cascade
	);
insert into gestion values('02112463-5');
insert into gestion values('53463278-1');
insert into gestion values('34531178-8');
insert into gestion values('22329787-2');

drop table if exists ventas cascade;
create table ventas(
	DUI_miembro	char(10) not null,
	constraint pk_ventas primary key (DUI_miembro),
	constraint fk_ventas_miembro foreign key (DUI_miembro) references miembro(DUI) on delete cascade on update cascade
	);

insert into ventas values('04926243-5');
insert into ventas values('12345678-1');
insert into ventas values('34345578-2');
insert into ventas values('54235576-4');

drop table if exists desarrolla cascade;
create table desarrolla(
	codigo_proyecto	char(5) not null,
	DUI_miembro_ingenieria	char(10) not null,
	labor text,
	constraint pk_desarrolla primary key (codigo_proyecto,DUI_miembro_ingenieria),
	constraint fk_desarrolla_proyecto foreign key (codigo_proyecto) references proyecto(codigo) on delete cascade on update cascade,
	constraint fk_desarrolla_miembro_ingenieria foreign key (DUI_miembro_ingenieria) references ingenieria(DUI_miembro) on delete cascade on update cascade
	);	

insert into desarrolla values ('00001','89326243-7','Coordinación');
insert into desarrolla values ('00001','72234278-3','Desarrollo');
insert into desarrolla values ('00001','42334528-3','Testing');
insert into desarrolla values ('00002','89326243-7','Coordinación');
insert into desarrolla values ('00002','24455578-6','Desarrollo');
insert into desarrolla values ('00002','42334528-3','Testing');
insert into desarrolla values ('00003','89326243-7','Coordinación');
insert into desarrolla values ('00003','72234278-3','Desarrollo');
insert into desarrolla values ('00004','54232478-2','Coordinación');
insert into desarrolla values ('00004','24455578-6','Desarrollo');
insert into desarrolla values ('00005','89326243-7','Coordinación');
insert into desarrolla values ('00005','72234278-3','Desarrollo');
insert into desarrolla values ('00005','24455578-6','Desarrollo');
insert into desarrolla values ('00005','54232478-2','Testing');
insert into desarrolla values ('00006','72234278-3','Coordinación');
insert into desarrolla values ('00006','24455578-6','Desarrollo');
insert into desarrolla values ('00006','42334528-3','Testing');
insert into desarrolla values ('00007','24455578-6','Coordinación');
insert into desarrolla values ('00007','54232478-2','Desarrollo');
insert into desarrolla values ('00008','89326243-7','Coordinación');
insert into desarrolla values ('00008','54232478-2','Desarrollo');
insert into desarrolla values ('00008','42334528-3','Testing');
insert into desarrolla values ('00009','54232478-2','Coordinación');
insert into desarrolla values ('00009','89326243-7','Desarrollo');
insert into desarrolla values ('00010','89326243-7','Coordinación');
insert into desarrolla values ('00010','72234278-3','Desarrollo');
insert into desarrolla values ('00010','54232478-2','Testing');
insert into desarrolla values ('00011','42334528-3','Coordinación');
insert into desarrolla values ('00011','24455578-6','Desarrollo');
insert into desarrolla values ('00012','89326243-7','Coordinación');
insert into desarrolla values ('00012','72234278-3','Desarrollo');
insert into desarrolla values ('00012','42334528-3','Testing');
insert into desarrolla values ('00013','72234278-3','Coordinación');
insert into desarrolla values ('00013','24455578-6','Desarrollo');
insert into desarrolla values ('00013','54232478-2','Testing');
	
drop table if exists modulo_erp cascade;
create table modulo_erp(
	codigo_proyecto_erp	char(5) not null,
	numero smallint not null,
	descripcion varchar(100) not null,
	constraint pk_modulo_erp primary key (codigo_proyecto_erp,numero,descripcion),
	constraint fk_modulo_erp_erp foreign key (codigo_proyecto_erp)
	references erp(codigo_proyecto) on delete cascade on update cascade);

insert into modulo_erp values ('00010',1,'RRHH');
insert into modulo_erp values ('00010',2,'CRM');
insert into modulo_erp values ('00010',3,'Finanzas');
insert into modulo_erp values ('00011',1,'RRHH');
insert into modulo_erp values ('00011',2,'CRM');
insert into modulo_erp values ('00012',2,'CRM');
insert into modulo_erp values ('00012',3,'Finanzas');
insert into modulo_erp values ('00013',1,'RRHH');
insert into modulo_erp values ('00013',2,'CRM');
insert into modulo_erp values ('00013',3,'Finanzas');
	
drop table if exists contrata cascade;
create table contrata(
	codigo_proyecto	char(5) not null,
	DUI_cliente	char(10) not null,
	DUI_miembro_gestion	char(10) not null,
	descuento smallint not null default 0 check (descuento between 0 and 100),
	implantacion_fecha_inicio date not null,
	implantacion_precio money not null,
	mantenimiento_periodicidad varchar(40) not null check (mantenimiento_periodicidad in ('Mensual','Bimestral','Trimestral','Cuatrimestral','Semestral','Anual')),
	mantenimiento_precio money not null,
	constraint pk_contrata primary key (codigo_proyecto,DUI_cliente), -- DUI_miembro_gestion omitido a propósito
	constraint fk_contrata_proyecto foreign key (codigo_proyecto) references proyecto(codigo) on delete cascade on update cascade,
	constraint fk_contrata_cliente foreign key (DUI_cliente) references cliente(DUI) on delete cascade on update cascade,
	constraint fk_contrata_miembro_gestion foreign key (DUI_miembro_gestion) references gestion(DUI_miembro) on delete cascade on update cascade
	);	

insert into contrata values ('00001','01234567-8','02112463-5',0,'3/10/2015',1500,'Trimestral',200);
insert into contrata values ('00002','01234567-8','02112463-5',0,'18/1/2017',1500,'Bimestral',200);
insert into contrata values ('00002','12345678-9','02112463-5',0,'23/12/2018',2000,'Trimestral',250);
insert into contrata values ('00003','23456789-0','53463278-1',0,'17/2/2016',3000,'Trimestral',200);
insert into contrata values ('00004','34567890-1','02112463-5',0,'1/4/2016',0,'Anual',0);
insert into contrata values ('00005','01234567-8','53463278-1',0,'5/4/2017',18000,'Mensual',200);
insert into contrata values ('00006','45678901-2','34531178-8',0,'8/3/2018',1000,'Semestral',200);
insert into contrata values ('00007','56789012-3','34531178-8',0,'10/6/2015',80000,'Bimestral',2000);
insert into contrata values ('00008','67890123-4','34531178-8',0,'2/11/2016',50000,'Mensual',2500);
insert into contrata values ('00009','78901234-5','34531178-8',0,'25/10/2016',20000,'Trimestral',1500);
insert into contrata values ('00010','89012345-6','53463278-1',0,'23/12/2017',40000,'Bimestral',1500);
insert into contrata values ('00011','90123456-7','53463278-1',0,'7/9/2018',50000,'Semestral',4000);
insert into contrata values ('00012','01123456-7','22329787-2',0,'9/5/2019',90000,'Trimestral',2000);
insert into contrata values ('00013','11234567-8','22329787-2',0,'11/1/2019',45000,'Trimestral',1000);


drop table if exists atiende cascade;
create table atiende(
	codigo_proyecto	char(5) not null,
	DUI_cliente	char(10) not null,
	DUI_miembro_ventas	char(10) not null,
	constraint pk_atiende primary key (codigo_proyecto,DUI_cliente,DUI_miembro_ventas),
	constraint fk_atiende_proyecto foreign key (codigo_proyecto) references proyecto(codigo) on delete cascade on update cascade,
	constraint fk_atiende_cliente foreign key (DUI_cliente) references cliente(DUI) on delete cascade on update cascade,
	constraint fk_atiende_miembro_ventas foreign key (DUI_miembro_ventas) references ventas(DUI_miembro) on delete cascade on update cascade
	);	

insert into atiende values ('00001','01234567-8','04926243-5');
insert into atiende values ('00002','01234567-8','04926243-5');
insert into atiende values ('00002','12345678-9','04926243-5');
insert into atiende values ('00003','23456789-0','04926243-5');
insert into atiende values ('00003','23456789-0','12345678-1');
insert into atiende values ('00004','34567890-1','04926243-5');
insert into atiende values ('00005','01234567-8','04926243-5');
insert into atiende values ('00005','01234567-8','12345678-1');
insert into atiende values ('00006','45678901-2','34345578-2');
insert into atiende values ('00007','56789012-3','34345578-2');
insert into atiende values ('00008','67890123-4','34345578-2');
insert into atiende values ('00009','78901234-5','34345578-2');
insert into atiende values ('00010','89012345-6','54235576-4');
insert into atiende values ('00010','89012345-6','12345678-1');
insert into atiende values ('00011','90123456-7','54235576-4');
insert into atiende values ('00011','90123456-7','12345678-1');
insert into atiende values ('00012','01123456-7','54235576-4');
insert into atiende values ('00012','01123456-7','12345678-1');
insert into atiende values ('00013','11234567-8','54235576-4');
insert into atiende values ('00013','11234567-8','12345678-1');
