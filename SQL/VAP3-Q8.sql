--8. Diff�rence en pourcentage du prix au m�tre carr� entre un appartement de 2 pi�ces et un appartement de 3 pi�ces.
--- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- 

--OK code optimis�V1 
with 
P2P as (SELECT  ROUND(AVG(valeurfonciere/cadastrelot1surfacecarrez),2) as PM2P FROM "P03VA".dvf_view where typelocalcode=2 and nombrepiecesprincipales=2 and  ROUND((valeurfonciere/cadastrelot1surfacecarrez),2)>0),
P3P as (SELECT  ROUND(AVG(valeurfonciere/cadastrelot1surfacecarrez),2) as PM3P FROM "P03VA".dvf_view where typelocalcode=2 and nombrepiecesprincipales=3 and  ROUND((valeurfonciere/cadastrelot1surfacecarrez),2)>0)
select PM2P as Prix_m�_Carrez_2P,PM3P as Prix_m�_Carrez_3P, round( (((PM3P-PM2P)/PM2P)*100),2) as "Delta_3P_vs_2P_%"
from P2P,P3P;

------- code compliqu�  Problemme performance car utilisation limit 1 (donc nombreux calculs inutiles ! )
select 
(SELECT (SELECT ROUND(AVG(valeurfonciere/cadastrelot1surfacecarrez),2))as Prix_m�_Carrez2P FROM "P03VASQL".dvf_view where typelocalcode=2 and cadastrenombrepiecesprincipales=2 and (SELECT ROUND((valeurfonciere/cadastrelot1surfacecarrez),2))>0 ) as P2P,
(SELECT (SELECT ROUND(AVG(valeurfonciere/cadastrelot1surfacecarrez),2))as Prix_m�_Carrez3P FROM "P03VASQL".dvf_view where typelocalcode=2 and cadastrenombrepiecesprincipales=3 and (SELECT ROUND((valeurfonciere/cadastrelot1surfacecarrez),2))>0 ) as P3P,
((SELECT (SELECT ROUND(AVG(valeurfonciere/cadastrelot1surfacecarrez),2))as Prix_m�_Carrez2P FROM "P03VASQL".dvf_view where typelocalcode=2 and cadastrenombrepiecesprincipales=2 and (SELECT ROUND((valeurfonciere/cadastrelot1surfacecarrez),2))>0 )-
(SELECT (SELECT ROUND(AVG(valeurfonciere/cadastrelot1surfacecarrez),2))as Prix_m�_Carrez3P FROM "P03VASQL".dvf_view where typelocalcode=2 and cadastrenombrepiecesprincipales=3 and (SELECT ROUND((valeurfonciere/cadastrelot1surfacecarrez),2))>0 )) as calculdelta,
round( (((((SELECT (SELECT ROUND(AVG(valeurfonciere/cadastrelot1surfacecarrez),2))as Prix_m�_Carrez2P FROM "P03VASQL".dvf_view where typelocalcode=2 and cadastrenombrepiecesprincipales=2 and (SELECT ROUND((valeurfonciere/cadastrelot1surfacecarrez),2))>0 )-
(SELECT (SELECT ROUND(AVG(valeurfonciere/cadastrelot1surfacecarrez),2))as Prix_m�_Carrez3P FROM "P03VASQL".dvf_view where typelocalcode=2 and cadastrenombrepiecesprincipales=3 and (SELECT ROUND((valeurfonciere/cadastrelot1surfacecarrez),2))>0 ))
)/(SELECT (SELECT ROUND(AVG(valeurfonciere/cadastrelot1surfacecarrez),2))as Prix_m�_Carrez2P FROM "P03VASQL".dvf_view where typelocalcode=2 and cadastrenombrepiecesprincipales=2 and (SELECT ROUND((valeurfonciere/cadastrelot1surfacecarrez),2))>0 )
)*100 ),2)as calculfinal
FROM "P03VASQL".dvf_view
limit 1;



-- Prix moyen d'un appartement 2 Pieces 1 cellule 

SELECT  ROUND(AVG(valeurfonciere/cadastrelot1surfacecarrez),2) as Prix_m�_Carrez3P
FROM "P03VA".dvf_view
where typelocalcode=2 and nombrepiecesprincipales=2 and  ROUND((valeurfonciere/cadastrelot1surfacecarrez),2)>0
;

-- Prix moyen d'un appartement 2 Pieces 
SELECT 
nombrepiecesprincipales,
(SELECT ROUND(AVG(valeurfonciere/cadastrelot1surfacecarrez),2))as Prix_m�_Carrez2P
FROM "P03VA".dvf_view
where typelocalcode=2 and nombrepiecesprincipales=2 and (SELECT ROUND((valeurfonciere/cadastrelot1surfacecarrez),2))>0
group by nombrepiecesprincipales
order by Prix_m�_Carrez2P desc 
;



-- Prix moyen d'un appartement 3 Pieces 1 Cellulle
SELECT (SELECT ROUND(AVG(valeurfonciere/cadastrelot1surfacecarrez),2))as Prix_m�_Carrez3P
FROM "P03VASQL".dvf_view
where typelocalcode=2 and cadastrenombrepiecesprincipales=3 and (SELECT ROUND((valeurfonciere/cadastrelot1surfacecarrez),2))>0
;


-- Prix moyen d'un appartement 3 Pieces 
SELECT 
cadastrenombrepiecesprincipales,
(SELECT ROUND(AVG(valeurfonciere/cadastrelot1surfacecarrez),2))as Prix_m�_Carrez3P
FROM "P03VASQL".dvf_view
where typelocalcode=2 and cadastrenombrepiecesprincipales=3 and (SELECT ROUND((valeurfonciere/cadastrelot1surfacecarrez),2))>0
group by dvf_view.cadastrenombrepiecesprincipales
order by Prix_m�_Carrez3P desc 
;





-- ==> Etape 1 :  Liste prix au  m� appart 2 pi�ces 
SELECT 
nombrepiecesprincipales,
cadastrelot1surfacecarrez,  surfacereellebati, 
 typelocalcode, typelocal, 
communeid, communear, 
deptcode, deptnom, deptcodetrinum ,
regionnom, regioncode,
(SELECT ROUND((valeurfonciere/surfacereellebati),2)) as Prix_m�_Bati,
(SELECT ROUND((valeurfonciere/cadastrelot1surfacecarrez),2))as Prix_m�_Carrez,
mutationdate, mutationquarter, mutationyear, 
valeurfonciere, 
cadastreidtxt 
FROM "P03VA".dvf_view
where typelocalcode=2 and nombrepiecesprincipales=2
order by deptcodetrinum ,Prix_m�_Bati desc 
;



