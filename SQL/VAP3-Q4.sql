--4. Prix moyen du mètre carré d’une maison en Île-de-France.
--- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- 

--- Ok avec arrondi 
SELECT 
round( (AVG((valeurfonciere/surfacereellebati))),0) as Prix_m²_Bati_Maison_IDF
FROM "P03VA".dvf_view
where regioncode=11 and typelocalcode=1
;


--- Verif  cohérance des données  Probleme sur le 75  avec données aberrantes

SELECT 
regionnom,
round( (AVG((valeurfonciere/surfacereellebati))),0) as Prix_m²_Bati
FROM "P03VA".dvf_view
where regioncode<=1100 and typelocalcode<=2
group by regionnom
order by Prix_m²_Bati DESC;



SELECT 
deptcode,
round( (AVG((valeurfonciere/surfacereellebati))),0) as Prix_m²_Bati
FROM "P03VA".dvf_view
where regioncode<=1100 and typelocalcode<=2
group by deptcode
order by Prix_m²_Bati DESC;







