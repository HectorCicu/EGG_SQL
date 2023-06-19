/*Consultas sobre una tabla*/
/*1. Devuelve un listado con el código de oficina y la ciudad donde hay oficinas.*/
select codigo_oficina, ciudad from oficina;

/*2. Devuelve un listado con la ciudad y el teléfono de las oficinas de España.*/
select ciudad, telefono from oficina 
where pais = 'españa';

/*3. Devuelve un listado con el nombre, apellidos y email de los empleados cuyo jefe tiene un
código de jefe igual a 7.*/
select nombre, apellido1, apellido2, email from empleado 
where codigo_jefe = 7;

select * from empleado where codigo_jefe = 3  order by nombre asc limit 2;

/*4. Devuelve el nombre del puesto, nombre, apellidos y email del jefe de la empresa.*/
select puesto, nombre, apellido1, apellido2, email from  empleado
where codigo_jefe is null;

/*5. Devuelve un listado con el nombre, apellidos y puesto de aquellos empleados que no sean
representantes de ventas.*/
select puesto, nombre, apellido1, apellido2 from  empleado
where puesto not like '%represent%Venta%';

/*6. Devuelve un listado con el nombre de los todos los clientes españoles.*/
select * from cliente
where pais != 'Spain';

/*7. Devuelve un listado con los distintos estados por los que puede pasar un pedido.*/
select distinct(estado) as 'Estados Producto' 
from pedido;

/*8. Devuelve un listado con el código de cliente de aquellos clientes que realizaron algún pago
en 2008. Tenga en cuenta que deberá eliminar aquellos códigos de cliente que aparezcan
repetidos. Resuelva la consulta:
o Utilizando la función YEAR de MySQL.
o Utilizando la función DATE_FORMAT de MySQL.
o Sin utilizar ninguna de las funciones anteriores.*/
select p.codigo_cliente as 'Cód. Cliente', nombre_cliente as 'Razón Social' 
from pago as p
join cliente as c on
p.codigo_cliente = c.codigo_cliente
where year(p.fecha_pago) = 2008
group by p.codigo_cliente, c.nombre_cliente;

/*9. Devuelve un listado con el código de pedido, código de cliente, fecha esperada y fecha de
entrega de los pedidos que no han sido entregados a tiempo.*/
select p.codigo_pedido, p.fecha_esperada, p.fecha_entrega
from pedido as p
where p.fecha_esperada < p.fecha_entrega;

/*10. Devuelve un listado con el código de pedido, código de cliente, fecha esperada y fecha de
entrega de los pedidos cuya fecha de entrega ha sido al menos dos días antes de la fecha
esperada.
o Utilizando la función ADDDATE de MySQL.
o Utilizando la función DATEDIFF de MySQL.*/
select p.codigo_pedido, p.fecha_esperada, p.fecha_entrega, 
datediff( p.fecha_entrega, p.fecha_esperada) as 'Dif Fechas'
from pedido as p
where datediff(p.fecha_entrega, p.fecha_esperada) <= -2;

/*11. Devuelve un listado de todos los pedidos que fueron rechazados en 2009.*/
select * from pedido 
   where estado = 'rechazado' and
   year(fecha_pedido) = 2009 ;

/*12. Devuelve un listado de todos los pedidos que han sido entregados en el mes de enero de
cualquier año.*/
select * from pedido
   where month(fecha_entrega) = 1;

/*13. Devuelve un listado con todos los pagos que se realizaron en el año 2008 mediante Paypal.
Ordene el resultado de mayor a menor.*/
select * from pago
   where forma_pago = 'paypal'
   and year(fecha_pago) = 2008
   order by total desc;
   
/*14. Devuelve un listado con todas las formas de pago que aparecen en la tabla pago. Tenga en
cuenta que no deben aparecer formas de pago repetidas.*/
select distinct(forma_pago) as 'Formas de Pago' 
  from pago;

