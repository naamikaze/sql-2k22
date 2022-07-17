--CREO LA BD
CREATE DATABASE FINALPRACTICA;

/*
Ejercicio 1: Cree los scripts de creación de las tablas, considere en todas las tablas la primera
columna como Primary Key, con excepción de Inversiones que tiene una Primary Key doble:
UsuarioID y AccionId
*/

CREATE TABLE usuarios(
usuarioid int not null identity (1,1) primary key,
nombre nvarchar(250) not null
)

CREATE TABLE sector(
sectorid int NOT NULL IDENTITY (1,1) PRIMARY KEY,
nombre nvarchar(250) NOT NULL,
)

CREATE TABLE acciones(
accionid int NOT NULL IDENTITY(1,1) PRIMARY KEY,
nombre nvarchar(250) NOT NULL,
sectorid int NOT NULL FOREIGN KEY REFERENCES sector(sectorid)
)

CREATE TABLE inversiones(
inversionid int identity (1,1) primary key,
usuarioid int not null foreign key references usuarios(usuarioid),
accionid int not null foreign key references acciones(accionid),
fecha date not null,
operacion nvarchar(250) not null,
cantidad int not null, 
pciounit float not null
)

drop table inversiones

--Ejercicio 2: Cree lo scripts para insertar los registros de las tablas que muestra el ejemplo.

--USUARIOS
insert into usuarios(nombre)
values('Nombre_1'), ('Nombre_2'), ('Nombre_3'), ('Nombre_4'), ('Nombre_5')

--SECTORES
insert into sector(nombre) values('Tecnologia'), ('Software'), ('Comercio Electronico')

--ACCIONES
insert into acciones(nombre, sectorid) values
('Apple', 1), ('Microsoft', 2), ('Google', 2), ('Amazon', 3), ('Mercado Libre', 3)

--INVERSIONES
insert into inversiones(usuarioid, accionid, fecha, operacion,cantidad, pciounit)
values
(1, 3, DATEFROMPARTS(2002,1,2), 'Compra', 5, 450),
(3, 5, DATEFROMPARTS(2022,1,6), 'Compra', 3, 250),
(2, 1, DATEFROMPARTS(2022,1,6), 'Compra', 4, 300),
(1, 3, DATEFROMPARTS(2022,1,7), 'Compra', 2, 440),
(5, 1, DATEFROMPARTS(2022,1,8), 'Compra', 1, 320),
(2, 1, DATEFROMPARTS(2022,1,8), 'Venta', -2, 325),
(5, 2, DATEFROMPARTS(2022,1,9), 'Compra', 2, 150),
(3, 5, DATEFROMPARTS(2022,1,10), 'Venta', -3, 260),
(4, 4, DATEFROMPARTS(2022,1,14), 'Compra', 2, 70),
(1, 3, DATEFROMPARTS(2022,1,14), 'Venta', -7, 460),
(1, 1, DATEFROMPARTS(2022,1,14), 'Compra', 5, 330),
(2, 1, DATEFROMPARTS(2022,1,16), 'Venta', -2, 250),
(4, 4, DATEFROMPARTS(2022,1,16), 'Venta', -2, 65),
(5, 2, DATEFROMPARTS(2022,1,18), 'Venta', -1, 160),
(1, 1, DATEFROMPARTS(2022,1,20), 'Venta', -3, 300)

drop table inversiones
select * from inversiones

--Ejercicio 3: Cree un índice sobre la columna SectorId de la tabla Acciones.
create index eje3 on acciones(sectorid)

/*
Ejercicio 4: Cree un índice sobre las columnas UsuarioID, AccionId y Fecha de la tabla
Inversiones.
*/
create index eje4 on inversiones(usuarioid, accionid, fecha)

/*
Ejercicio 5: Cree una vista que informe UsuarioID, Nombre, AccionId, Nombre de la Acción,
Cantidad Comprada (sin tener en cuenta las ventas) y precio Unitario promedio.
*/
go
create view eje5 as
select us.usuarioid, us.nombre as usuarionombre, inv.accionid, acc.nombre as accionnombre, inv.cantidad, avg(inv.pciounit) as Promedio from inversiones inv
join usuarios us on inv.usuarioid = us.usuarioid
join acciones acc on inv.accionid = acc.accionid
group by us.usuarioid, us.nombre, inv.accionid, acc.nombre, inv.cantidad
go

select * from eje5

/*
Ejercicio 6: Cree una vista que muestre la cantidad de acciones por sector
*/
go
create view eje6 as
select sec.nombre as Sector, count(1) as CantAcciones from acciones acc 
join sector sec on acc.sectorid = sec.sectorid
group by sec.nombre
go


select * from eje6

/*
Ejercicio 7: Cree un Stored Procedure que reciba un ID de usuario y devuelva Nombre del
Usuario, Nombre de la Acción, Cantidad que posee (compras menos ventas).
*/
go
create procedure eje7(@id int)
as begin
select usu.nombre nombreUsuario, acc.nombre nombreAccion, sum(inv.cantidad) cantidadTengo from usuarios usu
join inversiones inv on usu.usuarioid = inv.usuarioid
join acciones acc on inv.accionid = acc.accionid
where usu.usuarioid = @id
group by usu.nombre, acc.nombre
end

drop procedure eje7
exec eje7 1

/*
Ejercicio 8: Cree un stored procedure que reciba un ID de sector y devuelva los nombres de
las acciones del sector y la cantidad de usuarios que compraron dicha acción.
*/
create procedure eje8(@id int) as begin
select ac.nombre nombreAccion, count(inv.usuarioid) from sector se
join acciones ac on se.sectorid = ac.sectorid
join inversiones inv on ac.accionid = inv.accionid
where se.sectorid = @id
group by ac.nombre
end

exec eje8 2

/*
Ejercicio 9: Cree un stored procedure que inserte un registro en la tabla de Inversiones
*/

create procedure eje9(@usuarioid int, @accionid int, @fecha date,
@operacion varchar(250), @cantidad int, @pciounitario float) as begin
insert into inversiones(usuarioid, accionid, fecha, operacion,cantidad, pciounit)
values (@usuarioid, @accionid, @fecha, @operacion, @cantidad, @pciounitario)
end

exec eje9 2, 1, '2002/01/01', 'Venta', 4, 220

select * from inversiones

/*
Ejercicio 10: Cree un stored procedure que devuelva los nombres de las acciones cuyo precio
promedio de compra sea mayor a un valor recibido como parámetro.
*/
create procedure eje10(@pcio float) as begin
select ac.nombre nombreAccion from inversiones inv 
join acciones ac on inv.accionid = ac.accionid
group by ac.nombre
having avg(inv.pciounit) > @pcio
end

exec eje10 250


