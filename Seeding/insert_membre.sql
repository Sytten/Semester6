-- Insertion des membres et status
INSERT INTO membres(cip, faculteID, departementID, nom, prenom) VALUES
 ('girp2705',18,8,'philippe','ADMINgirard')
,('fuge2701',18,8,'emile','ETUDIANTfugulin')
,('jacr2222',18,8,'romain','PROFESSEURsomething')
,('pers1234',18,8,'perso','PERSONNEL SOUTIENT');

INSERT INTO statusmembre(cip, statusid) VALUES
 ('girp2705',3)
,('fuge2701',1)
,('jacr2222',0)
,('pers1234',2);

-- Insertion des temps avant reservations
INSERT INTO tempsavantreservation(statusID, categorieID, faculteID, departementID, numerobloc) VALUES
 (0,110,18,8,300)
,(2,110,18,8,300);