/*15. Devuelve un listado con todos los productos que pertenecen a la gama Ornamentales y que
tienen más de 100 unidades en stock. El listado deberá estar ordenado por su precio de
venta, mostrando en primer lugar los de mayor precio.*/
select * from producto
  where gama = 'ornamentales'
  and cantidad_en_stock > 100
  order by precio_venta desc;

/*16. Devuelve un listado con todos los clientes que sean de la ciudad de Madrid y cuyo
representante de ventas tenga el código de empleado 11 o 30.*/
SELECT 
    *
FROM
    cliente
WHERE
    ciudad = 'madrid'
        AND codigo_empleado_rep_ventas IN (11 , 30);
  
/*Consultas multitabla (Composición interna)*/
/*Las consultas se deben resolver con INNER JOIN.*/
/*1. Obtén un listado con el nombre de cada cliente y el nombre y apellido de su representante
de ventas.*/
select nombre_cliente, nombre, apellido1, apellido2 
	from cliente
    join empleado on 
    codigo_empleado_rep_ventas = codigo_empleado;

/*2. Muestra el nombre de los clientes que hayan realizado pagos junto con el nombre de sus
representantes de ventas.*/
SELECT 
    c.nombre_cliente AS 'Razón Social',
    c.codigo_empleado_rep_ventas,
    e.codigo_empleado as 'Codigo tabla empleado',
    e.nombre AS 'Nombre Rep. Vtas.',
    e.apellido1 AS 'Apellido',
    e.apellido2 AS 'Segundo Apellido'
FROM
    cliente AS c
        INNER JOIN
    empleado AS e ON c.codigo_empleado_rep_ventas = e.codigo_empleado
        INNER JOIN
    pago AS p ON c.codigo_cliente = p.codigo_cliente
GROUP BY c.nombre_cliente , e.nombre , e.apellido1 , e.apellido2, c.codigo_empleado_rep_ventas, e.codigo_empleado;

/* 3. Muestra el nombre de los clientes que no hayan realizado pagos junto con el nombre de
sus representantes de ventas. */
SELECT 
    c.nombre_cliente AS 'Razón Social',
    c.codigo_empleado_rep_ventas,
    e.codigo_empleado as 'Codigo tabla empleado',
    e.nombre AS 'Nombre Rep. Vtas.',
    e.apellido1 AS 'Apellido',
    e.apellido2 AS 'Segundo Apellido'
 
FROM
    cliente AS c
        INNER JOIN
    empleado AS e ON c.codigo_empleado_rep_ventas = e.codigo_empleado
        left JOIN
    pago AS p ON c.codigo_cliente = p.codigo_cliente
WHERE
  ( p.total is null)
GROUP BY c.nombre_cliente , e.nombre , e.apellido1 , e.apellido2, c.codigo_empleado_rep_ventas, e.codigo_empleado;

/*4. Devuelve el nombre de los clientes que han hecho pagos y el nombre de sus representantes
junto con la ciudad de la oficina a la que pertenece el representante.*/
SELECT 
    c.nombre_cliente AS 'Razón Social',
    e.nombre AS 'Nombre Rep. Vtas.',
    e.apellido1 AS 'Apellido',
    e.apellido2 AS 'Segundo Apellido',
    o.ciudad AS 'Localidad Oficina'
FROM
    cliente AS c
        INNER JOIN
    empleado AS e ON c.codigo_empleado_rep_ventas = e.codigo_empleado
        INNER JOIN
    oficina AS o ON e.codigo_oficina = o.codigo_oficina
        LEFT JOIN
    pago AS p ON c.codigo_cliente = p.codigo_cliente
WHERE
    p.total > 0
GROUP BY c.nombre_cliente , e.nombre , e.apellido1 , e.apellido2 , o.ciudad;

/*5. Devuelve el nombre de los clientes que no hayan hecho pagos y el nombre de sus
representantes junto con la ciudad de la oficina a la que pertenece el representante.*/
SELECT 
    c.nombre_cliente AS 'Razón Social',
    e.nombre AS 'Nombre Rep. Vtas.',
    e.apellido1 AS 'Apellido',
    e.apellido2 AS 'Segundo Apellido',
    o.ciudad AS 'Localidad Oficina'
