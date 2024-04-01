CREATE DOMAIN dom_santé AS INT CHECK (VALUE BETWEEN 1 AND 100);
CREATE TABLE character(id_character INT PRIMARY KEY,nom_character VARCHAR(15),prénom_character VARCHAR(15),niveau_character INT ,xp_character INT,santé_character dom_santé);

CREATE TABLE trésor(id_trésor INT PRIMARY KEY,type_trésor VARCHAR(10));

CREATE TABLE reward(id_reward INT PRIMARY KEY,type_reward VARCHAR(10));


CREATE  DOMAIN dom_type_vehicule AS VARCHAR(20) CHECK (VALUE IN(
'Boats',
'Cars',
'Helicopters',
'Motorcycles',
'Emergency',
'Sports',
'Cycles',
'Vans'));
CREATE TABLE vehicule(
id_vehicule INT  PRIMARY KEY,
type_vehicule dom_type_vehicule,
nom_vehicule VARCHAR(30),
prix_vehicule INT ,
speed_vehicule INT);


CREATE DOMAIN dom_type_weapon AS VARCHAR(15) CHECK (VALUE IN('hand','melee_weapon','thrown_weapon','pistol',
'shotgun','machine_gun','assault_rifle','heavy_weapon','sniper_rifle'));
CREATE TABLE weapon(id_weapon INT  PRIMARY KEY,type_weapon dom_type_weapon,nom_weapon VARCHAR(25),prix_weapon INT);

CREATE TABLE action(id_action INT PRIMARY KEY,description_action VARCHAR(120),id_weapon INT REFERENCES weapon(id_weapon),id_vehicule INT REFERENCES vehicule(id_vehicule));

CREATE TABLE lieu(id_lieu INT PRIMARY KEY ,nom_lieu VARCHAR(35));

CREATE DOMAIN dom_type_mission AS VARCHAR(10) CHECK (VALUE IN('légal','illégal'));
CREATE DOMAIN dom_status_mission AS VARCHAR(10) CHECK (VALUE IN('ouvert','fermé','complet'));
CREATE TABLE mission(
id_mission INT PRIMARY KEY,
description_mission VARCHAR(30),
type_mission dom_type_mission,
status_mission dom_status_mission,
id_lieu INT REFERENCES lieu(id_lieu),
id_action INT REFERENCES action(id_action));

CREATE TABLE gagner(id_mission INT REFERENCES mission(id_mission),id_reward INT REFERENCES reward(id_reward),quantité INT,PRIMARY KEY(id_mission,id_reward));


CREATE TABLE possède_t(id_character INT REFERENCES character(id_character),id_trésor INT REFERENCES trésor(id_trésor),quantité INT,PRIMARY KEY(id_character,id_trésor));

CREATE TABLE possède_v(id_character INT REFERENCES character(id_character),id_vehicule INT REFERENCES vehicule(id_vehicule),PRIMARY KEY(id_character,id_vehicule));

CREATE TABLE possède_w(id_character INT REFERENCES character(id_character),id_weapon INT REFERENCES weapon(id_weapon),PRIMARY KEY(id_character,id_weapon));

CREATE TABLE char_concerne_miss(id_character INT REFERENCES character(id_character) ,id_mission INT REFERENCES mission(id_mission) ,PRIMARY KEY(id_character,id_mission));



