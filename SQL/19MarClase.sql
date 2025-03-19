create database TechCorp;
set sql_safe_updates = 0;
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
select nombreEmpleado as 'Empleado mejor pagado', max(salarioEmpleado) from empleados; /*Esta mal*/

/*19FEB*/
/*Empleado con mayor salario*/
select nombreEmpleado, salarioEmpleado from empleados where salarioEmpleado = (select max(salarioEmpleado) from empleados);

/*Consultar un valor dentro de una lista de valores, in*/
select * from empleados where idEmpleado in (1,5,7);
/*Si un campo es nulo, is null*/
select * from clientes where domicilio is null;

select salarioEmpleado from empleados order by salarioEmpleado desc;
select departamento, count(*) from empleados where departamento is null;
select nombreEmpleado, anioContratacion, (2025 - anioContratacion) as 'anios contratados' from empleados;

select nombreEmpleado, salarioEmpleado from empleados order by salarioEmpleado desc limit 3;

/*Bono de 10% para empleados que hayan trabajdo por ams de 10 años en la empresa*/
select nombreEmpleado, salarioEmpleado, (2025 - anioContratacion) as 'Años trabajados', salarioEmpleado*0.1 as 'bono' from empleados where (2025 - anioContratacion) >9;
select avg(salarioEmpleado) as 'Promedio salario',count(*) as 'Empleados que ganan mas que el promedio' from empleados
where salarioEmpleado>(select avg(salarioEmpleado) from empleados);

select departamento,count(*) as 'Numero de empleados en el departamento' from empleados group by departamento order by count(*) desc;

/*No pude*/
select nombreEmpleado, salarioEmpleado, (2025 - anioContratacion) as 'anios contratados' from empleados  where (2025 - anioContratacion)>=(select(2025 - anioContratacion)) from empleados where salarioEmpleado >= (select max(salarioEmpleado) from empleados) order by desc

/*Ni chat pudo*/
SELECT nombreEmpleado, salarioEmpleado, (YEAR(CURDATE()) - anioContratacion) AS anios_contratados
FROM empleados
WHERE (YEAR(CURDATE()) - anioContratacion) = (
    SELECT MAX(YEAR(CURDATE()) - anioContratacion) FROM empleados
)
AND salarioEmpleado = (SELECT MAX(salarioEmpleado) FROM empleados)
ORDER BY nombreEmpleado DESC;

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



