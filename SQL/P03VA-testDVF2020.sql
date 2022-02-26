----- test Fichier valeurs Fonciere 2020 


-- Recherche Surface reelle bati < Surface Carrez du 1er lot
select
("Surface reelle bati"-"Surface Carrez du 1er lot") as deltasurface,
"Surface reelle bati",
"1er lot", "Surface Carrez du 1er lot",
"Date mutation", 
"Nature mutation", 
"Valeur fonciere", 
concat("No voie",' ', "B/T/Q",' ', "Type de voie", ' ',"Code voie",' ', voie, ' ',"Code postal",' ', commune, ' ',"Code departement", ' ',"Code commune") as adresse, 
concat ("Prefixe de section",'-', "Section", '-',"No plan",'-', "No Volume") as cadastrreinfo, 
"1er lot","Surface Carrez du 1er lot",
"2eme lot", "Surface Carrez du 2eme lot", 
"3eme lot", "Surface Carrez du 3eme lot",
"4eme lot", "Surface Carrez du 4eme lot", 
"5eme lot", "Surface Carrez du 5eme lot", 
"Nombre de lots", 
"Code type local", "Type local",
"Identifiant local",
"Nombre pieces principales", 
"Nature culture", 
"Nature culture speciale",
"Surface terrain" 
FROM "DVF2020"."valeursfoncieres-2020.txt"
where  "Surface reelle bati"<"Surface Carrez du 1er lot"
order by deltasurface
;


--- estimation  Surface reelle bati < Surface Carrez du 1er lot

--
(select count (*) FROM "DVF2020"."valeursfoncieres-2020.txt" where  "Surface reelle bati"<"Surface Carrez du 1er lot"); -- 143 994 
(select count (*) FROM "DVF2020"."valeursfoncieres-2020.txt"); -- 3 149 482 
---


--estimation avec %
select 
(select count (*) FROM "DVF2020"."valeursfoncieres-2020.txt" where  "Surface reelle bati"<"Surface Carrez du 1er lot") as "Nb Pb Surface Bati < Carrez",
(select count (*) FROM "DVF2020"."valeursfoncieres-2020.txt") as "Total mutations",
(((select count (*) FROM "DVF2020"."valeursfoncieres-2020.txt" where  "Surface reelle bati"<"Surface Carrez du 1er lot")/
((select count (*) FROM "DVF2020"."valeursfoncieres-2020.txt")::float))*100)::decimal(4,2)
as "% erreurs"
FROM "DVF2020"."valeursfoncieres-2020.txt" limit 1.








select
"Code service CH", "Reference document", 
"1 Articles CGI", "2 Articles CGI", "3 Articles CGI", "4 Articles CGI", "5 Articles CGI", 
"No disposition", 
"Date mutation", 
"Nature mutation", 
"Valeur fonciere", 
"No voie", "B/T/Q", "Type de voie", "Code voie", voie, "Code postal", commune, "Code departement", "Code commune", 
"Prefixe de section", "Section", "No plan", "No Volume", 
"1er lot", "Surface Carrez du 1er lot",
"2eme lot", "Surface Carrez du 2eme lot", 
"3eme lot", "Surface Carrez du 3eme lot",
"4eme lot", "Surface Carrez du 4eme lot", 
"5eme lot", "Surface Carrez du 5eme lot", 
"Nombre de lots", 
"Code type local", "Type local",
"Identifiant local",
"Surface reelle bati",
"Nombre pieces principales", 
"Nature culture", 
"Nature culture speciale",
"Surface terrain" 
FROM "DVF2020"."valeursfoncieres-2020.txt";


