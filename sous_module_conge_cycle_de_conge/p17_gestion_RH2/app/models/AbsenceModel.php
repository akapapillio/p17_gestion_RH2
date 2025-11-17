<?php
namespace app\models;

class AbsenceModel
{
    private $db;

    public function __construct($db)
    {
        $this->db = $db;
    }

    // Enregistrer une absence manuelle
    public function enregistrerAbsence($idPersonne, $dateAbsence)
    {
        $dateLimite = date('Y-m-d', strtotime($dateAbsence . ' +3 days'));
        $stmt = $this->db->prepare("
            INSERT INTO absence_non_justifiee (id_personne, date_absence, id_type_absence, equivalence_jours, id_statut_absence, date_limite_justification)
            VALUES (?, ?, 1, 1, 1, ?)
        ");
        return $stmt->execute([$idPersonne, $dateAbsence, $dateLimite]);
    }

    // Lister absences en attente
    public function listerAbsencesEnAttente()
    {
        $stmt = $this->db->query("
            SELECT a.*, p.nom_personne, p.prenom_personne, sa.nom as statut_nom
            FROM absence_non_justifiee a
            JOIN personne p ON a.id_personne = p.id_personne
            JOIN statut_absence sa ON a.id_statut_absence = sa.id_statut_absence
            WHERE a.id_statut_absence = 1
            ORDER BY a.date_absence DESC
        ");
        return $stmt->fetchAll();
    }
}
?>
