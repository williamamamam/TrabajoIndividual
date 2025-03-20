

create database TechCorp;
set sql_safe_updates = 0;
use TechCorp;
drop table empleados;
drop table departamento;
drop table cargo;

create table empleados(
idEmpleado int primary key auto_increment,
edadEmpleado int not null,
salarioEmpleado double(10,2) not null,
nombreEmpleado VARCHAR(20) not null,
anioContratacion VARCHAR(50) not null,
departamentoEmp int not null, foreign key(departamentoEmp) references departamento(idDep),
cargoEmp varchar(20) not null, foreign key(cargoEmp) references cargo(idCargo)
);

create table departamento(
	idDep int primary key auto_increment,
	nombreDep varchar(20) not null
);

create table cargo(
	idCargo VARCHAR(10) primary key,
	nombreCargo VARCHAR(20) not null,
	rangoCargo varchar(20) not null,
	descripcionCargo VARCHAR(50) not null
);

insert into cargo values('1','Administracion', 3, 'Jefe de Administracion empresa'),('2','Papeleo', 1, 'Persona de papeleo'),('3','Diseñador', 2, 'Brainstormer de diseños'),('4','Diseñador', 3, 'Revisor final de diseños de la empresa'),('5','Administrador', 1, 'Organiza archivos'),('6','Contaduria', 2, 'Contador de ganancias empresa');
insert into departamento values(null, 'Contratacion'),(null, 'IT'),(null, 'Ventas'),(null, 'Contratacion'),(null, 'IT'),(null, 'Ventas'),(null, 'Ventas'),(null, 'IT');

insert into empleados values('',32,12000,'William','2021-11-25',1,1),('',51,14999,'Arevalo','2013-05-25',2,2),('',39,125000,'Cuesta','2015-12-11',3,3),('',68,219999,'Mariana','2011-05-01',4,4),('',40,15400,'Andres','2020-09-02',5,5),('',18,3400,'Elpepe','2024-07-03',6,6);
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

/*19FEB--------------------------------------------------------------------------------------------------------------------------*/
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

/*20 FEB---------------------------------------------------------------------------------------------------------------------------------------------------------
CONSULTAS MULTITABLA: permiten manipular datos en mas de una tabla
inner join: devuelve las filas que son comunes en ambas tablas
left join: devuelve las filas de la tabla izquierda y todas las filas que coindioden con derecha
right join: devuleve las filas de la tabla derecha y todas las filas que coinciden con la izquierda
full join: devuleve todas las filas

select campoConsultaTabla1 as 'Alias', campoConsultaTabla2 from tabla1 inner join tabla2 on tabla1.nombreColumnaTabla1 = tabla2.nombreColumna2 inner join tabla3
on tabla1.nombrecColumnaTabla1=tabla3.nombreColumnaTabla3
*/
use TechCorp;
 /*consulta de todos los cargos que tengan un rango especifico*/
select nombreCargo as 'Nombre Cargo' ,rangoCargo 'Rango Espefico' from cargo where rangoCargo is not null;  

/*mostrar en pantalla los empleados que tengan un cargo especifico*/
select nombreEmpleado as 'Nombre' , nombreCargo as 'Cargo Especifico' from empleados
inner join cargo on empleados.cargoEmp = cargo.idCargo;

/*mostrar todos los empleados de antiugedad de mas de 3 años y a que departamento pertenece, salario, cargo*/
select nombreEmpleado, timestampdiff(YEAR, anioContratacion,  CURDATE()) as antiguedad, nombreDep as 'Nombre Departamento',
salarioEmpleado, nombreCargo from empleados
inner join departamento on empleados.departamentoEmp = departamento.idDep
inner join cargo on empleados.cargoEmp = cargo.idCargo
where timestampdiff(YEAR, anioContratacion,  CURDATE()) > 3;


/*mostrar toda la info de un empleado, nombre, fecha que se contrato, departamento, años de antigüedad empresa, cargo, rango del cargo*/
select nombreEmpleado, year(anioContratacion) ,TIMESTAMPDIFF(YEAR, anioContratacion, CURDATE()) AS 'antiguedad', nombreDep as 'Nombre Departamento' ,
nombreCargo as 'Nombre Cargo', rangoCargo from empleados inner join departamento on empleados.departamentoEmp = idDep
inner join cargo on empleados.cargoEmp = idCargo;

/*todos los departamentos que no tengan empleados asignados*/
SELECT nombreDep FROM departamento WHERE idDep NOT IN (SELECT departamentoEmp FROM empleados);

/*todos los cargos que no tengan empleados asignados*/
SELECT nombreCargo FROM cargo WHERE idCargo NOT IN(SELECT cargoEmp from empleados);






