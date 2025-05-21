create database TechCorp;

use TechCorp;

create table empleados(
idEmpleado int primary key auto_increment,
edadEmpleado int not null,
salarioEmpleado double(10,2) not null,
nombreEmpleado VARCHAR(20) not null,
anioContratacion int not null,
departamento VARCHAR(20) not null
);

insert into empleados values('',32,12000,'William',2018,'Contratacion');
insert into empleados values('',51,14999,'Arevalo',2025,'IT'),('',39,125000,'Cuesta',2022,'Ventas'),('',68,219999,'Mariana',2011,'Contratacion'),('',40,15400,'Andres',2020,'IT'),('',23,17560,'Fernando',2019,'Ventas'),('',35,20000,'Alexander',2015,'Ventas');
select * from empleados;
select nombreEmpleado, edadEmpleado, salarioEmpleado from empleados;
select nombreEmpleado, salarioEmpleado from empleados where salarioEmpleado >4000;
select nombreEmpleado as 'Empleados que trabajan en Ventas',departamento from empleados where departamento = 'Ventas';
select nombreEmpleado as 'Empleados entre 30 y 40 años', edadEmpleado from empleados where edadEmpleado between 30 and 40;
select nombreEmpleado as 'Empleados contratados despues del 2020', anioContratacion from empleados where anioContratacion >= 2020;
select departamento, count(*) from empleados group by departamento;
select avg(salarioEmpleado) as salarioPromedio from empleados;
select nombreEmpleado as 'Empleados que comienzan con A o C' from empleados where nombreEmpleado like 'a%' or nombreEmpleado like 'c%'; 
select nombreEmpleado as 'Empleados que no pertenecen al departamento IT', departamento from empleados where departamento <> 'IT';
select nombreEmpleado as 'Empleado mejor pagado', max(salarioEmpleado) from empleados;

