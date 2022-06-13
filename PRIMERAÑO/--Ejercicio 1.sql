--Ejercicio 1
select FirstName, LastName from person.person where ModifiedDate > '2010/01/01'

--Ejercicio 2
select firstname, lastname, PhoneNumber from person.person a
join person.PersonPhone b on a.BusinessEntityID = b.BusinessEntityID
join person.PhoneNumberType c on b.PhoneNumberTypeID = c.PhoneNumberTypeID
where c.Name = 'Cell'

--Ejercicio 3 Escriba la sentencia SQL para recuperar nombre, apellido y la cantidad de teléfonos que tiene asociados.Lector inmersivo

select firstname, lastname, count(1) as cantidad from person.person a
join person.PersonPhone b on a.BusinessEntityID = b.BusinessEntityID 
group by firstname, lastname
order by cantidad desc

--Ejercicio 4 Escriba la sentencia SQL para recuperar nombre, apellido, teléfono y tipo de teléfono (Name). Repetir Nombre y Apellido por cada teléfono que la persona tenga asociada
select firstname, lastname, phonenumber, c.Name from person.person a 
join person.personphone b on a.BusinessEntityID = b.BusinessEntityID
join person.PhoneNumberType c on b.PhoneNumberTypeID = c.PhoneNumberTypeID

-- Ejercicio 5 Escriba la sentencia SQL para recuperar la cantidad de personas que tienen configurado el teléfono de la casa (Home)

select count(1) as cantidad from person.person a 
join person.PersonPhone b on a.BusinessEntityID = b.BusinessEntityID
join person.PhoneNumberType c on b.PhoneNumberTypeID = c.PhoneNumberTypeID
where c.Name = 'Home'

-- EJercicio 6 Escriba la sentencia SQL para recuperar Id de la entidad, numero de teléfono y nombre del tipo de teléfono.Lector inmersivo
select a.BusinessEntityID, b.PhoneNumber, c.name from person.person a 
join person.PersonPhone b on a.BusinessEntityID = b.BusinessEntityID
join person.PhoneNumberType c on b.PhoneNumberTypeID = c.PhoneNumberTypeID



