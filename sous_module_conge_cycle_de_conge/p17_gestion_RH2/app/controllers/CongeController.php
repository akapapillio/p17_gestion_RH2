<?php
namespace app\controllers;

use app\models\DemandeCongeModel;
use app\models\SoldeCongeModel;
use Flight;

class CongeController
{
    // Afficher formulaire de demande
    public function nouveau()
    {
        if (!isset($_SESSION['user'])) {
            Flight::redirect('/login');
        }

        $db = Flight::db();
        
        // Récupérer types de congés
        $stmt = $db->query("SELECT * FROM type_conge WHERE nom IN ('classique', 'exceptionnel')");
        $types = $stmt->fetchAll();
        
        // Récupérer motifs
        $stmt = $db->query("SELECT * FROM motif_conge WHERE id_type_conge = 2");
        $motifs = $stmt->fetchAll();
        
        Flight::render('conge/nouveau', ['types' => $types, 'motifs' => $motifs]);
    }

    // Créer une demande
    public function creer()
    {
        if (!isset($_SESSION['user'])) {
            Flight::redirect('/login');
        }

        $idPersonne = $_SESSION['user']['id_personne'];
        $idTypeConge = $_POST['id_type_conge'];
        $dateDebut = $_POST['date_debut'];
        $dateFin = $_POST['date_fin'];
        $motifTexte = $_POST['motif_texte'] ?? null;
        $idMotif = $_POST['id_motif'] ?? null;

        // Calculer nombre de jours
        $debut = new \DateTime($dateDebut);
        $fin = new \DateTime($dateFin);
        $nbJours = $debut->diff($fin)->days + 1;

        $db = Flight::db();
        $soldeModel = new SoldeCongeModel($db);

        // Vérifier solde
        if (!$soldeModel->verifierSoldeSuffisant($idPersonne, $idTypeConge, $nbJours)) {
            // Recharger types et motifs pour le formulaire
            $types = $db->query("SELECT * FROM type_conge WHERE nom IN ('classique', 'exceptionnel')")->fetchAll();
            $motifs = $db->query("SELECT * FROM motif_conge WHERE id_type_conge = 2")->fetchAll();

            Flight::render('conge/nouveau', [
                'error' => 'Solde insuffisant',
                'types' => $types,
                'motifs' => $motifs
            ]);
            return;
        }

        // Créer demande
        $demandeModel = new DemandeCongeModel($db);
        $demandeModel->creerDemande($idPersonne, $idTypeConge, $dateDebut, $dateFin, $nbJours, $motifTexte, $idMotif);

        Flight::redirect('/conges/mes-demandes');
    }

    // Lister mes demandes
    public function mesConges()
    {
        if (!isset($_SESSION['user'])) {
            Flight::redirect('/login');
        }

        $idPersonne = $_SESSION['user']['id_personne'];
        $demandeModel = new DemandeCongeModel(Flight::db());
        $demandes = $demandeModel->listerDemandesEmploye($idPersonne);

        Flight::render('conge/mes_conges', ['demandes' => $demandes]);
    }

    // Afficher mes soldes
    public function mesSoldes()
    {
        if (!isset($_SESSION['user'])) {
            Flight::redirect('/login');
        }

        $idPersonne = $_SESSION['user']['id_personne'];
        $soldeModel = new SoldeCongeModel(Flight::db());
        $soldes = $soldeModel->obtenirSoldes($idPersonne);

        Flight::render('conge/mes_soldes', ['soldes' => $soldes]);
    }
}
?>

<!-- 

fonctionnalites:

2.1 creer une demande de conge

create ()
{

1. verifier ancennete (1 an)
2. afficher formulaire avec : 
    - type de conges disponibles
    - motifs (si exceptionnels)
    - dates debut et fin (datepicker avec jours feries exclus)
    - upload justificatif
3. verifier solde suffisant
4. verifier periode blackout
5. calculer nombre de jours

}

store ()
{

1. valider les donnees du formulaire
2. verifier la regle des 15 jours avant debut conge (sauf imprevu)
3. verifier conflit planning (40 % des employes du meme departement en conge simultanement maximum)
4. creer demande en bdd
5. creer les entrees planning_conge
6. envoyer notification au RH
7. envoyer email confirmation employe

2.2 lister les demandes de conge

index ()
{   

Afficher toutes les demandes avec :
    - filtres : statut , type , dates 
    - badge de statu (en attente, validee, refusee)
    - nombre de jours
    - actions : voir details 
}

2.3 voir les details d'une demande de conge
show ($id_demande)
{

Afficher :
    - infos completes de la demande
    - historique des actions (creation, validation, refus)
    - justificatif telechargeable
    - commentaire de validation/refus

}


-->