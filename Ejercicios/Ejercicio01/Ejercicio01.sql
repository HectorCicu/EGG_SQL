use personal;
select * from empleados; /* 1 */
select * from departamentos; /* 2 */
select nombre_depto from departamentos; /* 3 */
SELECT nombre_depto FROM departamentos; /* 4 */ 
select comision_emp from empleados; /* 5 */
select nombre from empleados where cargo_emp = 'Secretaria'; /* 6 */
select nombre from empleados where cargo_emp like 'Vendedor' order by nombre ASC; /* 7 */
select nombre, cargo_emp , sal_emp  from empleados order by sal_emp asc; /* 8 */
select * from departamentos where ciudad like '%Ciudad Real%';  /* 9 */
select nombre as Nombre, cargo_emp as Cargo from empleados; /* 10 */
select nombre as Nombre, sal_emp  as Salario, comision_emp as Comision , id_depto as Departamento
from empleados where id_depto = 2000 order by comision_emp asc; /* 11 */
select nombre as Nombre, (sal_emp + comision_emp + 500) as 'Total a Pagar'
from empleados where id_depto = 3000 order by nombre ASC; /* 12 */
select nombre as Nombre from empleados where nombre like 'j%'; /* 13 */
select nombre as Nombre, sal_emp as Salario, comision_emp as Comision , id_depto as 'Cod. Departamento'
from empleados where comision_emp = 0; /* 15 */
select * from empleados where comision_emp > sal_emp; /* 16 */
select* from empleados where comision_emp <= sal_emp * 0.30 and comision_emp > 0; /* 17 */
select * from empleados where nombre not like '%ma%'; /* 18 */
select * from departamentos where departamentos.nombre_depto in ('ventas', 'investigacion', 'mantenimiento');  /* 19 */
select * from departamentos where (nombre_depto like '%ventas%'or nombre_depto like '%investigacion%' or nombre_depto like '%mantenimiento%'); /* 19 */
select * from departamentos where departamentos.nombre_depto not in ('ventas', 'investigacion', 'mantenimiento');  /* 20 */
select * from departamentos where (nombre_depto not like '%ventas%'and nombre_depto not like '%investigacion%' and nombre_depto not like '%mantenimiento%'); /* 20 */

select max(sal_emp) from empleados; /* 21 */
/* select e.nombre 
from departamentos d, empleados e
where d.id_depto= e.id_depto  and ciudad = "CIUDAD REAL"
group by e.nombre ;  /* 9 otra opcion*/
select nombre from empleados order by nombre desc Limit 1;/* 22 */
select max(nombre) from empleados;  /* 21 */ -- otra versión
select max(sal_emp)  as 'Salario Máximo' , min(sal_emp) as 'Salario Mínimo',
(max(sal_emp) - min(sal_emp)) as 'Diferencia' from empleados;  /* 23 */

select id_depto as 'Departamento', avg(sal_emp) as 'Salario Promedio'  
from empleados group by id_depto; /* 24 */

/*25. Hallar los departamentos que tienen más de tres empleados. Mostrar el número de
empleados de esos departamentos*/
select e.id_depto as 'Id', d.nombre_depto as 'Departamento', count(nombre)  as 'Cantidad'
from empleados as e
inner join departamentos as d on
e.id_depto = d.id_depto
group by e.id_depto, d.nombre_depto
having count(nombre) > 3;

/*26. Hallar los departamentos que no tienen empleados*/
select e.id_depto as 'Id', d.nombre_depto as 'Departamento', count(nombre)  as 'Cantidad'
from empleados as e
inner join departamentos as d on
e.id_depto = d.id_depto
group by e.id_depto, d.nombre_depto
having count(nombre) = 0;

/* 27. Mostrar la lista de empleados, con su respectivo departamento y el jefe de cada
departamento. */
select id_emp as 'Id Empleado', nombre as 'Nombre', e.id_depto as 'ID Departamento',
d.nombre_depto  as 'Departamento', nombre_jefe_depto as 'Nombre Jefe Dto.'
from empleados as e
inner join departamentos as d on
e.id_depto = d.id_depto;

/* 28. Mostrar la lista de los empleados cuyo salario es mayor o igual que el promedio de la
empresa. Ordenarlo por departamento. */
select id_emp as 'Id Empleado', nombre as 'Nombre', e.id_depto as 'ID Departamento',
d.nombre_depto  as 'Departamento', sal_emp as 'Salario' from empleados as e
inner join departamentos as d on
e.id_depto = d.id_depto
having sal_emp >= (select avg(sal_emp) from empleados)
order by e.id_depto asc;


