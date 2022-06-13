-- 1
INSERT INTO Production.ProductListPriceHistory (ProductID, StartDate, ListPrice, ModifiedDate)
VALUES (707, 2014-06-01, 34.99, 2022-04-22);

-- 2
INSERT INTO Production.ProductPhoto (ThumbnailPhotoFileName, LargePhotoFileName, ModifiedDate)
VALUES ('the_witcher.gif', 'the_witcher_wolf.gif', '2022-04-23T00:00:00');

-- 3
INSERT INTO Production.Location (Name, CostRate, Availability, ModifiedDate)
VALUES ('The Witcher Store', 25.00, 96.00, '2022-04-23');

-- 4
SELECT Name, 
       CostRate, 
	   Availability
FROM Production.Location
WHERE CostRate <> 0

-- 5
SELECT ReviewerName, 
       EmailAddress, 
	   Comments 
FROM Production.ProductReview
WHERE Rating = 5

-- 6
SELECT ProductID, 
       Bin, 
	   Quantity
FROM Production.ProductInventory
WHERE Shelf = 'B'

-- 7
SELECT PP.ProductPhotoID, 
       ThumbNailPhoto, 
       ThumbnailPhotoFileName,
	   LargePhoto,
	   LargePhotoFileName,
	   PP.ModifiedDate,
	   ProductID
FROM Production.ProductPhoto AS PP
JOIN Production.ProductProductPhoto AS PPP
ON PP.ProductPhotoID = PPP.ProductPhotoID
WHERE PPP.ProductID = 330

--8
SELECT PL.LocationID, 
       Name, 
	   CostRate, 
	   Availability, 
	   PL.ModifiedDate, 
	   ProductID
FROM Production.Location AS PL
JOIN Production.ProductInventory AS PIV
ON PL.LocationID = PIV.LocationID
WHERE PIV.ProductID = 330

-- 9
SELECT PSC.ProductSubcategoryID,
       PC.ProductCategoryID,
	   PSC.Name,
	   PSC.rowguid,
	   PSC.ModifiedDate
FROM Production.ProductSubcategory AS PSC
JOIN Production.ProductCategory AS PC
ON PSC.ProductCategoryID = PC.ProductCategoryID
WHERE PC.Name = 'Bikes'

-- 10
SELECT PIV.ProductID,
	   COUNT(1) AS CantidadUbicaciones	
FROM Production.Location AS PL
JOIN Production.ProductInventory AS PIV
ON PL.LocationID = PIV.LocationID
GROUP BY ProductID
--ORDER BY CantidadUbicaciones DESC

-- 11
SELECT PC.Name,
       COUNT(1) AS CantidadSubcategorias
FROM Production.ProductCategory AS PC
JOIN Production.ProductSubcategory AS PSC
ON PC.ProductCategoryID = PSC.ProductCategoryID
GROUP BY PC.Name
ORDER BY CantidadSubcategorias DESC

-- 12
SELECT ProductID,
	   COUNT(1) AS CantidadFotos
FROM Production.ProductPhoto AS PP
JOIN Production.ProductProductPhoto AS PPP
ON PP.ProductPhotoID = PPP.ProductPhotoID
GROUP BY ProductID
ORDER BY CantidadFotos DESC

-- 13
UPDATE Production.ProductReview
SET ReviewerName = 'Julio'
WHERE ProductReviewID = 3

SELECT * 
FROM Production.ProductReview

-- 14
UPDATE Production.ProductCategory
SET Name = 'Accesorios'
WHERE ProductCategoryID = 4

SELECT *
FROM Production.ProductCategory

-- 15
UPDATE Production.Location 
SET Name = 'Ega estacion'
WHERE LocationID = 40

SELECT *
FROM Production.Location

-- 16
SELECT P.Name,
	   PH.LargePhotoFileName
FROM Production.Product AS P
JOIN Production.ProductProductPhoto AS PP
ON PP.ProductID = P.ProductID
JOIN Production.ProductPhoto AS PH
ON PH.ProductPhotoID = PP.ProductPhotoID

-- 17
SELECT P.Name,
	   L.Name
FROM Production.Product AS P
JOIN Production.ProductInventory AS PIV
ON P.ProductID = PIV.ProductID
JOIN Production.Location AS L
ON L.LocationID = PIV.LocationID
WHERE PIV.Quantity = 0

-- 18
SELECT P.Name,
	   L.Name
FROM Production.Product AS P
JOIN Production.ProductInventory AS PIV
ON P.ProductID = PIV.ProductID
JOIN Production.Location AS L
ON L.LocationID = PIV.LocationID
WHERE L.CostRate = 0
GROUP BY P.Name, L.Name

-- 19
SELECT Name, StandardCost 
FROM Production.Product AS P
JOIN Production.ProductReview AS PR
ON P.ProductID = PR.ProductID
WHERE PR.Rating > 3 and 
P.ProductSubcategoryID IN (SELECT ProductSubcategoryID FROM Production.ProductSubcategory WHERE Name = 'Socks')

-- 20
SELECT Name,
       Color
FROM Production.Product AS P
JOIN Production.ProductInventory AS PIV
ON P.ProductID = PIV.ProductID
WHERE PIV.Quantity > 300 and Shelf = 'A' and Bin = 1 and
P.ProductID IN (SELECT ProductID FROM Production.Product WHERE ProductSubcategoryID IN (SELECT ProductSubcategoryID FROM Production.ProductSubcategory WHERE Name = 'Brakes'))

-- 21
SELECT DISTINCT Name,
       ReorderPoint
FROM Production.Product AS P
JOIN Production.ProductListPriceHistory AS PPH
ON P.ProductID = PPH.ProductID
WHERE P.SellStartDate < PPH.StartDate and
P.ProductID IN (SELECT ProductID from Production.Product WHERE ProductSubcategoryID IN (SELECT ProductSubcategoryID FROM Production.ProductSubcategory WHERE Name = 'Jerseys'))

--SELECT Name
--FROM Production.Product
--WHERE ProductID IN (713, 714, 715, 716)


--SELECT *
--FROM Production.ProductListPriceHistory
--WHERE StartDate < '2012-01-01T00:00:00' and
--ProductID IN (SELECT ProductID from Production.Product WHERE ProductSubcategoryID IN (SELECT ProductSubcategoryID FROM Production.ProductSubcategory WHERE Name = 'Jerseys'))

-- 22
SELECT *
FROM Production.ProductReview

DELETE FROM Production.ProductReview WHERE Rating < 3

SELECT *
FROM Production.ProductReview

-- 23
SELECT *
FROM Production.ProductReview

DELETE FROM Production.ProductReview WHERE ModifiedDate < '2013-10-01T00:00:00'

SELECT *
FROM Production.ProductReview

-- 24
SELECT *
FROM Production.ProductReview

DELETE FROM Production.ProductListPriceHistory WHERE ModifiedDate < '2013-01-01T00:00:00'

SELECT *
FROM Production.ProductReview