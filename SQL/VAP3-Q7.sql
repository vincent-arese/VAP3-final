--7. Liste des communes où le nombre de ventes a augmenté d'au moins 20% entre le premier et le second trimestre de 2020
--- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- 
select TotalVentesComQ1_view.communeville ,
totalventescomq1 ,totalventescomq2,
totalventescomq2-totalventescomq1 as delta, 
(((totalventescomq2-totalventescomq1)::float/totalventescomq1)*100)::DECIMAL (6,2) as "%Var nb ventes"
from TotalVentesComQ2_view,TotalVentesComQ1_view 
where TotalVentesComQ2_view.communeville=TotalVentesComQ1_view.communeville 
	and (((totalventescomq2-totalventescomq1)::float/totalventescomq1)*100)::DECIMAL (6,2)>20 
order by "%Var nb ventes" desc ;

--ventes Q2 2020 detail 
create OR REPLACE VIEW  TotalVentesComQ2_view as 
 select   communeville,  count(communeid) as TotalVentesComQ2
FROM "P03VA".dvf_view  as VentesQ2
where mutationyear = 2020 and mutationquarter=2 and typelocalcode <=2
group by communeville
order by communeville ASC;

--ventes Q1 2020 detail 
create OR REPLACE VIEW TotalVentesComQ1_view as 
 select communeville ,  count(communeid) as TotalVentesComQ1
FROM "P03VA".dvf_view as VentesQ1
where mutationyear = 2020 and mutationquarter=1 and typelocalcode <=2
group by communeville
order by communeville asc 

-- nbr de villes concernées
select count(*)
from TotalVentesComQ2_view,TotalVentesComQ1_view 
where TotalVentesComQ2_view.communeville=TotalVentesComQ1_view.communeville 
	and (((totalventescomq2-totalventescomq1)::float/totalventescomq1)*100)::DECIMAL (6,2)>20 ;








-- Liste commune avec evolution ventes Q1vsQ2  --- Attention pbr resuluta division que des entiers ! 
select TotalVentesComQ1_view.communeville ,
totalventescomq1 ,totalventescomq2,
totalventescomq2-totalventescomq1 as delta, 
(((totalventescomq2-totalventescomq1)/totalventescomq1)*100) as Calcul_var,
(((totalventescomq2-totalventescomq1)::float/totalventescomq1)*100)::DECIMAL (6,2) as "%Var nb ventes"
from TotalVentesComQ2_view,TotalVentesComQ1_view 
where TotalVentesComQ2_view.communeville=TotalVentesComQ1_view.communeville 
	and (((totalventescomq2-totalventescomq1)::float/totalventescomq1)*100)::DECIMAL (6,2)>20 
order by (((totalventescomq2-totalventescomq1)::float/totalventescomq1)*100)::DECIMAL (6,2) desc ;