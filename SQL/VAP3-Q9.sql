--9 Les moyennes de valeurs foncières pour le top 3 des communes des départements 6, 13, 33, 59 et 69
--- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- 

--- TOP 3 Communes de l'ensemble des departements listés ! 
SELECT 
deptnom,communear ,round(( AVG(valeurfonciere)),0) as Prix_Immo_Moy
FROM "P03VA".dvf_view
where deptcodetrinum in (6,13,33,59,69) and valeurfonciere IS NOT null
group by communear,deptnom
order by Prix_Immo_Moy DESC
limit 3
; 




--- TOP 3 communes de chaque departements de la liste Commune VILLE ! 
with
Top06 as (SELECT deptnom,communeville,round(( AVG(valeurfonciere)),0) as Prix_Immo_Moy FROM "P03VA".dvf_view where deptcodetrinum in (6) and valeurfonciere IS NOT null group by communeville,deptnom order by deptnom,Prix_Immo_Moy desc limit 3),
Top13 as (select deptnom,communeville, round(( AVG(valeurfonciere)),0) as Prix_Immo_Moy FROM "P03VA".dvf_view where deptcodetrinum in (13) and valeurfonciere IS NOT null group by communeville,deptnom order by deptnom,Prix_Immo_Moy desc limit 3),
Top33 as (SELECT deptnom,communeville,round(( AVG(valeurfonciere)),0) as Prix_Immo_Moy FROM "P03VA".dvf_view where deptcodetrinum in (33) and valeurfonciere IS NOT null group by communeville,deptnom order by deptnom,Prix_Immo_Moy desc limit 3),
Top59 as (SELECT deptnom,communeville,round(( AVG(valeurfonciere)),0) as Prix_Immo_Moy FROM "P03VA".dvf_view where deptcodetrinum in (59) and valeurfonciere IS NOT null group by communeville,deptnom order by deptnom,Prix_Immo_Moy desc limit 3),
Top69 as (SELECT deptnom,communeville,round(( AVG(valeurfonciere)),0) as Prix_Immo_Moy FROM "P03VA".dvf_view where deptcodetrinum in (69) and valeurfonciere IS NOT null group by communeville,deptnom order by deptnom,Prix_Immo_Moy desc limit 3)
select *from Top06
union
select *from Top13
union 
select *from Top33
union 
select *from Top59
union 
select *from Top69
order by deptnom,Prix_Immo_Moy desc;



--- TOP 3 communes de chaque departements de la liste Commune Arrondissements
with
Top06 as (SELECT deptnom,communear,round(( AVG(valeurfonciere)),0) as Prix_Immo_Moy FROM "P03VA".dvf_view where deptcodetrinum in (6) and valeurfonciere IS NOT null group by communear,deptnom order by deptnom,Prix_Immo_Moy desc limit 3),
Top13 as (select deptnom,communear,round(( AVG(valeurfonciere)),0) as Prix_Immo_Moy FROM "P03VA".dvf_view where deptcodetrinum in (13) and valeurfonciere IS NOT null group by communear,deptnom order by deptnom,Prix_Immo_Moy desc limit 3),
Top33 as (SELECT deptnom,communear,round(( AVG(valeurfonciere)),0) as Prix_Immo_Moy FROM "P03VA".dvf_view where deptcodetrinum in (33) and valeurfonciere IS NOT null group by communear,deptnom order by deptnom,Prix_Immo_Moy desc limit 3),
Top59 as (SELECT deptnom,communear,round(( AVG(valeurfonciere)),0) as Prix_Immo_Moy FROM "P03VA".dvf_view where deptcodetrinum in (59) and valeurfonciere IS NOT null group by communear,deptnom order by deptnom,Prix_Immo_Moy desc limit 3),
Top69 as (SELECT deptnom,communear,round(( AVG(valeurfonciere)),0) as Prix_Immo_Moy FROM "P03VA".dvf_view where deptcodetrinum in (69) and valeurfonciere IS NOT null group by communear,deptnom order by deptnom,Prix_Immo_Moy desc limit 3)
select *from Top06
union
select *from Top13
union 
select *from Top33
union 
select *from Top59
union 
select *from Top69
order by deptnom,Prix_Immo_Moy desc;


