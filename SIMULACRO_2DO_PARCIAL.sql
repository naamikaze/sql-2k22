USE 
AdventureWorks2019
GO
--Simulacro 

/*
Ejercicio 1  
Cree un índice para la columna Color de la tabla Product
*/
create index ix_product_color
on production.product (color)

/*
Ejercicio 2
Cree un índice para la columna ProductCategoryId de la tabla ProductSubCategory
*/

create index ix_productsubcategory_productcategoryid
on production.ProductSubCategory(productcategoryid)

/*
Ejercicio 3
Crear una vista que contenga los siguientes campos:
- ProductId, Name, Color de la tabla Products
- Name de la tabla ProductSubCategory denominar a esta columna SubCategoryName
- Name de la tabla ProductCategory denomincar a esta columna CategoryName
*/ 

CREATE VIEW vEj3 as
SELECT P.ProductID, P.NAME, P.Color, PS.Name SubCategoryName, PC.Name CategoryName
FROM Production.Product P
JOIN Production.ProductSubcategory PS
ON P.ProductSubcategoryID = PS.ProductSubcategoryID
JOIN Production.ProductCategory PC
ON PS.ProductCategoryID = PC.ProductCategoryID


/* 
Ejercicio 4
Cree una vista que contenga los siguientes campos:
- ProductId, Name de la tabla Products
- ThumbnailPhotoFileName, LargePhotoFileName de la tabla ProductPhoto
- Mostrar solo las fotos que el campo Primary de la tabla ProductProductPhoto es igual a 1
*/

CREATE VIEW vEj4 as
SELECT P.ProductID, P.Name, PP.ThumbnailPhotoFileName, PP.LargePhotoFileName
FROM Production.Product P
JOIN Production.ProductProductPhoto PPP
ON P.ProductID = PPP.ProductID
JOIN Production.ProductPhoto PP
ON PP.ProductPhotoID = PPP.ProductPhotoID
WHERE PPP.[Primary] = 1



/*
Ejercicio 5
Cree un usuario denominado “bd1” y asígnele permisos de lectura, inserción y actualización a la tabla 
Products y solo permisos de lectura a las tablas ProductCategory y ProductSubCategory.*/

CREATE LOGIN bd2 WITH PASSWORD = 'abc1234'
CREATE USER bd2 FOR LOGIN bd2
GRANT SELECT ON Production.ProductCategory TO bd2
GRANT SELECT ON Production.ProductSubCategory TO bd2

/*
Ejercicio 6
Cree la función ObtenerMayor que reciba dos números y devuelva el mayor de los dos
*/

CREATE FUNCTION Obtener_Mayor
(@n1 int,
 @n2 int
) 

RETURNS INT
AS BEGIN
DECLARE @mayor int

if @n1 > @n2
	set @mayor = @n1
	
else 
	set @mayor = @n2

RETURN @Mayor
END

SELECT dbo.Obtener_Mayor (2, 3) Resultado



/*
Ejercicio 7
Cree un StoredProcedure que devuelva los nombres de las Subcategorias (ProductSubCategory.Name) 
que pertenezcan a categorías que tengan más de 5 subcategorías.
*/


CREATE PROCEDURE Name_SubCategorias
AS BEGIN 

SELECT Name, ProductCategoryID
FROM Production.ProductSubcategory
WHERE ProductCategoryID IN(
SELECT ProductCategoryID --COUNT(1)
FROM Production.ProductSubcategory 
GROUP BY ProductCategoryID
HAVING COUNT(1) > 7
)
END

EXEC Name_SubCategorias


/*
Ejercicio 8
Cree un StoredProcedure que devuelva Id de Producto, Nombre, SafetyStockLevel y Stock (sumar la 
cantidad de ProductInventory para el producto), pero muestre solamente aquellos productos que el 
Stock está por debajo del SafetyStockLevel.
*/

CREATE PROCEDURE ej8
AS BEGIN

SELECT P.ProductID, P.Name, P.SafetyStockLevel, PPI.Quantity
FROM Production.Product P 
JOIN Production.ProductInventory PPI
ON P.ProductID = PPI.ProductID
GROUP BY P.ProductID, P.Name, P.SafetyStockLevel, PPI.Quantity
HAVING SUM(PPI.Quantity) < P.SafetyStockLevel 

END

/*
Ejercicio 9
Cree un StoredProcedure que inserte un ProductInventory
*/


SELECT *
FROM Production.ProductInventory

CREATE PROCEDURE EJ9
@ProductID int,
@LocationID smallint,
@Shelf nvarchar(10),
@Bin tinyint,
@Quantity smallint

AS BEGIN

INSERT INTO Production.ProductInventory
VALUES(@ProductID, @LocationID, @Shelf, @Bin, @Quantity, NEWID(), GETDATE())
END 

EXEC EJ9 3,3,B,40,1

/*
Ejercicio 10
Cree un StoredProcedure que reciba el ID de Producto y un importe (ListPrice). 
a- En base al ID de producto deberá recuperar el ListPrice actual
b- Actualizar el ListPrice al nuevo ListPrice
c- Buscar y actualizar en la tabla ProductListPriceHistory, para el producto actual, el registro cuyo 
EndDate es Null, guardando en ese campo la fecha actual (función GetDate())
d- Insertar un nuevo registro en la tabla ProductListPriceHistory con el ListPrice nuevo con Fecha 
de inicio para la fecha actual y de fin en null
*/

CREATE PROCEDURE EJ10
@ProductID int,
@ListPrice money

AS BEGIN

--A
SELECT ListPrice
FROM Production.Product P
WHERE @ProductID = P.ProductID

--B
UPDATE Production.Product 
SET ListPrice = @ListPrice
WHERE @ProductID = ProductID

--C 
UPDATE Production.ProductListPriceHistory
SET EndDate = GETDATE()
WHERE EndDate IS NULL AND @ProductID = ProductID

--D
INSERT INTO Production.ProductListPriceHistory
VALUES(@ProductID, GETDATE(), NULL, @ListPrice, GETDATE())

END


EXEC EJ10 2, 40

SELECT * 
FROM Production.ProductListPriceHistory
