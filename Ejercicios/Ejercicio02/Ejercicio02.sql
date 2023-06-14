use tienda;

/* Lista el nombre de todos los productos que hay en la tabla producto.*/
select nombre as 'Nombre producto' from producto;

/*2. Lista los nombres y los precios de todos los productos de la tabla producto.*/
select nombre as 'Nommbre Producto', precio as 'Precio' 
from producto;

/* 3. Lista todas las columnas de la tabla producto.*/
select * from producto;

/*4. Lista los nombres y los precios de todos los productos de la tabla producto, redondeando
el valor del precio.*/
select nombre as 'Producto', round(precio,0) as 'Precio'
from producto;

/*5. Lista el código de los fabricantes que tienen productos en la tabla producto.*/
select f.codigo from fabricante as f 
inner join producto  as p on
p.codigo_fabricante = f.codigo;

/*6. Lista el código de los fabricantes que tienen productos en la tabla producto, sin mostrar
los repetidos. */
select f.codigo from fabricante as f 
inner join producto  as p on
p.codigo_fabricante = f.codigo
group by f.codigo;

/*7. Lista los nombres de los fabricantes ordenados de forma ascendente.*/
select nombre from fabricante
order by nombre asc;

/*8. Lista los nombres de los productos ordenados en primer lugar por el nombre de forma
ascendente y en segundo lugar por el precio de forma descendente.*/
select * from producto 
order by nombre asc, precio desc;

/*9. Devuelve una lista con las 5 primeras filas de la tabla fabricante.*/
select * from fabricante limit 5;

/*10. Lista el nombre y el precio del producto más barato. (Utilice solamente las cláusulas
ORDER BY y LIMIT)*/
select nombre as 'Nombre Producto' , precio as 'Precio'  
from producto 
order by precio asc
limit 1 ;

/*11. Lista el nombre y el precio del producto más caro. (Utilice solamente las cláusulas ORDER
BY y LIMIT)*/
select nombre as 'Nombre Producto' , precio as 'Precio'  
from producto 
order by precio desc
limit 1 ;

/*12. Lista el nombre de los productos que tienen un precio menor o igual a $120.*/
select * from producto 
where precio = 120;

/*13. Lista todos los productos que tengan un precio entre $60 y $200. Utilizando el operador
BETWEEN.*/
select * from producto where precio between 60 and 200;

/*14. Lista todos los productos donde el código de fabricante sea 1, 3 o 5. Utilizando el operador
IN.*/
select * from producto where codigo_fabricante in (1,3,5);

/*15. Devuelve una lista con el nombre de todos los productos que contienen la cadena Portátil
en el nombre.*/
select * from producto where nombre like '%portatil%';