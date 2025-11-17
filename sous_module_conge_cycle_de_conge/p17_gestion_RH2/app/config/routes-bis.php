<?php

// use app\controllers\ApiExampleController;
// use app\controllers\WelcomeController;
// use flight\Engine;
// use flight\net\Router;
// use Flight;

// /** 
//  * @var Router $router 
//  * @var Engine $app
//  */
// /*$router->get('/', function() use ($app) {
// 	$Welcome_Controller = new WelcomeController($app);
// 	$app->render('welcome', [ 'message' => 'It works!!' ]);
// });*/

// $Welcome_Controller = new WelcomeController();
// $router->get('/', [ $Welcome_Controller, 'home' ]); 
// //$router->get('/', [ 'WelcomeController', 'home' ]); 

// //$router->get('/', \app\controllers\WelcomeController::class.'->home'); 

// $router->get('/hello-world/@name', function($name) {
// 	echo '<h1>Hello world! Oh hey '.$name.'!</h1>';
// });

// $router->group('/api', function() use ($router, $app) {
// 	$Api_Example_Controller = new ApiExampleController($app);
// 	$router->get('/users', [ $Api_Example_Controller, 'getUsers' ]);
// 	$router->get('/users/@id:[0-9]', [ $Api_Example_Controller, 'getUser' ]);
// 	$router->post('/users/@id:[0-9]', [ $Api_Example_Controller, 'updateUser' ]);
// });

// // --------------------------------------------------------------------------------------------------------------------------------------------


// // // Routes employés
// // Flight::route('GET /conges/mes-conges', [CongeController::class, 'index']);
// // Flight::route('GET /conges/nouveau', [CongeController::class, 'create']);
// // Flight::route('POST /conges/nouveau', [CongeController::class, 'store']);
// // Flight::route('GET /conges/@id', [CongeController::class, 'show']);
// // Flight::route('GET /conges/solde', [SoldeCongeController::class, 'show']);

// // // Routes admin/RH
// // Flight::route('GET /admin/conges', [CongeAdminController::class, 'index']);
// // Flight::route('POST /admin/conges/@id/valider', [CongeAdminController::class, 'validate']);
// // Flight::route('POST /admin/conges/@id/refuser', [CongeAdminController::class, 'reject']);
// // Flight::route('GET /admin/conges/planning', [PlanningCongeController::class, 'index']);
// // Flight::route('GET /admin/conges/absences', [AbsenceController::class, 'index']);
// // Flight::route('POST /admin/conges/absences/traiter', [AbsenceController::class, 'process']);
// // Flight::route('GET /admin/conges/blackout', [PeriodeBlackout::class, 'index']);
// // Flight::route('POST /admin/conges/blackout', [PeriodeBlackout::class, 'store']);
// // Flight::route('GET /admin/conges/reporting', [ReportingCongeController::class, 'index']);

// // --------------------------------

// // Routes congés employé
// Flight::route('GET /conges/nouveau', [new \app\controllers\CongeController(), 'nouveau']);
// Flight::route('POST /conges/creer', [new \app\controllers\CongeController(), 'creer']);
// Flight::route('GET /conges/mes-demandes', [new \app\controllers\CongeController(), 'mesConges']);
// Flight::route('GET /conges/mes-soldes', [new \app\controllers\CongeController(), 'mesSoldes']);

// // Routes admin
// Flight::route('GET /admin/conges', [new \app\controllers\CongeAdminController(), 'lister']);
// Flight::route('POST /admin/conges/@id/valider', [new \app\controllers\CongeAdminController(), 'valider']);
// Flight::route('POST /admin/conges/@id/refuser', [new \app\controllers\CongeAdminController(), 'refuser']);
// Flight::route('GET /admin/conges/absences', [new \app\controllers\CongeAdminController(), 'listerAbsences']);
// Flight::route('POST /admin/conges/absences/ajouter', [new \app\controllers\CongeAdminController(), 'ajouterAbsence']);
// // --------------------------------

?>