FROM
    cliente AS c
        INNER JOIN
    empleado AS e ON c.codigo_empleado_rep_ventas = e.codigo_empleado
        INNER JOIN
    oficina AS o ON e.codigo_oficina = o.codigo_oficina
WHERE
    (SELECT 
            COUNT(1)
        FROM
            pago AS p
        WHERE
            c.codigo_cliente = p.codigo_cliente) = 0
GROUP BY c.nombre_cliente , e.nombre , e.apellido1 , e.apellido2 , o.ciudad;

/*6. Lista la dirección de las oficinas que tengan clientes en Fuenlabrada.*/
SELECT 
    o.codigo_oficina,
    o.ciudad,
    o.pais,
    o.region,
    o.codigo_postal,
    o.linea_direccion1,
    o.linea_direccion2,
    c.nombre_cliente,
    e.nombre,
    e.apellido1,
    e.apellido2,
    c.linea_direccion2
FROM
    oficina AS o
        INNER JOIN
    empleado AS e ON o.codigo_oficina = e.codigo_oficina
        INNER JOIN
    cliente AS c ON e.codigo_empleado = c.codigo_empleado_rep_ventas
WHERE
     c.linea_direccion2 = 'FUENLABRADA' ;

/*7. Devuelve el nombre de los clientes y el nombre de sus representantes junto con la ciudad
de la oficina a la que pertenece el representante.*/
SELECT 
    o.codigo_oficina,
    o.ciudad,
    o.pais,
    o.region,
    o.codigo_postal,
    o.linea_direccion1,
    o.linea_direccion2,
    c.nombre_cliente,
    e.nombre as 'Nombre Rep. Vtas.',
    e.apellido1 as 'Apellido',
    e.apellido2 as 'Apellido 2',
    c.linea_direccion2
FROM
    oficina AS o
        INNER JOIN
    empleado AS e ON o.codigo_oficina = e.codigo_oficina
        INNER JOIN
    cliente AS c ON e.codigo_empleado = c.codigo_empleado_rep_ventas;

/*8. Devuelve un listado con el nombre de los empleados junto con el nombre de sus jefes.*/
SELECT 
    e.codigo_empleado,
    e.nombre AS 'Nombre Empleado',
    e.apellido1 AS 'Apellido Empleado',
    e.apellido2 AS 'Apellido 2 empleado',
    e.codigo_jefe AS 'Cód jefe del empleado',
    e.puesto AS 'Puesto del Empleado',
    j.nombre AS 'Nombre Jefe',
    j.apellido1 AS 'Apellido Jefe',
    j.apellido2 AS 'Apellido2 jefe',
    j.puesto AS 'Puesto del jefe'
FROM
    empleado AS e
        JOIN
    empleado AS j ON e.codigo_jefe = j.codigo_empleado;
   
/*   9. Devuelve el nombre de los clientes a los que no se les ha entregado a tiempo un pedido.*/
SELECT 
    c.nombre_cliente
FROM
    cliente AS c
        INNER JOIN
    pedido AS p ON c.codigo_cliente = p.codigo_cliente
WHERE
    fecha_entrega < fecha_esperada;

/*10. Devuelve un listado de las diferentes gamas de producto que ha comprado cada cliente*/
SELECT 
    c.nombre_cliente,
    g.gama,
    g.descripcion_texto,
    g.descripcion_html,
    g.imagen
FROM
    cliente AS c
        INNER JOIN
    pedido AS p ON c.codigo_cliente = p.codigo_cliente
        INNER JOIN
    detalle_pedido AS d ON p.codigo_pedido = d.codigo_pedido
        INNER JOIN
    producto AS pr ON d.codigo_producto = pr.codigo_producto
        INNER JOIN
    gama_producto AS g ON pr.gama = g.gama
GROUP BY c.nombre_cliente , g.gama , g.descripcion_texto , g.descripcion_html , g.imagen;


