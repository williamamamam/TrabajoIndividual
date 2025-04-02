create database OnlineBD;
use OnlineBD;
drop database OnlineBD;
SET SQL_SAFE_UPDATES = 0;

create table cliente(
idCliente int primary key auto_increment,
documentoCliente VARCHAR(10) not null,
nombreCliente VARCHAR(10) not null,
apellidoCliente VARCHAR(20) not null,
telefonoCliente VARCHAR(10) not null
);

create table libro(
idLibro int primary key auto_increment,
nombreLibro VARCHAR(50) NOT NULL,
autorLibro VARCHAR(20) not null,
cantidadLibro int not null,
precioLibro float(10,2) not null
);

create table pedido(
idPedido int primary key auto_increment,
idLibroFK int,
idClienteFK int,
fechaPedido VARCHAR(10)
);

alter table pedido
add constraint FKidCliente
foreign key (idClienteFK)
references cliente(idCliente)
on delete cascade;

alter table pedido
add constraint FKidLibro
foreign key (idLibroFK)
references libro(idLibro)
on delete cascade;

insert into cliente values('','1031650258','William','Ramirez','3227830878'),
('','7167155','Cristobal','Guerrero','3107579891'),('','52770093','Edna','Montaña','3142090344'),
('','5248950','Juan','Arevalo','3012546834'),('','65871405','Juliana','Rodriguez','3165870957');

insert into libro values('','Inferno','Dan Brown',3,1200),('','Cronica de una Muerte Anunciada','Milton Fernandez',5,3500),
('','Mensajero de Agatha','Yazmin Castro',1,4000),('','Psicocibernetica','Catalina Carreño',8,300),('','La Biblia','Juan de Dios',20,5200);

insert into pedido values('',1,1,'02/04/2025'),('',2,2,'20/07/2019'),('',3,3,'12/12/2012'),('',4,4,'19/11/2020'),('',5,5,'09/08/2006');

select * from pedido;
select * from libro;
select * from cliente;
describe pedido;

#Actualizar el stock de los libros una vez que se realice un pedido

DELIMITER //
create trigger actualizarCantidadLibros
after insert on pedido
for each row
BEGIN
	update libro
    set cantidadLibro = cantidadLibro - 1
    where idLibro = new.idLibroFK;
END //
DELIMITER ;

select * from libro;
INSERT INTO pedido (idLibroFK, idClienteFK, fechaPedido) 
VALUES (1, 1, '02/04/2025');

SELECT * FROM libro WHERE idLibro = 1;

#listar los pedidos hechos por un cliente específico y obtener detalles de los libros comprados.

select nombreCliente as 'Cliente', fechaPedido as 'Fecha Pedido',  nombreLibro as 'Libro', autorLibro as 'Autor' 
from pedido inner join cliente on pedido.idClienteFK = cliente.idCliente
inner join libro on pedido.idLibroFK = libro.idLibro; 








