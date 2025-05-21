create database EjercicioClase;

use EjercicioClase;

create table Cliente(
codigo int not null primary key auto_increment,
nombre VARCHAR(20) not null,
domicilio VARCHAR(20) not null,
ciudad VARCHAR(10) not null,
provinicia VARCHAR(15) not null,
telefono VARCHAR(10) not null
);

insert into Cliente values('','William','Cra69B','Bogota','Cundinamarca','3227830878');
insert into Cliente values('','Arevalo','Cll 13', 'Bogota','Cundinamarca','3216758969'),
('','Arroyo','Cll 15#34','Pasto','Nariño','3142090344'),
('','Cuesta','Trv 123 B','Ibague','Tolima','3107579891'),
('','Travis','Bis 16 A','Melgar','Tolima',3012548798)
;

select * from Cliente;

/*Consultas especificas*/
select nombre from cliente;
select codigo,nombre from cliente;

/*clausula where (genera condiciones que necesita operadores como lo son logicos: or (o) and (y) not (negacion); aritmeticos +-* 
/ div modulo %; comparacion < > = <= => >0 ==*/

/*Toda la info*/
select * from cliente where nombre='william' ;
/*TODOS diferente a william*/
select * from cliente where nombre<>'william' ;

select * from cliente where codigo >=2 ;
select * from cliente where codigo <=3 ;
select * from cliente where not nombre  = 'Arevalo';

select nombre from cliente where nombre='william' and codigo=1;
select nombre from cliente where nombre='william' or codigo=3;

/*Alias (permite cambiar los nombres de los campos pero no los altera) select campo1 as 'nombre del alias que se desea mostrar' from nombreTabla*/
select nombre as 'Nombre Cliente',domicilio as 'Direccion cliente',ciudad as 'Ciudad Cliente',telefono as 'Telefono Cliente',provinicia as 'Departamento Cliente' from cliente;
select provinicia as 'departamento' from cliente;

/*ordenar, order by asc o desc, select camposConsultar from nombreTabla order by campoOrdenar tipoOrden*/

select * from cliente order by telefono asc;
select * from cliente order by nombre desc;

select nombre 'Nombre Cliente', domicilio,ciudad,telefono from cliente where nombre='William' order by telefono asc;

/*Consultar agrupando group by selecto camposAConsultar from nombreTabla condicion group by CampoAgrupar orden*/
select nombre as 'Nombre Cliente', domicilio,ciudad,telefono from cliente where ciudad='Bogota' group by telefono asc;

/* like not like; select camposConsultar from nombreTabla condicion like valorAConsultarT% %T% T%*/
select * from cliente where nombre like '%a%'; 
select * from cliente where nombre like 'a%';





