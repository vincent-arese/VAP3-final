-- 6. Taux d��volution du nombre de ventes entre le premier et le second trimestre de 2020.
--- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- 
with 
Q1 as (select count(*) as VQ1 FROM "P03VA".dvf_view where mutationyear=2020 and mutationquarter=1),
Q2 as (select count(*) as VQ2 FROM "P03VA".dvf_view where mutationyear=2020 and mutationquarter=2)
select VQ1,VQ2, VQ2-VQ1 as delta , (((VQ2-VQ1)::float/VQ1)*100)::DECIMAL(4,2) as "Taux variation %"
from Q1,Q2 ;

-- OK code optimis� ---> arondib ok ! 


--ventes Q1 & Q2 2020 => OK verifi� 
select count(*) FROM "P03VA".dvf_view as VentesQ2 where mutationyear=2020 and mutationquarter=2  ; --==>17393
select count(*) FROM "P03VA".dvf_view as VentesQ2 where mutationyear=2020 and mutationquarter=1  ; --==>16776
																								      -- D2-Q1 = + 617 soit + 3.6677%

--ventes Q1 2020 detail
select  mutationyear, mutationquarter,typelocal, count(typelocalcode) as nbr
FROM "P03VA".dvf_view
where mutationyear = 2020 and mutationquarter =1 and typelocalcode <=2
group by mutationyear, mutationquarter,typelocal
;

--ventes Q2 2020 detail 
 select  mutationyear, mutationquarter,typelocal, count(typelocalcode) as nbr
FROM "P03VA".dvf_view
where mutationyear = 2020 and mutationquarter =2 and typelocalcode <=2
group by mutationyear, mutationquarter,typelocal
;