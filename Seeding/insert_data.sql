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

-- Insertion des facultes et departements
INSERT INTO facultes(faculteid, nom) VALUES
 (18,'Génie');

INSERT INTO departements(departementID, faculteID, nom) VALUES
 (08,18,'Département génie électrique et informatique');

-- Insertion des locaux et leurs caracteristiques
INSERT INTO locaux(numeropavillon, numero, pavillonparent, localparent, categorieid, capacite, note) VALUES
 ('C1',1007,null,null,0212,21,'Grand')
,('C1',2018,null,null,0212,10,'Matériaux composites')
,('C1',2055,null,null,0211,24,'')
,('C1',3014,null,null,0211,25,'Laboratoire mécatronique')
,('C1',3027,null,null,0211,15,'Petit laboratoire de élect')
,('C1',3016,null,null,0210,50,'')
,('C1',3018,null,null,0211,50,'')
,('C1',3024,null,null,0211,50,'')
,('C1',3035,null,null,0210,50,'')
,('C1',3041,null,null,0210,50,'')
,('C1',3007,null,null,0620,106,'Avec console multi-média')
,('C1',3010,null,null,0211,30,'Laboratoire de conception VLSI')
,('C1',4016,null,null,0620,91,'')
,('C1',4018,null,null,0212,10,'Métallurgie')
,('C1',4019,null,null,0212,8,'Laboratoire accessoire Atelier')
,('C1',4021,null,null,0210,28,'')
,('C1',4023,null,null,0620,108,'')
,('C1',4030,null,null,0211,25,'Équipement photoélasticité')
,('C1',4028,null,null,0210,14,'')
,('C1',4008,null,null,0620,106,'')
,('C1',5012,null,null,0121,35,'8 cubicules')
,('C1',5026,null,null,0210,38,'Ordinateurs')
,('C1',5028,null,null,0210,50,'Ordinateurs')
,('C1',5001,null,null,0620,198,'Avec console multi-média')
,('C1',5009,null,null,0111,50,'Avec console multi-média')
,('C1',5006,null,null,0620,110,'Avec console multi-média')
,('C2',0009,null,null,0214,100,'Grand et équipé')
,('C2',1004,null,null,0212,30,'Atelier géologie équipement')
,('C2',1015,null,null,0211,40,'Laboratoire d’hydraulique')
,('C2',1042,null,null,0211,21,'Laboratoire chimie-physique')
,('C2',2040,null,null,0211,40,'Laboratoire sans instrument')
,('C2',251,null,null,0211,10,'')
,('C2',4,'C2',251,0211,10,'')
,('D7',2018,null,null,0111,57,'')
,('D7',3001,null,null,0110,35,'')
,('D7',3002,null,null,0110,22,'')
,('D7',3007,null,null,0110,54,'')
,('D7',3009,null,null,0110,45,'')
,('D7',3010,null,null,0110,21,'')
,('D7',3011,null,null,0110,50,'')
,('D7',3012,null,null,0110,54,'')
,('D7',3013,null,null,0110,44,'')
,('D7',3014,null,null,0110,40,'')
,('D7',3015,null,null,0110,48,'')
,('D7',3016,null,null,0620,125,'Avec console multi-média')
,('D7',3017,null,null,0110,45,'')
,('D7',3019,null,null,0110,48,'')
,('D7',3020,null,null,0110,35,'Un mur est en fenêtre');

INSERT INTO caracteristiquelocal(equipementid, numeropavillon, numero) VALUES
(30,'C1',3014)
,(22,'C1',3035)
,(11,'C1',3041)
,(22,'C1',3041)
,(11,'C1',3007)
,(14,'C1',3007)
,(24,'C1',3007)
,(38,'C1',3007)
,(40,'C1',3007)
,(11,'C1',4016)
,(14,'C1',4016)
,(40,'C1',4016)
,(24,'C1',4016)
,(22,'C1',4021)
,(11,'C1',4023)
,(14,'C1',4023)
,(24,'C1',4023)
,(38,'C1',4023)
,(40,'C1',4023)
,(22,'C1',4028)
,(11,'C1',4008)
,(14,'C1',4008)
,(24,'C1',4008)
,(38,'C1',4008)
,(40,'C1',4008)
,(11,'C1',5026)
,(14,'C1',5026)
,(22,'C1',5026)
,(11,'C1',5028)
,(14,'C1',5028)
,(22,'C1',5028)
,(11,'C1',5001)
,(14,'C1',5001)
,(24,'C1',5001)
,(38,'C1',5001)
,(40,'C1',5001)
,(11,'C1',5009)
,(14,'C1',5009)
,(24,'C1',5009)
,(38,'C1',5009)
,(40,'C1',5009)
,(11,'C1',5006)
,(14,'C1',5006)
,(24,'C1',5006)
,(38,'C1',5006)
,(40,'C1',5006)
,(33,'C2',1004)
,(07,'D7',2018)
,(11,'D7',2018)
,(14,'D7',2018)
,(43,'D7',2018)
,(02,'D7',3001)
,(11,'D7',3001)
,(14,'D7',3001)
,(02,'D7',3002)
,(11,'D7',3002)
,(14,'D7',3002)
,(02,'D7',3007)
,(11,'D7',3007)
,(02,'D7',3009)
,(11,'D7',3009)
,(02,'D7',3010)
,(11,'D7',3010)
,(14,'D7',3010)
,(02,'D7',3011)
,(11,'D7',3011)
,(14,'D7',3011)
,(02,'D7',3012)
,(11,'D7',3012)
,(14,'D7',3012)
,(02,'D7',3013)
,(11,'D7',3013)
,(14,'D7',3013)
,(02,'D7',3014)
,(11,'D7',3014)
,(14,'D7',3014)
,(02,'D7',3015)
,(11,'D7',3015)
,(11,'D7',3016)
,(14,'D7',3016)
,(24,'D7',3016)
,(39,'D7',3016)
,(43,'D7',3016)
,(02,'D7',3017)
,(11,'D7',3017)
,(14,'D7',3017)
,(02,'D7',3019)
,(11,'D7',3019)
,(14,'D7',3019)
,(02,'D7',3020)
,(11,'D7',3020)
,(14,'D7',3020)
,(16,'D7',3020);
