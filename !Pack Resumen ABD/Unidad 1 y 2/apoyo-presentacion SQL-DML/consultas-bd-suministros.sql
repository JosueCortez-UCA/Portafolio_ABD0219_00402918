/* PARTE 1 */

-- Nombres de Piezas que pesen más de 15 gramos y que su Cantidad sea menor o igual que 30”:
SELECT nombre_p FROM Pieza 
WHERE Peso>15 AND Cantidad<=30;

-- Piezas de las que se ignore el Peso
SELECT * FROM Pieza
WHERE Peso IS NULL;

-- Números de Suministradores que Suministren una Pieza de 15 gramos
SELECT Suministro.suministrador_id_s FROM Pieza, Suministro
WHERE Pieza.id_p = Suministro.pieza_id_p AND Peso=15;

-- Nombres de Suministradores que Suministren una Pieza de 15 gramos
SELECT Nombre_s FROM Suministrador, Pieza, Suministro
WHERE Suministro.pieza_id_p = Pieza.id_p AND Peso=15
AND Suministro.suministrador_id_s = Suministrador.id_s;

-- Nombres de Piezas suministradas desde Soyapango (Usando alias de tablas)
SELECT nombre_p FROM Suministrador S, Pieza P, Suministro SP 
WHERE SP.pieza_id_p = P.id_p AND SP.suministrador_id_s = S.id_s AND Ciudad='Soyapango';

-- Nombres de Piezas diferentes suministradas desde Soyapango (Usando alias de tablas)
SELECT DISTINCT nombre_p FROM Suministrador S, Pieza P, Suministro SP 
WHERE SP.pieza_id_p = P.id_p AND SP.suministrador_id_s = S.id_s AND Ciudad='Soyapango';

-- Códigos de suministradores que no suministren la pieza 'p008'
SELECT id_s FROM Suministrador
EXCEPT
SELECT suministrador_id_s FROM Suministro 
WHERE pieza_id_p='p008';

/* PARTE 2 */

-- Nombres de Piezas diferentes suministradas desde Soyapango (Usando JOIN)
SELECT DISTINCT nombre_p 
FROM ((Suministro SP JOIN Pieza P ON P.id_p=SP.pieza_id_p) 
     JOIN Suministrador S ON S.id_s=SP.suministrador_id_s)
WHERE Ciudad='Soyapango';

-- Lo mismo usando NATURAL JOIN (los atributos deben llamarse igual, hay que renombrar -ojo al orden-)
SELECT DISTINCT nombre_p 
FROM (Suministro AS SP (id_p,id_s) NATURAL JOIN PIEZA) NATURAL JOIN Suministrador
WHERE Ciudad='Soyapango';

-- Nombres de los empleados y sus supervisores (si los tienen)    
SELECT E1.Nombre Empleado, E2.Nombre Supervisor	  
FROM (Empleado E1 LEFT OUTER JOIN Empleado E2 ON E1.DUI_Supervisor=E2.DUI);

-- Supervisados y Supervisores
SELECT E1.Nombre Empleado, E2.Nombre Supervisor	  
FROM (Empleado E1 FULL OUTER JOIN Empleado E2 ON E1.DUI_Supervisor=E2.DUI);

-- Solo los empleados que no supervisan a nadie 
SELECT E2.Nombre NoSupervisor	  
FROM (Empleado E1 FULL OUTER JOIN Empleado E2 ON E1.DUI_Supervisor=E2.DUI) WHERE E1.DUI IS NULL;


-- Detalle de todas las piezas y suministradores que actualmente son suministradas
SELECT * FROM Pieza, Suministrador
WHERE (id_p,id_s) IN (SELECT * FROM Suministro);

-- Detalles de piezas que son suministradas desde Soyapango o bien tienen peso no nulo y en cantidad 15 o 20
SELECT * FROM Pieza 
WHERE id_p IN (
        SELECT pieza_id_p
        FROM Suministro SP, Suministrador S
        WHERE SP.suministrador_id_s=S.id_s AND Ciudad='Soyapango') 
   OR id_p IN (
        SELECT id_p FROM Pieza
        WHERE Peso IS NOT NULL AND Cantidad IN (15,20));

-- ¿Quien (o quienes) es el empleado que gana más que los demás?
SELECT Nombre,Salario FROM Empleado   
WHERE Salario >= ALL (SELECT Salario FROM Empleado);

-- Personas cuyos salarios son superiores al promedio de cada departamento
SELECT Nombre,salario,codigo_departamento FROM Empleado E 
WHERE salario::numeric >= 
  (SELECT AVG(salario::numeric) FROM Empleado
   WHERE codigo_departamento = E.codigo_departamento) 
ORDER BY codigo_departamento,salario;    

-- ¿Quién gana más por departamento?
SELECT Nombre,salario,codigo_departamento 
FROM Empleado E
WHERE Salario >= ALL (
  SELECT Salario FROM Empleado
  WHERE codigo_departamento = E.codigo_departamento);

