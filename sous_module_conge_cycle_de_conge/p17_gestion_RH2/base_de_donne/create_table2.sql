CREATE TABLE genre (
  id_genre int(11) NOT NULL AUTO_INCREMENT,
  n_genre varchar(100) NOT NULL,
  PRIMARY KEY (id_genre)
);
-- Masculin -- Féminin -- tous

CREATE TABLE diplome (
  id_diplome int(11) NOT NULL AUTO_INCREMENT,
  nom_diplome varchar(150) NOT NULL,
  PRIMARY KEY (id_diplome)
);
-- 1 Baccalauréat -- Licence x -- Master x       , x est la discipline 

CREATE TABLE degre_diplome (
  id_degre_diplome int(11) NOT NULL AUTO_INCREMENT,
  nom_degre varchar(150) NOT NULL,
  PRIMARY KEY (id_degre_diplome)
);
-- pas utiliser pour l instant 

CREATE TABLE lieu (
  id_lieu int(11) NOT NULL AUTO_INCREMENT,
  nom_lieu varchar(150) NOT NULL,
  PRIMARY KEY (id_lieu)
);


CREATE TABLE hauthierarchi (
  id_hierarchi int(11) NOT NULL AUTO_INCREMENT,
  nom_occupation varchar(150) DEFAULT NULL,
  nom_occupant varchar(150) DEFAULT NULL,
  mdp varchar(150) DEFAULT NULL,
  chef_departement tinyint(4) DEFAULT NULL,
  id_departement int(11) DEFAULT NULL,
  interface varchar(50) DEFAULT NULL,
  PRIMARY KEY (id_hierarchi)
);

CREATE TABLE departement (
  id_departement int(11) NOT NULL AUTO_INCREMENT,
  nom_departement varchar(150) NOT NULL,
  id_chef_departement int(11) DEFAULT NULL,
  PRIMARY KEY (id_departement),
  KEY id_chef_departement (id_chef_departement),
  CONSTRAINT departement_ibfk_1 FOREIGN KEY (id_chef_departement) REFERENCES hauthierarchi (id_hierarchi)
);

CREATE TABLE profil (
  id_profil int(11) NOT NULL AUTO_INCREMENT,
  id_annonce int , 
  nom_profil varchar(150) NOT NULL,
  id_diplome_requis int(11) DEFAULT NULL,
  age_requis int(11) DEFAULT NULL,
  id_genre_requis int(11) DEFAULT NULL,
  taille decimal(5,2) DEFAULT NULL,
  poids decimal(5,2) DEFAULT NULL,
  id_lieu_requis int(11) DEFAULT NULL,
  statu int(11) DEFAULT NULL,
  id_test INT ,
  PRIMARY KEY (id_profil),
  KEY id_diplome_requis (id_diplome_requis),
  KEY id_genre_requis (id_genre_requis),
  KEY id_lieu_requis (id_lieu_requis),
  CONSTRAINT profil_ibfk_1 FOREIGN KEY (id_diplome_requis) REFERENCES diplome (id_diplome),
  CONSTRAINT profil_ibfk_2 FOREIGN KEY (id_genre_requis) REFERENCES genre (id_genre),
  CONSTRAINT profil_ibfk_3 FOREIGN KEY (id_lieu_requis) REFERENCES lieu (id_lieu)
);

CREATE TABLE statu_candidat (
  id_statu_candidat int(11) NOT NULL AUTO_INCREMENT,
  nom varchar(50) NOT NULL,
  PRIMARY KEY (id_statu_candidat)
);
-- 

CREATE TABLE statu_poste (
  id_statu_poste int(11) NOT NULL AUTO_INCREMENT,
  nom varchar(50) NOT NULL,
  PRIMARY KEY (id_statu_poste)
);
-- 1 = inactif , 2 = vacant , 3 = occupe , 4 = offre

