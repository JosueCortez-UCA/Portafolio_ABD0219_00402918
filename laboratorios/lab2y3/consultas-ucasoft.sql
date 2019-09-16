/*1. Obtenga el listado de los nombres y DUI de todos los miembros que
participaron en la superpachanga que se realizó en 2018.*/

SELECT m.nombre, m.dui
FROM miembro m
INNER JOIN asiste a ON m.dui = a.dui_miembro
INNER JOIN superpachanga sp ON a.nombre_superpachanga = sp.nombre
WHERE sp.anio = '2018'
; 

/*2. ¿Qué proyecto es el que ha acumulado más dinero? ¿cuál el que menos?*/

SELECT *
FROM proyecto p
WHERE p.codigo = (SELECT p1.codigo FROM proyecto p1 ORDER BY monto_acumulado DESC limit 1)
OR p.codigo = (SELECT p2.codigo FROM proyecto p2 ORDER BY monto_acumulado ASC limit 1)
ORDER BY monto_acumulado DESC
;

/*3. ¿Cuánto se ha ganado por implantación de los proyectos cada año?*/

SELECT EXTRACT(YEAR FROM implantacion_fecha_inicio) AS año, SUM(implantacion_precio) AS ganado
FROM contrata
GROUP BY año
ORDER BY año
;

/*4. Liste los clientes (todos sus atributos) y muestre por cada uno el monto
total de todos sus contratos. Ordénelos de mayor a menor por monto.*/

SELECT cl.*, SUM((cn.implantacion_precio + cn.mantenimiento_precio) - cn.descuento) AS precio_contratos
FROM cliente cl
INNER JOIN contrata cn ON cl.dui = cn.dui_cliente
GROUP BY cl.dui, cl.denominacion, cl.tipo
ORDER BY precio_contratos
;

/*5. Obtenga el monto acumulado por tipo de proyectos (web,
venta_almacen y ERP).*/

SELECT tipo, SUM(monto_acumulado) AS monto_acumulado
FROM proyecto
GROUP BY tipo
;

/*6. Filtre de la anterior consulta aquellas categorías que tienen ganancias
acumuladas de más de $100,000.*/

/*7. Obtenga un listado de todos los proyectos en el que se muestre el
nombre de las superpachangas en las que eventualmente fue
presentado cada proyecto (o nulo si no lo fue).*/

/*8. Liste los nombres de todos los proyectos que tengan versiones
superiores a la 1.0.*/

/*9. Averigüe de qué proyectos es subproyecto el denominado “aulavirt”.*/

/*10. Efectúe la consulta anterior considerando que los proyectos de los
cuales “aulavirt” es supbroyecto podrían ser a su vez subproyectos de
otros, y así sucesivamente.*/