-- Empleados solitos en el departamento
 SELECT Nombre FROM Empleado E
 WHERE NOT EXISTS (SELECT * FROM Empleado
 WHERE codigo_departamento = E.codigo_departamento AND DUI<>E.DUI);

-- Piezas de las que haya menos de 100 y NO exista actualmente ningún suministrador
SELECT * FROM Pieza P
WHERE Cantidad<100 AND NOT EXISTS
(SELECT * FROM Suministro SP WHERE SP.pieza_id_p=P.id_p);
  
-- Números de suministradores para los que NO existen piezas que NO sean suministradas por ellos
-- (es decir, suministradores que suministran todas las piezas)
SELECT suministrador_id_s FROM Suministro SP1
WHERE NOT EXISTS 
 (SELECT * FROM Pieza P
  WHERE NOT EXISTS 
   (SELECT * FROM Suministro SP2
    WHERE SP2.suministrador_id_s=SP1.suministrador_id_s AND
    SP2.pieza_id_p=P.id_p));

-- Nombre de los suministradores que suministran más de 5 piezas
SELECT nombre_s FROM Suministrador S
WHERE 5 < (SELECT COUNT(*) FROM Suministro
WHERE S.id_s=suministrador_id_s);

--Nombre de las Piezas que pesan más que la media
SELECT nombre_p FROM Pieza
WHERE Peso > (SELECT AVG(Peso) FROM Pieza);

-- Nombre de la pieza o piezas que pesen más
SELECT nombre_p FROM Pieza
WHERE Peso = (SELECT MAX(Peso) FROM Pieza);

-- Nombre de piezas que son suministradas por varios suministradores
SELECT nombre_p FROM Pieza
WHERE 2 <= (SELECT COUNT(*) FROM Suministro WHERE pieza_id_p=Pieza.id_p);

-- Nombre de piezas que provengan de 3 suministradores de Soyapango
SELECT nombre_p FROM Pieza P 
WHERE 3 = (
 SELECT COUNT(*) FROM Suministro SP, Suministrador S
 WHERE pieza_id_p=P.id_p AND SP.suministrador_id_s=S.id_s AND Ciudad='Soyapango');
 
-- Para cada departamento, recuperar el número de empleados que tiene, su salario medio, y su mayor y menor salario
SELECT codigo_departamento, COUNT(*), AVG(Salario::numeric), MAX(Salario), MIN(salario)
FROM Empleado
GROUP BY codigo_departamento;

-- Para cada pieza, recuperar el número de suministradores que tiene
SELECT P.id_p, nombre_p, COUNT(*)
FROM Pieza P, Suministro SP
WHERE P.id_p=SP.pieza_id_p 
GROUP BY P.id_p, nombre_p;

-- Para cada pieza que sea suministrada por más de un suministrador, indicar cuántos suministradores tiene
SELECT id_p,nombre_p,COUNT(*) suministradores
FROM Pieza,Suministro 
WHERE id_p=pieza_id_p
GROUP BY id_p, nombre_p HAVING COUNT(*)>1;

-- Departamentos y el número de sus empleados de aquellos que tienen más de 2 empleados y la media de su salario es mayor que 2200
SELECT codigo_departamento, COUNT(*) 
FROM Empleado
GROUP BY codigo_departamento 
HAVING COUNT(*)>2 AND AVG(Salario::numeric)>2200;

-- Recuperar los departamentos y el número de sus empleados que cobran más de 2500 de aquellos que tienen más de 2 empleados
SELECT codigo_departamento, COUNT(*) 
FROM Empleado
WHERE Salario::numeric>2500 AND codigo_departamento IN (
  SELECT codigo_departamento 
  FROM Empleado 
  GROUP BY codigo_departamento HAVING COUNT(*)>2) 
GROUP BY codigo_departamento;

-- ¿Quiénes son los supervisores (directos e indirectos) de un empleado dado?
WITH RECURSIVE supervisores(DUI, nombre, DUI_supervisor) AS (
    SELECT DUI, nombre, DUI_supervisor FROM empleado WHERE DUI = '34531178-8'
  UNION ALL
    SELECT e.DUI, e.nombre, e.DUI_supervisor
    FROM supervisores sup, empleado e
    WHERE e.DUI = sup.DUI_supervisor
  )
SELECT DUI, nombre, DUI_supervisor
FROM supervisores;

-- ¿Quiénes son los empleados supervisados (directos o indirectos) por un empleado dado?
WITH RECURSIVE supervisados(DUI, nombre, DUI_supervisor) AS (
    SELECT DUI, nombre, DUI_supervisor FROM empleado WHERE DUI = '04926243-5'
  UNION ALL
    SELECT e.DUI, e.nombre, e.DUI_supervisor
    FROM supervisados sup, empleado e
    WHERE e.DUI IN (
     SELECT DUI FROM empleado WHERE DUI_supervisor=sup.DUI)
  )
SELECT DUI, nombre, DUI_supervisor
FROM supervisados;

