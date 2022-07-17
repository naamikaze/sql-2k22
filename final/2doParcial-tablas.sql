create database Clinica
go

use Clinica
go

create table Pacientes(
  PacienteID int identity(1,1) primary key,
  Nombre varchar(100) not null
)
go

insert into Pacientes values
  ('Paciente1'),
  ('Paciente2'),
  ('Paciente3'),
  ('Paciente4'),
  ('Paciente5');
go

create table Especialidad(
  EspID int identity(1,1) primary key,
  Nombre varchar(100) not null
)
go

insert into Especialidad values
  ('Clinico'),
  ('Neurologo'),
  ('Traumatologo');
go

create table Profesionales(
  ProfID int identity(1,1) primary key,
  Nombre varchar(100) not null,
  EspID int not null foreign key references Especialidad(EspID)
)
go

insert into Profesionales values
  ('Profesional1', 1),
  ('Profesional2', 2),
  ('Profesional3', 2),
  ('Profesional4', 3),
  ('Profesional5', 3);
go

create table Turnos(
  TurnoID int identity(1,1) primary key,
  PacienteID int not null foreign key references Pacientes(PacienteID),
  ProfesionalID  int not null foreign key references Profesionales(ProfID),
  Fecha date not null,
  Hora int not null
)
go

insert into Turnos values
  (1,3,DATEFROMPARTS(2022,1,2), 9),
  (3,5,DATEFROMPARTS(2022,1,6), 17),
  (2,1,DATEFROMPARTS(2022,1,6), 14),
  (1,3,DATEFROMPARTS(2022,1,7), 12),
  (5,1,DATEFROMPARTS(2022,1,8), 17),
  (2,1,DATEFROMPARTS(2022,1,8), 18),
  (5,2,DATEFROMPARTS(2022,1,9), 10),
  (3,5,DATEFROMPARTS(2022,1,10),11),
  (4,4,DATEFROMPARTS(2022,1,14),16),
  (1,3,DATEFROMPARTS(2022,1,14),15),
  (1,1,DATEFROMPARTS(2022,1,14),11),
  (2,1,DATEFROMPARTS(2022,1,16),12),
  (4,4,DATEFROMPARTS(2022,1,16),15),
  (5,2,DATEFROMPARTS(2022,1,18),17),
  (1,1,DATEFROMPARTS(2022,1,20),18);
go
