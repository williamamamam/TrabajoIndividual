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
fechaPedido date 
);

create table libroPedido(
idPedidoFK int,
unidadesVendidas int
);

alter table libroPedido
add constraint FKidPedido
foreign key (idPedidoFK)
references pedido(idPedido)
on delete cascade;

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

insert into pedido values('',1,1,'2025-02-04'),('',2,2,'2019-20-07'),('',3,3,'2012-12-12'),('',4,4,'2025-19-11'),('',5,5,'2006-09-08');
truncate pedido; #Borrar values sin borrar tabla

insert into libroPedido values(1,2),(2,6),(3,1),(4,2),(5,3);

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

select * from libro where idLibro = 1;
INSERT INTO pedido (idLibroFK, idClienteFK, fechaPedido) 
VALUES (1, 1, '02/04/2025');

INSERT INTO pedido (idLibroFK, idClienteFK, fechaPedido) 
VALUES (3, 3, '02/04/2025');


SELECT * FROM libro WHERE idLibro = 1;

#listar los pedidos hechos por un cliente específico y obtener detalles de los libros comprados.

select nombreCliente as 'Cliente', fechaPedido as 'Fecha Pedido',  nombreLibro as 'Libro', autorLibro as 'Autor' 
from pedido inner join cliente on pedido.idClienteFK = cliente.idCliente
inner join libro on pedido.idLibroFK = libro.idLibro; 

#Consultar el cliente que ha realizado el mayor número de pedidos

select c.idCliente, c.nombreCliente as 'Nombre', c.apellidoCliente as 'Apellido' ,
count(p.idPedido) as totalPedidos from pedido p
inner join cliente c on p.idClienteFK = c.idCliente
group by c.idCliente
order by totalPedidos desc limit 1;

#Crear un procedimiento almacenado que permita registrar un nuevo pedido, actualizando la tabla de pedidos 
#y reduciendo el stock del libro correspondiente.

DELIMITER //
create procedure registroPedido(
	in p_idLibro int,
    in p_idCliente int,
    in fechaPedido VARCHAR(10)
)
begin
	update libro
    set cantidadLibro = cantidadLibro - 1
    where idLibro = p_idLibro and cantidadLibro > 0;
    
    if row_count() > 0 then
		insert into pedido values(idLibroFK, idClienteFK, fechaPedido);
	end if;
end //
DELIMITER ;


Call registroPedido(1,1,"02/04/2025");
Call registroPedido(5,5,"09/08/2006");

select * from pedido;
select * from libro;

#Selecciona los libros cuyo precio sea mayor a $20.00.

select nombreLibro as 'Libros con un valor mayor a 2000', 
precioLibro as 'Precio' from libro where precioLibro > 2000 ;

#Selecciona los pedidos realizados después del 1 de octubre de 2024

select nombreCliente as 'Cliente',fechaPedido as 'Fecha Pedido' 
from pedido inner join cliente on pedido.idClienteFK = cliente.idCliente
where fechaPedido > '2024-10-01';

#Selecciona todos los libros ordenados por su precio de mayor a menor.

select nombreLibro as 'Nombre Libro', precioLibro as 'Precio Libro' from libro 
order by precioLibro desc;

#Obtén el total de clientes registrados en la tabla clientes. 

select count(*) as 'Numero clientes' from cliente;

#Obtén el total de unidades vendidas en la tabla pedidos

SELECT SUM(unidadesVendidas) AS Total_Unidades_Vendidas 
FROM libroPedido;

#Muestra el número de pedidos realizados por cada cliente

select c.idCliente, c.nombreCliente as 'Nombre Cliente',
c.apellidoCliente as 'Apellido Cliente', count(p.idPedido) as 'Total_Pedidos' from pedido p 
inner join cliente c on p.idClienteFK = c.idCliente group by c.idCliente, c.nombreCliente, c.apellidoCliente
order by 'Total_pedidos' desc;

#Muestra el nombre del cliente, el título del libro y la cantidad de cada pedido.

SELECT 
    c.nombreCliente AS Cliente, 
    l.nombreLibro AS Libro, 
    lp.unidadesVendidas AS Cantidad
FROM pedido p
INNER JOIN cliente c ON p.idClienteFK = c.idCliente
INNER JOIN libro l ON p.idLibroFK = l.idLibro
INNER JOIN libroPedido lp ON p.idPedido = lp.idPedidoFK;

#Muestra los títulos de los libros y la cantidad total vendida de cada uno

SELECT 
    l.nombreLibro AS Libro, 
    SUM(lp.unidadesVendidas) AS Total_Vendido
FROM libro l
INNER JOIN pedido p ON l.idLibro = p.idLibroFK
INNER JOIN libroPedido lp ON p.idPedido = lp.idPedidoFK
GROUP BY l.nombreLibro
ORDER BY Total_Vendido DESC;

/*UTILLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLL*/

/* having */
/*Est iria mejor si tuviera otra tabla llamada departamento y le pongo a los departamensot un idDepartamentoFK ya que hay empleados en varios 
departamentos, pero como lo tengo pues cada empleado solo esta en su idEmpleado*/
select idEmpleado, count(*) as 'total empleados' from empleados group by idEmpleado having count(*)>=0;

/*moidificacion */
/*update nombreTabla set camposModificar = 'ValorReemplazo', campoModificar2 = 'ValorReemplazo2' where llavePrimaria = 'valor'*/
update empleados set nombreEmpleado = 'Valentina' where idEmpleado = 4;
select * from empleados;

/*delete eliminar
sintaxis delete from nombreTabla where condicion*/
delete from empleados where nombreEmpleado = 'Alexander';
 /*Eliminar TODOOO*/
drop table empleados;

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

/*CONSULTAS MULTITABLA: permiten manipular datos en mas de una tabla
inner join: devuelve las filas que son comunes en ambas tablas
left join: devuelve las filas de la tabla izquierda y todas las filas que coindioden con derecha
right join: devuleve las filas de la tabla derecha y todas las filas que coinciden con la izquierda
full join: devuleve todas las filas

select campoConsultaTabla1 as 'Alias', campoConsultaTabla2 from tabla1 inner join tabla2 on tabla1.nombreColumnaTabla1 = tabla2.nombreColumna2 inner join tabla3
on tabla1.nombrecColumnaTabla1=tabla3.nombreColumnaTabla3*/



