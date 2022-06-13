--Ejercicio futbol

--1 determinar el equipo con la mayor cant de partidos ganados.

select * --nombre as club, ganados
from General
where ganados IN (
    select max(ganados) from general
    union
    select max(ganados) from general
)
select top 1 * from general 
order by ganados desc

--2 determinar el equipo con el mejor y peor promedio
select nombre as club, promedio
from General
where promedio IN (
    select max(promedio) from general 
    union
    select min(promedio) from general 
)

--3 determinar el jugador con el nro de documento mas bajo
select * 
from jugadores  
where Nrodoc in (
    select min(Nrodoc) from Jugadores
)

--4 listar los jugadores mas jovenes y los mas viejos del torneo.
select * from jugadores where Fecha_Nac in (
    select min(fecha_nac) from Jugadores
    union
    select max(fecha_nac) from Jugadores
)

--5 listar el jugador con el nro doc mas alto que pertenezca al equipo con el promedio mas bajo.
select*
from jugadores
where Id_Club in (
    select Id_Club
    from general
    where Promedio in(
        select min(Promedio) from General
    ) and Nrodoc in(select MAX(nrodoc) from Jugadores where Id_Club in(
	select Id_Club
	from general
	where Promedio in(
	select min(Promedio) from General
	))))

	--6 listar nombre del equipo y promedio de todos los equipos con un promedio inferior al mas alto.
	select nombre as club, promedio
	from General 
	where promedio NOT IN ( --Quiero los que no estan en esal ista
	select max(promedio) from general
	union
	select min(promedio) from general
	) 

	/* 7 listar nombre de equipo, nombre del jugador y fecha nac de los jugadores mas viejos 
	de aquellos equipos con un promedio inferior al promedio del equipo con la menor
	cantidad de partidos ganados. */

	select Nombre as jugador, Fecha_Nac
	from jugadores
	join general g
		on j.Id_Club = g.Id_Club
	where Fecha_Nac in
	(select min(Fecha_Nac) from jugadores)
	and j.Id_Club IN( select id_club from general 
	where ganados in (select min(ganados) from general)
	and promedio in(select min(promedio from general)
	)


	/* 8 Listar nombre y num doc de aquellos jugadores con el menor num de doc que pertenezcan a un equipo 
	donde la cant de partidos ganados sea igual a la cant de partidos perdidos */
	select * from Jugadores where Nrodoc in (
		select min(Nrodoc) from Jugadores
		where Id_Club in(select Id_Club from General where Ganados = Perdidos)

	/* 9 Determianr la categoria con el mejor y el peor promedio */
	select * from(
	select '184'as cat, MIN(promedio) as min, max(promedio) as max
	from PosCate184

	select '185' as cat, MIN(promedio) as min, max(promedio) as max
	from PosCate185

	select '284' as cat, MIN(promedio) as min, max(promedio) as max
	from PosCate284

	select '285' as cat, MIN(promedio) as min, max(promedio) as max
	from PosCate285
	) as t1

	where t1.min IN (
	select min(Promedio) from(
	select Promedio 
	from PosCate184
	union

	select Promedio
	from PosCate185
	union

	select Promedio
	from PosCate284
	union

	select Promedio
	from PosCate285)as t2
	or t1.max in(
		select max(Promedio) from(
	select Promedio 
	from PosCate184
	union

	select Promedio
	from PosCate185
	union

	select Promedio
	from PosCate284
	union

	select Promedio
	from PosCate285)as t3))
	
	/* 10 Determinar la maxima diferencia de goles (goles-golesV) de un partido en el que
	haya participado el equipo con el peor promedio del campeonato*/

	select max(GolesL-GolesV) from Partidos 
	where Id_ClubL in( select Id_Club from General where promedio
	in(select min(promedio) from general)

	or Id_ClubV in(
	select Id_Club from General where Promedio in ( select min(promedio) from general)
	)