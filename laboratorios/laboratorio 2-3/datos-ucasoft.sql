﻿	
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
	
insert into superpachanga values('El gran despije','Mañana no existe',2015);
insert into superpachanga values('Still alive','Siempre insensato, nunca ininsensato',2016);
insert into superpachanga values('La vida es una tómbola','De luz y de coloooor',2017);
insert into superpachanga values('Secret level unlocked','Lets play!',2018);
insert into superpachanga values('Más madera','Dijo Groucho',2019);

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

insert into proyecto_parte values ('00002','00001');
insert into proyecto_parte values ('00001','00005');
insert into proyecto_parte values ('00007','00006');
insert into proyecto_parte values ('00007','00008');
insert into proyecto_parte values ('00011','00010');
insert into proyecto_parte values ('00009','00012');

insert into presenta values('00002','El gran despije','02112463-5');
insert into presenta values('00009','Still alive','24455578-6');
insert into presenta values('00007','La vida es una tómbola','42334528-3');
insert into presenta values('00011','Secret level unlocked','53463278-1');
insert into presenta values('00005','Más madera','02112463-5');
	
insert into web values ('00001','http://dei.uca.edu.sv',35,20);
insert into web values ('00002','http://www.uca.edu.sv',45,50);
insert into web values ('00003','http://www.salud.gob.sv',43,40);
insert into web values ('00004','http://superpachanga.ucasoft.com',10,6);
insert into web values ('00005','http://dei.uca.edu.sv/aulavirt',60,30);

insert into venta_almacen values ('00006',10);
insert into venta_almacen values ('00007',400);
insert into venta_almacen values ('00008',20);
insert into venta_almacen values ('00009',4);
	
insert into erp values ('00010');
insert into erp values ('00011');
insert into erp values ('00012');
insert into erp values ('00013');

insert into ingenieria values('89326243-7');
insert into ingenieria values('72234278-3');
insert into ingenieria values('24455578-6');
insert into ingenieria values('54232478-2');
insert into ingenieria values('42334528-3');	

insert into gestion values('02112463-5');
insert into gestion values('53463278-1');
insert into gestion values('34531178-8');
insert into gestion values('22329787-2');

insert into ventas values('04926243-5');
insert into ventas values('12345678-1');
insert into ventas values('34345578-2');
insert into ventas values('54235576-4');

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
	
insert into contrata values ('00001','01234567-8','02112463-5',0,'2015/10/03',1500,'Trimestral',200);
insert into contrata values ('00002','01234567-8','02112463-5',0,'2017/1/18',1500,'Bimestral',200);
insert into contrata values ('00002','12345678-9','02112463-5',0,'2018/12/23',2000,'Trimestral',250);
insert into contrata values ('00003','23456789-0','53463278-1',0,'2016/2/17',3000,'Trimestral',200);
insert into contrata values ('00004','34567890-1','02112463-5',0,'2016/4/1',0,'Anual',0);
insert into contrata values ('00005','01234567-8','53463278-1',0,'2017/4/5',18000,'Mensual',200);
insert into contrata values ('00006','45678901-2','34531178-8',0,'2018/3/8',1000,'Semestral',200);
insert into contrata values ('00007','56789012-3','34531178-8',0,'2015/6/10',80000,'Bimestral',2000);
insert into contrata values ('00008','67890123-4','34531178-8',0,'2016/11/2',50000,'Mensual',2500);
insert into contrata values ('00009','78901234-5','34531178-8',0,'2016/10/25',20000,'Trimestral',1500);
insert into contrata values ('00010','89012345-6','53463278-1',0,'2017/12/23',40000,'Bimestral',1500);
insert into contrata values ('00011','90123456-7','53463278-1',0,'2018/9/7',50000,'Semestral',4000);
insert into contrata values ('00012','01123456-7','22329787-2',0,'2019/9/5',90000,'Trimestral',2000);
insert into contrata values ('00013','11234567-8','22329787-2',0,'2019/1/11',45000,'Trimestral',1000);

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