CREATE TABLE candidat (
  id_candidat int(11) NOT NULL AUTO_INCREMENT,
  nom varchar(150) NOT NULL,
  prenom varchar(150) NOT NULL,
  tel varchar(50) DEFAULT NULL,
  mail varchar(150) DEFAULT NULL,
  id_diplome int(11) DEFAULT NULL,
  id_profil_candidat int(11) DEFAULT NULL,
  dtn date DEFAULT NULL,
  id_adresse int(11) DEFAULT NULL,
  id_genre int(11) DEFAULT NULL,
  taille decimal(5,2) DEFAULT NULL,
  poids decimal(5,2) DEFAULT NULL,
  path_photo VARCHAR(200),
  id_statu_candidat INT ,
  id_poste_candidat INT ,
  PRIMARY KEY (id_candidat),
  KEY id_diplome (id_diplome),
  KEY id_profil_candidat (id_profil_candidat),
  KEY id_genre (id_genre),
  KEY id_adresse (id_adresse),
  CONSTRAINT candidat_ibfk_1 FOREIGN KEY (id_diplome) REFERENCES diplome (id_diplome),
  CONSTRAINT candidat_ibfk_2 FOREIGN KEY (id_profil_candidat) REFERENCES profil (id_profil),
  CONSTRAINT candidat_ibfk_3 FOREIGN KEY (id_genre) REFERENCES genre (id_genre),
  CONSTRAINT candidat_ibfk_4 FOREIGN KEY (id_adresse) REFERENCES lieu (id_lieu)
);


CREATE TABLE poste (
  id_poste int(11) NOT NULL AUTO_INCREMENT,
  nom_poste varchar(150) NOT NULL,      
  id_departement int(11) DEFAULT NULL,     
  id_manager_op int(11) DEFAULT NULL,        
  id_personne int(11) DEFAULT NULL,           
  argument varchar(150) DEFAULT NULL,          
  salaire decimal(10,2) DEFAULT NULL,             
  disponible int(11) DEFAULT NULL,                 
  id_diplome_requis int(11) DEFAULT NULL,          
  id_degre_diplome_requis int(11) DEFAULT NULL,       
  age_requis int(11) DEFAULT NULL,                     
  id_genre_requis int(11) DEFAULT NULL,                  
  taille decimal(5,2) DEFAULT NULL,                      
  poids decimal(5,2) DEFAULT NULL,                          
  id_lieu_requis int(11) DEFAULT NULL,                      
  id_statu_poste int(11) DEFAULT NULL,
  id_teste INT ,                       
  PRIMARY KEY (id_poste),
  KEY id_departement (id_departement),
  KEY id_manager_op (id_manager_op),
  KEY id_diplome_requis (id_diplome_requis),
  KEY id_degre_diplome_requis (id_degre_diplome_requis),
  KEY id_genre_requis (id_genre_requis),
  KEY id_lieu_requis (id_lieu_requis),
  CONSTRAINT poste_ibfk_1 FOREIGN KEY (id_departement) REFERENCES departement (id_departement),
  CONSTRAINT poste_ibfk_2 FOREIGN KEY (id_manager_op) REFERENCES hauthierarchi (id_hierarchi),
  CONSTRAINT poste_ibfk_3 FOREIGN KEY (id_diplome_requis) REFERENCES diplome (id_diplome),
  CONSTRAINT poste_ibfk_4 FOREIGN KEY (id_degre_diplome_requis) REFERENCES degre_diplome (id_degre_diplome),
  CONSTRAINT poste_ibfk_5 FOREIGN KEY (id_genre_requis) REFERENCES genre (id_genre),
  CONSTRAINT poste_ibfk_6 FOREIGN KEY (id_lieu_requis) REFERENCES lieu (id_lieu)
);


CREATE TABLE annonce (
  id_annonce int(11) NOT NULL AUTO_INCREMENT,
  id_poste int(11) NOT NULL,
  id_manager_op int(11) NOT NULL,
  date_creation datetime DEFAULT current_timestamp(),
  statut_validation varchar(50) DEFAULT NULL,
  statut_offre varchar(50) DEFAULT 'non_creee',
  PRIMARY KEY (id_annonce),
  KEY id_poste (id_poste),
  KEY id_manager_op (id_manager_op),
  CONSTRAINT annonce_ibfk_1 FOREIGN KEY (id_poste) REFERENCES poste (id_poste),
  CONSTRAINT annonce_ibfk_2 FOREIGN KEY (id_manager_op) REFERENCES hauthierarchi (id_hierarchi)
);

CREATE TABLE offre_emploi (
  id_offre int(11) NOT NULL AUTO_INCREMENT,
  id_annonce int(11) NOT NULL,
  date_creation datetime DEFAULT current_timestamp(),
  statut varchar(50) DEFAULT 'active',
  PRIMARY KEY (id_offre),
  KEY id_annonce (id_annonce),
  CONSTRAINT offre_emploi_ibfk_1 FOREIGN KEY (id_annonce) REFERENCES annonce (id_annonce)
);


