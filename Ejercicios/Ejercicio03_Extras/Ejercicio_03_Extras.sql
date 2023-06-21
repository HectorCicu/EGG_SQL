/*A continuación, se deben realizar las siguientes consultas:*/
/*1. Mostrar el nombre de todos los pokemon.*/
SELECT 
    *
FROM
    pokemon;

/*2. Mostrar los pokemon que pesen menos de 10k.*/
SELECT 
    *
FROM
    pokemon
WHERE
    peso < 10;

/*3. Mostrar los pokemon de tipo agua.*/
SELECT 
    *
FROM
    pokemon AS p
        JOIN
    pokemon_tipo AS tp ON p.numero_pokedex = tp.numero_pokedex
        JOIN
    tipo AS t ON tp.id_tipo = t.id_tipo
WHERE
    t.nombre = 'agua'; 
    
    call muestraPokemonByTipo('agua'); --  otro ejemplo usando el Store Procedure muestraPokemonByTipo

/*4. Mostrar los pokemon de tipo agua, fuego o tierra ordenados por tipo.*/
SELECT 
    *
FROM
    pokemon AS p
        JOIN
    pokemon_tipo AS tp ON p.numero_pokedex = tp.numero_pokedex
        JOIN
    tipo AS t ON tp.id_tipo = t.id_tipo
WHERE
    t.nombre IN ('agua' , 'tierra', 'fuego')
ORDER BY t.nombre ASC; 

/*5. Mostrar los pokemon que son de tipo fuego y volador.*/
SELECT 
    *
FROM
    pokemon AS p
        JOIN
    pokemon_tipo AS tp ON p.numero_pokedex = tp.numero_pokedex
        JOIN
    tipo AS t ON tp.id_tipo = t.id_tipo
WHERE
    t.nombre IN ('agua' , 'tierra', 'fuego')
ORDER BY t.nombre ASC; 

/*6. Mostrar los pokemon con una estadística base de ps mayor que 200.*/
SELECT 
    *
FROM
    pokemon AS p
        JOIN
    estadisticas_base AS e ON p.numero_pokedex = e.numero_pokedex
WHERE
    e.ps > 200;
/*7. Mostrar los datos (nombre, peso, altura) de la prevolución de Arbok.*/

select * from pokemon as p
where p.numero_pokedex = (select e.pokemon_origen from evoluciona_de as e
where e.pokemon_evolucionado = 
(select pk.numero_pokedex from pokemon as pk where pk.nombre ='Arbok'));

select * from evoluciona_de where pokemon_evolucionado = 24; -- comprobación de la evolución de Arbok (24)

/*8. Mostrar aquellos pokemon que evolucionan por intercambio.*/
SELECT 
    p.numero_pokedex, p.nombre, p.peso, p.altura
FROM
    pokemon AS p
        JOIN
    pokemon_forma_evolucion AS e ON p.numero_pokedex = e.numero_pokedex
        JOIN
    forma_evolucion AS f ON e.id_forma_evolucion = f.id_forma_evolucion
        JOIN
    tipo_evolucion AS t ON t.id_tipo_evolucion = f.tipo_evolucion
WHERE
    t.tipo_evolucion LIKE '%Intercambio%';
    
/*9. Mostrar el nombre del movimiento con más prioridad.*/
SELECT 
    *
FROM
    movimiento
ORDER BY prioridad DESC
LIMIT 1;

/*10. Mostrar el pokemon más pesado.*/
SELECT 
    *
FROM
    pokemon
ORDER BY peso DESC
LIMIT 1;
/*11. Mostrar el nombre y tipo del ataque con más potencia.*/
SELECT 
    *
FROM
    movimiento
ORDER BY potencia DESC
LIMIT 1;

select * from tipo_ataque;
select * from tipo;
select * from estadisticas_base;
select * from movimiento;
/*12. Mostrar el número de movimientos de cada tipo.*/
SELECT 
    m.id_tipo, COUNT(1) AS 'Cantidad'
FROM
    movimiento AS m
GROUP BY m.id_tipo;

/*13. Mostrar todos los movimientos que puedan envenenar.*/
SELECT 
    m.id_movimiento, m.nombre, m.potencia, m.id_tipo
