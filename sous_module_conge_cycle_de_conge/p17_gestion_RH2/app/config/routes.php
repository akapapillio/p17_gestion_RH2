<?php

use app\controllers\ApiExampleController;
use app\controllers\WelcomeController;
// use Flight;


session_start();

// Simulation d'un utilisateur connecté
$_SESSION['user'] = [
    'id_personne' => 1,
    'id_hierarchi' => 1, // ou l’ID du RH/admin
    'nom' => 'Test',
    'prenom' => 'User'
];

// Flight::route('GET /login', function() {
//     echo '<h1>Page login (à implémenter)</h1>';
// });

// Page d'accueil
Flight::route('GET /', function() {
    $controller = new WelcomeController();
    $controller->home();
});

// Exemple simple
Flight::route('GET /hello-world/@name', function($name) {
    echo '<h1>Hello world! Oh hey '.$name.'!</h1>';
});

// API
Flight::route('GET /api/users', function() {
    $controller = new ApiExampleController();
    $controller->getUsers();
});

Flight::route('GET /api/users/@id:[0-9]+', function($id) {
    $controller = new ApiExampleController();
    $controller->getUser($id);
});

Flight::route('POST /api/users/@id:[0-9]+', function($id) {
    $controller = new ApiExampleController();
    $controller->updateUser($id);
});

// Routes congés employé
Flight::route('GET /conges/nouveau', [new \app\controllers\CongeController(), 'nouveau']);
Flight::route('POST /conges/creer', [new \app\controllers\CongeController(), 'creer']);
Flight::route('GET /conges/mes-demandes', [new \app\controllers\CongeController(), 'mesConges']);
Flight::route('GET /conges/mes-soldes', [new \app\controllers\CongeController(), 'mesSoldes']);

// Routes admin
Flight::route('GET /admin/conges', [new \app\controllers\CongeAdminController(), 'lister']);
Flight::route('POST /admin/conges/@id/valider', [new \app\controllers\CongeAdminController(), 'valider']);
Flight::route('POST /admin/conges/@id/refuser', [new \app\controllers\CongeAdminController(), 'refuser']);
Flight::route('GET /admin/conges/absences', [new \app\controllers\CongeAdminController(), 'listerAbsences']);
Flight::route('POST /admin/conges/absences/ajouter', [new \app\controllers\CongeAdminController(), 'ajouterAbsence']);

?>
