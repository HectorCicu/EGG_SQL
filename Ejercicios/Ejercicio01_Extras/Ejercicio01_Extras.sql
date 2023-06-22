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
SELECT 
    ju.codigo,
    ju.nombre,
    ju.Nombre_equipo,
    (SELECT 
            SUM((e.puntos_por_partido) * (SELECT 
                        COUNT(1)
                    FROM
                        partidos AS p
                    WHERE
                        (ju.Nombre_equipo = p.equipo_local
                            OR ju.nombre_equipo = p.equipo_visitante)
                            AND p.temporada = e.temporada))
        FROM
            estadisticas AS e
        WHERE
            ju.codigo = e.jugador) AS 'Puntos Totales'
FROM
    jugadores AS ju
GROUP BY ju.codigo , ju.nombre , ju.Nombre_equipo;

/*SELECT 
    ju.codigo,
    ju.nombre,
    ju.Nombre_equipo,
    e.temporada,
    sum(e.Puntos_por_partido *  (select count(1) from partidos as p where (ju.nombre_equipo = p.equipo_local or ju.nombre_equipo = p.equipo_visitante)
     and e.temporada= p.temporada)) as 'Puntos Totales'  
    from jugadores as ju
    join estadisticas as e on 
    ju.codigo = e.jugador
    group by ju.codigo, ju.nombre, ju.Nombre_equipo, e.temporada ;*/
select * from estadisticas where jugador = 1;
select * from jugadores where codigo = 1;
SELECT 
    temporada, COUNT(1) AS cantpartidos
FROM
    partidos
WHERE
    (equipo_local = 'Timberwolves'
        OR equipo_visitante = 'Timberwolves')
GROUP BY temporada;


/*11. Mostrar el número de jugadores de cada equipo.*/
select Nombre_equipo, count(1) as  'Cant Jugadores' from jugadores
group by Nombre_equipo;


/*12. Mostrar el jugador que más puntos ha realizado en toda su carrera.*/
select jugador, nombre, Puntos_por_partido from estadisticas
join jugadores on
jugador = codigo
group by jugador, Nombre, Puntos_por_partido
order by puntos_por_partido desc
limit 1;

/*13. Mostrar el nombre del equipo, conferencia y división del jugador más alto de la NBA.*/
select j.nombre, j.nombre_equipo, e.Conferencia, altura from jugadores as j
join equipos as e
on j.nombre_equipo = e.Nombre
group by j.nombre, j.Nombre_equipo, e.Conferencia, altura
order by altura desc
limit 1;

/*14. Mostrar la media de puntos en partidos de los equipos de la división Pacific.*/
select avg(p.puntos_local) as 'Promedio Local', avg(p.puntos_visitante) as 'Promedio Visitante' from partidos as p
join equipos as l
on p.equipo_local = l.Nombre
join equipos as v
on p.equipo_visitante = v.Nombre
where l.division = 'Pacific' and v.Division = 'Pacific';

/*15. Mostrar el partido o partidos (equipo_local, equipo_visitante y diferencia) con mayor
diferencia de puntos.*/
select equipo_local  as  'Eq. Local', puntos_local as 'Puntos Local',
equipo_visitante as 'Eq. Visitante',  puntos_visitante as 'Puntos Visitantes',
 abs(puntos_local - puntos_visitante) as 'Diferencia' , temporada from partidos
 order by abs(puntos_local - puntos_visitante) desc
 limit 1;
/*16. Mostrar la media de puntos en partidos de los equipos de la división Pacific.*/
select avg(p.puntos_local) as 'Promedio Local', avg(p.puntos_visitante) as 'Promedio Visitante' from partidos as p
join equipos as l
on p.equipo_local = l.Nombre
join equipos as v
on p.equipo_visitante = v.Nombre
where l.division = 'Pacific' and v.Division = 'Pacific';
/*17. Mostrar los puntos de cada equipo en los partidos, tanto de local como de visitante.*/
select e.nombre, 
(select sum(pl.puntos_local) from partidos as pl where e.nombre = equipo_local) as 'Puntos de Local',
(select sum(pl.puntos_visitante) from partidos as pl where e.nombre = equipo_local) as 'Puntos de Visitante' 
from equipos as e;

/*18. Mostrar quien gana en cada partido (codigo, equipo_local, equipo_visitante,
equipo_ganador), en caso de empate sera null.*/
select codigo, equipo_local, puntos_local, equipo_visitante , puntos_visitante
, case when puntos_local > puntos_visitante then equipo_local
       when puntos_local < puntos_visitante then equipo_visitante
       else null end as 'Equipo Ganador'
from partidos;