--- TOP 3 communes de chaque departements de la liste Commune Arrondissements + Prix MEDIAN !!!!!!!!
with
Top06 as (SELECT deptnom,communear,round(( AVG(valeurfonciere)),0) as Prix_Immo_Moy, 
percentile_cont(0.5) within group (order by "P03VA".dvf_view.valeurfonciere) as "Prix median" 
FROM "P03VA".dvf_view where deptcodetrinum in (6) and valeurfonciere IS NOT null group by communear,deptnom order by deptnom,Prix_Immo_Moy desc limit 3),
Top13 as (select deptnom,communear,round(( AVG(valeurfonciere)),0) as Prix_Immo_Moy,
percentile_cont(0.5) within group (order by "P03VA".dvf_view.valeurfonciere) as "Prix median"
FROM "P03VA".dvf_view where deptcodetrinum in (13) and valeurfonciere IS NOT null group by communear,deptnom order by deptnom,Prix_Immo_Moy desc limit 3),
Top33 as (SELECT deptnom,communear,round(( AVG(valeurfonciere)),0) as Prix_Immo_Moy,
percentile_cont(0.5) within group (order by "P03VA".dvf_view.valeurfonciere) as "Prix median" 
FROM "P03VA".dvf_view where deptcodetrinum in (33) and valeurfonciere IS NOT null group by communear,deptnom order by deptnom,Prix_Immo_Moy desc limit 3),
Top59 as (SELECT deptnom,communear,round(( AVG(valeurfonciere)),0) as Prix_Immo_Moy ,
percentile_cont(0.5) within group (order by "P03VA".dvf_view.valeurfonciere) as "Prix median"
FROM "P03VA".dvf_view where deptcodetrinum in (59) and valeurfonciere IS NOT null group by communear,deptnom order by deptnom,Prix_Immo_Moy desc limit 3),
Top69 as (SELECT deptnom,communear,round(( AVG(valeurfonciere)),0) as Prix_Immo_Moy ,
percentile_cont(0.5) within group (order by "P03VA".dvf_view.valeurfonciere) as "Prix median" 
FROM "P03VA".dvf_view where deptcodetrinum in (69) and valeurfonciere IS NOT null group by communear,deptnom order by deptnom,Prix_Immo_Moy desc limit 3)
select *from Top06 union select *from Top13 union select *from Top33 union select *from Top59 union select *from Top69
order by deptnom,Prix_Immo_Moy desc;


--verif 
SELECT 
deptnom,communear,round(( AVG(valeurfonciere)),0) as Prix_Immo_Moy , valeurfonciere
FROM "P03VA".dvf_view 
where deptcodetrinum in (6) and valeurfonciere IS NOT null and communear like 'SAINT-JEAN-CAP-FERRA%'
group by communear,deptnom,valeurfonciere 
order by deptnom,Prix_Immo_Moy desc ;

SELECT 
deptnom,communear,round(( AVG(valeurfonciere)),0) as Prix_Immo_Moy , valeurfonciere
FROM "P03VA".dvf_view 
where deptcodetrinum in (6) and valeurfonciere IS NOT null and communear like 'EZE%'
group by communear,deptnom,valeurfonciere 
order by deptnom,Prix_Immo_Moy desc ;

SELECT 
deptnom,communear,round(( AVG(valeurfonciere)),0) as Prix_Immo_Moy , valeurfonciere
FROM "P03VA".dvf_view 
where deptcodetrinum in (6) and valeurfonciere IS NOT null and communear like 'MOUANS-SART%'
group by communear,deptnom,valeurfonciere 
order by deptnom,Prix_Immo_Moy desc ;

SELECT 
deptnom,communear,round(( AVG(valeurfonciere)),0) as Prix_Immo_Moy , valeurfonciere
FROM "P03VA".dvf_view 
where deptcodetrinum in (33) and valeurfonciere IS NOT null and communear like 'LEGE-CAP-FE%'
group by communear,deptnom,valeurfonciere 
order by deptnom,Prix_Immo_Moy desc ;



