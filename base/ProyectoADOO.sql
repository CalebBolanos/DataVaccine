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
  Alergias varchar(50) NULL,
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
  Folio varchar(50) NULL,
  Foto varchar(500) NOT NULL,
  Correo varchar(50) NOT NULL,
  Contraseña varchar(10) NOT NULL,
  idDatos INT NOT NULL,
  PRIMARY KEY (idUsuario),
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
  idUsuario INT NOT NULL,
  idVacuna INT NOT NULL,
  PRIMARY KEY (idUsuario, idVacuna),
  FOREIGN KEY (idUsuario) REFERENCES Usario(idUsuario),
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

/*===============================================Insert===========================================================================*/

insert into Vacunas values(1,"Cansino", "Es una vacuna de origen chino que fue diseñada por el Instituto de 
    Biotecnoligia de Beijing y Cansino Biologics, es una vacuna basada en un adenovirus que suele causar 
    resfriados o sintomas similares y han sido modificados para que no te causen la enfermedad, a este adenovirus 
    se le integra una proteina del virus SARS-CoV-2 su aplicacion es en el brazo a personas a partir de los 18 años", 
    "https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.gob.mx%2Fcms%2Fuploads%2Fattachment%2Ffile%2F597621%2FEstrategia_de_politica_exterior_contra_el_COVID-19_1.pdf&psig=AOvVaw06BGQdLMeiffQmwGRHOdN6&ust=1638771880161000&source=images&cd=vfe&ved=0CAsQjRxqFwoTCNit5ZaDzPQCFQAAAAAdAAAAABAJ", 
    "https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.capital21.cdmx.gob.mx%2Fnoticias%2F%3Fp%3D15783&psig=AOvVaw06BGQdLMeiffQmwGRHOdN6&ust=1638771880161000&source=images&cd=vfe&ved=0CAsQjRxqFwoTCNit5ZaDzPQCFQAAAAAdAAAAABAT", 
    "90%", "Aprobada por el Gobierno de Mexico",1);
    
insert into Vacunas values(2, "Pfizer", "Es una vacuna desarrollada por Pfizer de Estados Unidos y BioNTech de 
    Alemania, es una vacuna de ARN mensajero lo que quiere decir que no contiene virus vivos sino que solo una 
    parte de una proteina del virus que provoca COVID-19 y no hace daño su aplicacion es en el brazo a personas a partir de los 18 años",
    "https://coronavirus.utah.gov/wp-content/uploads/Pfizer-1-1-2-1.png?x50998",
    "https://i1.wp.com/hipertextual.com/wp-content/uploads/2021/04/vacuna-pfizer-coronavirus-scaled.jpeg?fit=2560%2C1439&ssl=1",
    "95%", "Aprobadas para el uso en Mexico, se considera segura y efectiva",2);
    
insert into Vacunas values(3, "SINOVAC", "Es una vacuna elaborada en la Republica Popular de China por el 
    laboratorio Sinovac, es una vacuna de virus inactivado, es decir de virus muertos que ya no tienen 
    capacidad de causar enfermedad, su aplicacion es en el brazo a personas a partir de los 18 años, se
    requieren dos dosis para su completa proteccion",
    "https://enfarma.lat/images/noticias/2020-09/sinovac.jpg",
    "https://icdn.dtcn.com/image/digitaltrends_es/shutterstock_1827366647-416x416.jpg",
    "91%", "Aprobadas para el uso en Mexico, considerada segura y efectiva", 3);

insert into Vacunas values(4, "Sputnik V", "Es una vacuna de origen Ruso desarrollada por el Instituto
    Gamaleya, esta basada en un adenovirus que suele causar resfriados y sintomas que suele causar 
    resfriados o sintomas similares y han sido modificados para que no te causen la enfermedad, a este adenovirus 
    se le integra una proteina del virus SARS-CoV-2, su aplicacion es en el brazo a personas a partir de los 
    18 años, se requiere de dos dosis para su total proteccion", 
    "https://elperiodicodevillena.com/wp-content/uploads/2021/02/SputnikV.png",
    "https://ichef.bbci.co.uk/news/640/cpsprodpb/7CFC/production/_119769913_1.jpg",
    "91.4% - 100%", "Aprobadas para el uso en Mexico, considerada segura y efectiva", 4);
    
insert into Vacunas values(5, "AstraZeneca", "Es una vacuna desarrollada en la Universidad de Oxford en conjunto
    con la farmaceutica britanica-sueca AztraZeneca, esta basada en un adenovirus que suele causar resfriados y sintomas que suele causar 
    resfriados o sintomas similares y han sido modificados para que no te causen la enfermedad, a este adenovirus 
    se le integra una proteina del virus SARS-CoV-2, su aplicacion es en el brazo a personas mayores a los 18 
    años, se requiere de dos dosis para su proteccion total", 
    "https://upload.wikimedia.org/wikipedia/de/thumb/e/ee/AstraZeneca_logo.svg/2560px-AstraZeneca_logo.svg.png",
    "https://cdn-3.expansion.mx/dims4/default/8607d89/2147483647/strip/true/crop/1800x1110+0+0/resize/1200x740!/format/webp/quality/90/?url=https%3A%2F%2Fcdn-3.expansion.mx%2Ff4%2F13%2Fa34387c44f43bc215ae509022989%2F2020-11-23t185921z-2147405510-rc269k9y7kli-rtrmadp-3-health-coronavirus-astrazeneca-oxford.jpg",
    "63%", "Aprobadas para el uso en Mexico, considerada segura y efectiva", 5);
    
insert into Vacunas values (6, "Janssen", "Fue desarrollada en Estados Unidos por la farmaceutica Janssen de 
    Johnson & Johnson, esta basada en un adenovirus que suele causar resfriados y sintomas que suele causar 
    resfriados o sintomas similares y han sido modificados para que no te causen la enfermedad, a este adenovirus 
    se le integra una proteina del virus SARS-CoV-2, su aplicacion es en el brazo a personas mayores a los 18 
    años, solo requiere una dosis",
    "https://semst.org/wp-content/uploads/2021/04/logo-janssen.gif",
    "https://phantom-marca.unidadeditorial.es/04d9e0f5167ff308a9dc52b73d86b3d3/resize/1320/f/jpg/assets/multimedia/imagenes/2021/05/12/16207973415931.jpg",
    "66.9%", "Aprobadas para el uso en Mexico, considerada segura y efectiva", 6);

insert into Vacunas values (7, "Spikevax (Moderna)", "Es producida por la farmaceutica Moderna de Estados Unidos,
    es una vacuna de ARN mensajero lo que quiere decir que no contiene virus vivos sino que solo una parte de una 
    proteina del virus que provoca COVID-19 y no hace daño su aplicacion es en el brazo a personas a 
    partir de los 18 años, se requiere de dos dosis para su proteccion completa", 
    "https://semst.org/wp-content/uploads/2021/04/logomoderna-1200x913.jpg",
    "https://img2.rtve.es/imagenes/logotipo-farmaceutica-moderna-junto-frasco-vacuna-imagen-archivo/1608041409942.jpg",
    "94.1%", "Aprobadas para el uso en Mexico, considerada segura y efectiva", 7);

show tables from vacunadoo;
select * from Vacunas;