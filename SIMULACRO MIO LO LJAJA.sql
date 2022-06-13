--EJERCICIO 1
create index indicelol on Production.Product(color)

--EJERCICIO 2
create index indice2 on Production.productsubcategory(productcategoryid)

--EJERCICIO 3

/*
Crear una vista que contenga los siguientes campos:
- ProductId, Name, Color de la tabla Products
- Name de la tabla ProductSubCategory denominar a esta columna SubCategoryName
- Name de la tabla ProductCategory denomincar a esta columna CategoryName
*/
create view ejer3 as 
select ProductID, p.Name, Color, psc.Name as SubCategoryName, pc.Name as CategoryName  from production.Product p
join Production.ProductSubcategory psc 
on p.ProductSubcategoryID = psc.ProductSubcategoryID
join Production.ProductCategory pc 
on psc.ProductCategoryID = pc.ProductCategoryID

select * from ejer4

-- EJERCICIO 4
/*
Cree una vista que contenga los siguientes campos:
- ProductId, Name de la tabla Products
- ThumbnailPhotoFileName, LargePhotoFileName de la tabla ProductPhoto
- Mostrar solo las fotos que el campo Primary de la tabla ProductProductPhoto es igual a 1
*/
create view ejer4 as 
select pp.ProductID, pp.Name, ph.ThumbnailPhotoFileName, ph.LargePhotoFileName
from Production.Product pp
join Production.ProductProductPhoto pph
on pp.ProductID = pph.ProductID
join production.ProductPhoto ph 
on pph.ProductPhotoID = ph.ProductPhotoID
where pph.[Primary] = 1

-- EJERCICIO 5
/* Cree un usuario denominado “bd1” y asígnele permisos de lectura, inserción y actualización a la tabla Products y solo permisos de lectura a las tablas ProductCategory y ProductSubCategory. */

CREATE LOGIN bd2 WITH PASSWORD = '123abc'
CREATE USER bd2 FOR LOGIN bd2 
GRANT SELECT ON Production.ProductCategory TO bd2
GRANT SELECT ON Production.ProductSubCategory TO bd2

--EJERCICIO 6
-- Cree la función ObtenerMayor que reciba dos números y devuelva el mayor de los dos.
CREATE FUNCTION Obtenermayor (@n1 int, @n2 int) returns int as begin declare @mayor int 

if @n1 > @n2 
        set @mayor = @n1
    else
        set @mayor = @n2 
return @mayor
end

select dbo.Obtenermayor (8,3) Resultado

-- EJERCICIO 7
/* 
Cree un StoredProcedure que devuelva los nombres de las Subcategorias (ProductSubCategory.Name)
que pertenezcan a categorías que tengan más de 5 subcategorías.
*/
create procedure ej7
as begin 

select Name, ProductCategoryID from production.ProductSubCategory 
where ProductCategoryID in (
    select ProductCategoryID from production.ProductSubcategory
    group by ProductCategoryID
    having count(1) > 7
)
END 

--EJERCICIO 8 
/* 
Cree un StoredProcedure que devuelva Id de Producto, Nombre, SafetyStockLevel y Stock (sumar la
cantidad de ProductInventory para el producto), pero muestre solamente aquellos productos que el
Stock está por debajo del SafetyStockLevel.
*/

create procedure ej8 
as BEGIN

select pp.ProductID, pp.Name, pp.SafetyStockLevel, sum(pr.ProductID) from Production.Product pp
join production.ProductInventory pr on pp.ProductID = pr.ProductID
group by pp.ProductID, pp.Name, pp.SafetyStockLevel
having sum(pr.ProductID) < pp.SafetyStockLevel

END
exec dbo.ej8

/*
Ejercicio 9
Cree un StoredProcedure que inserte un ProductInventory
*/
create procedure ej9(
    @productid int,
    @locationid smallint,
    @shelf nvarchar(10),
    @bin tinyint,
    @qty smallint
)
as BEGIN 
insert into Production.ProductInventory values(@productId, @locationId, @shelf, @bin, @qty, NEWID(), GETDATE())
END

exec dbo.ej9 2, 3, 'A',1, 50 

select * from production.ProductInventory pin where pin.ProductID = 2 and pin.Quantity = 50

/*
Ejercicio 10
Cree un StoredProcedure que reciba el ID de Producto y un importe (ListPrice).
a- En base al ID de producto deberá recuperar el ListPrice actual
b- Actualizar el ListPrice al nuevo ListPrice
c- Buscar y actualizar en la tabla ProductListPriceHistory, para el producto actual, el registro cuyo
EndDate es Null, guardando en ese campo la fecha actual (función GetDate())
d- Insertar un nuevo registro en la tabla ProductListPriceHistory con el ListPrice nuevo con Fecha
de inicio para la fecha actual y de fin en null.
*/

create procedure loiol(@id int, @importe money )
as BEGIN
UPDATE Production.Product set ListPrice = @importe where ProductID = @id
UPDATE Production.ProductListPriceHistory set EndDate = GETDATE() WHERE ProductID = @id and EndDate is null

insert into Production.ProductListPriceHistory values(@id, GETDATE(), null, @importe, GETDATE())

select pp.ProductID, pp.ListPrice from production.product pp 
join production.ProductListPriceHistory pl on pp.productid = pl.productid
where pp.ProductID = @id

END

exec dbo.loiol 777, 3480
select * from Production.ProductListPriceHistory where ProductID = 777