--- TOP 3 communes de chaque departements de la liste 
--Version With  .... AS  & Union 
with
Top06 as (SELECT deptnom,communear,round(( AVG(valeurfonciere)),0) as Prix_Immo_Moy
FROM "P03VA".dvf_view 
where deptcodetrinum in (6) and valeurfonciere IS NOT null group by communear,deptnom order by deptnom,Prix_Immo_Moy desc limit 3),
Top13 as (select deptnom,communear,round(( AVG(valeurfonciere)),0) as Prix_Immo_Moy 
FROM "P03VA".dvf_view 
where deptcodetrinum in (13) and valeurfonciere IS NOT null group by communear,deptnom order by deptnom,Prix_Immo_Moy desc limit 3),
Top33 as (SELECT deptnom,communear,round(( AVG(valeurfonciere)),0) as Prix_Immo_Moy 
FROM "P03VA".dvf_view 
where deptcodetrinum in (33) and valeurfonciere IS NOT null group by communear,deptnom order by deptnom,Prix_Immo_Moy desc limit 3),
Top59 as (SELECT deptnom,communear,round(( AVG(valeurfonciere)),0) as Prix_Immo_Moy 
FROM "P03VA".dvf_view 
where deptcodetrinum in (59) and valeurfonciere IS NOT null group by communear,deptnom order by deptnom,Prix_Immo_Moy desc limit 3),
Top69 as (SELECT deptnom,communear,round(( AVG(valeurfonciere)),0) as Prix_Immo_Moy 
FROM "P03VA".dvf_view 
where deptcodetrinum in (69) and valeurfonciere IS NOT null group by communear,deptnom order by deptnom,Prix_Immo_Moy desc limit 3)
select *from Top06 union select *from Top13 union  select *from Top33 union  select *from Top59 union 
select *from Top69
order by deptnom,Prix_Immo_Moy desc;


--Vérification cohérence résultats
SELECT 
deptnom,communear,round(( AVG(valeurfonciere)),0) as Prix_Immo_Moy
FROM "P03VA".dvf_view
where deptcodetrinum in (69) and valeurfonciere IS NOT null and communear like 'LYON%'
group by rollup  (deptnom,communear)

SELECT 
deptnom,communeville,round(( AVG(valeurfonciere)),0) as Prix_Immo_Moy
FROM "P03VA".dvf_view
where deptcodetrinum in (69) and valeurfonciere IS NOT null and communear like 'LYON%'
group by rollup  (deptnom,communeville)
; 





---Etapes intermediaire 
----- PBr Il faut lister au top 3 de chaque commune ! 
SELECT 
deptnom,communear,round(( AVG(valeurfonciere)),0) as Prix_Immo_Moy
FROM "P03VA".dvf_view
where deptcodetrinum in (6,13,33,59,69) and valeurfonciere IS NOT null
group by rollup  (deptnom,communear)
; 




--- Ajoute médiane à la requette ppour limiter les valeurs abérantes 

--Calcul mediane pour limiter impact  des valeurs abérrantes 
select percentile_disc(0.5) within group (order by things.value)
from things




SELECT 
percentile_disc(0.5) within group (order by "P03VA".dvf_view.valeurfonciere)
FROM "P03VA".dvf_view
where deptcodetrinum in (6) and valeurfonciere IS NOT null;

SELECT 
percentile_cont(0.5) within group (order by "P03VA".dvf_view.valeurfonciere)
FROM "P03VA".dvf_view
where deptcodetrinum in (6) and valeurfonciere IS NOT null;

--- `percentile_disc` will return a value from the input set closest to the percentile you request
---- `percentile_cont` will return an interpolated value between multiple values based on the distribution. You can think of this as being more accurate, but can return a fractional value between the two values from the input