/*Consultas multitabla (Composición externa)*/
/*Resuelva todas las consultas utilizando las cláusulas LEFT JOIN, RIGHT JOIN, JOIN.*/
/*1. Devuelve un listado que muestre solamente los clientes que no han realizado ningún pago.*/
SELECT 
    c.nombre_cliente AS 'Razón Social',
    c.codigo_empleado_rep_ventas,
    e.codigo_empleado as 'Codigo tabla empleado',
    e.nombre AS 'Nombre Rep. Vtas.',
    e.apellido1 AS 'Apellido',
    e.apellido2 AS 'Segundo Apellido'
 
FROM
    cliente AS c
        INNER JOIN
    empleado AS e ON c.codigo_empleado_rep_ventas = e.codigo_empleado
        left JOIN
    pago AS p ON c.codigo_cliente = p.codigo_cliente
WHERE
  ( p.total is null)
GROUP BY c.nombre_cliente , e.nombre , e.apellido1 , e.apellido2, c.codigo_empleado_rep_ventas, e.codigo_empleado;

/*2. Devuelve un listado que muestre solamente los clientes que no han realizado ningún
pedido.*/
SELECT 
    c.nombre_cliente
FROM
    cliente AS c
        LEFT JOIN
    pedido AS p ON c.codigo_cliente = p.codigo_cliente
WHERE
    p.codigo_cliente IS NULL;
    
/*3. Devuelve un listado que muestre los clientes que no han realizado ningún pago y los que
no han realizado ningún pedido.*/
SELECT 
    c.nombre_cliente
FROM
    cliente AS c
        LEFT JOIN
    pedido AS p ON c.codigo_cliente = p.codigo_cliente
        LEFT JOIN
    pago AS pg ON c.codigo_cliente = pg.codigo_cliente
WHERE
    (p.codigo_cliente IS NULL
        OR pg.codigo_cliente IS NULL)
GROUP BY c.nombre_cliente;
    
/*4. Devuelve un listado que muestre solamente los empleados que no tienen una oficina
asociada.*/
SELECT 
    *
FROM
    empleado
WHERE
    codigo_oficina IS NULL;
    
/*5. Devuelve un listado que muestre solamente los empleados que no tienen un cliente
asociado.*/
SELECT 
    e.nombre, e.apellido1, e.apellido2
FROM
    empleado AS e
        LEFT JOIN
    cliente AS c ON e.codigo_empleado = c.codigo_empleado_rep_ventas
WHERE
    c.codigo_empleado_rep_ventas IS NULL;
    
/*6. Devuelve un listado que muestre los empleados que no tienen una oficina asociada y los
que no tienen un cliente asociado.*/
SELECT 
    e.nombre, e.apellido1, e.apellido2
FROM
    empleado AS e
        LEFT JOIN
    cliente AS c ON e.codigo_empleado = c.codigo_empleado_rep_ventas
WHERE
    (codigo_oficina IS NULL
        OR c.codigo_empleado_rep_ventas IS NULL)
GROUP BY e.nombre , e.apellido1 , e.apellido2;
    
/*7. Devuelve un listado de los productos que nunca han aparecido en un pedido.*/
SELECT 
    p.codigo_producto, p.nombre, p.gama
FROM
    producto AS p
        LEFT JOIN
    detalle_pedido AS d ON p.codigo_producto = d.codigo_producto
WHERE
    d.codigo_producto IS NULL;

/*8. Devuelve las oficinas donde no trabajan ninguno de los empleados que hayan sido los
representantes de ventas de algún cliente que haya realizado la compra de algún producto
de la gama Frutales.*/

SELECT 
    *
FROM
    oficina AS ofi
WHERE
    codigo_oficina != ALL (SELECT DISTINCT
            (o.codigo_oficina)
        FROM
            oficina AS o
                JOIN
            empleado AS e ON o.codigo_oficina = e.codigo_oficina
                JOIN
            cliente AS c ON e.codigo_empleado = c.codigo_empleado_rep_ventas
                JOIN
            pedido AS p ON c.codigo_cliente = p.codigo_cliente
                JOIN
            detalle_pedido AS d ON p.codigo_pedido = d.codigo_pedido
                JOIN
            producto AS g ON d.codigo_producto = g.codigo_producto
                AND g.gama = 'frutales');

