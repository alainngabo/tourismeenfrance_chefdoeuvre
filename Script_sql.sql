#création de la base de donnée tourisme

drop database if exists tourisme;
create database if not exists tourisme;
use tourisme;


 CREATE TABLE regions(
   code_region INT,
   nom_region VARCHAR(200),
   Territoire VARCHAR(200)
); 

CREATE TABLE table_date(
   id_date INT,
   annee INT,
   mois VARCHAR(50),
   trimestre INT
);

CREATE TABLE categorie_touriste(
   id_categorie int,
   categorie VARCHAR(200)
);  

CREATE TABLE region_depart(
   id_provenance INT,
   provenance VARCHAR(400)
); 

CREATE TABLE departement(
   code_departement VARCHAR(50),
   nom_departement VARCHAR(200),
   code_region INT NOT NULL
);

CREATE TABLE zone_origine_touristes(
   id_date INT,
   id_provenance INT,
   quantite INT,
   destination VARCHAR(400)
);   

CREATE TABLE indicateurs_sejour(
   id_date INT,
   id_categorie int,
   code_departement VARCHAR(50),
   arrivees float,
   nuitees float
); 

CREATE TABLE occupation_hotel(
   id_date INT,
   code_departement VARCHAR(50),
   taux_occupation float
); 

#insertion des clés primaires 

Alter table regions add PRIMARY KEY(code_region);
alter table table_date add  PRIMARY KEY(id_date);
alter table categorie_touriste add PRIMARY KEY(id_categorie);
alter table region_depart add  PRIMARY KEY(id_provenance);
alter table departement add PRIMARY KEY(code_departement);
alter table zone_origine_touristes add PRIMARY KEY(id_date, id_provenance);
alter table indicateurs_sejour add PRIMARY KEY(id_date, id_categorie, code_departement);
alter table occupation_hotel add PRIMARY KEY(id_date, code_departement);


#connection avec les données contenues dans des fichiers csv et enregistrées en local 
#afin de les insérer dans mes tables

SET GLOBAL local_infile=1;
LOAD DATA LOCAL INFILE 'C:/Users/Alain NGABO/Dropbox/SIMPLON/Chefdoeuvre/data_propre/regions.csv' 
INTO TABLE regions
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

LOAD DATA LOCAL INFILE 'C:/Users/Alain NGABO/Dropbox/SIMPLON/Chefdoeuvre/data_propre/table_date.csv'  
INTO TABLE table_date
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

LOAD DATA LOCAL INFILE 'C:/Users/Alain NGABO/Dropbox/SIMPLON/Chefdoeuvre/data_propre/categorie_touriste.csv'  
INTO TABLE categorie_touriste
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

LOAD DATA LOCAL INFILE 'C:/Users/Alain NGABO/Dropbox/SIMPLON/Chefdoeuvre/data_propre/region_depart.csv'  
INTO TABLE region_depart
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

LOAD DATA LOCAL INFILE 'C:/Users/Alain NGABO/Dropbox/SIMPLON/Chefdoeuvre/data_propre/departement.csv'  
INTO TABLE departement
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

LOAD DATA LOCAL INFILE 'C:/Users/Alain NGABO/Dropbox/SIMPLON/Chefdoeuvre/data_propre/zone_origine_touristes.csv'  
INTO TABLE zone_origine_touristes
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

LOAD DATA LOCAL INFILE 'C:/Users/Alain NGABO/Dropbox/SIMPLON/Chefdoeuvre/data_propre/indicateurs_sejour.csv'  
INTO TABLE indicateurs_sejour
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

LOAD DATA LOCAL INFILE 'C:/Users/Alain NGABO/Dropbox/SIMPLON/Chefdoeuvre/data_propre/occupation_hotel.csv'  
INTO TABLE occupation_hotel
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;


#Insertion des clés étrangères 

SET FOREIGN_KEY_CHECKS=0;
Alter table departement add FOREIGN KEY(code_region) REFERENCES regions(code_region);
alter table zone_origine_touristes add FOREIGN KEY(id_date) REFERENCES table_date(id_date);
alter table zone_origine_touristes add  FOREIGN KEY(id_provenance) REFERENCES region_depart(id_provenance);
alter table indicateurs_sejour add  FOREIGN KEY(id_date) REFERENCES table_date(id_date);
alter table indicateurs_sejour add FOREIGN KEY(id_categorie) REFERENCES categorie_touriste(id_categorie);
alter table indicateurs_sejour add  FOREIGN KEY(code_departement) REFERENCES departement(code_departement);
alter table occupation_hotel add  FOREIGN KEY(id_date) REFERENCES table_date(id_date);
alter table occupation_hotel add  FOREIGN KEY(code_departement) REFERENCES departement(code_departement);
SET FOREIGN_KEY_CHECKS=1;

  