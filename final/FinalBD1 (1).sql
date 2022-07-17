CREATE DATABASE FinalDB;

-- Ejercicio 1
CREATE TABLE Clientes (
    ClienteID int NOT NULL IDENTITY(1, 1) PRIMARY KEY,
    Nombre nvarchar(250) NOT NULL
)

CREATE TABLE Proyectos (
    ProyectoID int NOT NULL IDENTITY(1, 1) PRIMARY KEY,
    Nombre nvarchar(250) NOT NULL,
    ClienteID int NOT NULL FOREIGN KEY REFERENCES Clientes(ClienteID)
)

CREATE TABLE Roles (
    RolID int NOT NULL IDENTITY(1, 1) PRIMARY KEY,
    Nombre nvarchar(250) NOT NULL
)

CREATE TABLE Empleados (
    EmpleadoID int NOT NULL IDENTITY(1, 1) PRIMARY KEY,
    Nombre nvarchar(250) NOT NULL,
    RolID int NOT NULL FOREIGN KEY REFERENCES Roles(RolID)
)

CREATE TABLE Asignaciones (
    ProyectoID int NOT NULL FOREIGN KEY REFERENCES Proyectos(ProyectoID),
    EmpleadoID int NOT NULL FOREIGN KEY REFERENCES Empleados(EmpleadoID),
    CONSTRAINT Pk_Asignaciones PRIMARY KEY (ProyectoID, EmpleadoID)
)

-- Ejercicio 2
INSERT INTO Clientes (Nombre)
VALUES ('Cliente 1'), ('Cliente 2')

INSERT INTO Roles (Nombre)
VALUES ('Java Developer'), ('Web Developer'), ('Mobile Developer')

INSERT INTO Proyectos (Nombre, ClienteID)
VALUES ('Proyecto 1', 1), ('Proyecto 2', 1), ('Proyecto 3', 2)

INSERT INTO Empleados (Nombre, RolID)
VALUES ('Empleado 1', 1),
       ('Empleado 2', 2),
       ('Empleado 3', 3),
       ('Empleado 4', 1),
       ('Empleado 5', 1),
       ('Empleado 6', 3),
       ('Empleado 7', 2),
       ('Empleado 8', 1),
       ('Empleado 9', 1),
       ('Empleado 10', 3)

INSERT INTO Asignaciones (ProyectoID, EmpleadoID)
VALUES (1, 1),
       (1, 2),
       (3, 3),
       (2, 4),
       (2, 5),
       (3, 6),
       (1, 7),
       (1, 8),
       (3, 9),
       (2, 10)

-- Ejercicio 3
GO
CREATE VIEW v_Empleado AS
    SELECT C.Nombre Nombre_del_Cliente, P.Nombre Nombre_del_Proyecto, E.Nombre Nombre_del_Empleado, R.Nombre Nombre_del_Rol FROM Clientes AS C
    JOIN Proyectos AS P
    ON C.ClienteID = P.ClienteID
    JOIN Asignaciones AS A
    ON A.ProyectoID = P.ProyectoID
    JOIN Empleados AS E
    ON E.EmpleadoID = A.EmpleadoID
    JOIN Roles AS R
    ON R.RolID = E.RolID 
GO

SELECT * FROM v_Empleado

-- Ejercicio 4
GO
CREATE VIEW v_EmpleadosPorCliente AS
    SELECT C.Nombre, COUNT(1) Cantidad_Empleados FROM Clientes AS C
    JOIN Proyectos AS P
    ON C.ClienteID = P.ClienteID
    JOIN Asignaciones AS A
    ON P.ProyectoID = A.ProyectoID
    JOIN Empleados AS E
    ON A.EmpleadoID = E.EmpleadoID
    GROUP BY C.Nombre
GO

SELECT * FROM v_EmpleadosPorCliente

-- Ejercicio 5
GO 
CREATE PROCEDURE empleadosPorProyecto(@projectId int)
AS BEGIN
SELECT R.Nombre, COUNT(1) Cantidad_Empleados FROM Asignaciones AS A
JOIN Proyectos AS P
ON A.ProyectoID = P.ProyectoID
JOIN Empleados AS E
ON A.EmpleadoID = E.EmpleadoID
JOIN Roles AS R
ON E.RolID = R.RolID
WHERE P.ProyectoID = @projectId
GROUP BY R.Nombre
END
GO

EXEC empleadosPorProyecto 3

-- Ejercicio 6
GO 
CREATE PROCEDURE empleadoCliente (@employeeId int)
AS BEGIN
    SELECT E.Nombre, P.Nombre, C.Nombre FROM Empleados AS E
    JOIN Asignaciones AS A
    ON A.EmpleadoID = E.EmpleadoID
    JOIN Proyectos AS P
    ON A.ProyectoID = P.ProyectoID
    JOIN Clientes AS C
    ON P.ClienteID = C.ClienteID
    WHERE E.EmpleadoID = @employeeId
END
GO

EXEC empleadoCliente 4

-- Ejercicio 7
GO
CREATE VIEW v_EmpleadosRol AS
    SELECT R.Nombre, COUNT(1) Cantidad_Empleados FROM Roles AS R
    JOIN Empleados AS E
    ON R.RolID = E.RolID
    GROUP BY R.Nombre
    HAVING COUNT(1) > 2
GO    

-- Ejercicio 8
CREATE LOGIN "usrAuditorLogin" WITH PASSWORD = 'Isabel1234'
CREATE USER "usrAuditor" FOR LOGIN "usrAuditorLogin"
CREATE LOGIN "usrStoredProcLogin" WITH PASSWORD = 'Isabel1234'
CREATE USER "usrStoredProc" FOR LOGIN "usrStoredProcLogin"


GRANT SELECT ON v_EmpleadosPorCliente TO "usrAuditor"

GRANT EXEC ON empleadosPorProyecto TO "usrStoredProc"
GRANT EXEC ON empleadoCliente TO "usrStoredProc"

-- Ejercicio 9
CREATE INDEX idx_rolId_empleados ON Empleados(RolID)

-- Ejercicio 10

GO
CREATE FUNCTION empleadosPorRolCliente (@rolId int, @clientId int)
RETURNS int
AS BEGIN
    DECLARE @qtyEmployee int
    SELECT @qtyEmployee = COUNT(1) FROM Empleados AS E
    JOIN Asignaciones AS A
    ON A.EmpleadoID = E.EmpleadoID
    JOIN Roles AS R
    ON R.RolID = E.RolID
    JOIN Proyectos AS P
    ON A.ProyectoID = P.ProyectoID
    JOIN Clientes AS C
    ON P.ClienteID = C.ClienteID
    WHERE P.ClienteID = @clientId AND R.RolID = @rolId
    GROUP BY R.Nombre, C.Nombre
RETURN @qtyEmployee
END
GO

SELECT dbo.empleadosPorRolCliente(1, 1) Cantidad_Empleados

 