--- TOP 3 communes de chaque departements de la liste Commune Arrondissements
with
Top06 as (SELECT deptnom,communear,round(( AVG(valeurfonciere)),0) as Prix_Immo_Moy, percentile_cont(0.5) within group (order by "P03VA".dvf_view.valeurfonciere) as "mediane" FROM "P03VA".dvf_view where deptcodetrinum in (6) and valeurfonciere IS NOT null group by communear,deptnom order by deptnom,Prix_Immo_Moy desc limit 3),
Top13 as (select deptnom,communear,round(( AVG(valeurfonciere)),0) as Prix_Immo_Moy, percentile_cont(0.5) within group (order by "P03VA".dvf_view.valeurfonciere) as "mediane" FROM "P03VA".dvf_view where deptcodetrinum in (13) and valeurfonciere IS NOT null group by communear,deptnom order by deptnom,Prix_Immo_Moy desc limit 3),
Top33 as (SELECT deptnom,communear,round(( AVG(valeurfonciere)),0) as Prix_Immo_Moy, percentile_cont(0.5) within group (order by "P03VA".dvf_view.valeurfonciere) as "mediane" FROM "P03VA".dvf_view where deptcodetrinum in (33) and valeurfonciere IS NOT null group by communear,deptnom order by deptnom,Prix_Immo_Moy desc limit 3),
Top59 as (SELECT deptnom,communear,round(( AVG(valeurfonciere)),0) as Prix_Immo_Moy , percentile_cont(0.5) within group (order by "P03VA".dvf_view.valeurfonciere) as "mediane"FROM "P03VA".dvf_view where deptcodetrinum in (59) and valeurfonciere IS NOT null group by communear,deptnom order by deptnom,Prix_Immo_Moy desc limit 3),
Top69 as (SELECT deptnom,communear,round(( AVG(valeurfonciere)),0) as Prix_Immo_Moy , percentile_cont(0.5) within group (order by "P03VA".dvf_view.valeurfonciere) as "mediane"FROM "P03VA".dvf_view where deptcodetrinum in (69) and valeurfonciere IS NOT null group by communear,deptnom order by deptnom,Prix_Immo_Moy desc limit 3)
select *from Top06
union
select *from Top13
union 
select *from Top33
union 
select *from Top59
union 
select *from Top69
order by deptnom,Prix_Immo_Moy desc;




--- TOP 3 communes de chaque departements de la liste Commune Arrondissements
with
Top06 as (SELECT deptnom,communear,round(( AVG(valeurfonciere)),0) as Prix_Immo_Moy, percentile_disc(0.5) within group (order by "P03VA".dvf_view.valeurfonciere) as "mediane disc" FROM "P03VA".dvf_view where deptcodetrinum in (6) and valeurfonciere IS NOT null group by communear,deptnom order by deptnom,Prix_Immo_Moy desc limit 3),
Top13 as (select deptnom,communear,round(( AVG(valeurfonciere)),0) as Prix_Immo_Moy, percentile_disc(0.5) within group (order by "P03VA".dvf_view.valeurfonciere) as "mediane disc" FROM "P03VA".dvf_view where deptcodetrinum in (13) and valeurfonciere IS NOT null group by communear,deptnom order by deptnom,Prix_Immo_Moy desc limit 3),
Top33 as (SELECT deptnom,communear,round(( AVG(valeurfonciere)),0) as Prix_Immo_Moy, percentile_disc(0.5) within group (order by "P03VA".dvf_view.valeurfonciere) as "mediane disc" FROM "P03VA".dvf_view where deptcodetrinum in (33) and valeurfonciere IS NOT null group by communear,deptnom order by deptnom,Prix_Immo_Moy desc limit 3),
Top59 as (SELECT deptnom,communear,round(( AVG(valeurfonciere)),0) as Prix_Immo_Moy , percentile_disc(0.5) within group (order by "P03VA".dvf_view.valeurfonciere) as "mediane disc" FROM "P03VA".dvf_view where deptcodetrinum in (59) and valeurfonciere IS NOT null group by communear,deptnom order by deptnom,Prix_Immo_Moy desc limit 3),
Top69 as (SELECT deptnom,communear,round(( AVG(valeurfonciere)),0) as Prix_Immo_Moy , percentile_disc(0.5) within group (order by "P03VA".dvf_view.valeurfonciere) as "mediane disc" FROM "P03VA".dvf_view where deptcodetrinum in (69) and valeurfonciere IS NOT null group by communear,deptnom order by deptnom,Prix_Immo_Moy desc limit 3)
select *from Top06
union
select *from Top13
union 
select *from Top33
union 
select *from Top59
union 
select *from Top69
order by deptnom,Prix_Immo_Moy desc;
