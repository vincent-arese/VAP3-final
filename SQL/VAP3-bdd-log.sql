--- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- 
/* Creation des Tables */
--- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- 

-- 1 Table Region  & Département 
-----------------------------------------------------------------------------------------------------------------------------------------------

-- 1.1 RegionFR : Creation PK 
ALTER TABLE "P03VASQL"."regionFR" ADD CONSTRAINT regionfr_pk PRIMARY KEY (regioncode);


--1.2 DeptFR : creation PK & FK 
ALTER TABLE "P03VA"."DeptFR" ADD CONSTRAINT deptfr_pk PRIMARY KEY (deptcode);
ALTER TABLE "P03VA"."DeptFR" ADD CONSTRAINT deptfr_fk FOREIGN KEY (regioncodefk) REFERENCES "P03VA"."RegionFR"(regioncode);


--2 Normalisation Table RAW 
-----------------------------------------------------------------------------------------------------------------------------------------------

-- 2.1 Creation d'un RowID pour Normaliser la table raw
ALTER TABLE "P03VASQL".raw ADD column1 serial NOT NULL;
-----------------


-- 2.2 Creation table Type Local 
-------------------------------------------------------
--- 2.2.1 Recherche des  Type Local présent dans RAW
create table typeLocal as
SELECT distinct 
typelocalcode
FROM "P03VA"."RAW";
-- Seul 2 types de locaux sont présent dans la table Raw 1:maison & 2: appartement

--- 2.2.1 Creation table Type Local 
CREATE TABLE typelocal (
	typelocalcode int4 NOT NULL,
	typelocal varchar NULL,
	CONSTRAINT typelocal_pk PRIMARY KEY (typelocalcode)
);

INSERT INTO typelocal (typelocalcode, typelocal) VALUES(1, 'Maison');
INSERT INTO typelocal (typelocalcode, typelocal) VALUES(2, 'Appartement');
-----------------


-- 2.3 Table Commune
-------------------------------------------------------

---- Recherche clef Commune
--Recherche des communes qui apparaissent plus d'une fois dans la table
select commune  FROM "RAW" group by Commune having count (*)>1 order by commune ; 
 SELECT  count(distinct commune) FROM "RAW" ;   /*--=>3110  */ select count(commune) FROM "RAW"; -- =>34169
--Recherche des communes qui apparaissent plus d'une fois dans la table
select *  FROM "RAW" where commune like'AUBERV%'  order by commune ; 
 
 
----Creation de la table Commune 
drop table commune ;
create table Commune as 
select distinct 
cadastrecodedepartement as codedepartementFK,
commune as communeAR , 
commune as communeVille,
concat(cadastrecodedepartement,'-',commune) as CommuneID
FROM "RAW"
group by cadastrecodedepartement,commune
order by cadastrecodedepartement,commune
;

--Ajout Commune SERIAL UK numerique 
ALTER TABLE "P03VA".commune ADD communeSerial NOT NULL; --ligne serial
ALTER TABLE "P03VA".commune ADD CONSTRAINT commune_pk PRIMARY KEY (comnuneID);
ALTER TABLE "P03VA".commune ADD CONSTRAINT commune_fk FOREIGN KEY (codedepartementFK) REFERENCES "P03VA"."DeptFR"(deptcode);



-- Creation Nom CommuneVille  unique pour les 3 communes avec Arrondissement en france ( PARIS LYON MARSEILLE )

--Paris-------------------------------------------------
SELECT * FROM commune where Communeville like 'PARIS%';
UPDATE commune SET  communeville='PARIS' where communeville like 'PARIS%';

--Lyon---------------------------------------------------
SELECT * FROM commune where Communeville like 'LYON%';
UPDATE commune SET  communeville='LYON' where communeville like 'LYON%'

--Marseille-----------------------------------------------
SELECT * FROM commune where Communeville like 'MARSEILLE%';
UPDATE commune SET  communeville='MARSEILLE' where communeville like 'MARSEILLE%'

-- verif Nom departements ! 
SELECT * FROM commune where codedepartementFK like '01';
UPDATE commune SET  codedepartementFK='01'where cadastrecodedepartement like '1';

