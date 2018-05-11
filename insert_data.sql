-- Insertion des caracteristiques
INSERT INTO caracteristiques(equipementid,nom) VALUES
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
