--Ejercicio 1
insert into Production.ProductListPriceHistory(ProductID, StartDate, ListPrice, ModifiedDate) values (4,'2010/02/04', 341, '2014/05/11')
select * from Production.ProductListPriceHistory where ProductID = 4

--Ejercicio2
insert into Production.ProductPhoto(ThumbnailPhotoFileName,LargePhotoFileName,ModifiedDate) values ('Pancho_The_Phanter.jpg', 'Pancho_Large_Panther.jpg', '2014/13/02')
select * from production.ProductPhoto

--Ejercicio3
insert into Production.Location(Name, CostRate, Availability, ModifiedDate) values ('Andorra', 20.32,32.20, '2015/04/02')
select * from Production.Location where ModifiedDate > '2015/01/01'

--Ejercicio 4
select Name, CostRate, Availability from Production.Location where CostRate != 0

-- Ejercicio 5
select ReviewerName, EmailAddress, Comments from Production.ProductReview where Rating = 5

-- Ejercicio 6
select ProductID, Bin, Quantity from Production.ProductInventory where Shelf = 'B'

--Ejercicio 7
select * from production.ProductPhoto A
inner join production.ProductProductPhoto B 
on a.ProductPhotoID = b.ProductPhotoID
where b.ProductID = 330

-- Ejercicio 8
select * from Production.Location A
inner join Production.ProductInventory B
on a.LocationID = b.LocationID
where b.ProductID = 330

-- Ejercicio 9
select A.* from production.ProductSubcategory A
inner join production.ProductCategory B 
on a.ProductCategoryID = b.ProductCategoryID
where b.Name = 'Bikes'

--Ejercicio 10 
select productid, count(1) as cantidad from production.Location a
join production.ProductInventory b  on a.LocationID = b.LocationID
group by ProductID order by cantidad desc

-- Ejercicio 11
select b.Name, count(1) as cant from Production.ProductSubcategory A 
join Production.ProductCategory b on a.ProductCategoryID = b.ProductCategoryID
group by b.Name order by cant desc

-- Ejercicio 12
select ProductID, count(1) as cantidad from Production.ProductPhoto A
inner join production.ProductProductPhoto B on a.ProductPhotoID = b.ProductPhotoID
group by b.ProductID order by cantidad desc

-- Ejercicio 13
update production.ProductReview set ReviewerName = 'Pancho' where ProductReviewID = 3
select * from production.ProductReview where ProductReviewID = 3

-- Ejercicio 14
update production.ProductCategory set Name='Sexologoia' where ProductCategoryID = 4
select * from production.ProductCategory where ProductCategoryID = 4

--Ejercicio 15
update production.location set Name='Andorra' where LocationID = 40
select * from production.location where LocationID = 40

-- Ejercicio 16
select a.Name, c.LargePhotoFileName from Production.Product a
inner join production.ProductProductPhoto b on a.ProductID = b.ProductID
inner join production.ProductPhoto c on b.ProductPhotoID = c.ProductPhotoID

--EJERCICIO 17
select a.Name, c.Name as locacion from production.Product a
inner join production.ProductInventory b on a.ProductID = b.ProductID
inner join production.location c on b.LocationID = c.LocationID 
where b.Quantity = 0

--EJERCICIO 18
select a.Name, c.Name as locacion from production.Product a
inner join production.ProductInventory b on a.ProductID = b.ProductID
inner join production.location c on b.LocationID = c.LocationID 
where c.CostRate = 0

--Ejercicio 19
select a.Name, a.StandardCost from production.product A
join production.ProductReview b on a.ProductID = b.ProductID
join production.ProductSubcategory c on a.ProductSubcategoryID = c.ProductSubcategoryID
where b.Rating > 3 and c.Name = 'Socks'

--Ejercicio 20
select a.Name, a.Color from production.product a 
join Production.ProductInventory b on a.ProductID = b.ProductID
join production.ProductSubcategory c on a.ProductSubcategoryID = c.ProductSubcategoryID
where b.Quantity > 300 and c.Name = 'Brakes' and shelf = 'A' and bin = 1

-- Ejercicio 21
select a.Name, ReorderPoint from production.product a 
join production.ProductListPriceHistory b on a.ProductID = b.ProductID
join production.ProductSubcategory c on a.ProductSubcategoryID = c.ProductSubcategoryID
where b.StartDate < '2012/01/01' and c.Name = 'Jerseys'

--Ejercicio 22
delete from production.ProductReview where rating < 3
select * from production.ProductReview

--Ejercicio 23
delete from production.ProductReview where ModifiedDate < '2013/01/10'
select * from production.ProductReview

--Ejercicio 24
select * from production.ProductListPriceHistory where ModifiedDate < '2013/01/01'
delete from Production.ProductListPriceHistory where ModifiedDate < '2013/01/01'