-- 1. Obtenga el listado de los nombres y DUI de todos los miembros que participaron en la superpachanga que se realizó en 2018.
select M.DUI,M.nombre 
from miembro M, asiste A, superpachanga S 
where DUI_miembro=DUI and nombre_superpachanga=S.nombre and anyo=2018;

-- 2. ¿Qué proyecto es el que ha acumulado más dinero? ¿cuál el que menos?
select denominacion from proyecto where monto_acumulado = (select max(monto_acumulado) from proyecto);
select denominacion from proyecto where monto_acumulado = (select min(monto_acumulado) from proyecto);

-- 3. ¿Cuánto se ha ganado por implantación de los proyectos cada año?

-- opción funcional
select date_part('year',implantacion_fecha_inicio) as año,sum(implantacion_precio) 
from contrata 
group by año 
order by año asc;

-- opción mucho más compleja (pero elegante, no omite años con facturación cero)
with recursive lista_anhos(anho) as 
(
    select min(date_part('year',implantacion_fecha_inicio)) as anho from contrata
    union all
    select lista.anho + 1 as anho
    from lista_anhos lista
    where lista.anho + 1 <= date_part('year',current_date)
)
select anho as año,sum(implantacion_precio) 
from lista_anhos left outer join contrata on lista_anhos.anho=date_part('year',implantacion_fecha_inicio)
group by año 
order by año asc;

-- 4. Liste los clientes (todos sus atributos) y muestre por cada uno el monto total de todos sus contratos. Ordénelos de mayor a menor por monto.
select dui,denominacion,tipo,sum(implantacion_precio) as total
from cliente,contrata
where contrata.DUI_cliente=DUI
group by dui,denominacion,tipo
order by total;

-- 5. Obtenga el monto acumulado por tipo de proyectos (web, venta_almacen y ERP).
select tipo,sum(implantacion_precio) as total
from proyecto,contrata
where contrata.codigo_proyecto=codigo
group by tipo
order by total;

-- 6. Filtre de la anterior consulta aquellas categorías que tienen ganancias acumuladas de más de $100,000.
select tipo,sum(implantacion_precio) as total
from proyecto,contrata
where contrata.codigo_proyecto=codigo 
group by tipo having sum(implantacion_precio::numeric)>100000
order by total;

-- 7. Obtenga un listado de todos los proyectos en el que se muestre el nombre de las superpachangas en las que eventualmente fue presentado cada proyecto (o nulo si no lo fue).
select codigo,denominacion,nombre_superpachanga,anyo
from proyecto left outer join (presenta join superpachanga on nombre=nombre_superpachanga) on codigo=codigo_proyecto
order by codigo;

-- 8. Liste los nombres de todos los proyectos que tengan versiones superiores a la 1.0.
-- Opción 1
select codigo_proyecto,denominacion,count(*) 
from proyecto,version 
where codigo_proyecto=codigo 
group by codigo_proyecto,denominacion 
having count(*)>= 2 
order by codigo_proyecto; 

--Opción 2
select distinct codigo_proyecto,denominacion 
from proyecto,version
where numero <> 1.0  and codigo_proyecto=codigo
order by codigo_proyecto;

-- 9. Averigüe de qué proyectos es subproyecto el denominado “aulavirt”.
select macro.codigo,macro.denominacion
from proyecto sub,proyecto macro,proyecto_parte
where codigo_subproyecto=sub.codigo and codigo_macroproyecto=macro.codigo and sub.denominacion='aulavirt';

-- 10. Efectúe la consulta anterior considerando que los proyectos de los cuales “aulavirt” es supbroyecto podrían ser a su vez subproyectos de otros, y así sucesivamente.
select codigo,denominacion
from proyecto
where codigo in (
  WITH RECURSIVE macroproyectos(codigo_macro) AS (
    SELECT codigo_macroproyecto
    FROM proyecto,proyecto_parte 
    WHERE codigo_subproyecto=codigo and denominacion = 'aulavirt'
  UNION ALL
    SELECT pp.codigo_macroproyecto
    FROM macroproyectos macro, proyecto_parte pp
    WHERE pp.codigo_subproyecto = macro.codigo_macro
  )
  SELECT codigo_macro
  FROM macroproyectos
)
order by codigo;
