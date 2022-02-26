--3. Liste des 10 d�partements o� le prix du m�tre carr� est le plus �lev�.
--- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- 

-- deux options 


-- Requette sur les 10 dept ou prix moyen du d�partement au  m�tre carr� est le plus �lev�.
SELECT 
deptcode, deptnom ,
round((AVG(valeurfonciere/surfacereellebati)),0) as Prix_m�_Moy_Dept
FROM "P03VA".dvf_view
where (valeurfonciere/surfacereellebati)>0 
group by deptcode, deptnom 
order by Prix_m�_Moy_Dept desc 
limit 10;



-- Requette sur les 10 dept ou le prix/m� d'un bien est le plus �lev�.
SELECT 
deptcode, deptnom ,
MAX(ROUND((valeurfonciere/surfacereellebati),0)) as Prix_m�_MAX_Dept
FROM "P03VA".dvf_view
where (valeurfonciere/surfacereellebati) is not NULL
group by deptcode, deptnom 
order by Prix_m�_MAX_Dept desc 
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
(SELECT ROUND((valeurfonciere/cadastresurfacereellebati),0)) as Prix_m�_Bati,
--(SELECT ROUND((valeurfonciere/cadastrelot1surfacecarrez),2))as Prix_m�_Carrez,
count((SELECT ROUND((valeurfonciere/cadastresurfacereellebati),0)))
FROM "P03VASQL".dvf_view
--Probleme :  Where Prix_m�_Bati>0 ne fct pas , donc remplac� par fonction ==> est-il possible d'utiser un alias ????? 
where (SELECT ROUND((valeurfonciere/cadastresurfacereellebati),0))>0 
group by deptcode,valeurfonciere,cadastresurfacereellebati,cadastrelot1surfacecarrez
order by Prix_m�_Bati desc 
;

 /* Etape 1 : listes des mutation avec prix au m2 */

SELECT 
mutationidnun,
valeurfonciere, 
cadastreid,
cadastrelot1surfacecarrez, cadastresurfacereellebati, 
deptcode, 
(SELECT ROUND((valeurfonciere/cadastresurfacereellebati),2)) as Prix_m�_Bati,
(SELECT ROUND((valeurfonciere/cadastrelot1surfacecarrez),2))as Prix_m�_Carrez,
count((SELECT ROUND((valeurfonciere/cadastresurfacereellebati),2)))
FROM "P03VASQL".dvf_view
--Probleme Alias sur un select Code trop compliqu� !
where (SELECT ROUND((valeurfonciere/cadastresurfacereellebati),2))>0
--Where Prix_m�_Bati>0
group by mutationidnun,
valeurfonciere, 
cadastreid,
cadastrelot1surfacecarrez, cadastresurfacereellebati, 
deptcode
order by Prix_m�_Bati desc 
;
