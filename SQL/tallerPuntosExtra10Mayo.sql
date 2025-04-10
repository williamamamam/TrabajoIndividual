drop database BDmental;
create database BDmental;
use BDmental;


create table usuario(
idUsuario int primary key auto_increment,
nomUsuario VARCHAR(20) NOT NULL,
correoUsuario varchar(40) not null,
contraseñaUsuario varchar(20) not null,
nacimientoUsuario date not null,
generoUsuario enum('Masculino','Femenino','otro'),
idSesionFK int,
idBitacoraFK int,
idRecordatorioFK int,
idTareaFK int,
idComunidadFK int
);

create table sesion(
idSesion int primary key auto_increment,
tituloSesion varchar(40) not null,
duracionSesion varchar(20) not null,
dificultadSesion enum ('Basico','Intermedio','Avanzado'),
descripcionSesion varchar(40) not null
);

create table bitacora(
idBitacora int primary key auto_increment,
fechaBitacora date not null,
estadoEmocional varchar(20) not null,
notaPersonal varchar(50) not null,
recomendaciones varchar(50) not null
);

create table recordatorio(
idRecordatorio int primary key auto_increment,
nombreRecordatorio varchar(20),
descripcionRecordatorio varchar(50),
fechaRecordatorio date not null
);

create table tarea(
idTarea int primary key auto_increment,
nombreTarea date not null,
descripcionTarea varchar(50) not null,
fechaEntregaTarea date not null,
prioridadTarea int not null,
estadoTarea enum('Pendiente','En progreso','Completada')
);

create table comunidad(
idComunidad int primary key auto_increment,
tematicaApoyo enum('Concentracion','Ansiedad','Gestion del tiempo')
);

create table grupoUsuario(
idGrupoUsuario int primary key auto_increment,
idComunidadFK int,
idUsuarioFK int
);

alter table usuario
add constraint FKidSesion
foreign key (idSesionFK)
references sesion(idSesion)
on delete cascade;

alter table usuario
add constraint FKidBitacora
foreign key (idBitacoraFK)
references bitacora(idBitacora)
on delete cascade;

alter table usuario
add constraint FKidRecordatorio
foreign key (idRecordatorioFK)
references recordatorio(idRecordatorio)
on delete cascade;

alter table usuario
add constraint FKidTarea
foreign key (idTareaFK)
references tarea(idTarea)
on delete cascade;

alter table usuario
add constraint FKidComunidad
foreign key (idComunidadFK)
references comunidad(idComunidad)
on delete cascade;

alter table sesion
add column estadoSesion enum('Completada','En curso','Sin Comenzar'),
add column fechaSesion date;
truncate usuario;

insert into sesion(tituloSesion,duracionSesion,dificultadSesion,descripcionSesion,estadoSesion,fechaSesion)
values('Calma visual','1 H 20 MIN','5/10','charla importancia de la calma','Completada','2020-05-05'),
('Control Enojo','4 H','810','discusion formas control de enojo','Sin Comenzar','2022-08-12');

insert into bitacora(fechaBitacora,estadoEmocional,notaPersonal,recomendaciones)
values('2024-03-08','Tristeza','Perdi un parcial muy importante','Tomar aire, buscar amigos o familiares'),
('2021-01-05','Furia','Mi hermano esta muy herido','Tener actitud positiva');

insert into tarea(nombreTarea,descripcionTarea,fechaEntregaTarea,prioridadTarea,estadoTarea)
values('Taller Fisica','Taller de MRU de 20 puntos','2024-05-06',5,'Completada'),('Trabajo Artes','Pintura con oleos','2025-01-09',5,'En progreso');

insert into recordatorio(nombreRecordatorio,descripcionRecordatorio,fechaRecordatorio) values ('Entrega taller fisica','Taller de MRU de 20 puntos','2024-05-06'),
('Trabajo Artes','Pintura con oleos','2025-01-09');

insert into comunidad(tematicaApoyo) values ('Ansiedad'),('Miedo');

insert into usuario(nomUsuario,correoUsuario,contraseñaUsuario,nacimientoUsuario,generoUsuario,idSesionFK,idBitacoraFK,idRecordatorioFK,idTareaFK,idComunidadFK)
 values('William','william@gmail.com','billywarm','2006-08-09','Masculino',1,1,1,1,1),
 ('Juan','juan@gmail.com','juankeku','2007-03-01','Masculino',2,2,2,2,2) ;
 

insert into grupoUsuario(idComunidadFK,idUsuarioFK) values (1,1),(2,2);

select * from usuario;
select * from bitacora;
select * from grupousuario;
select * from sesion;
select * from comunidad;

select tituloSesion, estadoSesion from usuario inner join sesion on idSesionFK = idSesion where estadoSesion = 'Sin Completar';

DELIMITER //
create procedure agregarBitacora(
	in b_idBitacora int,
    in b_estadoEmocional varchar(20),
    in b_notaPersonal varchar(20),
    in b_recomendaciones varchar(20)
)
begin 