-- Insertion des caracteristiques
INSERT INTO caracteristiques(equipementid,nom) VALUES
 (0,'Connexion à Internet')
,(1,'Tables fixes en U et chaises mobiles')
,(2,'Monoplaces')
,(3,'Tables fixes et chaises fixes')
,(6,'Tables pour 2 ou + et chaises mobiles')
,(7,'Tables mobiles et chaises mobiles')
,(8,'Tables hautes et chaises hautes')
,(9,'Tables fixes et chaises mobiles')
,(11,'Écran')
,(14,'Rétroprojecteur')
,(15,'Gradins')
,(16,'Fenêtres')
,(17,'1 piano')
,(18,'2 pianos')
,(19,'Autres instruments')
,(20,'Système de son')
,(21,'Salle réservée (spéciale)')
,(22,'Ordinateurs PC')
,(23,'Ordinateurs SUN pour génie électrique')
,(24,'Console multimédia')
,(25,'Ordinateurs (oscillomètre et multimètre)')
,(26,'Ordinateurs modélisation des structures')
,(27,'Ordinateurs PC')
,(28,'Équipement pour microélectronique')
,(29,'Équipement pour génie électrique')
,(30,'Ordinateurs et équipement pour mécatroni')
,(31,'Équipement métrologie')
,(32,'Équipement de machinerie')
,(33,'Équipement de géologie')
,(34,'Équipement pour la caractérisation')
,(35,'Équipement pour la thermodynamique')
,(36,'Équipement pour génie civil')
,(37,'Télévision')
,(38,'VHS')
,(39,'Hauts parleurs')
,(40,'Micro')
,(41,'Magnétophone à cassette')
,(42,'Amplificateur audio')
,(43,'Local barré')
,(44,'Prise réseau');

-- Insertion des categories
INSERT INTO categories(categorieid,nom) VALUES
 (0110,'Salle de classe générale')
,(0111,'Salle de classe spécialisée')
,(0120,'Salle de séminaire')
,(0121,'Cubicules')
,(0210,'Laboratoire informatique')
,(0211,'Laboratoire d’enseignement spécialisé')
,(0212,'Atelier')
,(0213,'Salle à dessin')
,(0214,'Atelier (civil)')
,(0215,'Salle de musique')
,(0216,'Atelier sur 2 étages conjoint avec autre local')
,(0217,'Salle de conférence')
,(0372,'Salle de réunion')
,(0373,'Salle d’entrevue et de tests')
,(0510,'Salle de lecture ou de consultation')
,(0620,'Auditorium')
,(0625,'Salle de concert')
,(0640,'Salle d’audience')
,(0930,'Salon du personnel')
,(1030,'Studio d’enregistrement')
,(1260,'Hall d’entrée');

-- Insertion des campus et pavillons
INSERT INTO campus(campusid, nom) VALUES
 (0,'Campus principal')
,(1,'Campus de longueuil')
,(2,'Campus de la santé');

INSERT INTO pavillons(numeropavillon, campusid, nom) VALUES
 ('C1', 0, 'Pavillon Joseph-Armand Bombardier')
,('C2', 0, 'Pavillon Joseph-Armand Bombardier C2')
,('D7', 0, 'Pavillon Marie-Victorin');

INSERT INTO facultes(faculteid, nom) VALUES
 (18,'Génie');

INSERT INTO departements(departementID, faculteID, nom) VALUES
 (08,18,'Département génie électrique et informatique');
