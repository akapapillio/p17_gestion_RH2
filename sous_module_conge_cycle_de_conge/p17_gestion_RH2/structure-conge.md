

## 2. ARCHITECTURE MVC DÉTAILLÉE

Avec ta structure FlightPHP, voici comment organiser les fichiers :

### **A. Models** (à créer dans un dossier `app/models/`)
```
app/models/
├── TypeConge.php          // Gestion des types de congés
├── MotifConge.php         // Gestion des motifs
├── SoldeConge.php         // Calcul et gestion des soldes
├── DemandeConge.php       // CRUD demandes de congé
├── PlanningConge.php      // Gestion du planning
├── AbsenceNonJustifiee.php // Traitement des absences
├── PeriodeBlackout.php    // Gestion des périodes interdites
├── HistoriqueConge.php    // Logs d'actions
└── NotificationConge.php  // Envoi de notifications
```

### **B. Controllers** (dans `app/controllers/`)
```
app/controllers/
├── CongeController.php           // Gestion des demandes (employés)
├── CongeAdminController.php      // Validation et admin (RH)
├── SoldeCongeController.php      // Affichage des soldes
├── PlanningCongeController.php   // Gestion du planning
├── AbsenceController.php         // Traitement absences (intégration module présence)
└── ReportingCongeController.php  // Statistiques et rapports
```

### **C. Views** (dans `app/views/conge/`)
```
app/views/conge/
├── employe/
│   ├── mes_conges.php           // Liste des demandes de l'employé
│   ├── nouvelle_demande.php     // Formulaire de demande
│   ├── detail_demande.php       // Détail d'une demande
│   └── mon_solde.php            // Affichage des soldes
├── admin/
│   ├── liste_demandes.php       // Liste toutes demandes (filtres)
│   ├── validation_demande.php   // Interface de validation
│   ├── planning_global.php      // Planning départemental
│   ├── gestion_absences.php     // Traitement absences non justifiées
│   ├── gestion_blackout.php     // Création périodes interdites
│   └── reporting.php            // Statistiques
└── partials/
    ├── filtre_conge.php         // Composant de filtres
    └── carte_conge.php          // Carte d'affichage d'un congé