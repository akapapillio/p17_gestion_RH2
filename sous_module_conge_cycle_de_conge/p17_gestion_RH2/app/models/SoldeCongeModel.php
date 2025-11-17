<?php
namespace app\models;

class SoldeCongeModel
{
    private $db;

    public function __construct($db)
    {
        $this->db = $db;
    }

    // Obtenir solde d'un employé
    public function obtenirSoldes($idPersonne, $annee = null)
    {
        $annee = $annee ?? date('Y');
        $stmt = $this->db->prepare("
            SELECT sc.*, tc.nom as type_nom
            FROM solde_conge sc
            JOIN type_conge tc ON sc.id_type_conge = tc.id_type_conge
            WHERE sc.id_personne = ? AND sc.annee = ?
        ");
        $stmt->execute([$idPersonne, $annee]);
        return $stmt->fetchAll();
    }

    // Vérifier si solde suffisant
    public function verifierSoldeSuffisant($idPersonne, $idTypeConge, $nbJours)
    {
        $annee = date('Y');
        $stmt = $this->db->prepare("
            SELECT jours_restants FROM solde_conge 
            WHERE id_personne = ? AND id_type_conge = ? AND annee = ?
        ");
        $stmt->execute([$idPersonne, $idTypeConge, $annee]);
        $solde = $stmt->fetch();
        
        return $solde && $solde['jours_restants'] >= $nbJours;
    }

    // Déduire jours après validation
    public function deduireJours($idPersonne, $idTypeConge, $nbJours)
    {
        $annee = date('Y');
        $stmt = $this->db->prepare("
            UPDATE solde_conge 
            SET jours_pris = jours_pris + ?, 
                jours_restants = jours_restants - ?
            WHERE id_personne = ? AND id_type_conge = ? AND annee = ?
        ");
        return $stmt->execute([$nbJours, $nbJours, $idPersonne, $idTypeConge, $annee]);
    }

    // Initialiser solde pour un nouvel employé
    public function initialiserSolde($idPersonne)
    {
        $annee = date('Y');
        // Congé classique : 30j
        $stmt = $this->db->prepare("
            INSERT INTO solde_conge (id_personne, id_type_conge, annee, jours_acquis, jours_restants, cumul_total)
            VALUES (?, 1, ?, 30, 30, 30), (?, 2, ?, 10, 10, 0)
        ");
        return $stmt->execute([$idPersonne, $annee, $idPersonne, $annee]);
    }
}
?>


<!-- 

FONCTIONNALITES

1. calculerAcquisitionMensuelle($id_employe) : calcul automatique des 2,5j / mois

2. mettreAJourSoldes($id_employe) : MAJ des soldes de tout types 

3. verifierDroitDemande($id_employe) : verifier 1 and d anciennete oui ou non 

4. appliquerRegle3Ans($id_employe) : retrait automatique des conges acquis il y a plus de 3 ans

5. obtenirSoldeActuel($id_employe, $id_type_conge) : obtenir le solde actuel d un employe pour un type de conge donne

6. deduireConge($id_employe, $id_type_conge, $nombre_jours) : deduire le nombre de jours demandes du solde apres validation

7. restituerJours($id_employe, $id_type_conge, $nombre_jours) : restituer les jours en cas d annulation

-->
