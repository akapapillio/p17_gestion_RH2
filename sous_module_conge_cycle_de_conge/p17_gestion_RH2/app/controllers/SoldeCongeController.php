<?php
namespace app\controllers;

use app\models\SoldeCongeModel;
use Flight;

class SoldeCongeController
{
    private $soldeModel;

    public function __construct()
    {
        // Instancie le modèle avec la DB de Flight
        $this->soldeModel = new SoldeCongeModel(Flight::db());
    }

    /**
     * Afficher les soldes de l'employé connecté
     */
    public function show()
    {
        if (!isset($_SESSION['user'])) {
            Flight::redirect('/login');
        }

        $idPersonne = $_SESSION['user']['id_personne'];

        // Récupérer les soldes actuels
        $soldes = $this->soldeModel->obtenirSoldes($idPersonne);

        // Rendu de la vue avec les informations nécessaires
        Flight::render('conge/mes_soldes', [
            'soldes' => $soldes
        ]);
    }

    /**
     * Déduire des jours (après validation d'une demande)
     */
    public function deduire($idTypeConge, $nbJours)
    {
        if (!isset($_SESSION['user'])) {
            Flight::redirect('/login');
        }

        $idPersonne = $_SESSION['user']['id_personne'];
        $this->soldeModel->deduireJours($idPersonne, $idTypeConge, $nbJours);

        Flight::redirect('/conges/mes-soldes');
    }

    /**
     * Initialiser le solde pour un nouvel employé
     */
    public function initialiser()
    {
        if (!isset($_SESSION['user'])) {
            Flight::redirect('/login');
        }

        $idPersonne = $_SESSION['user']['id_personne'];
        $this->soldeModel->initialiserSolde($idPersonne);

        Flight::redirect('/conges/mes-soldes');
    }
}
?>


<!-- 

a implementer 

CRON job quotidien pour calcul automatique

interface admin pour ajustements manuels 

2.4 voir mes soldes de conges
show()
{

Afficher pour chaque type de conge :
    - jours acquis cette annee 
    - jours pris 
    - jours restants
    - cumul total (si classique)
    - graphique de consommation dans l'annee
}

-->

