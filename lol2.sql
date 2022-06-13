/*
Ejercicio 1: Cree una vista que informe UsuarioID, Minutos (según su plan), MinutosConsumidos, MinutosRestantes. Para el cálculo de los minutos consumidos tener en cuenta que las llamadas entre Usuarios de una misma compañía no consumen minutos. 
*/
create view ej21 as
select u.UsuarioID, pl.Minutos, sum(ll.Minutos) as Consumidos , pl.Minutos-sum(ll.Minutos) as Restantes  from dbo.Usuarios u 
join dbo.Usuarios_Planes up on u.UsuarioID = up.UsuarioID 
join dbo.Planes pl on up.PlanID = pl.PlanID
join dbo.Llamadas ll on u.UsuarioID = ll.UsuarioID
join dbo.Usuarios_Planes usp on ll.DestinoID = usp.UsuarioID
where usp.PlanID != pl.PlanID
group by u.UsuarioID, pl.Minutos

select * from ej1 

--Ejercicio 2: Cree un índice sobre la columna UsuarioID de la tabla de llamadas. 
create index indicellamada on llamadas(UsuarioID)

/*
Ejercicio 3
Cree un Stored Procedure que reciba un ID de llamada y devuelva 
NombreUsuario, NombreCía, NombrePlan, NombreUsuarioDestino, NombreCíaDestino y NombrePlanDestino. 
*/
create procedure ej333(@id int)
as begin
select u.Nombre, ci.Nombre, pl.Nombre, usu.Nombre, cia.Nombre, pla.Nombre from dbo.Llamadas ll
join dbo.Usuarios u on ll.UsuarioID = u.UsuarioID
join dbo.Compañia ci on u.CialID = ci.CialID
join dbo.Usuarios_Planes up on ll.UsuarioID = up.UsuarioID
join dbo.Planes pl on up.PlanID = pl.PlanID
join dbo.Usuarios usu on ll.DestinoID = usu.UsuarioID
join dbo.Compañia cia on usu.CialID = cia.CialID
join dbo.Usuarios_Planes upl on ll.DestinoID = upl.UsuarioID
join dbo.Planes pla on upl.PlanID = pla.PlanID
where ll.LlamadaID = @id
end

exec ej333 8

/*
Ejercicio 4: Cree un stored procedure que reciba un ID de plan e informe el promedio de duración de las llamadas de los usuarios de plan seleccionado, agrupado por Compañía. 
*/
create procedure ej4(@id int)
as begin

select co.Nombre, up.PlanID, avg(cast(ll.Minutos as Float)) as Promedio  from dbo.Usuarios_Planes up 
join dbo.Usuarios u on up.UsuarioID = u.UsuarioID
join dbo.Compañia co on u.CialID = co.CialID 
join dbo.Llamadas ll on up.UsuarioID = ll.UsuarioID

--avg(ll.Minutos+lll.Minutos)
--join dbo.Llamadas lll on up.UsuarioID = ll.DestinoID
--join dbo.Usuarios usu on lll.DestinoID = usu.UsuarioID

where up.PlanID = 2
group by co.Nombre, up.PlanID


--Ejercicio 5: Cree un stored procedure que devuelva los nombres de los usuarios que hicieron 3 o más llamadas. 
create procedure ej5
as BEGIN
select u.Nombre, ll.UsuarioID from dbo.Usuarios u
join dbo.Llamadas ll on ll.UsuarioID = u.UsuarioID
group by u.nombre, ll.UsuarioID
having count(ll.LlamadaID) >= 2





