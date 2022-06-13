-- Simulacro 2do Parcial 

 

-- Ejercicio 1 

 

create index idx_product_color 

  ON production.product(color) 

 

-- Ejercicio 2 

 

create index idx_psc_pc 

  ON production.productsubcategory(productcategoryid) 

 

-- Ejercicio 3 

 

create view v_ej3 

  as 

    select p.ProductID, p.Name Producto, p.Color, sc.Name SubCategoria, c.Name Categoria 

from Production.Product p 

join Production.ProductSubcategory sc 

on p.ProductSubcategoryID = sc.ProductSubcategoryID 

join Production.ProductCategory c 

on c.ProductCategoryID = sc.ProductCategoryID 

 

-- Ej 4 

 

create view v_ej4 

as 

  select p.ProductID, p.Name, pp.ThumbnailPhotoFileName, pp.LargePhotoFileName 

  from Production.Product p 

  join Production.ProductProductPhoto ppp 

  on p.ProductID = ppp.ProductID 

  join Production.ProductPhoto pp 

  on pp.ProductPhotoID = ppp.ProductPhotoID 

  where ppp.[Primary] = 1 

 

-- Ejercicio 5 

 

create login bd1 with password = 'abc123' 

go 

create user bd1 for login bd1  

 

grant select, update, insert ON production.product to bd1 

 

-- Ej 6 

 

create function f_mayor(@n1 as int, @n2 as int) 

returns int 

as 

begin 

declare @ret int 

if @n1 > @n2  

  set @ret = @n1 

else  

  set @ret = @n2 

 

return @ret 

 

end 

 

select dbo.f_mayor(9,6) 

 

-- Ej 7 

create procedure sp_ej7  

as 

begin 

select sc.Name 

from Production.ProductSubcategory sc 

where sc.ProductCategoryID IN ( 

--select p.ProductCategoryID  -- , COUNT(1)  

--from Production.ProductSubcategory sc 

--JOIN Production.ProductCategory p 

--on p.ProductCategoryID = sc.ProductCategoryID 

--group by p.ProductCategoryID 

--having COUNT(1) > 5 

select sc.ProductCategoryID  -- , COUNT(1)  

from Production.ProductSubcategory sc 

group by sc.ProductCategoryID 

having COUNT(1) > 5 

) 

end 

 

exec dbo.sp_ej7 

 

-- ej 8 

 

select p.ProductID, p.Name, p.SafetyStockLevel, SUM(pri.quantity) 

from Production.Product p 

join Production.ProductInventory pri 

on p.ProductID = pri.ProductID 

group by p.ProductID, p.Name, p.SafetyStockLevel 

having SUM(pri.quantity) < p.SafetyStockLevel 

 

-- Ej 9 

create procedure sp_ej9 (  

  @productId int, 

  @locationId smallint,  

  @shelf nvarchar(10), 

  @bin tinyint, 

  @qty smallint 

) as 

begin 

  insert into Production.ProductInventory VALUES  

    (@productId, @locationId, @shelf, @bin, @qty, NEWID(), GETDATE()) 

end 

 

select COUNT(1) from Production.ProductInventory 

 

exec dbo.sp_ej9 1, 2, 'A',1, 20 

 

-- Ej 10 

 

create procedure sp_ej10 ( 

  @productId int, 

  @price money 

) 

as 

begin 

  declare @old money 

  select @old= p.ListPrice  

  from Production.Product p 

  where p.ProductID = @productId 

 

  update Production.Product SET ListPrice = @price Where ProductID = @productId 

 

  update Production.ProductListPriceHistory SET EndDate = GETDATE()  

    Where ProductID = @productId and EndDate is null 

 

  insert into Production.ProductListPriceHistory Values (@productId, GETDATE(), null, @price, GETDATE()) 

 

end 