/*9. Devuelve un listado con los clientes que han realizado algún pedido, pero no han realizado
ningún pago.*/
SELECT 
    c.codigo_cliente,
    c.nombre_cliente,
    c.linea_direccion1,
    c.ciudad,
    c.region,
    c.pais
FROM
    cliente AS c
        JOIN
    pedido AS p ON c.codigo_cliente = p.codigo_cliente
        LEFT JOIN
    pago AS pa ON c.codigo_cliente = pa.codigo_cliente
WHERE
    pa.codigo_cliente IS NULL
GROUP BY c.codigo_cliente , c.nombre_cliente , c.linea_direccion1 , c.ciudad , c.region , c.pais
;
/*10. Devuelve un listado con los datos de los empleados que no tienen clientes asociados y el
nombre de su jefe asociado.*/
select 
e.codigo_empleado, e.nombre, e.apellido1, e.apellido2, e.codigo_jefe, e.puesto, b.nombre as 'Nombre Jefe',
b.apellido1 as 'Apellido', b.puesto as 'Puesto'
 from empleado as e
 left join cliente as c
 on e.codigo_empleado = c.codigo_empleado_rep_ventas
 left join empleado as b
 on e.codigo_jefe = b.codigo_empleado
 where c.codigo_empleado_rep_ventas is null;
 
/*Consultas resumen*/
/*1. ¿Cuántos empleados hay en la compañía?*/
select count(1) from empleado;
# hay 31 empleados

/*2. ¿Cuántos clientes tiene cada país?*/
select pais ,count(1) as 'Cant. clientes' from cliente
group by pais;

/*3. ¿Cuál fue el pago medio en 2009?*/
select avg(total) from pago where year(fecha_pago) = 2009;
# 4504.076923

/*4. ¿Cuántos pedidos hay en cada estado? Ordena el resultado de forma descendente por el
número de pedidos.*/
SELECT 
    estado, COUNT(1)
FROM
    pedido
GROUP BY estado
ORDER BY COUNT(1) DESC;

/*5. Calcula el precio de venta del producto más caro y más barato en una misma consulta.*/
select max(p.precio_venta) as 'Valor máx prod.' ,
(select min(g.precio_venta) from producto as g) as 'Valor mín Producto'  from producto as p;

/*6. Calcula el número de clientes que tiene la empresa.*/
SELECT 
    COUNT(1) AS 'Nro. Clientes'
FROM
    cliente;
    
/*7. ¿Cuántos clientes tiene la ciudad de Madrid?*/
SELECT 
    ciudad, COUNT(1) AS 'Nro. Clientes'
FROM
    cliente
WHERE
    ciudad = 'Madrid'
GROUP BY ciudad;
    
/*8. ¿Calcula cuántos clientes tiene cada una de las ciudades que empiezan por M?*/
SELECT 
    ciudad, COUNT(1) AS 'Nro. Clientes'
FROM
    cliente
WHERE
    ciudad LIKE 'M%'
GROUP BY ciudad;

/*9. Devuelve el nombre de los representantes de ventas y el número de clientes al que atiende
cada uno.*/
	SELECT
    e.nombre,
    e.apellido1,
    e.apellido2,     
    (SELECT COUNT(1) FROM cliente AS c 
    WHERE e.codigo_empleado = c.codigo_empleado_rep_ventas) AS 'Cantidad de Clientes'
    FROM empleado AS e 
    where (SELECT codigo_empleado FROM cliente AS c 
    WHERE e.codigo_empleado = c.codigo_empleado_rep_ventas limit 1) is not null ;
    
/*10. Calcula el número de clientes que no tiene asignado representante de ventas.*/
select count(1) as 'Clientes Sin Rep.Vtas.' from cliente as c where
(c.codigo_empleado_rep_ventas = 0 or c.codigo_empleado_rep_ventas is null);

