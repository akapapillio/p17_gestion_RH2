<?php
namespace app\controllers;

use app\models\DemandeCongeModel;
use app\models\SoldeCongeModel;
use app\models\AbsenceModel;
use Flight;

class CongeAdminController
{
    // Lister toutes les demandes
    public function lister()
    {
        $demandeModel = new DemandeCongeModel(Flight::db());
        $demandes = $demandeModel->listerToutesDemandesEnAttente();

        Flight::render('conge/admin/liste', ['demandes' => $demandes]);
    }

    // Valider une demande
    public function valider($idDemande)
    {
        $idValidateur = $_SESSION['user']['id_hierarchi'];
        
        $demandeModel = new DemandeCongeModel(Flight::db());
        $demande = $demandeModel->obtenirDemande($idDemande);
        
        // Déduire du solde
        $soldeModel = new SoldeCongeModel(Flight::db());
        $soldeModel->deduireJours($demande['id_personne'], $demande['id_type_conge'], $demande['nombre_jours']);
        
        // Valider
        $demandeModel->validerDemande($idDemande, $idValidateur, 'Validé');

        Flight::redirect('/admin/conges');
    }

    // Refuser une demande
    public function refuser($idDemande)
    {
        $idValidateur = $_SESSION['user']['id_hierarchi'];
        $motif = $_POST['motif_refus'];
        
        $demandeModel = new DemandeCongeModel(Flight::db());
        $demandeModel->refuserDemande($idDemande, $idValidateur, $motif);

        Flight::redirect('/admin/conges');
    }

    // Ajouter absence manuelle
    public function ajouterAbsence()
    {
        $idPersonne = $_POST['id_personne'];
        $dateAbsence = $_POST['date_absence'];
        
        $absenceModel = new AbsenceModel(Flight::db());
        $absenceModel->enregistrerAbsence($idPersonne, $dateAbsence);

        Flight::redirect('/admin/conges/absences');
    }

    // Lister absences
    public function listerAbsences()
    {
        $absenceModel = new AbsenceModel(Flight::db());
        $absences = $absenceModel->listerAbsencesEnAttente();

        Flight::render('conge/admin/absences', ['absences' => $absences]);
    }
}
?>


<!-- 

Fonctionnalités :
3.1. Liste des demandes
phpindex() {
    // Afficher tableau avec :
    // - Filtres : statut, employé, département, dates, type
    // - Tri : date demande, priorité (premier arrivé)
    // - Indicateur : conflit planning (>40%)
    // - Actions rapides : valider/refuser
    // - Export Excel
}
3.2. Valider une demande
phpvalidate($idDemande) {
    // 1. Vérifier solde employé
    // 2. Vérifier limite 40% département
    // 3. Vérifier période blackout
    // 4. Déduire jours du solde
    // 5. Mettre à jour planning
    // 6. Créer historique
    // 7. Envoyer notification + email employé
}
3.3. Refuser une demande
phpreject($idDemande, $motifRefus) {
    // 1. Marquer refusée
    // 2. Libérer les jours du planning
    // 3. Créer historique avec motif
    // 4. Notifier employé
}

-->