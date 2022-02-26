 */ _____________________________________________________________________________________________________________________________________________
    | RAW  Valeur Abrerante																														 |
    |____________________________________________________________________________________________________________________________________________|
*/

--- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- 
-- Valeurs foncieres manquantes !  18   // nombrepiecesprincipales=0 ! 33 
--- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- 

--Valeures fonciéres manquantes
select  valeurfonciere, rawid ,mutationdate  
from "RAW"
where valeurfonciere is null --=> 18;

---nombrepiecesprincipales=0
select  valeurfonciere, rawid ,mutationdate ,nombrepiecesprincipales, surfacereellebati 
from "RAW"
where nombrepiecesprincipales=0;
select  count(*)
from "RAW"
where nombrepiecesprincipales=0;


--total mutations
select count(*)
from "RAW"
 --=>34169
----------------------------


-- Prix m2 bati surprennant (Prix /m²  Nbr de pieces pas toujours corrélé avec la surfrace ....)
SELECT 
typelocal,
valeurfonciere,
cadastrelot1surfacecarrez,
surfacereellebati, 
nombrepiecesprincipales,
(SELECT ROUND((valeurfonciere/surfacereellebati),0)) as Prix_m²_Bati,
(SELECT ROUND((valeurfonciere/cadastrelot1surfacecarrez),0))as Prix_m²_Carrez,
deptnom,
communeid  
FROM "P03VA".dvf_view
where  typelocalcode<=2 and valeurfonciere>0
order by Prix_m²_Bati desc , valeurfonciere desc ,deptcodetrinum
limit 100



-- Mutations avec Nombre de pieces/surface suspecte ( Nbr de pieces pas corrélé avec la surfrace .... car pieces de moins de 10.0m2 en moyenne !)
SELECT 
typelocal,
valeurfonciere,
cadastrelot1surfacecarrez as Carrez,
surfacereellebati, 
nombrepiecesprincipales as "Nb piece p.",
round((surfacereellebati/nombrepiecesprincipales),0) as "Estim surf. moy/piece",
(SELECT ROUND((valeurfonciere/surfacereellebati),0)) as Prix_m²_Bati,
(SELECT ROUND((valeurfonciere/cadastrelot1surfacecarrez),0))as Prix_m²_Carrez,
deptnom,
communeid  
FROM "P03VA".dvf_view
where  typelocalcode<=2 and valeurfonciere>0 and nombrepiecesprincipales>=1 and round((surfacereellebati/nombrepiecesprincipales),0)<=10.00
order by round((surfacereellebati/nombrepiecesprincipales),0),Prix_m²_Bati desc , valeurfonciere desc ,deptcodetrinum
;

SELECT 
count(*) as "<= 10m²"
FROM "P03VA".dvf_view
where  typelocalcode<=2 and valeurfonciere>0 and nombrepiecesprincipales>=1 and round((surfacereellebati/nombrepiecesprincipales),0)<=10;

SELECT 
count(*) as "< 10m²"
FROM "P03VA".dvf_view
where  typelocalcode<=2 and valeurfonciere>0 and nombrepiecesprincipales>=1 and round((surfacereellebati/nombrepiecesprincipales),0)<10;



--- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- 
-- Appartempent avec surface carrez > Surface relle bati ! 
--Data Valeur aberante : surfacereellebati < cadastrelot1surfacecarrez
--- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- 

--dvf view 
select 
(SELECT count(*) as "Nb Appt Pb Surface Bati < Carrez" FROM "P03VA".dvf_view  where surfacereellebati<cadastrelot1surfacecarrez ),
(SELECT count(*) as "Total Appt" FROM "P03VA".dvf_view) ,
((((SELECT count(*) as "Nb Pb Surface Bati < Carrez" FROM "P03VA".dvf_view  where surfacereellebati<cadastrelot1surfacecarrez )/(SELECT count(*) as "Total Appt" FROM "P03VA".dvf_view)::float)*100)::decimal(4,2)) as "% erreur"
from "P03VA".dvf_view limit 1;

--RAW 
select 
(SELECT count(*) as "Nb Appt Pb Surface Bati < Carrez" FROM "P03VA".dvf_view  where surfacereellebati<cadastrelot1surfacecarrez ),
(SELECT count(*) as "Total Appt" FROM "P03VA"."RAW") ,
((((SELECT count(*) as "Nb Pb Surface Bati < Carrez" FROM "P03VA".dvf_view  where surfacereellebati<cadastrelot1surfacecarrez )/(SELECT count(*) as "Total Appt" FROM "P03VA"."RAW")::float)*100)::decimal(4,2)) as "% erreur"
from "P03VA".dvf_view limit 1;



-- liste data aberantes  ou surfacereellebati < cadastrelot1surfacecarrez
SELECT * FROM "P03VA".dvf_view as Pb where surfacereellebati<cadastrelot1surfacecarrez; --dvf view
SELECT * FROM "P03VA"."RAW" as Pb where surfacereellebati<cadastrelot1surfacecarrez; --RAW 
----------------------------


select surfacereellebati-cadastrelot1surfacecarrez as "delta Surface (Bati-Carrez)", surfacereellebati,cadastrelot1surfacecarrez as "Surface Carrez",nombrepiecesprincipales as "Nb Pieces princip",mutationdate, valeurfonciere,
concat(adressevoienum,' ', adressevoienumdetail,' ', adressevoienom,' ', cadastrecodedepartement,'-',commune) as adressse, rawid 
FROM "P03VA"."RAW"
where surfacereellebati<cadastrelot1surfacecarrez
order by surfacereellebati-cadastrelot1surfacecarrez ASC;















