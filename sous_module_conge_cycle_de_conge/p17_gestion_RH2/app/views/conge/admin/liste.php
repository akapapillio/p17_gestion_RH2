<h2>Demandes de congé en attente</h2>
<table border="1">
    <tr>
        <th>Employé</th>
        <th>Type</th>
        <th>Dates</th>
        <th>Jours</th>
        <th>Actions</th>
    </tr>
    <?php foreach($demandes as $demande): ?>
<tr>
    <td><?= $demande['nom_personne'] ?> <?= $demande['prenom_personne'] ?></td>
    <td><?= $demande['type_conge'] ?></td>
    <td><?= $demande['date_debut'] ?> → <?= $demande['date_fin'] ?></td>
    <td><?= $demande['nombre_jours'] ?></td>
    <td>
        <form method="POST" action="/admin/conges/<?= $demande['id_demande'] ?>/valider" style="display:inline-block">
            <button>Valider</button>
        </form>
        <form method="POST" action="/admin/conges/<?= $demande['id_demande'] ?>/refuser" style="display:inline-block">
            <input type="text" name="motif_refus" placeholder="Motif du refus" required>
            <button>Refuser</button>
        </form>
    </td>
</tr>
<?php endforeach; ?>
</table>
