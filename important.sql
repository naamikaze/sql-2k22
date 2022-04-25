CREATE DATABASE facultad; 

GO 

USE facultad; 

 

CREATE TABLE cursos ( 

id int not null PRIMARY KEY, 

Nombre varchar(100) 

); 

 

CREATE TABLE alumnos ( 

id int IDENTITY(1,1) PRIMARY KEY, 

Apellido varchar(100) not null, 

Nombre varchar(100), 

idCurso int FOREIGN KEY REFERENCES Cursos(id) 

); 

 

 

--ALTER TABLE alumnos 

--ADD idCurso int; 

 

--ALTER TABLE alumnos 

--ADD FOREIGN KEY (idCurso) REFERENCES Cursos(id) 

--; 

 

 

ALTER TABLE alumnos 

ADD email varchar(100) UNIQUE; 

 

--ALTER TABLE alumnos 

--DROP COLUMN email; 

 

ALTER TABLE alumnos 

ALTER COLUMN email varchar(200); 

 

ALTER TABLE alumnos 

ALTER COLUMN Nombre varchar(100) NOT NULL 

 

--ALTER TABLE alumnos 

--ADD PRIMARY KEY (id); 

 







 ------


 -- Adventure works Algebra Relacional 

-- Ejercicio 1 

select * from Production.Product where ReorderPoint = 375 

UNION 

select * from Production.Product where ReorderPoint = 75 

 

-- Ejercicio 2 

select * from Production.Product where ReorderPoint = 375 or ReorderPoint = 75 

 

-- Ejercicio 3 

select * from Production.Product where ReorderPoint = 375 

except 

select * from Production.Product where ListPrice = 0 

 

-- Ejercicio 4 

select * from Production.Product where ReorderPoint = 375 and ListPrice <> 0 

 

-- Ejercicio 5 

--select * from Production.Product as p 

--    join Production.ProductReview as pr 

-- on p.ProductID = pr.ProductID 

select * from Production.Product -- 504 registros 

select * from Production.ProductReview -- 4 registros 

-- 2016 reg 

select * from Production.Product, Production.ProductReview 

 

-- Ejercicio 6 

select * from Production.Product as p 

    join Production.ProductReview as pr 

on p.ProductID = pr.ProductID 

 

select * from Production.Product as p 

    left join Production.ProductReview as pr 

on p.ProductID = pr.ProductID 

 

-- Ejercicio 7 

select * from Production.Product where ReorderPoint = 375 

intersect 

select * from Production.Product where ListPrice = 0 

 

-- Ejercicio 8 

select * from Production.Product where ReorderPoint = 375 and ListPrice = 0  

 

-- Ejercicio 9 

SELECT  

    Name,  

SafetyStockLevel,  

ReorderPoint 

FROM Production.Product 

 

-- Ejercicio 10 

select * 

from Production.Product 

where ListPrice > 1000 

 

-- Ejercicio 11 

select * from Production.ProductCategory 

select * from Production.ProductSubcategory 

 

select  

  psc.ProductSubcategoryID, 

  psc.Name as SubcategoryName, 

  pc.Name as CategoryName 

from Production.ProductCategory pc 

  JOIN Production.ProductSubcategory psc 

    ON pc.ProductCategoryID = psc.ProductCategoryID 

 

-- Ejercicio 12 

select  

p.Name Producto, 

psc.Name SubCat, 

pc.Name Cat 

 

from Production.Product p 

left join Production.ProductSubcategory psc 

on p.ProductSubcategoryID = psc.ProductSubcategoryID 

left join Production.ProductCategory pc 

ON pc.ProductCategoryID = psc.ProductCategoryID 

 

select  

p.Name Producto, 

psc.Name SubCat, 

pc.Name Cat 

 

from Production.ProductSubcategory psc 

left join Production.ProductCategory pc 

ON pc.ProductCategoryID = psc.ProductCategoryID 

right join Production.Product p 

on p.ProductSubcategoryID = psc.ProductSubcategoryID 

