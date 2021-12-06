show databases;

SET sql_mode=(SELECT REPLACE(@@sql_mode,"ONLY_FULL_GROUP_BY","")); -- Comando usado para poder modificar tablar
drop database if exists vacunadoo;				   -- Comando para borrar una base de datos en caso de exist
create database vacunadoo;					   -- Comando para crear una base de datos

use vacunadoo;

/*===============================================Tablas===========================================================================*/
CREATE TABLE Usuario
(
  idUsuario INT AUTO_INCREMENT,
  Nombre varchar(50) NOT NULL,
  ApellidoP varchar(50) NOT NULL,
  ApellidoM varchar(50) NOT NULL,
  Edad INT NOT NULL,
  Genero varchar(20) NOT NULL,
  Folio varchar(50) NULL,
  Foto varchar(500) NULL,
  Correo varchar(50) NOT NULL,
  Contrasena varchar(10) NOT NULL,
  Altura float NOT NULL,
  Peso float NOT NULL,
  Alergias varchar(50) NULL,
  GrupoSanguineo varchar(10) NOT NULL,
  PRIMARY KEY (idUsuario),
  UNIQUE (Folio)
);

CREATE TABLE Vacunas
(
  idVacuna INT AUTO_INCREMENT,
  nombreVacuna varchar(1000) NOT NULL,
  Descripcion varchar(1000) NOT NULL,
  Logo varchar(1000) NOT NULL,
  Portada varchar(1000) NOT NULL,
  Eficacia nvarchar(1500) NOT NULL,
  Seguridad varchar(1000) NOT NULL,
  PRIMARY KEY (idVacuna)
);

CREATE TABLE Noticias
(
  idNoticias INT AUTO_INCREMENT,
  Titulo varchar(50) NOT NULL,
  Descripcion varchar(500) NOT NULL,
  URL varchar(50) NOT NULL,
  PRIMARY KEY (idNoticias),
  UNIQUE (URL)
);

CREATE TABLE ReaccionesAdversas
(
  idSintoma INT AUTO_INCREMENT,
  Descripción varchar(500) NOT NULL,
  Edad INT NOT NULL,
  Sintoma varchar(50) NOT NULL,
  PRIMARY KEY (idSintoma)
);

CREATE TABLE Foros
(
  idForo INT AUTO_INCREMENT,
  Nombre varchar(30) NOT NULL,
  idVacuna INT NOT NULL,
  PRIMARY KEY (idForo),
  FOREIGN KEY (idVacuna) REFERENCES Vacunas(idVacuna)
);

