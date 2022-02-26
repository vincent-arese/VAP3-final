-- 2. Proportion des ventes d’appartements par le nombre de pièces.
--- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- 

select 
typelocal as "Type Local", 
nombrepiecesprincipales as "Nombre Pieces Principales",
count(nombrepiecesprincipales) as nbr,
(Select count(typelocalcode) as totalappt  FROM "P03VA".dvf_view as totalAppt where mutationyear = 2020 and mutationquarter <=2 and typelocalcode =2) as "Total Appt",
((count(nombrepiecesprincipales)::float/(Select count(typelocalcode) as totalappt  FROM "P03VA".dvf_view as totalAppt where mutationyear = 2020 and mutationquarter <=2 and typelocalcode =2))*100)::DECIMAL(4,2) as "%"
FROM "P03VA".dvf_view
where mutationyear = 2020 and mutationquarter<=2 and typelocalcode=2
group by nombrepiecesprincipales , typelocal
order by nombrepiecesprincipales ;

--- requette OK 





-- Partiel Ok probleme arrondi 

-- ==> Etape 2 : Requette finale   !!!!!  Reseolution pbr probleme arrondi 
select 
typelocal, nombrepiecesprincipales as NombrePiecesPrincipales,
count(nombrepiecesprincipales) as nbr,
(Select count(typelocalcode) as totalappt  FROM "P03VA".dvf_view as totalAppt where mutationyear = 2020 and mutationquarter <=2 and typelocalcode =2) as TotalAppt,
((count(nombrepiecesprincipales)/(select count(typelocalcode) as totalappt  FROM "P03VA".dvf_view as totalAppt where mutationyear = 2020 and mutationquarter <=2 and typelocalcode =2))*100000) as calcul
FROM "P03VA".dvf_view
where mutationyear = 2020 and mutationquarter<=2 and typelocalcode=2
group by nombrepiecesprincipales , typelocal
order by nombrepiecesprincipales ;


select 
typelocal, nombrepiecesprincipales as NombrePiecesPrincipales,
count(nombrepiecesprincipales) as nbr,
(Select count(typelocalcode) as totalappt  FROM "P03VA".dvf_view as totalAppt where mutationyear = 2020 and mutationquarter <=2 and typelocalcode =2) as totalappt,
((count(nombrepiecesprincipales)/(select count(typelocalcode) as totalappt  FROM "P03VA".dvf_view as totalAppt where mutationyear = 2020 and mutationquarter <=2 and typelocalcode =2))*100000) as calcul,
((count(nombrepiecesprincipales))*10000)/31000 as Pour10000,
(select (5::numeric )as test6 ),
(select (count(typelocalcode)::numeric )as test7 ),
count(nombrepiecesprincipales)::float/31378 as test8,
(count(nombrepiecesprincipales)::float/31378)::DECIMAL(2,2) as test9,
(count(nombrepiecesprincipales)::float/(Select count(typelocalcode) as totalappt  FROM "P03VA".dvf_view as totalAppt where mutationyear = 2020 and mutationquarter <=2 and typelocalcode =2))::DECIMAL(2,2) as test10,
((count(nombrepiecesprincipales)::float/(Select count(typelocalcode) as totalappt  FROM "P03VA".dvf_view as totalAppt where mutationyear = 2020 and mutationquarter <=2 and typelocalcode =2))*100)::DECIMAL(4,2) as test11
FROM "P03VA".dvf_view
where mutationyear = 2020 and mutationquarter<=2 and typelocalcode=2
group by nombrepiecesprincipales , typelocal
order by nombrepiecesprincipales ;





--> Etape 1 : test requette intermédiaire 


-- Resolution pbr arrondi 
typelocal, nombrepiecesprincipales as NombrePiecesPrincipales,
count(nombrepiecesprincipales) as nbr,
(Select count(typelocalcode) as totalappt  FROM "P03VA".dvf_view as totalAppt where mutationyear = 2020 and mutationquarter <=2 and typelocalcode =2) as TotalAppt,
((count(nombrepiecesprincipales)/(select count(typelocalcode) as totalappt  FROM "P03VA".dvf_view as totalAppt where mutationyear = 2020 and mutationquarter <=2 and typelocalcode =2))*100000) as calcul
FROM "P03VA".dvf_view
where mutationyear = 2020 and mutationquarter<=2 and typelocalcode=2
group by nombrepiecesprincipales , typelocal
order by nombrepiecesprincipales ;


select 
typelocal, nombrepiecesprincipales as NombrePiecesPrincipales,
count(nombrepiecesprincipales) as nbr,
(Select count(typelocalcode) as totalappt  FROM "P03VA".dvf_view as totalAppt where mutationyear = 2020 and mutationquarter <=2 and typelocalcode =2) as totalappt,
((count(nombrepiecesprincipales)/(select count(typelocalcode) as totalappt  FROM "P03VA".dvf_view as totalAppt where mutationyear = 2020 and mutationquarter <=2 and typelocalcode =2))*100000) as calcul,
((count(nombrepiecesprincipales))*10000)/31000 as Pour10000,
(select (5::numeric )as test6 ),
(select (count(typelocalcode)::numeric )as test7 ),
count(nombrepiecesprincipales)::float/31378 as test8,
(count(nombrepiecesprincipales)::float/31378)::DECIMAL(2,2) as test9,
(count(nombrepiecesprincipales)::float/(Select count(typelocalcode) as totalappt  FROM "P03VA".dvf_view as totalAppt where mutationyear = 2020 and mutationquarter <=2 and typelocalcode =2))::DECIMAL(2,2) as test10,
((count(nombrepiecesprincipales)::float/(Select count(typelocalcode) as totalappt  FROM "P03VA".dvf_view as totalAppt where mutationyear = 2020 and mutationquarter <=2 and typelocalcode =2))*100)::DECIMAL(4,2) as test11
FROM "P03VA".dvf_view
where mutationyear = 2020 and mutationquarter<=2 and typelocalcode=2
group by nombrepiecesprincipales , typelocal
order by nombrepiecesprincipales ;





-- total par type local Appt ou maison : 
select  typelocal, count(typelocalcode) as nbr_appt FROM "P03VA".dvf_view as totalAppt where mutationyear = 2020 and mutationquarter <=2 and typelocalcode <=2 group by typelocal; 

--Total Appt 
select count(typelocalcode) as totalappt  FROM "P03VA".dvf_view as totalAppt where mutationyear = 2020 and mutationquarter <=2 and typelocalcode =2;
(select count(typelocalcode) as totalappt  FROM "P03VA".dvf_view as totalAppt where mutationyear = 2020 and mutationquarter <=2 and typelocalcode =2);





------------------------------ 
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


