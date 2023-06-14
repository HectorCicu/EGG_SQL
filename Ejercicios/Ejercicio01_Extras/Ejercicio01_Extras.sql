use nba;
/*A continuación, se deben realizar las siguientes consultas sobre la base de datos:
/*1. Mostrar el nombre de todos los jugadores ordenados alfabéticamente.*/
select * from jugadores 
order by Nombre asc;

/*2. Mostrar el nombre de los jugadores que sean pivots (‘C’) y que pesen más de 200 libras,
ordenados por nombre alfabéticamente.*/
select * from jugadores 
where posicion = 'c' and peso > 200
order by nombre asc;

/*3. Mostrar el nombre de todos los equipos ordenados alfabéticamente.*/
select * from equipos 
order by equipos.Nombre asc;

/*4. Mostrar el nombre de los equipos del este (East).*/
select * from equipos 
where conferencia = 'east';

/*5. Mostrar los equipos donde su ciudad empieza con la letra ‘c’, ordenados por nombre.*/
select * from equipos
where ciudad like 'C%'
order by nombre asc;

/*6. Mostrar todos los jugadores y su equipo ordenados por nombre del equipo.*/
select * from equipos as e
inner join jugadores as j
on e.nombre = j.Nombre_equipo
order by e.nombre asc;

/*7. Mostrar todos los jugadores del equipo “Raptors” ordenados por nombre.*/
select * from jugadores as j
where j.Nombre_equipo =  'RAPTORS' 
order by nombre asc;
/*8. Mostrar los puntos por partido del jugador ‘Pau Gasol’.*/
select * from jugadores as j
inner join estadisticas as e
on j.codigo = e.jugador
where j.nombre = 'Pau Gasol';

/*9. Mostrar los puntos por partido del jugador ‘Pau Gasol’ en la temporada ’04/05′.*/
select * from jugadores as j
inner join estadisticas as e
on j.codigo = e.jugador
where j.nombre = 'Pau Gasol'
and temporada = '04/05';

/*10. Mostrar el número de puntos de cada jugador en toda su carrera.*/
select j.codigo, j.nombre, j.Nombre_equipo, 
(select sum(puntos_por_partido) from estadisticas as e where j.codigo = e.jugador ) as puntos
from jugadores as j;

/*11. Mostrar el número de jugadores de cada equipo.*/
select Nombre_equipo, count(1) as  'Cant Jugadores' from jugadores
group by Nombre_equipo;
/*12. Mostrar el jugador que más puntos ha realizado en toda su carrera.*/
/*13. Mostrar el nombre del equipo, conferencia y división del jugador más alto de la NBA.*/
/*14. Mostrar la media de puntos en partidos de los equipos de la división Pacific.*/
/*15. Mostrar el partido o partidos (equipo_local, equipo_visitante y diferencia) con mayor
diferencia de puntos.*/
/*16. Mostrar la media de puntos en partidos de los equipos de la división Pacific.*/
/*17. Mostrar los puntos de cada equipo en los partidos, tanto de local como de visitante.*/
/*18. Mostrar quien gana en cada partido (codigo, equipo_local, equipo_visitante,
equipo_ganador), en caso de empate sera null.*/select * from equipos as e join jugadores as j on e.nombre = j.Nombre_equipo order by e.nombre_equipo asc LIMIT 0, 1000