FROM
    movimiento AS m
        JOIN
    tipo AS t ON m.id_tipo = t.id_tipo
WHERE
    t.nombre LIKE '%veneno%';

/*14. Mostrar todos los movimientos que causan daño, ordenados alfabéticamente por nombre.*/
SELECT 
    *
FROM
    movimiento
WHERE
    descripcion LIKE '%daño%'
ORDER BY nombre ASC;

/*15. Mostrar todos los movimientos que aprende pikachu.*/
SELECT 
    p.numero_pokedex,
    p.nombre,
  
    
    t.tipo_aprendizaje,
    t.id_tipo_aprendizaje
FROM
    pokemon AS p
        INNER JOIN
    pokemon_movimiento_forma AS m ON p.numero_pokedex = m.numero_pokedex
             INNER JOIN
    forma_aprendizaje AS f ON f.id_forma_aprendizaje = m.id_forma_aprendizaje
        LEFT JOIN
    tipo_forma_aprendizaje AS t ON f.id_tipo_aprendizaje= t.id_tipo_aprendizaje
WHERE
    p.nombre LIKE '%pikachu%'
GROUP BY p.numero_pokedex , p.nombre , m.id_movimiento ,  t.tipo_aprendizaje , t.id_tipo_aprendizaje;

/*16. Mostrar todos los movimientos que aprende pikachu por MT (tipo de aprendizaje).*/
SELECT 
    p.numero_pokedex,
    p.nombre,
    n.nivel,
    t.tipo_aprendizaje,
    t.id_tipo_aprendizaje
FROM
    pokemon AS p
        INNER JOIN
    pokemon_movimiento_forma AS m ON p.numero_pokedex = m.numero_pokedex
        INNER JOIN
    forma_aprendizaje AS f ON f.id_forma_aprendizaje = m.id_forma_aprendizaje
        LEFT JOIN
    tipo_forma_aprendizaje AS t ON f.id_tipo_aprendizaje = t.id_tipo_aprendizaje

WHERE
    p.nombre LIKE '%pikachu%'
        AND t.tipo_aprendizaje = 'MT'
GROUP BY p.numero_pokedex , p.nombre , m.id_movimiento , t.tipo_aprendizaje , t.id_tipo_aprendizaje;

/*17. Mostrar todos los movimientos de tipo normal que aprende pikachu por nivel.*/
-- ????????????????????????????????????????????????????????????????????
SELECT 
*
 FROM
    pokemon AS p
        left JOIN
  pokemon_forma_evolucion as f on
  p.numero_pokedex = f.numero_pokedex
  left join forma_evolucion as fe on
  f.id_forma_evolucion = fe.id_forma_evolucion
  left join nivel_evolucion as n on
  fe.id_forma_evolucion = n.id_forma_evolucion
WHERE
    p.nombre LIKE '%pikachu%';

/*18. Mostrar todos los movimientos de efecto secundario cuya probabilidad sea mayor al 30%.*/
SELECT 
    *
FROM
    movimiento_efecto_secundario AS m
        JOIN
    efecto_secundario AS e ON m.id_efecto_secundario = e.id_efecto_secundario
WHERE
    probabilidad > 30;
/*19. Mostrar todos los pokemon que evolucionan por piedra.*/
select * from pokemon as p
join pokemon_forma_evolucion as f
on p.numero_pokedex = f.numero_pokedex
join forma_evolucion as fe
on f.id_forma_evolucion = fe.id_forma_evolucion
join piedra as r
on fe.id_forma_evolucion = r.id_forma_evolucion;

/*20. Mostrar todos los pokemon que no pueden evolucionar.*/
SELECT 
    *
FROM
    pokemon_no_evolucionan; --  utilizo la vista
    
/*21. Mostrar la cantidad de los pokemon de cada tipo.*/
SELECT 
    p.numero_pokedex, p.nombre, k.nombre
FROM
    pokemon AS p
        JOIN
    pokemon_tipo AS t ON p.numero_pokedex = t.numero_pokedex
        JOIN
    tipo AS k ON t.id_tipo = k.id_tipo;
