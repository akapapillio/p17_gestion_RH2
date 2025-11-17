<!-- 
 
Fonctionnalités :
4.1. Vue calendrier
phpindex() {
    // Afficher :
    // - Calendrier mensuel/annuel
    // - Congés validés par département
    // - Congés en attente (transparents)
    // - Périodes blackout (grisées)
    // - Indicateur de charge (% absents)
    // - Légende des couleurs par type
}
4.2. Vérification des conflits
phpverifierConflits($idDepartement, $dateDebut, $dateFin) {
    // Calculer % d'absents sur la période
    // Retourner TRUE si > 40%
}
4.3. Gestion des périodes blackout
php// Dans PeriodeBlackoutController
store() {
    // Créer période interdite
    // Notifier tous les employés concernés
}


-->