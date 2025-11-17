-- MCD CONGE 

-- ==========================================
-- TABLES PRINCIPALES
-- ==========================================

-- Table des types de congés
CREATE TABLE type_conge (
    id_type_conge INT PRIMARY KEY AUTO_INCREMENT,
    nom VARCHAR(50) NOT NULL, -- 'classique', 'exceptionnel', 'maternite', 'maladie'
    description TEXT,
    est_cumulative BOOLEAN DEFAULT FALSE, -- TRUE pour classique, FALSE pour autres
    duree_max_annuel INT, -- 30 pour classique, 10 pour exceptionnel, NULL pour autres
    duree_cumul_max INT, -- 90 pour classique (3 ans), NULL pour autres
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Table des motifs de congé (pour les congés exceptionnels principalement)
CREATE TABLE motif_conge (
    id_motif INT PRIMARY KEY AUTO_INCREMENT,
    id_type_conge INT NOT NULL,
    nom VARCHAR(100) NOT NULL, -- 'mariage', 'décès', 'naissance', 'adoption', etc.
    duree_jours INT, -- 5 pour mariage, 3-7 pour décès, 3 pour paternité
    justificatif_requis BOOLEAN DEFAULT TRUE,
    description TEXT,
    FOREIGN KEY (id_type_conge) REFERENCES type_conge(id_type_conge)
);

-- Table des soldes de congés par employé
CREATE TABLE solde_conge (
    id_solde INT PRIMARY KEY AUTO_INCREMENT,
    id_employe INT NOT NULL,
    id_type_conge INT NOT NULL,
    annee INT NOT NULL, -- année en cours
    jours_acquis DECIMAL(5,2) DEFAULT 0, -- jours gagnés (2.5/mois pour classique)
    jours_pris DECIMAL(5,2) DEFAULT 0, -- jours consommés
    jours_restants DECIMAL(5,2) DEFAULT 0, -- solde actuel
    cumul_total DECIMAL(5,2) DEFAULT 0, -- cumul sur 3 ans pour classique
    date_derniere_maj TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (id_employe) REFERENCES employes(id_employe),
    FOREIGN KEY (id_type_conge) REFERENCES type_conge(id_type_conge),
    UNIQUE KEY unique_solde (id_employe, id_type_conge, annee)
);

-- Table des demandes de congé
CREATE TABLE demande_conge (
    id_demande INT PRIMARY KEY AUTO_INCREMENT,
    id_employe INT NOT NULL,
    id_type_conge INT NOT NULL,
    id_motif INT NULL, -- pour les congés exceptionnels
    date_debut DATE NOT NULL,
    date_fin DATE NOT NULL,
    nombre_jours DECIMAL(5,2) NOT NULL,
    motif_texte TEXT, -- description libre du motif
    justificatif_path VARCHAR(255), -- chemin du fichier justificatif uploadé
    statut ENUM('en_attente', 'validee', 'refusee', 'annulee') DEFAULT 'en_attente',
    id_validateur INT NULL, -- ID de l'employé RH qui valide
    date_validation DATETIME NULL,
    commentaire_validation TEXT, -- raison du refus ou commentaire
    est_imprevue BOOLEAN DEFAULT FALSE, -- TRUE si demande faite après absence
    date_demande DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_employe) REFERENCES employes(id_employe),
    FOREIGN KEY (id_type_conge) REFERENCES type_conge(id_type_conge),
    FOREIGN KEY (id_motif) REFERENCES motif_conge(id_motif),
    FOREIGN KEY (id_validateur) REFERENCES employes(id_employe)
);

-- Table du planning de congés (vue globale)
CREATE TABLE planning_conge (
    id_planning INT PRIMARY KEY AUTO_INCREMENT,
    id_demande INT NOT NULL,
    id_employe INT NOT NULL,
    id_departement INT NOT NULL,
    date_absence DATE NOT NULL, -- une ligne par jour d'absence
    est_valide BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (id_demande) REFERENCES demande_conge(id_demande),
    FOREIGN KEY (id_employe) REFERENCES employes(id_employe),
    FOREIGN KEY (id_departement) REFERENCES departements(id_departement),
    INDEX idx_date_dept (date_absence, id_departement)
);

-- Table des absences non justifiées (venant du module présence)
CREATE TABLE absence_non_justifiee (
    id_absence INT PRIMARY KEY AUTO_INCREMENT,
    id_employe INT NOT NULL,
    date_absence DATE NOT NULL,
    type_absence ENUM('absence_totale', 'retard') DEFAULT 'absence_totale',
    duree_retard_minutes INT NULL, -- pour les retards
    equivalence_jours DECIMAL(5,2), -- conversion en jours (ex: 10mn = 0.02j)
    statut ENUM('en_attente_justificatif', 'justifiee', 'deduite_conge', 'deduite_salaire') DEFAULT 'en_attente_justificatif',
    id_demande_conge INT NULL, -- si justifiée après coup par demande de congé
    date_limite_justification DATE NOT NULL, -- date_absence + 3 jours
    date_traitement DATETIME NULL,
    commentaire TEXT,
    FOREIGN KEY (id_employe) REFERENCES employes(id_employe),
    FOREIGN KEY (id_demande_conge) REFERENCES demande_conge(id_demande)
);

-- Table des périodes de blackout (interdiction de congés)
CREATE TABLE periode_blackout (
    id_blackout INT PRIMARY KEY AUTO_INCREMENT,
    nom VARCHAR(100) NOT NULL, -- ex: "Inventaire annuel", "Pic d'activité"
    date_debut DATE NOT NULL,
    date_fin DATE NOT NULL,
    id_departement INT NULL, -- NULL = tous les départements
    raison TEXT,
    created_by INT NOT NULL, -- ID de l'admin qui a créé
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_departement) REFERENCES departements(id_departement),
    FOREIGN KEY (created_by) REFERENCES employes(id_employe)
);

-- Table historique des actions (audit trail)
CREATE TABLE historique_conge (
    id_historique INT PRIMARY KEY AUTO_INCREMENT,
    id_demande INT NOT NULL,
    action VARCHAR(50) NOT NULL, -- 'creation', 'validation', 'refus', 'modification'
    id_acteur INT NOT NULL, -- qui a fait l'action
    ancien_statut VARCHAR(50),
    nouveau_statut VARCHAR(50),
    details JSON, -- données détaillées de l'action
    date_action TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_demande) REFERENCES demande_conge(id_demande),
    FOREIGN KEY (id_acteur) REFERENCES employes(id_employe)
);

-- Table des notifications
CREATE TABLE notification_conge (
    id_notification INT PRIMARY KEY AUTO_INCREMENT,
    id_employe INT NOT NULL, -- destinataire
    id_demande INT NULL,
    type VARCHAR(50) NOT NULL, -- 'demande_creee', 'demande_validee', 'demande_refusee', 'rappel_blackout', etc.
    message TEXT NOT NULL,
    est_lue BOOLEAN DEFAULT FALSE,
    envoi_email BOOLEAN DEFAULT FALSE,
    date_envoi_email DATETIME NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_employe) REFERENCES employes(id_employe),
    FOREIGN KEY (id_demande) REFERENCES demande_conge(id_demande)
);
```

---