/*
Ejercicio 1: Cree el índice considere necesario para optimizar la siguiente consulta:
SELECT * FROM Llamadas WHERE UsuarioID = 3 AND DestinoID = 2. 
*/

CREATE INDEX ix_llamadas_usuarioid_destinoid
on llamadas(usuarioid, destinoid)

/*
Ejercicio 2: Cree una vista que muestre las llamadas, con las siguientes columnas: 
LlamadaID 
Nombre del Usuario 
Nombre del Destino 
Minutos 
*/

CREATE VIEW vLlamadas as
SELECT L.LlamadaID, U.Nombre Nombre_Usuario, U2.Nombre Nombre_Destino, L.Minutos 
FROM Llamadas L
JOIN Usuarios U
ON U.UsuarioID = L.UsuarioID
JOIN Usuarios U2
ON L.DestinoID = U2.UsuarioID

select *
from vLlamadas

/*
Ejercicio 3: Cree una vista que indique la cantidad de usuarios que pertenecen  
a una compañía y un plan, con las siguientes columnas: 
• Nombre de la compañía 
• Nombre del plan 
• Cantidad de usuarios
*/

CREATE VIEW vEjer3 AS

SELECT C.Nombre Nombre_Compania, P.Nombre Nombre_Plan, COUNT(1) Cantidad_De_Usuarios
FROM Usuarios U
JOIN Compañia C
ON U.CialID = C.CialID
JOIN Usuarios_Planes UP
ON U.UsuarioID = UP.UsuarioID
JOIN Planes P 
ON P.PlanID = UP.PlanID
GROUP BY C.Nombre, P.Nombre

SELECT *
FROM vEjer3

/*
Ejercicio 4: Cree un stored procedure que reciba como parámetro un PlanID y
devuelva un listado con los usuarios que tienen dicho plan, con las siguientes columnas: 
•	Nombre Usuario
•	Nombre Plan
•	Minutos
*/

CREATE PROCEDURE sp_Ejer4
@PlanID int

AS BEGIN

SELECT U.Nombre Nombre_Usuario, P.Nombre Nombre_Plan, L.Minutos
FROM Usuarios U
JOIN Llamadas L
ON L.UsuarioID = U.UsuarioID
JOIN Usuarios_Planes UP
ON U.UsuarioID = UP.UsuarioID
JOIN Planes P 
ON P.PlanID = UP.PlanID
WHERE @PlanID = U.UsuarioID

END

EXEC sp_Ejer4 1

/*
Ejercicio 5: Cree una vista que devuelva la lista de las
compañías (ID y nombre) que tengan 2 o más usuarios. 
*/

CREATE VIEW vEj5 AS

SELECT C.CialID, C.Nombre 
FROM Compañia C
JOIN Usuarios U
ON U.CialID = C.CialID
GROUP BY C.CialID, C.Nombre
HAVING COUNT(1) >= 2

SELECT *
FROM vEj5

/* 
Ejercicio 6: Cree una función que reciba UsuarioID y DestinoID, y devuelva la cantidad de llamados
que se hicieron desde ese usuario y hasta ese destino. 
*/

CREATE FUNCTION f_Ejer6
(@UsuarioID int,
@DestinoID int
)
RETURNS int
AS BEGIN
declare @Cantidad_Llamadas int

SELECT @Cantidad_Llamadas = count(1)
FROM Llamadas
WHERE @UsuarioID = UsuarioID and @DestinoID = UsuarioID
RETURN @Cantidad_Llamadas

END

SELECT dbo.f_Ejer6 (1,2)

/*
Ejercicio 7: Cree un Stored Procedure inserte una llamada. 
*/

CREATE PROCEDURE sp_Ejer7 
@UsuarioID INT,
@DestinoID INT,
@Minutos int
AS BEGIN
INSERT INTO Llamadas
VALUES(@UsuarioID, @DestinoID, @Minutos)
END

EXEC sp_Ejer7  1, 3, 100

SELECT *
FROM Llamadas

/*
Ejercicio 8: Cree un StoredProcedure que permita cambiar el plan de un usuario.  
*/

CREATE PROCEDURE sp_Ejer8
@PlanID INT,
@UsuarioID int

AS BEGIN

UPDATE Usuarios_Planes
SET PlanID = @PlanID
WHERE UsuarioID = @UsuarioID

END

EXEC sp_Ejer8 3, 1


SELECT *
FROM Usuarios_Planes

/*
Ejercicio 9
Cree una vista que devuelva la cantidad de llamadas realizadas
y los minutos totales para cada una de las compañías.
*/

CREATE VIEW vEj9 as
SELECT C.Nombre, Count(1) Cantidad_Llamadas, sum(l.Minutos) Minutos_Totales
FROM Usuarios U
JOIN Llamadas L
ON U.UsuarioID = L.UsuarioID
JOIN Compañia C
ON C.CialID = U.CialID
GROUP BY C.Nombre

SELECT *
FROM vEj9

/*
Ejercicio 10
Cree un usuario denominado “parcial2” y asígnele permisos de ejecución
sobre los stored procedures creados en los ejercicios anteriores. 
*/

CREATE LOGIN parcial12 with password = 'abcd1234'
CREATE USER parcial12 for login parcial12

GRANT EXECUTE ON Usuarios_Planes TO parcial12
GRANT EXECUTE ON Llamadas TO parcial12










