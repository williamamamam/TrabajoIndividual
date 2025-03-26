/*Sentencias de DDL*/
/*Creacion de base de datos*/
drop database tiendamascota;
SET SQL_SAFE_UPDATES = 0;
create database TiendaMascota;
/*Habilitar la base de datos*/
use TiendaMascota;
/*Creacion de tablas*/
create table Mascota(
idMascota int primary key,
nombreMascota varchar (15),
generoMascota varchar (15),
razaMascota varchar (15),
cantidad int (10)
);
create table Cliente(
cedulaCliente int primary key,
nombreCliente varchar (15),
apellidoCliente varchar (15),
direccionCliente varchar (10),
telefono int (10),
idMascotaFK int
);
create table Producto(
codigoProducto int primary key,
nombreProducto varchar (15),
marca varchar (15),
precio float,
cedulaClienteFK int
);
create table Vacuna(
codigoVacuna int primary key,
nombreVacuna varchar (15),
dosisVacuna int (10),
enfermedad varchar (15)
);
create table Mascota_Vacuna(
codigoVacunaFK int,
idMascotaFK int,
enfermedad varchar (15)
);

/*crear las relaciones*/
alter table Cliente
add constraint FClienteMascota
foreign key (idMascotaFK)
references Mascota(idMascota);

alter table Producto
add constraint FKProductoCliente
foreign key (cedulaClienteFK)
references Cliente(cedulaCliente);

alter table Mascota_Vacuna
add constraint FKMV
foreign key (idMascotaFK)
references Mascota(idMascota );

alter table Mascota_Vacuna
add constraint FKVM
foreign key (codigoVacunaFK)
references Vacuna(codigoVacuna);

insert into Mascota values(1,'Max','Masculino','Chihuahua',10),(2,'Chana','Femenino','Pastor Aleman',2);
insert into Cliente values(1031650258,'William','Ramirez','Cra 69 B',3227830878,1),(7167155,'Edna','Montaña','Cll 13 B',3107579891,2);
insert into Producto values(1,'Comida','GoPet',10000,1031650258),(2,'Juguete','Rawr',12500,7167155);
insert into Vacuna values(1,'Penicilina',3,'Gastroenteritis'),(2,'Tetanos',1,'Debilidad');
insert into Mascota_Vacuna values(1,1,'Dolor intestinal'),(2,2,'Sin fuerza');

select m.*, c.nombreCliente, p.nombreProducto
from Mascota m
join cliente c on m.idMascota = idMascotaFK
join producto p on p.cedulaClienteFK=c.cedulaCliente;

delete from producto where codigoProducto = 11;
describe producto;
delete from producto;

/*Procedimientos almacenados 
Stored Procedure conjunto de instrucciones de SQL que se almacenan en y estos se pueden ejecutar muchas veces*/

/*Sintaxis del procedimiento
delimiter //
create procedure nombreProcedimiento(parametros)
begin
--instrucciones de sql
end
//Delimiter
*/

/*Creacion de procedimiento almacenado*/
drop procedure InsertarVacuna;
DELIMITER //
CREATE PROCEDURE InsertarVacuna(in codigoVacuna int, nombreVacuna varchar(15),
dosisVacuna int, enfermedad Varchar(15))
Begin
	insert into vacuna values(codigoVacuna,nombreVacuna,dosisVacuna,enfermedad);
end //
DELIMITER ;

select * from vacuna;
call InsertarVacuna(3,'Hepatitis',4,'ETS');

CREATE PROCEDURE InsertarMascota(in idMascota int, nombreMascota varchar(10),
generoMascota varchar(15), razaMascota varchar(15), cantidad int)
Begin
	insert into mascota values(idMascota,nombreMascota,generoMascota,razaMascota,cantidad);
end //
DELIMITER ;

select * from mascota;
CALL InsertarMascota(5,'Firulais','Femenino','Pomerania',4);

select * from mascota;
describe producto;
DELIMITER //
CREATE PROCEDURE ConsultarPrecio(in precio float,out total float)
Begin
	select count(*) into precio from producto;
end //
DELIMITER ;

call ConsultarPrecio(@resultado);

drop procedure ConsultarVacuna;
DELIMITER //
CREATE PROCEDURE ConsultarVacuna(in dosisVacuna int ,out totalVacunas float)
Begin
	select count(*) into totalVacunas from Vacuna;
end //
DELIMITER;

DELIMITER //
CREATE PROCEDURE ConsultarEnfermedad(in enfermedad varchar(15) ,out EnfermedadMascota float)
Begin
	select count(*) into totalVacunas from Vacuna;
end //
DELIMITER ;