/*11. Calcula la fecha del primer y último pago realizado por cada uno de los clientes. El listado
deberá mostrar el nombre y los apellidos de cada cliente.*/
select c.codigo_cliente,c.nombre_cliente, max(p.fecha_pago) as 'Fecha último pago' , min(p.fecha_pago) as 'Fecha primer Pago' 
from pago as p
join cliente as c
on p.codigo_cliente = c.codigo_cliente
group by c.codigo_cliente, c.nombre_cliente;

/*12. Calcula el número de productos diferentes que hay en cada uno de los pedidos.*/
select d.codigo_pedido, count(distinct(d.codigo_producto)) as 'Cantidad de productos distintos'
from detalle_pedido as d
group by d.codigo_pedido
order by d.codigo_pedido;

/*13. Calcula la suma de la cantidad total de todos los productos que aparecen en cada uno de
los pedidos.*/
select d.codigo_pedido, sum(d.cantidad) as 'Total Unidades'
from detalle_pedido as d
group by d.codigo_pedido;

/*14. Devuelve un listado de los 20 productos más vendidos y el número total de unidades que
se han vendido de cada uno. El listado deberá estar ordenado por el número total de
unidades vendidas.*/
SELECT 
    d.codigo_producto, SUM(d.cantidad) AS 'cantidad vendida'
FROM
    detalle_pedido AS d
GROUP BY d.codigo_producto
ORDER BY SUM(d.cantidad) DESC
LIMIT 20;

/*15. La facturación que ha tenido la empresa en toda la historia, indicando la base imponible, el
IVA y el total facturado. La base imponible se calcula sumando el coste del producto por el
número de unidades vendidas de la tabla detalle_pedido. El IVA es el 21 % de la base
imponible, y el total la suma de los dos campos anteriores.*/
SELECT 
    SUM(d.cantidad * d.precio_unidad) AS 'base imponible',
    SUM(d.cantidad * d.precio_unidad * 0.21) AS 'IVA',
    SUM(d.cantidad * d.precio_unidad * 1.21) AS 'Total'
FROM
    detalle_pedido AS d;

/*16. La misma información que en la pregunta anterior, pero agrupada por código de producto.*/
SELECT 
    d.codigo_producto AS 'Cod Producto',
    SUM(d.cantidad * d.precio_unidad) AS 'base imponible',
    SUM(d.cantidad * d.precio_unidad * 0.21) AS 'IVA',
    SUM(d.cantidad * d.precio_unidad * 1.21) AS 'Total'
FROM
    detalle_pedido AS d
GROUP BY d.codigo_producto
ORDER BY d.codigo_producto ASC;

/*17. La misma información que en la pregunta anterior, pero agrupada por código de producto
filtrada por los códigos que empiecen por OR.*/
SELECT 
    SUM(d.cantidad * d.precio_unidad) AS 'base imponible',
    SUM(d.cantidad * d.precio_unidad * 0.21) AS 'IVA',
    SUM(d.cantidad * d.precio_unidad * 1.21) AS 'Total'
FROM
    detalle_pedido AS d;

/*16. La misma información que en la pregunta anterior, pero agrupada por código de producto.*/
SELECT 
    d.codigo_producto AS 'Cod Producto',
    p.nombre as 'Descripción',
    SUM(d.cantidad * d.precio_unidad) AS 'base imponible',
    SUM(d.cantidad * d.precio_unidad * 0.21) AS 'IVA',
    SUM(d.cantidad * d.precio_unidad * 1.21) AS 'Total'
FROM
    detalle_pedido AS d
    inner join producto as p
    on d.codigo_producto = p.codigo_producto
    where p.nombre like 'OR%'
GROUP BY d.codigo_producto, p.nombre
ORDER BY d.codigo_producto ASC;

