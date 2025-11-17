INSERT INTO solde_conge (id_personne, id_type_conge, annee, jours_acquis, jours_restants, cumul_total)
SELECT id_personne, 1, 2025, 30, 30, 30 FROM personne;


-- 1. Ajouter une personne test
INSERT INTO personne (nom_personne, prenom_personne, mdp)
VALUES ('Test', 'Utilisateur', '0000');

-- Récupérer l'id de la personne créée
SET @id_personne := LAST_INSERT_ID();

-- 2. Initialiser solde de congés classique et exceptionnel
INSERT INTO solde_conge (id_personne, id_type_conge, annee, jours_acquis, jours_restants, cumul_total)
VALUES 
(@id_personne, 1, 2025, 30, 30, 30),   -- congé classique
(@id_personne, 2, 2025, 10, 10, 0);    -- congé exceptionnel

-- 3. Optionnel : ajouter un motif pour le congé exceptionnel (déjà présent dans ta base)
-- Exemple : Mariage de l'employé (id_motif = 1)

-- 4. Créer une demande test (5 jours de congé classique)
INSERT INTO demande_conge 
(id_personne, id_type_conge, date_debut, date_fin, nombre_jours, id_statut)
VALUES
(@id_personne, 1, '2025-12-01', '2025-12-05', 5, 1);

-- 5. Vérifier le solde après déduction (manuellement)
UPDATE solde_conge
SET jours_pris = jours_pris + 5,
    jours_restants = jours_restants - 5
WHERE id_personne = @id_personne AND id_type_conge = 1 AND annee = 2025;
