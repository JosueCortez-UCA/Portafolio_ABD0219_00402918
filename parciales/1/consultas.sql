--1
select * from empleado;

--2
select *, (salario + comision) as salario_final
from empleado
order by salario_final desc
;

--3
select ident, nombre, puesto
from empleado
where nombre LIKE 'J%'
;

--4
select emp.ident, emp.nombre, emp.puesto, dp.denominacion
from empleado emp
inner join departamento dp ON emp.codigo_departamento = dp.codigo
order by emp.ident, dp.denominacion asc
;

--5
--no existe

--6
select ident, nombre, salario, dp.denominacion
from empleado, departamento dp
where dp.codigo (
	select emp.ident, emp.nombre, emp.salario
	from empleado emp
	where emp.codigo_departamento = dp.codigo
	order by salario asc
	limit 1
) as sp
;

--7
select ident, nombre, coalesce(titulo, 'vacio')
from empleado
left join trabaja on ident_empleado = ident
left join proyecto on numero = numero_proyecto
;

--8
select denominacion, sum(salario) as suma_salarios
from empleado
inner join departamento ON codigo_departamento = codigo
group by denominacion
;

--9
select denominacion, sum(salario) as suma_salarios
from empleado
inner join departamento ON codigo_departamento = codigo
group by denominacion
having sum(salario) > 10500
;

--10
select ident, nombre
from empleado
where ident in (
	with recursive supervisor(cod) as (
		select ident_supervisor
		from empleado
		where nombre like 'CATALINA%'
	union all
		select ident_supervisor
		from empleado, supervisor
		where ident_supervisor
			in (
				select ident_supervisor
				from empleado
				where ident = cod
			)
	)
	select cod
	from supervisor
)
;

----------------------------------------------------

select * from proyecto 

select * from trabaja 

select * from empleado 

select * from departamento 