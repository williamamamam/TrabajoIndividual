create database votaciones2503816;
use votaciones2503816;
drop database votaciones2503816;
set SQL_SAFE_UPDATES = 0;

create table usuario(
idUsuario int primary key not null auto_increment,
noDocUsuario int not null,
idTipoDocFK int,
nombreUsuario VARCHAR(10) not null,
apellidoUsuario VARCHAR(10) not null,
idGeneroFK int,
fechaNacUsuario date not null,
emailUsuario VARCHAR(30) not null,
passwordUsuario VARCHAR(20)	not null,
fotoUsuario blob null,
idJornadaFK int,
idTipoMiembroFK int,
idCursoFK int,
estadoU VARCHAR(5) not null
);

alter table usuario
modify column nombreUsuario VARCHAR(30) not null,
modify column apellidoUsuario VARCHAR(30) not null
;

alter table usuario
modify column noDocUsuario VARCHAR(10) not null;

alter table usuario
modify column emailUsuario VARCHAR(30) null,
modify column passwordUsuario VARCHAR(15) null;


create table curso(
idCurso int primary key not null auto_increment,
nomCurso VARCHAR(20) not null,
estadoCu VARCHAR(10) not null
);

alter table usuario
add constraint FKidCurso
foreign key (idCursoFK)
references curso(idCurso);

create table eleccion(
idEleccion int primary key not null auto_increment,
fechaEleccion date not null,
anioEleccion year not null, 
estadoEL VARCHAR(5) not null
);

create table jornada(
idJornada int primary key not null auto_increment,
nomJornada VARCHAR(10) not null,
estadoJ VARCHAR(5) not null
);

alter table usuario
add constraint FKidJornada
foreign key (idJornadaFK)
references jornada(idJornada);

create table genero(
idGenero int primary key not null auto_increment,
nomGenero VARCHAR(10) not null,
estadoG VARCHAR(5) not null
);

alter table usuario
add constraint FKidGenero
foreign key (idGeneroFK)
references genero(idGenero);

create table concejo(
idConcejo int primary key not null auto_increment,
nomConcejo VARCHAR(10) not null,
estadoCO VARCHAR(5) not null
);

alter table concejo 
modify column nomConcejo VARCHAR(30) not null;

create table votacion(
idVotacion int primary key not null auto_increment,
horaVotacion VARCHAR(10) not null,
idUsuarioVotanteFK int ,
idPostCandidatoFK int ,
estadoV VARCHAR(10) not null
);

ALTER TABLE votacion  
MODIFY COLUMN horaVotacion TIME NOT NULL;

alter table votacion 
add constraint FKidUsuarioVotante
foreign key (idUsuarioVotanteFK)
references usuario(idUsuario);

alter table votacion 
add constraint FKidPostCandidato
foreign key (idPostCandidatoFK)
references postulacionCandidato(idPostCandidato);

create table tipoDocumento(
idTipoDoc int primary key not null auto_increment,
nomTipoDoc VARCHAR(10) not null,
estadoTD VARCHAR(5) not null
);

alter table tipoDocumento
modify column nomTipoDoc VARCHAR(30) not null;

alter table usuario
add constraint FKidTipoDoc
foreign key (idTipoDocFK)
references tipoDocumento(idTipoDoc);

create table tipoMiembro(
idTipoMiembro int primary key not null auto_increment,
nomTipoMiembro VARCHAR(10) not null,
estadoTM VARCHAR(5) not null
);

alter table usuario
add constraint FKidTipoMiembro
foreign key (idTipoMiembroFK)
references tipoMiembro(idTipoMiembro);

create table cargo(
idCargo int primary key not null auto_increment,
nomCargo varchar(10) not null,
idConcejoFK int,
estadoC VARCHAR(5) not null
);

alter table cargo
add constraint FKidConcejo 
foreign key (idConcejoFK)
references concejo(idConcejo);

create table postulacionCandidato(
idPostCandidato int primary key not null auto_increment,
idUsuarioFK int,
idEleccionFK int,
idCargoFK int, 
propuestas VARCHAR(50) not null,
totalVotos int not null,
estadoCan VARCHAR(10) not null
);

alter table postulacionCandidato
add constraint FKidUsuario
foreign key (idUsuarioFK)
references usuario(idUsuario);

alter table postulacionCandidato
add constraint FKidEleccion
foreign key (idEleccionFK)
references eleccion(idEleccion);

alter table postulacionCandidato
add constraint FKidCargo
foreign key (idCargoFK)
references cargo(idCargo);

/*--------------------------------------INSERCIONES-------------------------------------------------------------*/

insert into genero(idGenero,nomGenero,estadoG) 
values ('','Femenino','true'),('','Masculino','false');

insert into jornada(idJornada,nomJornada,estadoJ)
values('','Mañana','true'),('','Tarde','true'),('','Noche','true');

insert into TipoDocumento(idTipoDoc,nomTipoDoc,estadoTD)
values('','Tarjeta de Identidad','true'),('','Cédula Ciudadania','true'),('','Cédula Extranjeria','true'),
('','Pasaporte','true'),('','NUIP','true');

insert into TipoMiembro(idTipoMiembro,nomTipoMiembro,estadoTM)
values('','Estdudiante','true'),('','Profesor','true'),('','Acudiente','true');

