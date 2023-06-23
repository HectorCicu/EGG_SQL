use tienda;
/*Consultas Multitabla*/
/*1. Devuelve una lista con el código del producto, nombre del producto, código del fabricante
y nombre del fabricante, de todos los productos de la base de datos.*/
select p.codigo as 'Codigo Producto' , p.nombre as 'Nombre Producto', 
f.codigo as 'Código Fabricante', f.nombre as 'Nombre Fabricante' 
from producto as p
join fabricante as f
on p.codigo_fabricante = f.codigo;

/*2. Devuelve una lista con el nombre del producto, precio y nombre de fabricante de todos
los productos de la base de datos. Ordene el resultado por el nombre del fabricante, por
orden alfabético.*/
select p.codigo as 'Codigo Producto' , p.nombre as 'Nombre Producto', 
f.codigo as 'Código Fabricante', f.nombre as 'Nombre Fabricante' 
from producto as p
join fabricante as f
on p.codigo_fabricante = f.codigo
order by f.nombre asc;

/*3. Devuelve el nombre del producto, su precio y el nombre de su fabricante, del producto
más barato.*/
select p.codigo as 'Codigo Producto' , p.nombre as 'Nombre Producto', p.precio as 'Precio', 
f.codigo as 'Código Fabricante', f.nombre as 'Nombre Fabricante' 
from producto as p
join fabricante as f
on p.codigo_fabricante = f.codigo
order by precio asc
limit 1 ;

/*4. Devuelve una lista de todos los productos del fabricante Lenovo.*/
select p.codigo as 'Codigo Producto' , p.nombre as 'Nombre Producto', p.precio as 'Precio', 
f.codigo as 'Código Fabricante', f.nombre as 'Nombre Fabricante' 
from producto as p
join fabricante as f
on p.codigo_fabricante = f.codigo
where f.nombre like '%Lenovo%';

/*5. Devuelve una lista de todos los productos del fabricante Crucial que tengan un precio
mayor que $200.*/
select p.codigo as 'Codigo Producto' , p.nombre as 'Nombre Producto', p.precio as 'Precio', 
f.codigo as 'Código Fabricante', f.nombre as 'Nombre Fabricante' 
from producto as p
join fabricante as f
on p.codigo_fabricante = f.codigo
where f.nombre like '%crucial%' and p.precio > 200;

/*6. Devuelve un listado con todos los productos de los fabricantes Asus, Hewlett-Packard.
Utilizando el operador IN.*/
select p.codigo as 'Codigo Producto' , p.nombre as 'Nombre Producto', precio as 'Precio', 
f.codigo as 'Código Fabricante', f.nombre as 'Nombre Fabricante' 
from producto as p
join fabricante as f
on p.codigo_fabricante = f.codigo
where f.nombre in ( 'Hewlett-Packard' , 'Asus');

/*7. Devuelve un listado con el nombre de producto, precio y nombre de fabricante, de todos
los productos que tengan un precio mayor o igual a $180. Ordene el resultado en primer
lugar por el precio (en orden descendente) y en segundo lugar por el nombre (en orden
ascendente)*/

select p.codigo as 'Codigo Producto' , p.nombre as 'Nombre Producto', p.precio as 'Precio', 
f.codigo as 'Código Fabricante', f.nombre as 'Nombre Fabricante' 
from producto as p
join fabricante as f
on p.codigo_fabricante = f.codigo
where p.precio >= 180
order by p.precio asc, p.nombre asc;

/*Consultas Multitabla*/

/*Resuelva todas las consultas utilizando las cláusulas LEFT JOIN y RIGHT JOIN.*/
/*1. Devuelve un listado de todos los fabricantes que existen en la base de datos, junto con los
productos que tiene cada uno de ellos. El listado deberá mostrar también aquellos
fabricantes que no tienen productos asociados.*/
select * from fabricante as f 
left join producto as p on
f.codigo = p.codigo_fabricante; 

/*2. Devuelve un listado donde sólo aparezcan aquellos fabricantes que no tienen ningún
producto asociado.*/
select * from fabricante as f 
left join producto as p on
f.codigo = p.codigo_fabricante
where p.codigo is null; 

/*Subconsultas (En la cláusula WHERE)*/
/*Con operadores básicos de comparación*/
/*1. Devuelve todos los productos del fabricante Lenovo. (Sin utilizar INNER JOIN).*/
select * 
from  producto as p
where p.codigo_fabricante = (select codigo from fabricante where nombre = 'Lenovo') ; 

/*2. Devuelve todos los datos de los productos que tienen el mismo precio que el producto
más caro del fabricante Lenovo. (Sin utilizar INNER JOIN).*/
select p.codigo as 'Codigo Producto' , p.nombre as 'Nombre Producto', p.precio as 'Precio' 
from producto as p
Where p.precio = (select max(pr.precio)
from  producto as pr 
where pr.codigo_fabricante = (select codigo from fabricante where nombre = 'Lenovo')) ; 


/*3. Lista el nombre del producto más caro del fabricante Lenovo.*/
select p.codigo as 'Codigo Producto' , p.nombre as 'Nombre Producto', p.precio as 'Precio', 
f.codigo as 'Código Fabricante', f.nombre as 'Nombre Fabricante' 
from producto as p
join fabricante as f
on p.codigo_fabricante = f.codigo
where f.nombre = 'LENOVO' 
order by p.precio asc
limit 1;

/*4. Lista todos los productos del fabricante Asus que tienen un precio superior al precio
medio de todos sus productos.*/
select p.codigo as 'Codigo Producto' , p.nombre as 'Nombre Producto', p.precio as 'Precio', 
f.codigo as 'Código Fabricante', f.nombre as 'Nombre Fabricante' 
from producto as p
join fabricante as f
on p.codigo_fabricante = f.codigo
where f.nombre = 'ASUS'
and p.precio > (select avg(precio)
from  producto as pr 
where pr.codigo_fabricante = (select codigo from fabricante where nombre = 'ASUS'));
select* from producto where codigo_fabricante = 1;
select avg(precio)from  producto as pr;
 select avg(precio)
from  producto as pr 
where pr.codigo_fabricante = (select codigo from fabricante where nombre = 'ASUS');
/*Subconsultas con IN y NOT IN*/
/*1. Devuelve los nombres de los fabricantes que tienen productos asociados. (Utilizando IN o
NOT IN).*/
select * from fabricante as f
where f.codigo in (select codigo_fabricante from producto);


/*2. Devuelve los nombres de los fabricantes que no tienen productos asociados. (Utilizando
IN o NOT IN).*/
select * from fabricante as f
where f.codigo not in (select codigo_fabricante from producto);

/*Subconsultas (En la cláusula HAVING)*/
/*1. Devuelve un listado con todos los nombres de los fabricantes que tienen el mismo número
de productos que el fabricante Lenovo.*/
select * 
from  producto as p
having p.codigo_fabricante = (select codigo from fabricante where nombre = 'Lenovo') ; 


