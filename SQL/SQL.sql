/*Sentencias de DDL*/
/*Creacion de base de datos*/
drop database tiendamascota;
SET SQL_SAFE_UPDATES = 0;
create database TiendaMascota;
/*Habilitar la base de datos*/
use TiendaMascota;
set SQL_SAFE_UPDATES=1;
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

-- 1 
DELIMITER //

CREATE PROCEDURE InsertarVacunaMascota(
    IN p_codigoVacuna INT,
    IN p_idMascota INT,
    IN p_enfermedad VARCHAR(15)
)
BEGIN
    -- Insertar un registro en la tabla Mascota_Vacuna
    INSERT INTO Mascota_Vacuna (codigoVacunaFK, idMascotaFK, enfermedad)
    VALUES (p_codigoVacuna, p_idMascota, p_enfermedad);
END //

DELIMITER ;

CALL InsertarVacunaMascota(3, 1, 'Rabia');

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
DELIMITER ;|

call ConsultarPrecio(@resultado);

DELIMITER //

CREATE PROCEDURE ConsultarVacunasMascota(
    IN p_idMascota INT
)
BEGIN
    -- Consultar las vacunas y las enfermedades para una mascota específica
    SELECT 
        m.nombreMascota,
        v.nombreVacuna,
        mv.enfermedad 
    FROM 
        Mascota_Vacuna mv
    JOIN 
        Vacuna v ON mv.codigoVacunaFK = v.codigoVacuna
    JOIN 
        Mascota m ON mv.idMascotaFK = m.idMascota
    WHERE 
        mv.idMascotaFK = p_idMascota;
END //

/*27 MAR --------------------------------------------------------------------------------------------------------------------------------------------------------*/
/*VISTAS VIEWS Es una consulta en la BD que genera una tabla virtual*/

/*SINTAXIS*/
/*create view nombreLista as
select valoresAConsultar from nombreTabla where condiciones
para ejectura se realiza una consulta de la vista
*/
describe cliente;
create view vistaCliente as 
select * from cliente where cedulaCliente = 1031650258;

select * from vistaCliente;

create view numeroCliente as 
select * from cliente where telefono like '%1%' or telefono like '%5%' or telefono like '%7%';
drop view numeroCliente;

select * from numeroCliente;

/*disparadores Triggers
tipos
before insert
before update
before delete
se ejecutan antes de la operacion

after insert
after update
after delete
se ejecutan despues de la operacion

sintaxis
DELIMITER//
create trigger nombreTrigger
after insert on nombreTabla 
for each row 
BEGIN
END	
//
DELIMITER;
*/

/*Crear u trigger para registrar en una tabla consolidadad cada vez que se inserte ina mascota*/

create table consolidado(
idMascota int primary key,
nombreMascota varchar (15),
generoMascota varchar (15),
razaMascota varchar (15),
cantidad int (10)
);

drop trigger registrarConsolidadoMascota;
DELIMITER //
CREATE trigger registrarConsolidadoMascota
after insert on mascota
for each row
BEGIN
	insert into consolidado values(new.idMascota, new.nombreMascota,new.generoMascota,new.razaMascota,new.cantidad); 
END //
DELIMITER ;

insert into Mascota values(6,'Mateo', 'Masculino','labrador',2);

select  * from consolidado;


create table clienteEliminados(
cedulaCliente int primary key,
nombreCliente varchar (15),
apellidoCliente varchar (15),
direccionCliente varchar (10),
telefono int (10),
idMascotaFK int
);

create table mascotaEliminada(
idMascota int primary key,
nombreMascota varchar (15),
generoMascota varchar (15),
razaMascota varchar (15),
cantidad int (10)
);

DELIMITER //
CREATE trigger mascotasEliminadas
after delete on mascota
for each row
BEGIN
	insert into mascotasEliminadas values(old.idMascota, old.nombreMascota,old.generoMascota,old.razaMascota,old.cantidad); 
END //
DELIMITER ;

delete from mascota where idMascota = 1;

select * from mascota;

ALTER TABLE Cliente
ADD CONSTRAINT fk_cliente_mascota
FOREIGN KEY (idMascotaFK) REFERENCES Mascota(idMascota)
ON DELETE CASCADE;

DELIMITER //
CREATE TRIGGER clientesEliminados
AFTER DELETE ON Cliente
FOR EACH ROW
BEGIN
    INSERT INTO clienteEliminados 
    (cedulaCliente, nombreCliente, apellidoCliente, direccionCliente, telefono, idMascotaFK)
    VALUES
    (OLD.cedulaCliente, OLD.nombreCliente, OLD.apellidoCliente, OLD.direccionCliente, OLD.telefono, OLD.idMascotaFK);
END //
DELIMITER ;