CREATE TABLE entretien (
  id_entretien int(11) NOT NULL AUTO_INCREMENT,
  date_entretien date DEFAULT NULL,
  id_candidat int(11) DEFAULT NULL,
  presence varchar(25) DEFAULT NULL,
  score int(11) DEFAULT NULL,
  nom_responsable varchar(150) DEFAULT NULL,
  PRIMARY KEY (id_entretien),
  KEY id_candidat (id_candidat),
  CONSTRAINT entretien_ibfk_1 FOREIGN KEY (id_candidat) REFERENCES candidat (id_candidat)
);

CREATE TABLE offre_embauche (
  id_offre_embauche int(11) NOT NULL AUTO_INCREMENT,
  id_candidat int(11) DEFAULT NULL,
  statu int(11) DEFAULT NULL,
  nb_contact int(11) DEFAULT NULL,
  PRIMARY KEY (id_offre_embauche),
  KEY id_candidat (id_candidat),
  CONSTRAINT offre_embauche_ibfk_1 FOREIGN KEY (id_candidat) REFERENCES candidat (id_candidat)
);


CREATE TABLE personne (
  id_personne int(11) NOT NULL AUTO_INCREMENT,
  id_candidature int(11) DEFAULT NULL,
  nom_personne varchar(150) DEFAULT NULL,
  prenom_personne varchar(150) DEFAULT NULL,
  mdp varchar(150) DEFAULT '0000',
  chemin_photo varchar(150) DEFAULT NULL,
  id_poste int(11) DEFAULT NULL,
  PRIMARY KEY (id_personne),
  KEY id_candidature (id_candidature),
  KEY id_poste (id_poste),
  CONSTRAINT personne_ibfk_1 FOREIGN KEY (id_candidature) REFERENCES candidat (id_candidat),
  CONSTRAINT personne_ibfk_2 FOREIGN KEY (id_poste) REFERENCES poste (id_poste)
);

CREATE TABLE test (
  idTest int(11) NOT NULL AUTO_INCREMENT,
  dateTest date DEFAULT NULL,
  id_hierarchi int(11) DEFAULT NULL,
  PRIMARY KEY (idTest),
  KEY id_hierarchi (id_hierarchi),
  CONSTRAINT test_ibfk_1 FOREIGN KEY (id_hierarchi) REFERENCES hauthierarchi (id_hierarchi)
);

CREATE TABLE question (
  idQuestion int(11) NOT NULL AUTO_INCREMENT,
  question text NOT NULL,
  idTest int(11) DEFAULT NULL,
  PRIMARY KEY (idQuestion),
  KEY idTest (idTest),
  CONSTRAINT question_ibfk_1 FOREIGN KEY (idTest) REFERENCES test (idTest) ON DELETE CASCADE
);

CREATE TABLE reponse (
  idReponse int(11) NOT NULL AUTO_INCREMENT,
  idQuestion int(11) NOT NULL,
  reponse text NOT NULL,
  points int(11) DEFAULT NULL,
  PRIMARY KEY (idReponse, idQuestion),
  KEY idQuestion (idQuestion),
  CONSTRAINT reponse_ibfk_1 FOREIGN KEY (idQuestion) REFERENCES question (idQuestion) ON DELETE CASCADE
);


CREATE TABLE scoring (
  idScoring int(11) NOT NULL AUTO_INCREMENT,
  points int(11) DEFAULT NULL,
  idTest int(11) DEFAULT NULL,
  id_candidat int(11) DEFAULT NULL,
  PRIMARY KEY (idScoring),
  KEY idTest (idTest),
  KEY id_candidat (id_candidat),
  CONSTRAINT scoring_ibfk_1 FOREIGN KEY (idTest) REFERENCES test (idTest) ON DELETE CASCADE,
  CONSTRAINT scoring_ibfk_2 FOREIGN KEY (id_candidat) REFERENCES candidat (id_candidat) ON DELETE CASCADE
);

CREATE TABLE team_op (
  id_team_op int(11) NOT NULL AUTO_INCREMENT,
  id_departement int(11) DEFAULT NULL,
  id_manager_op int(11) DEFAULT NULL,
  PRIMARY KEY (id_team_op),
  KEY id_departement (id_departement),
  KEY id_manager_op (id_manager_op),
  CONSTRAINT team_op_ibfk_1 FOREIGN KEY (id_departement) REFERENCES departement (id_departement),
  CONSTRAINT team_op_ibfk_2 FOREIGN KEY (id_manager_op) REFERENCES hauthierarchi (id_hierarchi)
);
