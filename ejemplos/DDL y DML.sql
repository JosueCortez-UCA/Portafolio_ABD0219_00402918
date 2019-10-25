-- 1
select descripcion,count(*) cantidad
from modulo_erp
group by descripcion;

-- 2
select dui,nombre,sum(monto_acumulado) as total 
from miembro,desarrolla,proyecto 
where DUI_miembro_ingenieria=dui and codigo_proyecto=codigo 
group by dui,nombre 
order by total desc;

-- 3
select codigo,denominacion,dui,nombre 
from proyecto,miembro 
where (codigo,dui) in (
    select codigo_proyecto,DUI_miembro_ingenieria from desarrolla
    union 
    select codigo_proyecto,DUI_miembro_gestion from contrata
    union
    select codigo_proyecto,DUI_miembro_ventas from atiende
) order by codigo,dui;

-- Incluyendo el nombre del departamento es un poquito más complicado (se usa una tabla temporal)
select codigo_proyecto,denominacion,M.dui,M.nombre,departamento 
from (
   select codigo_proyecto,DUI_miembro_ingenieria dui,'Ingeniería' departamento from desarrolla
   union
   select codigo_proyecto,DUI_miembro_gestion dui,'Gestión' departamento from contrata
   union
   select codigo_proyecto,DUI_miembro_ventas dui,'Ventas' departamento from atiende
) as fusion (codigo_proyecto,dui,departamento),proyecto,miembro M 
where codigo=codigo_proyecto and M.dui=fusion.dui 
order by codigo_proyecto,departamento,M.dui;

-- 4 
select codigo,denominacion,monto_acumulado,sum(implantacion_precio) suma_contratos 
from proyecto,contrata 
where codigo_proyecto=codigo 
group by codigo,denominacion,monto_acumulado 
order by codigo;

-- 5
-- Opción 1
select dui,nombre from miembro 
except 
select dui,nombre from miembro,presenta where DUI_miembro=DUI;

-- Opción 2
select dui,nombre 
from miembro 
where dui not in (
    select dui 
    from miembro,presenta 
    where DUI_miembro=DUI
);

-- 6
select codigo,denominacion
from proyecto
where codigo in (
  WITH RECURSIVE subproyectos(codigo_sub) AS (
    SELECT codigo_subproyecto
    FROM proyecto,proyecto_parte 
    WHERE codigo_macroproyecto=codigo and denominacion = 'Web UCA'
  UNION ALL
    SELECT pp.codigo_subproyecto
    FROM subproyectos sub, proyecto_parte pp
    WHERE pp.codigo_subproyecto 
     IN (
        SELECT codigo_subproyecto 
        FROM proyecto_parte 
        WHERE codigo_macroproyecto=sub.codigo_sub
        )
  )
  SELECT codigo_sub
  FROM subproyectos
)
order by codigo;
