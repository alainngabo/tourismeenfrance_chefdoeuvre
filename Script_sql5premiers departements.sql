#Quels sont les 5 départements qui ont accueillis le plus de touristes en 2020
use tourisme;
select nom_departement as "departement", round(sum(arrivees)) as "nombre de touristes" from departement as d
join indicateurs_sejour as i
on i.code_departement = d.code_departement
join table_date as t
on t.id_date = i.id_date
where annee = 2020
group by nom_departement
order by round(sum(arrivees)) desc
limit 5;