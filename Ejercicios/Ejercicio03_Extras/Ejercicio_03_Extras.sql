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
/*6. Mostrar los pokemon con una estadística base de ps mayor que 200.*/
/*7. Mostrar los datos (nombre, peso, altura) de la prevolución de Arbok.*/
/*8. Mostrar aquellos pokemon que evolucionan por intercambio.*/
/*9. Mostrar el nombre del movimiento con más prioridad.*/
/*10. Mostrar el pokemon más pesado.*/
/*11. Mostrar el nombre y tipo del ataque con más potencia.*/
/*12. Mostrar el número de movimientos de cada tipo.*/
/*13. Mostrar todos los movimientos que puedan envenenar.*/
/*14. Mostrar todos los movimientos que causan daño, ordenados alfabéticamente por nombre.*/
/*15. Mostrar todos los movimientos que aprende pikachu.*/
/*16. Mostrar todos los movimientos que aprende pikachu por MT (tipo de aprendizaje).*/
/*17. Mostrar todos los movimientos de tipo normal que aprende pikachu por nivel.*/
/*18. Mostrar todos los movimientos de efecto secundario cuya probabilidad sea mayor al 30%.*/
/*19. Mostrar todos los pokemon que evolucionan por piedra.*/
/*20. Mostrar todos los pokemon que no pueden evolucionar.*/
/*21. Mostrar la cantidad de los pokemon de cada tipo.*/