CREATE TABLE Mensajes
(
  idMensaje INT AUTO_INCREMENT,
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

CREATE TABLE Consulta
(
  idUsuario INT NOT NULL,
  idVacuna INT NOT NULL,
  PRIMARY KEY (idUsuario, idVacuna),
  FOREIGN KEY (idUsuario) REFERENCES Usuario(idUsuario),
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

insert into Vacunas values(1,"CanSino", "Es una vacuna de origen chino que fue disenada por el Instituto de 
    Biotecnoligia de Beijing y Cansino Biologics, es una vacuna basada en un adenovirus que suele causar 
    resfriados o sintomas similares y han sido modificados para que no te causen la enfermedad, a este adenovirus 
    se le integra una proteina del virus SARS-CoV-2 su aplicacion es en el brazo a personas a partir de los 18 anios", 
    "https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.gob.mx%2Fcms%2Fuploads%2Fattachment%2Ffile%2F597621%2FEstrategia_de_politica_exterior_contra_el_COVID-19_1.pdf&psig=AOvVaw06BGQdLMeiffQmwGRHOdN6&ust=1638771880161000&source=images&cd=vfe&ved=0CAsQjRxqFwoTCNit5ZaDzPQCFQAAAAAdAAAAABAJ", 
    "https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.capital21.cdmx.gob.mx%2Fnoticias%2F%3Fp%3D15783&psig=AOvVaw06BGQdLMeiffQmwGRHOdN6&ust=1638771880161000&source=images&cd=vfe&ved=0CAsQjRxqFwoTCNit5ZaDzPQCFQAAAAAdAAAAABAT", 
    "De acuerdo con la Secretaria de Salud, los resultados del analisis intermedio del ensayo clinico
    de Fase III de esta vacuna, mostraron que tiene una eficacia general del 68.83 por ciento para la 
    prevencion de todas las infecciones sintomaticas de COVID-19, 14 dias despues de la vacunacion. 
    Asi mismo, mostro una eficacia del 65.28 porciento 28 dias despues de su aplicacion. Sin embargo
    se requere una segunda dosis para un refuerzo pues a los 6 meses su eficacia decae a 50%, por otro lado
    los anticuerpos neutralizantes se mantienen altos en 70% de personas", "COFEPRIS autoriza el uso de emergencia para lotes
    envasados en Mexico de la vacuna CanSino, el biologico cumple con especificaciones requeridas para
    garantizar calidad, seguridad y eficancia, se realizaron las pruebas necesarias, incluyendo esterilidad,
    identidad y potencia, se comprobo que la vacuna en su presentacion envasada cumple con los requerimentos");
    
insert into Vacunas values(2, "Pfizer", "Es una vacuna desarrollada por Pfizer de Estados Unidos y BioNTech de 
    Alemania, es una vacuna de ARN mensajero lo que quiere decir que no contiene virus vivos sino que solo una 
    parte de una proteina del virus que provoca COVID-19 y no hace danio su aplicacion es en el brazo a personas a partir de los 18 anios",
    "https://coronavirus.utah.gov/wp-content/uploads/Pfizer-1-1-2-1.png?x50998",
    "https://i1.wp.com/hipertextual.com/wp-content/uploads/2021/04/vacuna-pfizer-coronavirus-scaled.jpeg?fit=2560%2C1439&ssl=1",
    "Segun los datos facilitados por el fabricante, la vacuna Pfizer-BioNTech ha demostrado tener una
    efectividad del 95% en un ensayo clinico a gran escala en curso. En cuanto a las nuevas variantes,
    el SAGE ha examinado todos los datos disponibles sobre la eficacia de esta vacuna contra diversas
    variantes, de acuerdo con los resultados obtenidos, es eficaz contra las variantes del virus SARS-COV-2.
    Las conclusiones preliminares ponen de relieve la necesidad urgente de adoptar un enfoque coordinado para la 
    vigilancia y la evaluacion de variantes y de sus posibles efectos en la eficacia de las vacunas.", 
    "La OMS autorizo la inclusion de la vacuna de Pfizer BioNTech contra la COVID-19 en la lista de uso 
    de emergencia. La OMS ha evaluado a fondo la calidad, la seguridad y la eficacia de esta vacuna y ha 
    recomendado su administración a personas mayores de 16 anios");
    
insert into Vacunas values(3, "SINOVAC", "Es una vacuna elaborada en la Republica Popular de China por el 
    laboratorio Sinovac, es una vacuna de virus inactivado, es decir de virus muertos que ya no tienen 
    capacidad de causar enfermedad, su aplicacion es en el brazo a personas a partir de los 18 anios, se
    requieren dos dosis para su completa proteccion",
    "https://enfarma.lat/images/noticias/2020-09/sinovac.jpg",
    "https://icdn.dtcn.com/image/digitaltrends_es/shutterstock_1827366647-416x416.jpg",
    "Segun la informacion proporcionada por el fabricante, la vacuna de SINOVAC ha demostrado tener una efectividad del
    51% contra la infeccion sintomatica. Ademas, ha demostrado tener una efectividad del 100% frente a la 
    hospitalizacion y el desarrollo gave de la enfermedad. En un gran ensayo internacional de fase III 
    realizado en Brasil se observo que la administracion de dos dosis de esta vacuna, separadas por un intervalo de 
    14 dias, protege con una eficacia del 51% contra la infeccion sintomatica por el SRAS-CoV-2; 3; 
    en cuanto la prevencion de la COVID-19 grave y de la hospitalizacion a los 14 dias de administrar 
    la segunda dosis, la eficacia de la vacuna fue del 100%. la eficacia estimada de la vacuna CoronaVac 
    de Sinovac contra la infeccion sintomática fue del 49,6%. También se demostro que la vacuna es eficaz 
    en un estudio observacional realizado en Sao Paulo (Brasil), donde circulaba tambien la variante
    P.1 (se detecto en el 83% de las muestras)", "El SAGE ha evaluado exhaustivamente los datos sobre la calidad, 
    la seguridad y la eficacia de la vacuna y ha recomendado su administracion a las personas de 18 
    anios y mas. Se dispone de pocos datos sobre la inocuidad de esta vacuna en personas mayores de 
    60 anios, debido al reducido numero de participantes en los ensayos clinicos. Aunque no se puede 
    anticipar que haya diferencias en el perfil de seguridad de la vacuna en los adultos mayores con 
    respecto a los grupos de edad mas jovenes, los paises que se planteen administrar esta vacuna a 
    personas mayores de 60 anios deben mantenerse vigilantes ante posibles efectos adversos. Como 
    parte del proceso de inclusion en la lista de uso en emergencias, Sinovac se ha comprometido a seguir 
    presentando datos sobre seguridad, eficacia y calidad procedentes de los ensayos en curso y de 
    la vacunacion de grupos poblacionales, incluidas las personas de edad avanzada.");

insert into Vacunas values(4, "Sputnik V", "Es una vacuna de origen Ruso desarrollada por el Instituto
    Gamaleya, esta basada en un adenovirus que suele causar resfriados y sintomas que suele causar 
    resfriados o sintomas similares y han sido modificados para que no te causen la enfermedad, a este adenovirus 
    se le integra una proteina del virus SARS-CoV-2, su aplicacion es en el brazo a personas a partir de los 
    18 anios, se requiere de dos dosis para su total proteccion", 
    "https://elperiodicodevillena.com/wp-content/uploads/2021/02/SputnikV.png",
    "https://ichef.bbci.co.uk/news/640/cpsprodpb/7CFC/production/_119769913_1.jpg",
    "La eficacia de la vacuna, confirmada por el analisis de los datos en el punto de control final de los ensayos
    clinicos, fue del 91.4%. La eficacia frente a los casos graves de infeccion por COVID-19 es del 100%.
    El efecto protector de la vacuna puede verse afectado por factores como el manejo no adecuado de la red de frio
    y tecnicas inadecuadas de aplicacion.", "Con el objetivo de asegurar una inmunidad duradera, cientificos rusos 
    han desarrollado la idea novedosa de usar dos tipos diferentes de vectores adenovirales (rAd26 y rAd5) 
    para la primera y segunda dosis de la vacuna, reforzando así su efecto inmunizador. El uso de adenovirus humanos 
    como vectores es seguro porque estos virus, que causan el resfriado comun, no son nuevos y existen desde hace miles de anios.");
    
insert into Vacunas values(5, "AstraZeneca", "Es una vacuna desarrollada en la Universidad de Oxford en conjunto
    con la farmaceutica britanica-sueca AztraZeneca, esta basada en un adenovirus que suele causar resfriados y sintomas que suele causar 
    resfriados o sintomas similares y han sido modificados para que no te causen la enfermedad, a este adenovirus 
    se le integra una proteina del virus SARS-CoV-2, su aplicacion es en el brazo a personas mayores a los 18 
    anios, se requiere de dos dosis para su proteccion total", 
    "https://upload.wikimedia.org/wikipedia/de/thumb/e/ee/AstraZeneca_logo.svg/2560px-AstraZeneca_logo.svg.png",
    "https://cdn-3.expansion.mx/dims4/default/8607d89/2147483647/strip/true/crop/1800x1110+0+0/resize/1200x740!/format/webp/quality/90/?url=https%3A%2F%2Fcdn-3.expansion.mx%2Ff4%2F13%2Fa34387c44f43bc215ae509022989%2F2020-11-23t185921z-2147405510-rc269k9y7kli-rtrmadp-3-health-coronavirus-astrazeneca-oxford.jpg",
    "Segun los datos facilitados por el fabricante, la vacuna de AstraZeneca-Oxford (AZD1222) ha 
    demostrado tener una efectividad del 63% en un ensayo clinico a gran escala en curso. Los intervalos de dosis mas 
    largos dentro del rango de 8 a 12 semanas se asocian con una mayor eficacia de la vacuna. Las conclusiones preliminares 
    ponen de relieve la necesidad urgente de adoptar un enfoque coordinado para la vigilancia y evaluación de variantes y sus 
    posibles efectos en la eficacia de las vacunas. A medida que se disponga de nuevos datos, la OMS actualizará las recomendaciones como corresponda.", 
    "La OMS ha clasificado la vacuna de Astrazeneca-Oxford como vacuna de emergencia, y los datos de 
    los ensayos clinicos a gran escala demuestran que es segura y eficaz. La EMA ha evaluado exhaustivamente los datos 
    sobre la calidad, seguridad y eficacia de la vacuna y ha recomendado que se conceda una autorizacion de comercializacion 
    condicional para las personas de 18 anios y mas.");
    
insert into Vacunas values (6, "Janssen", "Fue desarrollada en Estados Unidos por la farmaceutica Janssen de 
    Johnson & Johnson, esta basada en un adenovirus que suele causar resfriados y sintomas que suele causar 
    resfriados o sintomas similares y han sido modificados para que no te causen la enfermedad, a este adenovirus 
    se le integra una proteina del virus SARS-CoV-2, su aplicacion es en el brazo a personas mayores a los 18 
    anios, solo requiere una dosis",
    "https://semst.org/wp-content/uploads/2021/04/logo-janssen.gif",
    "https://phantom-marca.unidadeditorial.es/04d9e0f5167ff308a9dc52b73d86b3d3/resize/1320/f/jpg/assets/multimedia/imagenes/2021/05/12/16207973415931.jpg",
    "Segun los datos facilitados por el fabricante, la vacuna de Johnson & Johnson (Ad26.COV2.S) 
    ha demostrado tener una efectividad del 66.9% en un ensayo clinico a gran escala en curso. 28 
    dias despues de la inoculacion, se encontro que Janssen Ad26.CoV2.S tenia una eficacia del 85.4% contra la 
    enfermedad grave y del 93,1% contra la hospitalizacion. En ensayos clinicos se encontro que una dosis 
    unica de Janssen Ad26.COV2.S tiene una eficacia del 66,9% contra la infeccion sintomatica moderada y grave por SARS-CoV-2.", 
    "COFEPRIS emite autorizacion para uso de emergencia a vacuna contra COVID-19 Janssen, el Comite
    de Moleculas Nuevas sesiono el 7 de mayo de 2021 para analizar el uso de esta vacuna, la cual recibio 
    una opinion favorable de manera unanime por parte de las y los expertos. Esta autorizacion de 
    uso de emergencia certifica que la vacuna cumple los requisitos de calidad, seguridad y eficacia 
    necesarios para ser aplicada");

insert into Vacunas values (7, "Spikevax (Moderna)", "Es producida por la farmaceutica Moderna de Estados Unidos,
    es una vacuna de ARN mensajero lo que quiere decir que no contiene virus vivos sino que solo una parte de una 
    proteina del virus que provoca COVID-19 y no hace danio su aplicacion es en el brazo a personas a 
    partir de los 18 anios, se requiere de dos dosis para su proteccion completa", 
    "https://semst.org/wp-content/uploads/2021/04/logomoderna-1200x913.jpg",
    "https://img2.rtve.es/imagenes/logotipo-farmaceutica-moderna-junto-frasco-vacuna-imagen-archivo/1608041409942.jpg",
    "Segun los datos facilitados por el fabricante, la vacuna de Moderna (mRNA-1273) ha demostrado 
    tener una efectividad del 94.1% en un ensayo clinico a gran escala en curso. La vacuna tambien 
    demostro tener un alto nivel de efectividad en los ensayos clinicos en la prevencion del COVID-19
    entre personas de diferentes categorias de edad, sexo, raza y etnia, y entre personas con afecciones 
    subyacentes. La evidencia demuestra que las vacunas de ARNm contra el COVID-19 ofrecen una proteccion 
    similar en condiciones reales a la que ofrecen en los entornos de ensayos clinicos, reduciendo 
    el riesgo en un 90 % o más de que las personas que recibieron la vacuna completa se infecten o enfermen gravemente a 
    causa del COVID-19.", "COFEPRIS emite autorizacion para uso de emergencia a vacuna moderna. 
    El Comite de Moleculas Nuevas (CMN) sesiono el 16 de agosto de 2021 para analizar el uso de esta 
    vacuna, la cual recibió una opinion favorable de manera unanime por parte de las y los expertos.
    Después de integrar la opinion del CMN, la solicitud de autorizacion para uso de emergencia fue presentada 
    a la Comision de Autorizacion Sanitaria, donde dictaminadores especializados realizaron una revision 
    de los expedientes, certificando que el biologico cumple los requisitos de calidad, seguridad y eficacia 
    necesarios para ser aplicado.");
    
/*Procedimiento (Procedure) para el INICIO DE SESION*/
drop procedure if exists spIniciarSesion;
delimiter |
create procedure spIniciarSesion(in usr varchar(50), contra varchar(10))
begin
	declare existe, id int;
    declare msj varchar(200);
    
    set existe = (select count(*) from Usuario where Correo = usr and Contraseña = contra);
    if(existe = 1) then
        set id=(select idUsuario from Usuario where Correo = usr and  Contraseña = contra);
        select id;
    else
		if(existe=0)then
     set msj="Correo o contraseña incorrecto";
      select msj;
		end if;
    end if;
end; |
delimiter ;

show tables from vacunadoo;
select * from Vacunas;

select * from Usuario;