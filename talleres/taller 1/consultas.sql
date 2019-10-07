--NO PUEDE TERMINAR DE AGREGAR DATOS PERO AL MENOS QUIERO DEJAR LA LOGICA DE ALGUNAS CONSULTAS

--Mostrar secciones de las que es responsable el docente con dui 00000000-1
SELECT *
FROM seccion s
INNER JOIN responsable_seccion rs ON (rs.letra_seccion, rs.numero_grado, rs.denominacion_nivel) = (s.letra, s.numero_grado, s.denominacion_nivel)
WHERE rs.dui_docente = '00000000-1'
;