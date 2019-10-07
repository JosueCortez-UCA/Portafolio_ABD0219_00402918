--NIVELES
INSERT INTO public.nivel values('inicial');
INSERT INTO public.nivel values('parvularia');
INSERT INTO public.nivel values('basica');
INSERT INTO public.nivel values('media');

--GRADOS
INSERT INTO public.grado values(1,'inicial');
INSERT INTO public.grado values(1,'parvularia');
INSERT INTO public.grado values(2,'parvularia');
INSERT INTO public.grado values(1,'basica');
INSERT INTO public.grado values(2,'basica');
INSERT INTO public.grado values(3,'basica');
INSERT INTO public.grado values(4,'basica');
INSERT INTO public.grado values(5,'basica');
INSERT INTO public.grado values(6,'basica');
INSERT INTO public.grado values(7,'basica');
INSERT INTO public.grado values(8,'basica');
INSERT INTO public.grado values(9,'basica');
INSERT INTO public.grado values(1,'media');
INSERT INTO public.grado values(2,'media');

--SECCIONES
INSERT INTO public.seccion values('a',1,'basica');
INSERT INTO public.seccion values('b',1,'basica');
INSERT INTO public.seccion values('a',2,'basica');
INSERT INTO public.seccion values('a',3,'basica');
INSERT INTO public.seccion values('a',4,'basica');
INSERT INTO public.seccion values('a',5,'basica');
INSERT INTO public.seccion values('a',6,'basica');
INSERT INTO public.seccion values('b',6,'basica');

--EDIFICIOS
INSERT INTO public.edificio values('Edificio 1');
INSERT INTO public.edificio values('Edificio 2');

--AULAS
INSERT INTO public.aula values(1,1,'Edificio 1',100);
INSERT INTO public.aula values(1,2,'Edificio 1',100);

INSERT INTO public.aula values(2,1,'Edificio 1',50);
INSERT INTO public.aula values(2,2,'Edificio 1',50);
INSERT INTO public.aula values(2,3,'Edificio 1',50);
INSERT INTO public.aula values(2,4,'Edificio 1',50);

INSERT INTO public.aula values(3,1,'Edificio 1',50);
INSERT INTO public.aula values(3,2,'Edificio 1',50);
INSERT INTO public.aula values(3,3,'Edificio 1',50);
INSERT INTO public.aula values(3,4,'Edificio 1',50);

--CLASES
INSERT INTO public.clase values(1,1);
INSERT INTO public.clase values(1,2);

INSERT INTO public.clase values(2,1);
INSERT INTO public.clase values(2,2);
INSERT INTO public.clase values(2,3);
INSERT INTO public.clase values(2,4);

--LABS Y CENTROS DE COMPU
INSERT INTO public.lab_cc values(3,1);
INSERT INTO public.lab_cc values(3,2);
INSERT INTO public.lab_cc values(3,3);
INSERT INTO public.lab_cc values(3,4);

--AÑOS
INSERT INTO public.annio values(2019);