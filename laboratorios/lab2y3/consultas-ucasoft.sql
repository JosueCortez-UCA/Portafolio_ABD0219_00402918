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


SELECT tipo, SUM(monto_acumulado) AS monto_acumulado
FROM proyecto
GROUP BY tipo
HAVING SUM(monto_acumulado) > CAST('$ 100,000' AS MONEY)
;

/*7. Obtenga un listado de todos los proyectos en el que se muestre el
nombre de las superpachangas en las que eventualmente fue
presentado cada proyecto (o nulo si no lo fue).*/

SELECT py.denominacion, COALESCE(ps.nombre_superpachanga, 'nulo')
FROM proyecto py
LEFT JOIN presenta ps ON py.codigo = ps.codigo_proyecto
;

/*8. Liste los nombres de todos los proyectos que tengan versiones
superiores a la 1.0.*/

SELECT p.denominacion AS proyecto
FROM version v
INNER JOIN proyecto p ON v.codigo_proyecto = p.codigo
WHERE numero > 1
GROUP BY proyecto
;

/*9. Averigüe de qué proyectos es subproyecto el denominado “aulavirt”.*/
--FORMA 1
SELECT py.codigo AS "Codigo Macro Proyecto", py.denominacion AS "Denominacion Macro Proyecto"
FROM proyecto py
INNER JOIN proyecto_parte pp ON py.codigo = pp.codigo_macroproyecto
WHERE pp.codigo_subproyecto = (
	SELECT p.codigo
	FROM proyecto p
	WHERE p.denominacion = 'aulavirt'
)
;
--FORMA 2
SELECT codigo AS "Codigo Macro Proyecto", denominacion AS "Denominacion Macro Proyecto"
FROM proyecto
WHERE codigo = (
	SELECT codigo_macroproyecto
	FROM proyecto_parte, proyecto
	WHERE codigo_subproyecto = codigo
	AND denominacion = 'aulavirt'
)
;

/*10. Efectúe la consulta anterior considerando que los proyectos de los
cuales “aulavirt” es supbroyecto podrían ser a su vez subproyectos de
otros, y así sucesivamente.*/

SELECT codigo AS "Codigo", denominacion AS "Denominacion"
FROM proyecto
WHERE codigo IN (
	WITH RECURSIVE macro_proyecto(cod) AS (
		SELECT codigo_macroproyecto
		FROM proyecto, proyecto_parte
		WHERE codigo_subproyecto = codigo
		AND denominacion = 'aulavirt'
	UNION ALL
		SELECT pp.codigo_macroproyecto
		FROM macro_proyecto macro, proyecto_parte pp
		WHERE pp.codigo_macroproyecto
			IN (
				SELECT codigo_macroproyecto
				FROM proyecto_parte
				WHERE codigo_subproyecto = macro.cod
			)
	)
	SELECT cod
	FROM macro_proyecto
)
ORDER BY codigo
;
