insert into suministrador values ('sum0','Freund Construcción','Calle La Sultana','Antiguo Cuscatlán');
insert into suministrador values ('sum1','Vidrí Mayoreo','Bulevar del Hipódromo','San Salvador');
insert into suministrador values ('sum2','EPA','Bulevar del Ejército','Soyapango');
insert into suministrador values ('sum3','Freund Soya','Bulevar del Ejército','Soyapango');
insert into suministrador values ('sum4','Vidrí Soya','Calle a Ciudadela Don Bosco','Soyapango');

insert into pieza values ('p001','Tornillo grande',2.1,2000);
insert into pieza values ('p002','Tornillo chico',0.4,7000);
insert into pieza values ('p003','Cemento',2000,200);
insert into pieza values ('p004','Arena',1000,2000);
insert into pieza values ('p005','Martillo',2000,18);
insert into pieza values ('p006','Galón pintura',5000,350);
insert into pieza values ('p007','Tomacorriente doble',15,1000);
insert into pieza values ('p008','Desatornillador',null,20);
insert into pieza values ('p009','Clavos gordos',null,200);
insert into pieza values ('p010','Pega loca',2,28);


insert into suministro values('p001','sum0');
insert into suministro values('p002','sum0');
insert into suministro values('p003','sum0');
insert into suministro values('p004','sum0');
insert into suministro values('p005','sum0');
insert into suministro values('p006','sum0');
insert into suministro values('p007','sum0');
insert into suministro values('p008','sum0');
insert into suministro values('p001','sum1');
insert into suministro values('p002','sum1');
insert into suministro values('p003','sum1');
insert into suministro values('p004','sum1');
insert into suministro values('p005','sum1');
insert into suministro values('p001','sum2');
insert into suministro values('p002','sum2');
insert into suministro values('p003','sum2');
insert into suministro values('p004','sum2');
insert into suministro values('p001','sum3');
insert into suministro values('p002','sum3');
insert into suministro values('p003','sum3');
insert into suministro values('p004','sum3');
insert into suministro values('p005','sum3');
insert into suministro values('p006','sum3');
insert into suministro values('p003','sum4');
insert into suministro values('p004','sum4');
insert into suministro values('p005','sum4');
insert into suministro values('p006','sum4');
insert into suministro values('p008','sum4');
insert into suministro values('p009','sum4');

insert into departamento values('d0001','Atención al cliente');
insert into departamento values('d0002','Ingeniería');
insert into departamento values('d0003','Administración');
insert into departamento values('d0004','I+D');

insert into empleado values('04926243-5','Ana Ramírez',3200.23,NULL,'d0003');
insert into empleado values('12345678-1','Manolo Lama',3400.50,'04926243-5','d0003');
insert into empleado values('34345578-2','Esmeralda Alonso',1800.30,'04926243-5','d0003');
insert into empleado values('54235576-4','Juan Luque',1300.00,'34345578-2','d0003');

insert into empleado values('02112463-5','Susana Cantor',2200.13,'04926243-5','d0002');
insert into empleado values('53463278-1','Pedro Santos',800.80,'02112463-5','d0002');
insert into empleado values('34531178-8','Carolina Flores',4300.50,'02112463-5','d0002');
insert into empleado values('22329787-2','Lucio Suárez',1400.10,'34531178-8','d0002');

insert into empleado values('89326243-7','Martín Deras',3200.22,'04926243-5','d0001');
insert into empleado values('72234278-3','Ramón Pérez',2400.25,'89326243-7','d0001');
insert into empleado values('24455578-6','Clara Datas',2000.15,'89326243-7','d0001');
insert into empleado values('54232478-2','Magdalena Díaz',1900.70,'89326243-7','d0001');

insert into empleado values('42334528-3','Antonio López',3000.70,'04926243-5','d0004');
