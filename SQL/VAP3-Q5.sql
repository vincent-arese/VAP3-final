--5. Liste des 10 appartements les plus chers avec le d�partement et le nombre de m�tres carr�s.
--- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- 
SELECT 
typelocal,
valeurfonciere,
cadastrelot1surfacecarrez,
surfacereellebati, 
deptnom,
(SELECT ROUND((valeurfonciere/surfacereellebati),2)) as Prix_m�_Bati,
(SELECT ROUND((valeurfonciere/cadastrelot1surfacecarrez),2))as Prix_m�_Carrez,
communeid  
FROM "P03VA".dvf_view
where  typelocalcode=2 and valeurfonciere>0
order by valeurfonciere desc ,deptcodetrinum
limit 10
;
--oK ! 

-- requette Q5 ok .... mais valeurs ab�rantes dans le raw ! 

SELECT 
typelocal,
valeurfonciere,
cadastrelot1surfacecarrez,
surfacereellebati, 
nombrepiecesprincipales,
deptnom,
(SELECT ROUND((valeurfonciere/surfacereellebati),2)) as Prix_m�_Bati,
(SELECT ROUND((valeurfonciere/cadastrelot1surfacecarrez),2))as Prix_m�_Carrez,
communeid  
FROM "P03VA".dvf_view
where  typelocalcode=2 and valeurfonciere>0
order by valeurfonciere desc ,deptcodetrinum
limit 100
;






-- oK mais nombreuses valeurs incoherentes presente sur le raw ! 
SELECT *, (SELECT ROUND((valeurfonciere/cadastresurfacereellebati),2)) as Prix_m�_Bati,(SELECT ROUND((valeurfonciere/cadastrelot1surfacecarrez),2))as Prix_m�_Carrez
from raw
where valeurfonciere>0
order by (SELECT ROUND((valeurfonciere/cadastresurfacereellebati),2)) desc
--where rawid in (32275, 29799, 32433, 31973, 32135, 29513)