/*18. Lista las ventas totales de los productos que hayan facturado más de 3000 euros. Se
mostrará el nombre, unidades vendidas, total facturado y total facturado con impuestos (21%
IVA)*/
SELECT 
    d.codigo_producto AS 'Cod Producto',
    p.nombre AS 'Descripción',
    SUM(d.cantidad * d.precio_unidad) AS 'base imponible',
    SUM(d.cantidad * d.precio_unidad * 0.21) AS 'IVA',
    SUM(d.cantidad * d.precio_unidad * 1.21) AS 'Total'
FROM
    detalle_pedido AS d
        INNER JOIN
    producto AS p ON d.codigo_producto = p.codigo_producto
GROUP BY d.codigo_producto , p.nombre
HAVING SUM(d.cantidad * d.precio_unidad) > 3000
ORDER BY d.codigo_producto ASC;

/*Subconsultas con operadores básicos de comparación*/
/*1. Devuelve el nombre del cliente con mayor límite de crédito.*/
select * from cliente
order by limite_credito desc
limit 1;
/*2. Devuelve el nombre del producto que tenga el precio de venta más caro.*/
select * from producto
order by precio_venta desc
limit 1;
/*3. Devuelve el nombre del producto del que se han vendido más unidades. (Tenga en cuenta
que tendrá que calcular cuál es el número total de unidades que se han vendido de cada
producto a partir de los datos de la tabla detalle_pedido. Una vez que sepa cuál es el código
del producto, puede obtener su nombre fácilmente.)*/
select p.codigo_producto, p.nombre, sum(d.cantidad) as 'Cant.Vendida'
from detalle_pedido as d
join producto as p on
d.codigo_producto = p.codigo_producto
group by p.codigo_producto, p.nombre
order by sum(d.cantidad) desc
limit 1;

/*4. Los clientes cuyo límite de crédito sea mayor que los pagos que haya realizado. (Sin utilizar
INNER JOIN).*/
select c.codigo_cliente, c.nombre_cliente, c.limite_credito, 
(select sum(p.total) from pago as p where p.codigo_cliente = c.codigo_cliente) as 'Total Pagos' from cliente as c
where c.limite_credito > (select sum(p.total) from pago as p where p.codigo_cliente = c.codigo_cliente);

/*5. Devuelve el producto que más unidades tiene en stock.*/
select * from producto
order by cantidad_en_stock desc
limit 1;

/*6. Devuelve el producto que menos unidades tiene en stock.*/
select * from producto
order by cantidad_en_stock asc
limit 1;

/*7. Devuelve el nombre, los apellidos y el email de los empleados que están a cargo de Alberto
Soria.*/
select  e.nombre, e.apellido1, e.apellido2, e.codigo_jefe from empleado as e
where e.codigo_jefe = (select j.codigo_empleado from empleado as j
 where j.nombre  like '%alberto%' and j.apellido1 like '%soria%');
 
/*Subconsultas con ALL y ANY*/
/*1. Devuelve el nombre del cliente con mayor límite de crédito.*/

/*2. Devuelve el nombre del producto que tenga el precio de venta más caro.*/
/*3. Devuelve el producto que menos unidades tiene en stock.*/
/*Subconsultas con IN y NOT IN*/
/*1. Devuelve el nombre, apellido1 y cargo de los empleados que no representen a ningún
cliente.*/
/*2. Devuelve un listado que muestre solamente los clientes que no han realizado ningún pago.*/
/*3. Devuelve un listado que muestre solamente los clientes que sí han realizado ningún pago.*/
/*4. Devuelve un listado de los productos que nunca han aparecido en un pedido.*/
/*5. Devuelve el nombre, apellidos, puesto y teléfono de la oficina de aquellos empleados que
no sean representante de ventas de ningún cliente.*/
/*Subconsultas con EXISTS y NOT EXISTS*/
/*1. Devuelve un listado que muestre solamente los clientes que no han realizado ningún
pago.*/
/*2. Devuelve un listado que muestre solamente los clientes que sí han realizado ningún pago.*/
/*3. Devuelve un listado de los productos que nunca han aparecido en un pedido.*/
/*4. Devuelve un listado de los productos que han aparecido en un pedido alguna vez.*/