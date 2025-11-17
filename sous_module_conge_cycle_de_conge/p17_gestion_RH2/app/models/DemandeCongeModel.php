<?php
namespace app\models;

use Flight;

class DemandeCongeModel
{
    private $db;

    public function __construct($db)
    {
        $this->db = $db;
    }

    // Créer une demande
    public function creerDemande($idPersonne, $idTypeConge, $dateDebut, $dateFin, $nbJours, $motifTexte = null, $idMotif = null)
    {
        $stmt = $this->db->prepare("
            INSERT INTO demande_conge (id_personne, id_type_conge, id_motif, date_debut, date_fin, nombre_jours, motif_texte, id_statut)
            VALUES (?, ?, ?, ?, ?, ?, ?, 1)
        ");
        return $stmt->execute([$idPersonne, $idTypeConge, $idMotif, $dateDebut, $dateFin, $nbJours, $motifTexte]);
    }

    // Lister demandes d'un employé
    public function listerDemandesEmploye($idPersonne)
    {
        $stmt = $this->db->prepare("
            SELECT dc.*, tc.nom as type_nom, sd.nom as statut_nom
            FROM demande_conge dc
            JOIN type_conge tc ON dc.id_type_conge = tc.id_type_conge
            JOIN statut_demande sd ON dc.id_statut = sd.id_statut
            WHERE dc.id_personne = ?
            ORDER BY dc.date_demande DESC
        ");
        $stmt->execute([$idPersonne]);
        return $stmt->fetchAll();
    }

    // Lister TOUTES les demandes (pour RH)
    public function listerToutesDemandesEnAttente()
    {
        $stmt = $this->db->query("
            SELECT dc.*, p.nom_personne, p.prenom_personne, tc.nom as type_conge, sd.nom as statut
        FROM demande_conge dc
        JOIN personne p ON dc.id_personne = p.id_personne
        JOIN type_conge tc ON dc.id_type_conge = tc.id_type_conge
        JOIN statut_demande sd ON dc.id_statut = sd.id_statut
        WHERE dc.id_statut = 1
        ORDER BY dc.date_demande DESC
        ");
        return $stmt->fetchAll();
    }

    // Valider une demande
    public function validerDemande($idDemande, $idValidateur, $commentaire = null)
    {
        $stmt = $this->db->prepare("
            UPDATE demande_conge 
            SET id_statut = 2, id_validateur = ?, date_validation = NOW(), commentaire_validation = ?
            WHERE id_demande = ?
        ");
        return $stmt->execute([$idValidateur, $commentaire, $idDemande]);
    }

    // Refuser une demande
    public function refuserDemande($idDemande, $idValidateur, $motifRefus)
    {
        $stmt = $this->db->prepare("
            UPDATE demande_conge 
            SET id_statut = 3, id_validateur = ?, date_validation = NOW(), commentaire_validation = ?
            WHERE id_demande = ?
        ");
        return $stmt->execute([$idValidateur, $motifRefus, $idDemande]);
    }

    // Récupérer une demande
    public function obtenirDemande($idDemande)
    {
        $stmt = $this->db->prepare("SELECT * FROM demande_conge WHERE id_demande = ?");
        $stmt->execute([$idDemande]);
        return $stmt->fetch();
    }
}
?>