--Q1. Nombre total d’appartements vendus au 1er semestre 2020.
--- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- 
select
typelocal,count(typelocalcode) as nbr_appt
FROM "P03VA".dvf_view
where mutationyear = 2020 and mutationquarter <=2 and typelocalcode =2
group by typelocal
;



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