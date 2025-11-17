<h2>Ajouter une absence</h2>
<form method="POST" action="/admin/conges/absences/ajouter">
    <input type="number" name="id_personne" placeholder="ID Employé" required>
    <input type="date" name="date_absence" required>
    <button>Enregistrer</button>
</form>

<h3>Absences en attente</h3>
<table border="1">
    <tr><th>Employé</th><th>Date</th><th>Statut</th></tr>
    <?php foreach($absences as $a): ?>
    <tr>
        <td><?= $a['nom_personne'] ?> <?= $a['prenom_personne'] ?></td>
        <td><?= $a['date_absence'] ?></td>
        <td><?= $a['statut_nom'] ?></td>
    </tr>
    <?php endforeach; ?>
</table>