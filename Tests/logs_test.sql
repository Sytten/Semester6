SELECT truncate_all_tables('POSTGRES');

INSERT INTO membres(cip, faculteID, departementID, nom, prenom) VALUES
 ('girp2705', 18, 08, 'girard', 'philippe');
 
 DELETE from membres where cip = 'girp2705';