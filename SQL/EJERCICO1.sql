/* Hola a todas las personas */
create database viajeUR;

create database tienda;

/*Habilitar o usar la base de datos use nombre BD*/
USE tienda;

/*Crear tablas*/

create table Cliente(
idCliente int auto_increment primary key,
documentoCliente VARCHAR(10) NOT NULL,
nombreCliente VARCHAR(10) NOT NULL,
emailCliente VARCHAR(20) NOT NULL,
telefonoCliente VARCHAR(10) NOT NULL,
direccionCliente text,
fechaRegistro timestamp default current_timestamp
);

create table pedido(
idPedido int auto_increment primary key,
idClienteFK INT NOT NULL,	
fechaPedido DATE NOT NULL,
totdalPedido decimal(10,2) NOT NULL,
estado enum('Pendiente', 'Enviado', 'Entregado', 'Cancelado') default 'Pendiente',
fechaRegistro timestamp default current_timestamp
);

create table Producto(
idProducto int auto_increment primary key,
codigoProducto VARCHAR(10) NOT NULL,
nombreProducto VARCHAR(10) NOT NULL,
precioProducto decimal (10,2) NOT NULL,
stock int default 0,
fechaCreacion timestamp default current_timestamp 
);

/*Consultar esctructura de las tablas describe nombreTabla*/
describe Producto;
