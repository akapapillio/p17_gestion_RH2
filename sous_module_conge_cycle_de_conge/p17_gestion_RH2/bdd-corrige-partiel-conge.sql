-- ==========================================
-- TABLES DE RÉFÉRENCE NÉCESSAIRES
-- ==========================================

CREATE TABLE diplome (
  id_diplome int(11) NOT NULL AUTO_INCREMENT,
  nom_diplome varchar(150) NOT NULL,
  PRIMARY KEY (id_diplome)
);

CREATE TABLE degre_diplome (
  id_degre_diplome int(11) NOT NULL AUTO_INCREMENT,
  nom_degre varchar(150) NOT NULL,
  PRIMARY KEY (id_degre_diplome)
);

CREATE TABLE lieu (
  id_lieu int(11) NOT NULL AUTO_INCREMENT,
  nom_lieu varchar(150) NOT NULL,
  PRIMARY KEY (id_lieu)
);

CREATE TABLE genre (
  id_genre int(11) NOT NULL AUTO_INCREMENT,
  n_genre varchar(100) NOT NULL,
  PRIMARY KEY (id_genre)
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
  id_annonce int,
  nom_profil varchar(150) NOT NULL,
  id_diplome_requis int(11) DEFAULT NULL,
  age_requis int(11) DEFAULT NULL,
  id_genre_requis int(11) DEFAULT NULL,
  taille decimal(5,2) DEFAULT NULL,
  poids decimal(5,2) DEFAULT NULL,
  id_lieu_requis int(11) DEFAULT NULL,
  statu int(11) DEFAULT NULL,
  id_test INT,
  PRIMARY KEY (id_profil),
  KEY id_diplome_requis (id_diplome_requis),
  KEY id_genre_requis (id_genre_requis),
  KEY id_lieu_requis (id_lieu_requis),
  CONSTRAINT profil_ibfk_1 FOREIGN KEY (id_diplome_requis) REFERENCES diplome (id_diplome),
  CONSTRAINT profil_ibfk_2 FOREIGN KEY (id_genre_requis) REFERENCES genre (id_genre),
  CONSTRAINT profil_ibfk_3 FOREIGN KEY (id_lieu_requis) REFERENCES lieu (id_lieu)
);

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
  id_statu_candidat INT,
  id_poste_candidat INT,
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


-- ==========================================
-- TABLES DE RÉFÉRENCE (ENUM remplacés)
-- ==========================================

CREATE TABLE statut_demande (
    id_statut INT PRIMARY KEY AUTO_INCREMENT,
    nom VARCHAR(50) NOT NULL UNIQUE -- 'en_attente', 'validee', 'refusee', 'annulee'
);

CREATE TABLE type_absence (
    id_type_absence INT PRIMARY KEY AUTO_INCREMENT,
    nom VARCHAR(50) NOT NULL UNIQUE -- 'absence_totale', 'retard'
);

CREATE TABLE statut_absence (
    id_statut_absence INT PRIMARY KEY AUTO_INCREMENT,
    nom VARCHAR(50) NOT NULL UNIQUE -- 'en_attente_justificatif', 'justifiee', 'deduite_conge', 'deduite_salaire'
);

-- ==========================================
-- TABLES PRINCIPALES (CORRIGÉES)
-- ==========================================