SELECT * FROM commune where Communeville like 'AUBERVI%';
----------------------------------------------------------------------------------------


--formatage  Nettoyage Rax  coee dept  1->01 
----------------------------------------------

UPDATE "RAW"  SET  cadastrecodedepartement='01'
where cadastrecodedepartement like '1';

UPDATE "RAW"  SET  cadastrecodedepartement='02'
where cadastrecodedepartement like '2';

UPDATE "RAW"  SET  cadastrecodedepartement='03'
where cadastrecodedepartement like '3';

UPDATE "RAW"  SET  cadastrecodedepartement='04'
where cadastrecodedepartement like '4';

UPDATE "RAW"  SET  cadastrecodedepartement='05'
where cadastrecodedepartement like '5';

UPDATE "RAW"  SET  cadastrecodedepartement='06'
where cadastrecodedepartement like '6';

UPDATE "RAW"  SET  cadastrecodedepartement='07'
where cadastrecodedepartement like '7';

UPDATE "RAW"  SET  cadastrecodedepartement='08'
where cadastrecodedepartement like '8';


UPDATE "RAW"  SET  cadastrecodedepartement='09'
where cadastrecodedepartement like '9';

-----------------


--Commune PK & FK 
ALTER TABLE "P03VA".commune ADD CONSTRAINT commune_pk PRIMARY KEY (communeid);
ALTER TABLE "P03VA".commune ADD CONSTRAINT commune_fk FOREIGN KEY (codedepartementfk) REFERENCES "P03VA"."DeptFR"(deptcode);





--2.4 VoieCommunale
-------------------------------------------------------
DROP table VoieCommunale ;
create table VoieCommunale as 
select distinct
concat(adressevoiecode,'-',commune) as adresseVoiePK,
concat(adressevoietype,' ',adressevoienom) as adresseVoieNomtype,
adressevoiecode,
concat(cadastrecodedepartement,'-',commune) as CommuneFK
FROM "RAW"
order by adresseVoiePK;

--verifcation unicite PK candidate
select count (*),adresseVoiePK  FROM voiecommunale group by adresseVoiePK having count (*)>1 order by adresseVoiePK ; 
select count (*),comnuneFK  FROM voiecommunale group by comnuneFK having count (*)>1 order by comnuneFK;


--Nettoyage du raw 
SELECT count (*),adresseVoiePK  FROM "P03VA".voiecommunale group by adresseVoiePK  having count (*)>1; --- verif doucblons?
select * from "RAW"   where concat(adressevoiecode,'-',commune,'-') in ('7742-PARIS 13-','170-CARNOUX-EN-PROVENCE-','7740-PARIS 13-','510-VERNOUILLET-','950-ABBEVILLE-','8437-MARSEILLE 5EME-','1978-PARIS 06-','170-PERIGNY-','645-LE LAVANDOU-')
order by concat(adressevoiecode,'-',commune,'-'); --Correction manuelle des erreurs de saisie ( non de rue avec vs sans tiret , fautes de frappes à la saisie ...)
--Nettoyage du raw du raw

-- creation Pk 
ALTER TABLE "P03VA".voiecommunale ADD CONSTRAINT voiecommunale_pk PRIMARY KEY (adressevoiepk);


-- 2.5 Table Cadastre
-------------------------------------------------------
drop table cadastre;
create table cadastre as 
select distinct
Concat (cadastrecodecommune,'-', cadastreprefixesection,'-', cadastresection, '-',cadastreplannum,'-', cadastrevolume,'-', cadastrelot1) as cadastreIDtxt,
cadastrelot1surfacecarrez, surfacereellebati, 
nombrepiecesprincipales,
nombrelots,
concat(cadastrecodedepartement,'-',commune) as CommuneFK,
cadastresection,
concat(adressevoienum,' ',adressevoienumdetail) as adresseVoieNumber,
concat(adressevoiecode,'-',commune) as adresseVoieFK,
typelocalcode as typelocalcodeFK
FROM "RAW"
order by cadastreIDtxt;


SELECT count (*), cadastreIDtxt  FROM "P03VA".Cadastre group by cadastreIDtxt  having count (*)>1;
SELECT count (*), adresseVoieFK  FROM "P03VA".Cadastre group by adresseVoieFK  having count (*)>1;

