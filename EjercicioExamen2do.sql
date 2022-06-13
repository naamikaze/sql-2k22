/*
Ejercicio 1
Cree una vista que informe UsuarioID, Minutos (según su plan), MinutosConsumidos, MinutosRestantes.
Para el cálculo de los minutos consumidos tener en cuenta
que las llamadas entre Usuarios de una misma compañía no consumen minutos. 
*/ 

create view vEj1 as
select u.UsuarioID, p.minutos minutosPlan, SUM(ll.minutos) consumidos, p.minutos - SUM(ll.minutos) restantes
from Usuarios u
join Compañia c
on u.CialID = c.CialID
join Usuarios_Planes up
on up.UsuarioID = u.UsuarioID
join Planes p
on p.PlanID = up.PlanID
join Llamadas ll
on ll.UsuarioID = u.UsuarioID
join Usuarios ud
on ll.DestinoID = ud.UsuarioID
join Compañia cd
on ud.CialID = cd.CialID
where c.CialID <> cd.CialID
group by u.UsuarioID, p.Minutos

select *
from vEj1

/*
Ejercicio 2
Cree un índice sobre la columna UsuarioID de la tabla de llamadas. 
*/

CREATE INDEX ix_llamadas_usuarioid
on llamadas(UsuarioID)


/*
Ejercicio 3
Cree un Stored Procedure que reciba un ID de llamada y devuelva 
NombreUsuario, NombreCía, NombrePlan, NombreUsuarioDestino, NombreCíaDestino y NombrePlanDestino. 
*/

CREATE PROCEDURE Ejercicio3 (@LlamadaID int)
AS BEGIN

SELECT u.Nombre NombreUsuario,
c.Nombre NombreCía,
p.Nombre NombrePlan,
ud.Nombre NombreUsuarioDestino,
cd.Nombre NombreCíaDestino,
pd.Nombre NombrePlanDestino
from Usuarios u
join Compañia c
on u.CialID = c.CialID
join Usuarios_Planes up
on up.UsuarioID = u.UsuarioID
join Planes p
on p.PlanID = up.PlanID
join Llamadas ll
on ll.UsuarioID = u.UsuarioID
join Usuarios ud
on ll.DestinoID = ud.UsuarioID
join Compañia cd
on ud.CialID = cd.CialID
join Usuarios_Planes upd
on upd.UsuarioID = ud.UsuarioID
join Planes pd
on pd.PlanID = upd.PlanID

END

exec Ejercicio3 1

/*
Ejercicio 4: Cree un stored procedure que reciba un ID de plan e informe el promedio
de duración de las llamadas de los usuarios de plan seleccionado, agrupado por Compañía. 
*/

CREATE PROCEDURE Ejer4 @planID int
AS BEGIN
SELECT U.CialID, AVG(Cast(l.Minutos as Float)) Promedio
FROM Usuarios U
JOIN Llamadas L
ON U.UsuarioID = L.UsuarioID
JOIN Usuarios_Planes UP
ON U.UsuarioID = UP.UsuarioID
WHERE UP.PlanID = @planID
GROUP BY U.CialID
END

EXEC Ejer4 1


/*
Ejercicio 5: Cree un stored procedure que devuelva los nombres de los usuarios que hicieron 3 o más llamadas. 
*/

Create procedure Ej5 
as begin

select u.Nombre, u.UsuarioID
from Usuarios u
join Llamadas l
 on l.UsuarioID = u.UsuarioID
group by u.UsuarioID, u.Nombre
having COUNT(1) >= 3
end

exec Ej5 


/*
Ejercicio 6: Cree una función que reciba UsuarioID y DestinoID, 
y devuelva la cantidad de llamados que se hicieron desde ese usuario y hasta ese destino. 
*/

Create function Ej6 
(@usuarioid int,
@destinoid int
)
RETURNS INT
as begin
declare @cantidad int


select @cantidad = count(1) 
from Llamadas l
where UsuarioID = @usuarioid and DestinoID = @destinoid

return @cantidad

end

select dbo.Ej6 (4,2) Cantidad