-- Types de congés (GARDER TELLE QUELLE)
CREATE TABLE type_conge (
    id_type_conge INT PRIMARY KEY AUTO_INCREMENT,
    nom VARCHAR(50) NOT NULL, -- 'classique', 'exceptionnel', 'maternite', 'maladie'
    description TEXT,
    est_cumulative BOOLEAN DEFAULT FALSE,
    duree_max_annuel INT,
    duree_cumul_max INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Motifs de congé
CREATE TABLE motif_conge (
    id_motif INT PRIMARY KEY AUTO_INCREMENT,
    id_type_conge INT NOT NULL,
    nom VARCHAR(100) NOT NULL,
    duree_jours INT,
    justificatif_requis BOOLEAN DEFAULT TRUE,
    description TEXT,
    FOREIGN KEY (id_type_conge) REFERENCES type_conge(id_type_conge)
);

-- Soldes de congés
CREATE TABLE solde_conge (
    id_solde INT PRIMARY KEY AUTO_INCREMENT,
    id_personne INT NOT NULL, -- CORRIGÉ : id_personne au lieu de id_employe
    id_type_conge INT NOT NULL,
    annee INT NOT NULL,
    jours_acquis DECIMAL(5,2) DEFAULT 0,
    jours_pris DECIMAL(5,2) DEFAULT 0,
    jours_restants DECIMAL(5,2) DEFAULT 0,
    cumul_total DECIMAL(5,2) DEFAULT 0,
    date_derniere_maj TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP, -- Timestamp auto de mise à jour
    FOREIGN KEY (id_personne) REFERENCES personne(id_personne),
    FOREIGN KEY (id_type_conge) REFERENCES type_conge(id_type_conge),
    UNIQUE KEY unique_solde (id_personne, id_type_conge, annee)
);

-- Demandes de congé (CORRIGÉE)
CREATE TABLE demande_conge (
    id_demande INT PRIMARY KEY AUTO_INCREMENT,
    id_personne INT NOT NULL, -- CORRIGÉ
    id_type_conge INT NOT NULL,
    id_motif INT NULL,
    date_debut DATE NOT NULL,
    date_fin DATE NOT NULL,
    nombre_jours DECIMAL(5,2) NOT NULL,
    motif_texte TEXT,
    justificatif_path VARCHAR(255),
    id_statut INT DEFAULT 1, -- CORRIGÉ : référence statut_demande
    id_validateur INT NULL,
    date_validation DATETIME NULL,
    commentaire_validation TEXT,
    est_imprevue BOOLEAN DEFAULT FALSE,
    date_demande DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_personne) REFERENCES personne(id_personne),
    FOREIGN KEY (id_type_conge) REFERENCES type_conge(id_type_conge),
    FOREIGN KEY (id_motif) REFERENCES motif_conge(id_motif),
    FOREIGN KEY (id_statut) REFERENCES statut_demande(id_statut),
    FOREIGN KEY (id_validateur) REFERENCES personne(id_personne)
);

-- Absences non justifiées (CORRIGÉE)
CREATE TABLE absence_non_justifiee (
    id_absence INT PRIMARY KEY AUTO_INCREMENT,
    id_personne INT NOT NULL, -- CORRIGÉ
    date_absence DATE NOT NULL,
    id_type_absence INT DEFAULT 1, -- CORRIGÉ
    duree_retard_minutes INT NULL,
    equivalence_jours DECIMAL(5,2),
    id_statut_absence INT DEFAULT 1, -- CORRIGÉ
    id_demande_conge INT NULL, -- Si l'employé justifie APRÈS par une demande rétroactive
    date_limite_justification DATE NOT NULL,
    date_traitement DATETIME NULL,
    commentaire TEXT,
    FOREIGN KEY (id_personne) REFERENCES personne(id_personne),
    FOREIGN KEY (id_type_absence) REFERENCES type_absence(id_type_absence),
    FOREIGN KEY (id_statut_absence) REFERENCES statut_absence(id_statut_absence),
    FOREIGN KEY (id_demande_conge) REFERENCES demande_conge(id_demande)
);

-- ==========================================
-- DONNÉES INITIALES (OBLIGATOIRE)
-- ==========================================

INSERT INTO statut_demande (nom) VALUES 
('en_attente'), ('validee'), ('refusee'), ('annulee');

INSERT INTO type_absence (nom) VALUES 
('absence_totale'), ('retard');

INSERT INTO statut_absence (nom) VALUES 
('en_attente_justificatif'), ('justifiee'), ('deduite_conge'), ('deduite_salaire');

-- Types de congés
INSERT INTO type_conge (nom, description, est_cumulative, duree_max_annuel, duree_cumul_max) VALUES
('classique', 'Congé payé classique', TRUE, 30, 90),
('exceptionnel', 'Congé pour événements spéciaux', FALSE, 10, NULL),
('maternite', 'Congé de maternité', FALSE, 90, NULL),
('maladie', 'Congé maladie', FALSE, NULL, NULL);

-- Motifs exceptionnels
INSERT INTO motif_conge (id_type_conge, nom, duree_jours, justificatif_requis) VALUES
(2, 'Mariage de l employé', 5, TRUE),
(2, 'Décès proche', 5, TRUE),
(2, 'Naissance (paternité)', 3, TRUE),
(2, 'Adoption', 5, TRUE);