select * from cadastre;
select count(*) from cadastre;

-- Cadastre  PK et FK 
ALTER TABLE "P03VA".cadastre ADD CONSTRAINT cadastre_pk PRIMARY KEY (cadastreidtxt);
ALTER TABLE "P03VA".cadastre ADD CONSTRAINT cadastre_commune_fk FOREIGN KEY (communefk) REFERENCES "P03VA".commune(communeid) ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE "P03VA".cadastre ADD CONSTRAINT cadastre_typelocal_fk FOREIGN KEY (typelocalcodefk) REFERENCES "P03VA".typelocal(typelocalcode) ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE "P03VA".cadastre ADD CONSTRAINT cadastre_voiecom_fk FOREIGN KEY (adressevoiefk) REFERENCES "P03VA".voiecommunale(adressevoiepk) ON DELETE CASCADE ON UPDATE CASCADE;



-- 2.6 Table Mutation
-------------------------------------------------------
drop table mutation;
create table mutation as 
select distinct
rawid as mutationID,
date_part('year', mutationdate)as mutationYear,
date_part('quarter', mutationdate) as mutationQuarter,
mutationdate,
valeurfonciere, 
Concat (cadastrecodecommune,'-', cadastreprefixesection,'-', cadastresection, '-',cadastreplannum,'-', cadastrevolume,'-', cadastrelot1) as cadastreIDFK
FROM "RAW"
order by mutationdate DESC;

--verif Pk 
SELECT count (*), mutationID  FROM "P03VA".mutation group by mutationID having count (*)>1;
SELECT count (*)  FROM "P03VA".mutation;

-- Set PK et FK 
ALTER TABLE "P03VA".mutation ADD CONSTRAINT mutation_pk PRIMARY KEY (mutationid);
ALTER TABLE "P03VA".mutation ADD CONSTRAINT mutation_fk FOREIGN KEY (cadastreidfk) REFERENCES "P03VA".cadastre(cadastreidtxt) ON UPDATE CASCADE ON DELETE CASCADE;


-- 3 Jointure des tables sur DVF.view
-----------------------------------------------------------------------------------------------------------------------------------------------

--liste  des tables 
SELECT regionnom, regioncode FROM "RegionFR";
SELECT deptnom, deptcode, deptcodetrinum, regioncodefk FROM "DeptFR";
SELECT codedepartementfk, communear, communeville, communeid FROM commune;

SELECT typelocalcode, typelocal FROM typelocal;
SELECT adressevoiepk, adressevoienomtype, adressevoiecode, communefk FROM voiecommunale;
SELECT cadastreidtxt, cadastrelot1surfacecarrez, surfacereellebati, nombrepiecesprincipales, nombrelots, communefk, cadastresection, adressevoienumber, adressevoiefk, typelocalcodefk FROM cadastre;

SELECT mutationid, mutationyear, mutationquarter, mutationdate, valeurfonciere, cadastreidfk FROM mutation;

--- DVF_view 
create view DVF_view as
select 
 mutationid, mutationyear, mutationquarter, mutationdate, valeurfonciere,
cadastreidtxt, cadastrelot1surfacecarrez, surfacereellebati, nombrepiecesprincipales, nombrelots, cadastresection,
regionnom, regioncode,
deptnom, deptcode, deptcodetrinum,
communear, communeville, communeid,
 typelocal,typelocalcode,
 adressevoienumber,
 adressevoienomtype,adressevoiecode
from "RegionFR","DeptFR",commune,typelocal, voiecommunale, cadastre,mutation
where "RegionFR".regioncode="DeptFR".regioncodefk 
	and "DeptFR".deptcode=commune.codedepartementfk
	and commune.communeid=cadastre.communefk
	and typelocal.typelocalcode=cadastre.typelocalcodefk
	and voiecommunale.adressevoiepk=cadastre.adressevoiefk
	and mutation.cadastreidfk = cadastre.cadastreidtxt 
order by 	regionnom,deptcodetrinum,communear,cadastreidtxt ;
----

--verif 
select * from dvf_view;
select count(*) from dvf_view;

-------



