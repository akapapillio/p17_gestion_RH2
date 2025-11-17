<!-- 
 
Fonctionnalités :
5.1. Réception des absences (depuis module présence)
phprecevoirAbsences($absences) {
    // $absences = array des absents de la veille
    // Pour chaque absence :
    // 1. Vérifier si congé validé existe
    // 2. Si non, créer absence_non_justifiee
    // 3. Calculer date_limite (date + 3j)
    // 4. Envoyer notification employé
}
5.2. Traitement automatique (CRON quotidien)
phptraiterAbsencesExpirees() {
    // Pour toutes les absences > 3 jours sans justificatif :
    // 1. Déduire du solde congé classique
    // 2. Si solde = 0, signaler pour déduction salaire
    // 3. Créer historique
    // 4. Notifier RH et employé
}
5.3. Traitement des retards
phptraiterRetards($retards) {
    // Pour chaque retard >= 10mn :
    // 1. Convertir en fraction de jour (10mn = 0.014j)
    // 2. Cumuler les retards du mois
    // 3. Si cumul >= 1 jour, déduire
}
5.4. Interface admin
phpindex() {
    // Liste des absences non justifiées :
    // - En attente (< 3j)
    // - Expirées (> 3j)
    // - Justifiées rétroactivement
    // Actions : forcer justification, annuler
}

-->