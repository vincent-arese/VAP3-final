--4. Prix moyen du m�tre carr� d�une maison en �le-de-France.
--- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- 

--- Ok avec arrondi 
SELECT 
round( (AVG((valeurfonciere/surfacereellebati))),0) as Prix_m�_Bati_Maison_IDF
FROM "P03VA".dvf_view
where regioncode=11 and typelocalcode=1
;


--- Verif  coh�rance des donn�es  Probleme sur le 75  avec donn�es aberrantes

SELECT 
regionnom,
round( (AVG((valeurfonciere/surfacereellebati))),0) as Prix_m�_Bati
FROM "P03VA".dvf_view
where regioncode<=1100 and typelocalcode<=2
group by regionnom
order by Prix_m�_Bati DESC;



SELECT 
deptcode,
round( (AVG((valeurfonciere/surfacereellebati))),0) as Prix_m�_Bati
FROM "P03VA".dvf_view
where regioncode<=1100 and typelocalcode<=2
group by deptcode
order by Prix_m�_Bati DESC;