insert into curso(idCurso,nomCurso,estadoCu)
values('','901','true'),('','902','true'),('','1001','true'),('','1002','true'),('','1003','true')
,('','1101','true'),('','1102','true'),('','1103','true');

insert into concejo(idConcejo,nomConcejo,estadoCO)
values('','Concejo Académico','true'),('','Concejo Directivo','true'),('','Concejo Convivencia','true');

insert into cargo(idCargo,nomCargo,idConcejoFK,estadoC)
values('','Personero',1,'true'),('','Contralor',1,'true'),('','Cabildante',1,'true');

insert into eleccion(idEleccion,fechaEleccion,anioEleccion,estadoEL)
values('','2020-04-20','2020','true'),('','2019-04-15','2019','true'),('','2019-04-12','2019','true'),
('','2018-04-14','2018','true'),('','2017-04-12','2017','true');

insert into usuario(idUsuario,noDocUsuario,idTipoDocFK,nombreUsuario,apellidoUsuario,idGeneroFK,fechaNacUsuario,
emailUsuario,passwordUsuario,fotoUsuario,idJornadaFK,idTipoMiembroFK,idCursoFK,estadoU) values
('','1',1,'VOTO','BLANCO',2,'0000-00-00',null,null,null,1,1,3,'true'),('','1010123456',1,'DAVID SANTIAGO','LÓPEZ MORA',2,'2004-10-11','davidLopez456@hotmail.com','David2004',
null,1,1,1,'true'),('','1010123789',1,'LAURA MILENA','GOMEZ BONILLA',1,'2004-03-17','lauragomez@gmail.com','Gomez2004',
null,1,1,1,'true'),('','1010123741',1,'DIEGO FERNANDO','CAÑON VARGAS',2,'2003-05-20','diegocanon@hotmail.com','Diego2003',
null,1,1,1,'true'),('','1010123852',1,'TATIANA','VARGAS CABRERA',1,'2003-11-28','tatacabrera@gmail.com','Cabrera2003',
null,1,1,3,'true'),('','1010123963',1,'LEYDY KATHERINE','FERNANDEZ RODRIGUEZ',1,'2004-06-28','leydy2004@gmail.com','Leydy2004',
null,1,1,4,'true'),('','1010123654',2,'MAURICIO','BERMUDEZ AMAYA',2,'2002-01-26','maobermudez@gmail.com','Amaya2002',
null,1,1,4,'true'),('','1010741258',1,'ANDRES FELIPE','RODRIGUEZ PEREZ',2,'2004-03-23','andyrodriguez@gmail.com','Arodriguez2004',
null,1,1,3,'true'),('','1010236859',1,'MARIA ANGÉLICA','TRIVIÑO LATORRE',1,'2002-02-04','angelicatri@gmail.com','Trivino2002',
null,1,1,3,'true'),('','1010236963',1,'GENARO','VASQUEZ RODRIGUEZ',2,'2002-11-14','gevasquez@gmail.com','Vasquez123',
null,1,1,3,'false');

insert into votacion(idVotacion,horaVotacion,idUsuarioVotanteFK,idPostCandidatoFK,estadoV) values
('','12:08:15',1,1,'true'),('','12:12:35',2,3,'true'),('','12:14:18',3,2,'true'),('','12:15:58',4,2,'true'),
('','12:18:02',5,3,'true'),('','12:24:22',6,3,'true'),('','12:28:02',7,3,'true'),('','12:30:14',8,2,'true'),
('','12:40:20',9,2,'true'),('','12:45:20',10,2,'true');

insert into postulacioncandidato(idPostCandidato,idUsuarioFK,idEleccionFK,idCargoFK,propuestas,totalVotos,estadoCan)
values('',1,1,1,'Mejorar entrega refrigerios, Alargar descansos',0,'true'),
('',2,5,1,'Mejorar entrega refrigerios, Alargar descansos',0,'true'),
('',7,1,1,'Mejorar sala de informática, Construir piscina',0,'true');

SELECT * from usuario;

select co.nomConcejo as 'Nombre Concejo' , c.nomCargo as 'Nombre Cargo', c.estadoC as 'Estado Cargo'
from concejo co inner join cargo c on co.idConcejo = c.idConcejoFK;

select co.nomConcejo as 'Nombre Concejo' , c.nomCargo as 'Nombre Cargo', c.estadoC as 'Estado Cargo'
from concejo co left join cargo c on co.idConcejo = c.idConcejoFK;

select u.nombreUsuario as 'Usuario', j.nomJornada as 'jornada', tm.nomTipoMiembro as 'Tipo de Miembro',
c.nomCurso as 'Curso' from usuario u inner join jornada j on u.idJornadaFK = j.idJornada
inner join tipoMiembro tm on u.idTipoMiembroFK = tm.idTipoMiembro
inner join curso c on u.idCursoFK = c.idCurso;

select count(can.totalVotos) as 'Total Votos', u.nombreUsuario as 'Candidato' from postulacionCandidato can
inner join usuario u on can.idUsuarioFK = u.idUsuario
group by u.nombreUsuario;

select u.nombreUsuario as 'Candidato', count(v.idVotacion) as 'Total Votos' from votacion v
inner join postulacioncandidato can on v.idPostCandidatoFK = can.idPostCandidato
inner join usuario u on v.idUsuarioVotanteFK = u.idUsuario
group by u.nombreUsuario;

