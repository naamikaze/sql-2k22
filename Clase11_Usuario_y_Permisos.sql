/*
use AdventureWorks2019
go 
*/

--Crear un usuario de windows
/*
create login uade\adominguez from windows
*/

--Crea un usuario
/*
create login bd2022 with password = 'abc123' must_change;
*/

--Cambiar contrasenia 
/*
alter login bd2022 with password = 'abc124'
*/

--Borra el usuario
/*
drop login bd2022
*/

--Crear usuario de base de datos
/*
create user dbusr2002 for login bd2022;
*/

--Borra el usuario
/*
drop user bd2022
*/

--Asignar permisos
/*
grant select, update, insert, delete on person.person to dbusr2002,

--Permisos
Select
Execute
Delete
Insert
Update
*/

--Sacar Permisos
/*
revoke select on person.person to dbusr2002;
*/

--Asignar permisos a una vista
/*
grant select on [HumanResources].[Employee] to dbusr2002,
*/

--Asignar perimisos al store procedure
/*
grant execute on[dbo].production_productCategory_GetAll] to dbusr2002
*/

--Asignar permisos a todo el esquema definido (Tablas, Vistas, Store Procedure)
/*
GRANT select ON SCHEMA :: HumanResources TO dbusr2002
*/

--Crear Roles
/*
Create Role hr;
*/

--Asigna Roles
/*
Exec sp_addrolemember 'hr', 'dbusr2002'
*/

--Asigna los permisos de todo el esquema a los roles seleccionado
/*
grant select on schema :: Person TO hr
*/

