-- Insertion des membres, status et privileges
INSERT INTO membres(cip, faculteID, departementID, nom, prenom) VALUES
 ('girp2705',18,8,'philippe','girard')
,('fuge2701',18,8,'emile','fugulin')
,('jacr2222',18,8,'romain','something');

INSERT INTO statusmembre(cip, statusid) VALUES
 ('girp2705',3)
,('fuge2701',1)
,('jacr2222',0);