where pc.ProductCategoryID = 1 

 

-- Ejercicio 13 

select  

pc.Name categ, 

count(1) cant, 

avg(p.listprice) pcioprom, 

min(p.listprice) min, 

max(p.listprice) max 

 

from Production.ProductSubcategory psc 

left join Production.ProductCategory pc 

ON pc.ProductCategoryID = psc.ProductCategoryID 

right join Production.Product p 

on p.ProductSubcategoryID = psc.ProductSubcategoryID 

group by pc.Name 

-- having count(1) > 50 and avg(p.listprice) > 500 

 -- Adventure works Algebra Relacional 

-- Ejercicio 1 

select * from Production.Product where ReorderPoint = 375 

UNION 

select * from Production.Product where ReorderPoint = 75 

 

-- Ejercicio 2 

select * from Production.Product where ReorderPoint = 375 or ReorderPoint = 75 

 

-- Ejercicio 3 

select * from Production.Product where ReorderPoint = 375 

except 

select * from Production.Product where ListPrice = 0 

 

-- Ejercicio 4 

select * from Production.Product where ReorderPoint = 375 and ListPrice <> 0 

 

-- Ejercicio 5 

--select * from Production.Product as p 

--    join Production.ProductReview as pr 

-- on p.ProductID = pr.ProductID 

select * from Production.Product -- 504 registros 

select * from Production.ProductReview -- 4 registros 

-- 2016 reg 

select * from Production.Product, Production.ProductReview 

 

-- Ejercicio 6 

select * from Production.Product as p 

    join Production.ProductReview as pr 

on p.ProductID = pr.ProductID 

 

select * from Production.Product as p 

    left join Production.ProductReview as pr 

on p.ProductID = pr.ProductID 

 

-- Ejercicio 7 

select * from Production.Product where ReorderPoint = 375 

intersect 

select * from Production.Product where ListPrice = 0 

 

-- Ejercicio 8 

select * from Production.Product where ReorderPoint = 375 and ListPrice = 0  

 

-- Ejercicio 9 

SELECT  

    Name,  

SafetyStockLevel,  

ReorderPoint 

FROM Production.Product 

 

-- Ejercicio 10 

select * 

from Production.Product 

where ListPrice > 1000 

 

-- Ejercicio 11 

select * from Production.ProductCategory 

select * from Production.ProductSubcategory 

 

select  

  psc.ProductSubcategoryID, 

  psc.Name as SubcategoryName, 

  pc.Name as CategoryName 

from Production.ProductCategory pc 

  JOIN Production.ProductSubcategory psc 

    ON pc.ProductCategoryID = psc.ProductCategoryID 

 

-- Ejercicio 12 

select  

p.Name Producto, 

psc.Name SubCat, 

pc.Name Cat 

 

from Production.Product p 

left join Production.ProductSubcategory psc 

on p.ProductSubcategoryID = psc.ProductSubcategoryID 

left join Production.ProductCategory pc 

ON pc.ProductCategoryID = psc.ProductCategoryID 

 

select  

p.Name Producto, 

psc.Name SubCat, 

pc.Name Cat 

 

from Production.ProductSubcategory psc 

left join Production.ProductCategory pc 

ON pc.ProductCategoryID = psc.ProductCategoryID 

right join Production.Product p 

on p.ProductSubcategoryID = psc.ProductSubcategoryID 

where pc.ProductCategoryID = 1 

 

-- Ejercicio 13 

select  

pc.Name categ, 

count(1) cant, 

avg(p.listprice) pcioprom, 

min(p.listprice) min, 

max(p.listprice) max 

 

from Production.ProductSubcategory psc 

left join Production.ProductCategory pc 

ON pc.ProductCategoryID = psc.ProductCategoryID 

right join Production.Product p 

on p.ProductSubcategoryID = psc.ProductSubcategoryID 

group by pc.Name 

-- having count(1) > 50 and avg(p.listprice) > 500 

 