--Ejercicio 1 Escriba la sentencia SQL para recuperar FirstName, LastName de los registros que cuya ModifiedDate sea mayor al 1 de enero de 2010.Lector inmersivo

--select FirstName, LastName from Person.Person where ModifiedDate > '2010/01/01'

--Ejercicio 2 Escriba la sentencia SQL para recuperar nombre, apellido y teléfono celular (Cell) de las personas.

select FirstName, LastName, PhoneNumber, from Person.Person
INNER JOIN Person.PersonPhone ON Person.Person.BusinessEntityID = Person.PersonPhone.BusinessEntityID
INNER JOIN Person.PhoneNumberType 
ON Person.PersonPhone.PhoneNumberTypeID = Person.PhoneNumberType.PhoneNumberTypeID
where Person.PhoneNumberType.Name = 'Cell'

--Ejercicio 3 Escriba la sentencia SQL para recuperar nombre, apellido y la cantidad de teléfonos que tiene asociados.
/*
select FirstName, LastName, count(PhoneNumber)
from Person.Person
INNER JOIN Person.PersonPhone ON Person.Person.BusinessEntityID=Person.PersonPhone.BusinessEntityID
*/
--Ejercicio 4
/*
select FirstName, LastName, PhoneNumber, Name
from Person.Person
INNER JOIN Person.PersonPhone ON Person.Person.BusinessEntityID = Person.PersonPhone.BusinessEntityID
INNER JOIN Person.PhoneNumberType ON Person.PersonPhone.PhoneNumberTypeID = Person.PhoneNumberType.PhoneNumberTypeID
*/

--Ejercicio 5 Escriba la sentencia SQL para recuperar la cantidad de personas que tienen configurado el teléfono de la casa (Home).
--select count(PhoneNumberTypeID) from Person.PersonPhone where PhoneNumberTypeID = 2

--Ejercicio 6 Escriba la sentencia SQL para recuperar Id de la entidad, numero de teléfono y nombre del tipo de teléfono.
/*
select distinct BusinessEntityID, PhoneNumber, Name
from Person.PersonPhone
INNER JOIN Person.PhoneNumberType ON Person.PersonPhone.PhoneNumberTypeID = Person.PhoneNumberType.PhoneNumberTypeID
*/

