--3. Liste des 10 départements où le prix du mètre carré est le plus élevé.
--- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- 

-- deux options 


-- Requette sur les 10 dept ou prix moyen du département au  mètre carré est le plus élevé.
SELECT 
deptcode, deptnom ,
round((AVG(valeurfonciere/surfacereellebati)),0) as Prix_m²_Moy_Dept
FROM "P03VA".dvf_view
where (valeurfonciere/surfacereellebati)>0 
group by deptcode, deptnom 
order by Prix_m²_Moy_Dept desc 
limit 10;



-- Requette sur les 10 dept ou le prix/m² d'un bien est le plus élevé.
SELECT 
deptcode, deptnom ,
MAX(ROUND((valeurfonciere/surfacereellebati),0)) as Prix_m²_MAX_Dept
FROM "P03VA".dvf_view
where (valeurfonciere/surfacereellebati) is not NULL
group by deptcode, deptnom 
order by Prix_m²_MAX_Dept desc 
limit 10;







------------------------------- 
select * FROM "P03VA".dvf_view;

SELECT 
mutationid,
mutationyear, mutationquarter, mutationdate,
valeurfonciere, 
cadastreidtxt, 
cadastrelot1surfacecarrez, surfacereellebati,
nombrepiecesprincipales,
nombrelots, cadastresection, 
regionnom, regioncode, 
deptnom, deptcode, deptcodetrinum,
communear, communeville, communeid, 
typelocal, typelocalcode, 
adressevoienumber, adressevoienomtype, adressevoiecode 
FROM "P03VA".dvf_view;

------------------------------- 











 /* Etape 2 : manque agregation/ */

SELECT 
deptcode, 
(SELECT ROUND((valeurfonciere/cadastresurfacereellebati),0)) as Prix_m²_Bati,
--(SELECT ROUND((valeurfonciere/cadastrelot1surfacecarrez),2))as Prix_m²_Carrez,
count((SELECT ROUND((valeurfonciere/cadastresurfacereellebati),0)))
FROM "P03VASQL".dvf_view
--Probleme :  Where Prix_m²_Bati>0 ne fct pas , donc remplacé par fonction ==> est-il possible d'utiser un alias ????? 
where (SELECT ROUND((valeurfonciere/cadastresurfacereellebati),0))>0 
group by deptcode,valeurfonciere,cadastresurfacereellebati,cadastrelot1surfacecarrez
order by Prix_m²_Bati desc 
;

 /* Etape 1 : listes des mutation avec prix au m2 */

SELECT 
mutationidnun,
valeurfonciere, 
cadastreid,
cadastrelot1surfacecarrez, cadastresurfacereellebati, 
deptcode, 
(SELECT ROUND((valeurfonciere/cadastresurfacereellebati),2)) as Prix_m²_Bati,
(SELECT ROUND((valeurfonciere/cadastrelot1surfacecarrez),2))as Prix_m²_Carrez,
count((SELECT ROUND((valeurfonciere/cadastresurfacereellebati),2)))
FROM "P03VASQL".dvf_view
--Probleme Alias sur un select Code trop compliqué !
where (SELECT ROUND((valeurfonciere/cadastresurfacereellebati),2))>0
--Where Prix_m²_Bati>0
group by mutationidnun,
valeurfonciere, 
cadastreid,
cadastrelot1surfacecarrez, cadastresurfacereellebati, 
deptcode
order by Prix_m²_Bati desc 
;
