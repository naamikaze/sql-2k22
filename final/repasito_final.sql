CREATE DATABASE repasito
use repasito


CREATE TABLE Sector(
	SectorID int IDENTITY(1,1) PRIMARY KEY,
	Nombre nvarchar(50) not null
)

CREATE TABLE Acciones(
	AccionID int IDENTITY(1,1) PRIMARY KEY,
	Nombre nvarchar(50) not null,
	SectorID int FOREIGN KEY REFERENCES Sector(SectorID) not null
)

CREATE TABLE Usuarios(
	UsuarioID int IDENTITY(1,1) PRIMARY KEY,
	Nombre nvarchar(50) not null
)

CREATE TABLE Inversiones(
	InversionID int IDENTITY(1,1) PRIMARY KEY,
	UsuarioID int FOREIGN KEY REFERENCES Usuarios(UsuarioID) not null,
	AccionID int FOREIGN KEY REFERENCES Acciones(AccionID) not null,
	Fecha date not null,
	Operacion nvarchar(50) not null,
	Cantidad int not null,
	PrecioUnitario int not null
	
)

--inserts a sector
INSERT INTO Sector
VALUES ('Tecnologia')
INSERT INTO Sector
VALUES ('Software')
INSERT INTO Sector
VALUES ('Comercio Electronico')

-- inserts a acciones
INSERT INTO Acciones
VALUES('Apple', 1)
INSERT INTO Acciones
VALUES('Microsoft', 2)
INSERT INTO Acciones
VALUES('Google', 2)
INSERT INTO Acciones
VALUES('Amazon', 3)
INSERT INTO Acciones
VALUES('Mercadolibre', 3)

--inserts a usuarios
INSERT INTO Usuarios
VALUES('Nombre_1')
INSERT INTO Usuarios
VALUES('Nombre_2')
INSERT INTO Usuarios
VALUES('Nombre_3')
INSERT INTO Usuarios
VALUES('Nombre_4')
INSERT INTO Usuarios
VALUES('Nombre_5')

--inserts a inversiones
INSERT INTO Inversiones
VALUES(1, 3, '2022-01-02', 'Compra', 5, 450)
INSERT INTO Inversiones
VALUES(3, 5, '2022-01-06', 'Compra', 3, 250)
INSERT INTO Inversiones
VALUES(2, 1, '2022-01-06', 'Compra', 4, 300)
INSERT INTO Inversiones
VALUES(1, 3, '2022-01-07', 'Compra', 2, 440)
INSERT INTO Inversiones
VALUES(5, 1, '2022-01-08', 'Compra', 1, 320)
INSERT INTO Inversiones
VALUES(2, 1, '2022-01-08', 'Venta', -2, 325)
INSERT INTO Inversiones
VALUES(5, 2, '2022-01-09', 'Compra', 2, 150)
INSERT INTO Inversiones
VALUES(3, 5, '2022-01-10', 'Venta', -3, 260)
INSERT INTO Inversiones
VALUES(4, 4, '2022-01-14', 'Compra', 2, 70)
INSERT INTO Inversiones
VALUES(1, 3, '2022-01-14', 'Venta', -7, 460)
INSERT INTO Inversiones
VALUES(1, 1, '2022-01-14', 'Compra', 5, 330)
INSERT INTO Inversiones
VALUES(2, 1, '2022-01-16', 'Venta', -2, 250)
INSERT INTO Inversiones
VALUES(4, 4, '2022-01-16', 'Venta', -2, 65)
INSERT INTO Inversiones
VALUES(5, 2, '2022-01-18', 'Venta', -1, 160)
INSERT INTO Inversiones
VALUES(1, 1, '2022-01-20', 'Venta', -3, 300)


--ej 3
CREATE INDEX idx_sector_acciones
ON Acciones(SectorID)

-- ej 4
CREATE INDEX idx_inversiones
ON Inversiones(UsuarioID, AccionID, Fecha)

--ej 5
CREATE VIEW repasito_repasito_ej5 AS
SELECT u.UsuarioID, u.Nombre Usuario, a.AccionID, a.Nombre Accion, AVG(i.PrecioUnitario) PrecioUnitarioPromedio FROM Usuarios u
JOIN Inversiones i
ON u.UsuarioID = i.UsuarioID
JOIN Acciones a
ON i.AccionID = a.AccionID
GROUP BY u.UsuarioID, u.Nombre, a.AccionID, a.Nombre


--ej 6
CREATE VIEW repasito_repasito_ej6 AS
SELECT s.Nombre, COUNT(i.Cantidad) AccionesPorSector FROM Acciones a
JOIN Inversiones i
ON a.AccionID = i.AccionID
JOIN Sector s
ON a.SectorID = s.SectorID
GROUP BY s.Nombre

-- ej 7
CREATE PROCEDURE repasito_repasito_ej7
@IDUsuario int
AS BEGIN
SELECT u.Nombre Usuario, a.Nombre Accion, SUM(i.Cantidad) CantidadPoseida FROM Usuarios u
JOIN Inversiones i
ON u.UsuarioID = i.UsuarioID
JOIN Acciones a
ON i.AccionID = a.AccionID
WHERE U.UsuarioID = @IDUsuario
GROUP BY u.Nombre, a.Nombre
END

-- ej 8
CREATE PROCEDURE repasito_repasito_ej8
@IDSector int
AS BEGIN
SELECT a.Nombre, COUNT(i.UsuarioID) CantidadUsuarios FROM Acciones a
JOIN Inversiones i
ON a.AccionID = i.AccionID
GROUP BY a.Nombre
END

--ej 9
CREATE PROCEDURE repasito_repasito_ej9
@UsuarioID int,
@AccionID int,
@Operacion nvarchar(50),
@Cantidad int,
@PrecioUnitario int
AS BEGIN
INSERT INTO Inversiones
VALUES(@UsuarioID, @AccionID, GETDATE(), @Operacion, @Cantidad, @PrecioUnitario)
END

--ej 10
CREATE PROCEDURE repasito_repasito_ej10
@Promedio int
AS BEGIN
SELECT a.Nombre FROM Acciones a
JOIN Inversiones i
ON a.AccionID = i.AccionID
GROUP BY a.Nombre
HAVING AVG(i.PrecioUnitario) > @Promedio
END
