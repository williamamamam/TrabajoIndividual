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
references Mascota(idMascota);

alter table Mascota_Vacuna
add constraint FKVM
foreign key (codigoVacunaFK)
references Vacuna(codigoVacuna);

select * from mascota;

insert into Mascota values(3,'gordito','M','Bulldog',2),(5,'añañin','F','Poodle',5),(85,'maxili','F','Beagle',3),(15,'godoy','M','Chihuahua',3),(487,'estupiñna','F','Husky',3),(46,'goku','F','Malamute de Alaska',8),(49,'pony','F','Dachshund',13);
insert into Mascota values(567,'etesech','M','Golden Retriever',45),(542,'coco','F','Pastor Aleman', 56);

insert into Vacuna values(12828373,'Peninsilina',3,'Sifilis');
insert into Vacuna values(17944963,'Peninsilina',3,'Sifilis'),(12457373,'Tetanos',1,'Rabia'),(185473,'Herpes',9,'Herpes'),(1245273,'Paravirosis',4,'Virus'),(18479373,'Hepatitis',8,'Dolor abdominal'),(1454788,'Moquillo',7,'Asma'),(112565778,'Peninsilina',3,'Sifilis'),(41487521,'Peninsilina',3,'Sifilis'),(136475,'Peninsilina',3,'Sifilis'),(14788478,'Diarrea',3,'Dolor estomacal');

select * from vacuna;

insert into Producto values(1,'Alimento','H&B',1500,104818);
insert into Producto values(2,'Correa','H&M',1300,1031658),(3,'Juguete','Play Doh',1000,106448),(4,'Casa','Alkosto',15000,1148752), (5,'Tapete','DollarCity',500,1005448) ;
select * from producto;

insert into Cliente values(1031658,'William','Ramirez','Cra 69 B ',322783087, 3);
insert into Cliente values(104818,'Juan','Perez','Cll 81 ',315478217, 5),(106448,'Mariana','Rojas','Trv 281 ',301478598, 85),(1148752,'Juan','Cuesta','Dia 73 # ',3140147859, 15),(1005448,'Juan','Arroyo','Cll 19 A ',314785922, 487);
describe cliente;

select * from cliente;

insert into Mascota_Vacuna values(12828373,3,'Cancer');
insert into Mascota_Vacuna values(17944963,5,'Sifilis'),(12457373,85,'Alzheimeir'),(185473,15,'Hambre'),(1245273,487,'Diarrea');
select * from mascota_vacuna;



