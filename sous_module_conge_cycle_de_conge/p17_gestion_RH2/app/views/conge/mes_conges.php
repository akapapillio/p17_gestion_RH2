<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>liste demandes de conges</title>
</head>
<body>
    <h2>Mes demandes de congé</h2>
<table border="1">
    <tr>
        <th>Type</th>
        <th>Date début</th>
        <th>Date fin</th>
        <th>Jours</th>
        <th>Statut</th>
    </tr>
    <?php foreach($demandes as $d): ?>
    <tr>
        <td><?= $d['type_nom'] ?></td>
        <td><?= $d['date_debut'] ?></td>
        <td><?= $d['date_fin'] ?></td>
        <td><?= $d['nombre_jours'] ?></td>
        <td><?= $d['statut_nom'] ?></td>
    </tr>
    <?php endforeach; ?>
</table>
</body>
</html>