
-- Insertion des données
INSERT INTO statu_candidat (nom) VALUES
('pardefaut'),
('rejete'),
('classifie'),
('entretien'),
('interviewee'),
('offre_embauche'),
('sous_contrat_essaie'),
('personnelpermanent');

INSERT INTO statu_poste (nom) VALUES
('inactif'),
('vacant'),
('occupe'),
('offre');

INSERT INTO genre (n_genre) VALUES
('Masculin'),
('Féminin'),
('tous');

INSERT INTO diplome (nom_diplome) VALUES
('Baccalauréat'),
('Licence_informatique'),
('Master_informatique'),
('Licence_Réseaux_télécommunication'),
('Licence_Marketing'),
('Master_Commerce'),
('Licence_RH');

INSERT INTO degre_diplome (nom_degre) VALUES
('Bac+0'),
('Bac+3'),
('Bac+5');

INSERT INTO lieu (nom_lieu) VALUES
('Antananarivo'),
('Toamasina'),
('Fianarantsoa');

INSERT INTO hauthierarchi (nom_occupation, nom_occupant, mdp, chef_departement, id_departement, interface) VALUES
('RH', 'Sandrone', 'pass123', 5, NULL, 'RH'),
('Manager', 'Aino', 'pass123', 4, NULL, 'MOp'),
('Manager', 'Noro', 'pass123', 5, NULL, 'MOp'),
('Manager', 'Charlotte', 'pass123', 6, NULL, 'MOp'),
('Manager', 'Ajax', 'pass123', 5, NULL, 'MOp'),
('Chef de département', 'Inefa', 'pass123', 1, NULL, 'Admin'),
('Chef de département', 'Tsarine', 'pass123', 1, NULL, 'Admin'),
('Chef de département', 'Navia', 'pass123', 1, NULL, 'Admin'),
('Chef de département', 'Mora', 'pass123', 1, NULL, 'Admin');

INSERT INTO departement (nom_departement, id_chef_departement) VALUES
('Informatique', 6),
('Ressources Humaines', 7),
('Marketing', 8),
('Finance',9);



INSERT INTO poste (nom_poste, id_departement, id_manager_op, salaire , id_diplome_requis, id_degre_diplome_requis, id_genre_requis, id_lieu_requis, age_requis , id_statu_poste ) VALUES
('Développeur Web', 1, 2, 200000 , 2, 2, 3, 1, 20 , 2 ),
('RH Assistant', 2, 3, 200000 , 7, 2, 3, 1, 20 , 2 ),
('Marketing Lead', 3, 4, 200000 , 6, 3, 3, 2, 25 , 2 );

INSERT INTO annonce (id_poste, id_manager_op, statut_offre) VALUES
(1, 2, 'non_creee'),
(2, 1, 'non_creee'),
(3, 2, 'non_creee');

INSERT INTO profil (nom_profil, id_diplome_requis, id_genre_requis, id_lieu_requis, age_requis) VALUES
('Profil Junior', 1, 1, 1, 22),
('Profil Senior', 3, 2, 2, 28);

INSERT INTO candidat (nom, prenom, tel, mail, id_diplome, id_profil_candidat, dtn, id_adresse, id_genre, taille, poids,id_statu_candidat,id_poste_candidat, path_photo) VALUES
('Rakoto', 'Jean', '0341234567', 'jean.rakoto@mail.com', 2, 1, '1998-05-12', 1, 1, 1.75, 70 , 1 , 1 , 'uploads/photopardefaut'),
('Rasoa', 'Marie', '0339876543', 'marie.rasoa@mail.com', 3, 2, '1995-10-20', 2, 2, 1.65, 60 , 1 ,2 , 'uploads/photopardefaut');

-- tsy miditra
INSERT INTO entretien (date_entretien, id_candidat, presence, score, nom_responsable) VALUES
('2025-09-15', 1, 'Présent', 15, 'Rija'),
('2025-09-16', 2, 'Absent', NULL, 'Noro');

INSERT INTO offre_emploi (id_annonce, statut) VALUES
(1, 'active'),
(2, 'active');

-- tsy miditra
INSERT INTO offre_embauche (id_candidat, statu, nb_contact) VALUES
(1, 1, 2),
(2, 0, 1);

INSERT INTO test (dateTest, id_hierarchi) VALUES
('2025-09-20', 1),
('2025-09-20', 1);

INSERT INTO question (question, idTest) VALUES
('Quelle est votre expérience en développement ?', 1),
('quelle d entre eux est un language de programation ?', 1),
('lequelle d entre eux est un outil logiciel ?', 1),
('comment s appelle l entreprise ?', 1),
('Quelle est votre experience dans le milieu du travail', 2),
('combien de jour met - on pour finir un projet de 72h si on travail 8H/jr ', 2),
('combien de logiciel bureautique maitrisez vous ?', 2),
('quelle est le nom de l entreprise ', 2);


-- test 1
INSERT INTO reponse (idQuestion, reponse, points) VALUES
(1, '2 ans en entreprise', 5),
(1, 'Stage de 6 mois', 2),
(2, 'java', 5),
(2, 'chrome', 0),
(3, 'processeur', 0),
(3, 'excel', 5),
(4, 'Tomato express', 0),
(4,'Entreprise' , 5);

-- teste 2
INSERT INTO reponse (idQuestion, reponse, points) VALUES
(5, '2 ans en entreprise', 5),
(5, 'Stage de 6 mois', 2),
(6, '8 jr - 10jr ', 5),
(6, '3 jr', 2),
(7, '1 logiciel', 0),
(7, '5 logiciels plus', 5),
(8, 'Gastropizza', 0),
(8,'Entreprise' , 5);

-- tsy miditra 
INSERT INTO scoring (points, idTest, id_candidat) VALUES
(5, 1, 1),
(2, 1, 2);

INSERT INTO team_op (id_departement, id_manager_op) VALUES
(1, 2),
(2, 1);