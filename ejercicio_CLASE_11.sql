CREATE DATABASE Telefonia

use Telefonia


CREATE TABLE Compañia (
CialID int IDENTITY(1,1)PRIMARY KEY not null,
Nombre nvarchar(50)
)

CREATE TABLE Usuarios(
UsuarioID int IDENTITY (1,1) PRIMARY KEY,
Nombre varchar(50),
CialID int FOREIGN KEY REFERENCES Compañia(CialID)
)

CREATE TABLE Llamadas (
LlamadaID int IDENTITY(1,1) PRIMARY KEY,
UsuarioID int FOREIGN KEY (UsuarioID) references Usuarios(UsuarioID) not null,
DestinoID int not null,
Minutos int not null
)


CREATE TABLE Planes (
PlanID int IDENTITY (1,1) PRIMARY KEY,
Nombre nvarchar(50),
Minutos int
)


CREATE TABLE Usuarios_Planes (
UsuarioID int PRIMARY KEY not null,
PlanID int FOREIGN KEY REFERENCES Planes(PlanID),
FOREIGN KEY(UsuarioID) references Usuarios(UsuarioID)
)

INSERT INTO Compañia(Nombre) VALUES ('Personal')
INSERT INTO Compañia(Nombre) VALUES ('Movistar')
INSERT INTO Compañia(Nombre) VALUES ('Claro')


INSERT INTO Usuarios(Nombre,CialID) Values('Raúl',1) 
INSERT INTO Usuarios(Nombre,CialID) Values('Marta',3) 
INSERT INTO Usuarios(Nombre,CialID) Values('Carla',2) 
INSERT INTO Usuarios(Nombre,CialID) Values('Justin',2) 
INSERT INTO Usuarios(Nombre,CialID) Values('Marcos',1) 


INSERT INTO Llamadas (UsuarioID,DestinoID,Minutos) VALUES (1,5,20)
INSERT INTO Llamadas (UsuarioID,DestinoID,Minutos) VALUES (4,2,15)
INSERT INTO Llamadas (UsuarioID,DestinoID,Minutos) VALUES (3,4,40)
INSERT INTO Llamadas (UsuarioID,DestinoID,Minutos) VALUES (1,3,30)
INSERT INTO Llamadas (UsuarioID,DestinoID,Minutos) VALUES (2,5,10)
INSERT INTO Llamadas (UsuarioID,DestinoID,Minutos) VALUES (3,1,15)
INSERT INTO Llamadas (UsuarioID,DestinoID,Minutos) VALUES (5,1,10)
INSERT INTO Llamadas (UsuarioID,DestinoID,Minutos) VALUES (5,2,15)
INSERT INTO Llamadas (UsuarioID,DestinoID,Minutos) VALUES (3,2,20)
INSERT INTO Llamadas (UsuarioID,DestinoID,Minutos) VALUES (2,4,5)


INSERT INTO Planes (Nombre,Minutos) VALUES ('Light',50)
INSERT INTO Planes (Nombre,Minutos) VALUES ('Full',100)
INSERT INTO Planes (Nombre,Minutos) VALUES ('Premium',200)


INSERT INTO Usuarios_Planes (UsuarioID,PlanID) VALUES (1,2)
INSERT INTO Usuarios_Planes (UsuarioID,PlanID) VALUES (2,1)
INSERT INTO Usuarios_Planes (UsuarioID,PlanID) VALUES (3,3)
INSERT INTO Usuarios_Planes (UsuarioID,PlanID) VALUES (4,1)
INSERT INTO Usuarios_Planes (UsuarioID,PlanID) VALUES (5,2)

ALTER TABLE Llamadas
ADD FOREIGN KEY (DestinoID) REFERENCES Usuarios(UsuarioID)




--Ejercicio 1
USE Telefonia
CREATE INDEX idx_llamadas ON Llamadas(UsuarioID,DestinoID);

-- Ejercicio 2
CREATE VIEW vLlamadas AS
SELECT LlamadaID,u.Nombre as 'Usuario',u2.Nombre as 'Destino',Minutos from Llamadas l
JOIN Usuarios u ON l.UsuarioID=u.UsuarioID
JOIN Usuarios u2 ON l.DestinoID=u2.UsuarioID

-- Ejercicio 3

CREATE VIEW vCantidadUsuarios AS
SELECT C.Nombre,p.Nombre as 'Nombre plan',COUNT(u.UsuarioID) 'cantidad de usuarios' 
FROM Usuarios u
JOIN Compañia c
ON u.CialID = C.CialID
JOIN Usuarios_Planes up
ON u.UsuarioID = up.UsuarioID
JOIN Planes p
ON p.PlanID = up.PlanID
GROUP BY c.Nombre,p.Nombre

-- Ejercicio 4
CREATE PROCEDURE plan_Usuario @PlanID int AS
select u.Nombre,p.Nombre,p.Minutos from Usuarios as u
join Usuarios_Planes as up
on u.UsuarioID=up.UsuarioID
join Planes as p
on p.PlanID=up.PlanID
WHERE p.PlanID = @PlanID

EXEC plan_Usuario 1

-- Ejercicio 5

CREATE VIEW vListaCompañias AS
SELECT DISTINCT c.CialID,c.Nombre FROM Compañia AS c
JOIN Usuarios AS u
ON c.CialID = u.CialID
WHERE c.CialID  in (SELECT c.CialID FROM Compañia c
JOIN Usuarios u ON c.CialID=u.CialID 
JOIN Usuarios_Planes up ON up.UsuarioID=u.UsuarioID
Group by c.CialID
HAVING COUNT(u.CialID) >= 2)

select * from vListaCompañias
--Ejercicio 6

CREATE FUNCTION f_cantidadLLamados(
@UsuarioID int,
@DestinoID int )
returns int
AS begin
declare @cantidad int
SELECT @cantidad = count(LlamadaID) from Llamadas
WHERE UsuarioID = @UsuarioID and DestinoID=@DestinoID

return @cantidad

end

SELECT dbo.f_cantidadLLamados(1,5)

-- Ejercicio 7

CREATE PROCEDURE insertar_llamada @usuario int,@destino int, @minutos int AS
INSERT INTO Llamadas (UsuarioID,DestinoID,Minutos)
VALUES (@usuario,@destino,@minutos)

exec insertar_llamada 4,1,60

select * from Llamadas

-- Ejercicio 8
CREATE PROCEDURE cambiarPlanUser (@UsuarioID int, @planID int)
AS 
begin
UPDATE Usuarios_Planes 
SET PlanID=@planID
WHERE UsuarioID=@UsuarioID
end
EXEC cambiarPlanUser 1,3

select * from Usuarios_Planes

-- Ejercicio 9
CREATE VIEW cantidad_compañias AS
SELECT c.Nombre,COUNT(l.LlamadaID) as 'Cantidad de llamadas', SUM(l.Minutos) as 'Cantidad de Minutos'FROM Compañia AS c
JOIN Usuarios as u ON c.CialID = u.CialID
JOIN Usuarios_Planes up ON up.UsuarioID=u.UsuarioID
JOIN Llamadas l ON up.UsuarioID = l.UsuarioID
GROUP BY c.Nombre

select * from cantidad_compañias

-- Ejercicio 10

CREATE LOGIN usuarioTelefonia with password ='123';

CREATE USER parcial2 for login usuarioTelefonia;

GRANT EXECUTE ON dbo.cambiarPlanUser
to parcial2
GO

GRANT EXECUTE ON  dbo.insertar_llamada to parcial2
GO

GRANT EXECUTE ON  dbo.plan_Usuario to parcial2
GO