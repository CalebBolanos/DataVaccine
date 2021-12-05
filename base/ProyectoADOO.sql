SET sql_mode=(SELECT REPLACE(@@sql_mode,"ONLY_FULL_GROUP_BY","")); -- Comando usado para poder modificar tablar
drop database if exists vacunadoo;				   -- Comando para borrar una base de datos en caso de exist
create database vacunadoo;					   -- Comando para crear una base de datos

use vacunadoo;

/*===============================================Tablas===========================================================================*/
CREATE TABLE DatosMedicos
(
  idDatos INT NOT NULL,
  Altura float NOT NULL,
  Peso float NOT NULL,
  Alergias varchar(50) NOT NULL,
  TipoSangre varchar(10) NOT NULL,
  PRIMARY KEY (idDatos)
);

CREATE TABLE Noticias
(
  idNoticias INT NOT NULL,
  Titulo varchar(50) NOT NULL,
  Descripcion varchar(500) NOT NULL,
  URL varchar(50) NOT NULL,
  PRIMARY KEY (idNoticias),
  UNIQUE (URL)
);

CREATE TABLE ReaccionesAdversas
(
  idSintoma INT NOT NULL,
  Descripción varchar(500) NOT NULL,
  Edad INT NOT NULL,
  Sintoma varchar(50) NOT NULL,
  PRIMARY KEY (idSintoma)
);

CREATE TABLE Foros
(
  idForo INT NOT NULL,
  Nombre varchar(30) NOT NULL,
  PRIMARY KEY (idForo)
);

CREATE TABLE Mensajes
(
  idMensaje INT NOT NULL,
  Titulo varchar(50) NOT NULL,
  Contenido varchar(500) NOT NULL,
  Imagen varchar(500) NOT NULL,
  PRIMARY KEY (idMensaje)
);

CREATE TABLE cubren
(
  idForo INT NOT NULL,
  idMensaje INT NOT NULL,
  PRIMARY KEY (idForo, idMensaje),
  FOREIGN KEY (idForo) REFERENCES Foros(idForo),
  FOREIGN KEY (idMensaje) REFERENCES Mensajes(idMensaje)
);

CREATE TABLE Usario
(
  idUsuario INT NOT NULL,
  Nombre varchar(50) NOT NULL,
  ApellidoP varchar(50) NOT NULL,
  ApellidoM varchar(50) NOT NULL,
  Edad INT NOT NULL,
  Genero varchar(20) NOT NULL,
  Folio varchar(50) NOT NULL,
  Foto varchar(500) NOT NULL,
  Correo varchar(50) NOT NULL,
  Contraseña varchar(10) NOT NULL,
  idDatos INT NOT NULL,
  PRIMARY KEY (idCliente),
  FOREIGN KEY (idDatos) REFERENCES DatosMedicos(idDatos),
  UNIQUE (Folio)
);

CREATE TABLE Vacunas
(
  idVacuna INT NOT NULL,
  nombreVacuna varchar(1000) NOT NULL,
  Descripcion varchar(1000) NOT NULL,
  Logo varchar(1000) NOT NULL,
  Portada varchar(1000) NOT NULL,
  Eficacia nvarchar(1000) NOT NULL,
  Seguridad varchar(1000) NOT NULL,
  idForo INT NOT NULL,
  PRIMARY KEY (idVacuna),
  FOREIGN KEY (idForo) REFERENCES Foros(idForo)
);

CREATE TABLE Consulta
(
  idCliente INT NOT NULL,
  idVacuna INT NOT NULL,
  PRIMARY KEY (idCliente, idVacuna),
  FOREIGN KEY (idCliente) REFERENCES Usario(idCliente),
  FOREIGN KEY (idVacuna) REFERENCES Vacunas(idVacuna)
);

CREATE TABLE Recaban
(
  idVacuna INT NOT NULL,
  idNoticias INT NOT NULL,
  PRIMARY KEY (idVacuna, idNoticias),
  FOREIGN KEY (idVacuna) REFERENCES Vacunas(idVacuna),
  FOREIGN KEY (idNoticias) REFERENCES Noticias(idNoticias)
);	

CREATE TABLE Generan
(
  idVacuna INT NOT NULL,
  idSintoma INT NOT NULL,
  PRIMARY KEY (idVacuna, idSintoma),
  FOREIGN KEY (idVacuna) REFERENCES Vacunas(idVacuna),
  FOREIGN KEY (idSintoma) REFERENCES ReaccionesAdversas(idSintoma)
);

show tables from vacunadoo;