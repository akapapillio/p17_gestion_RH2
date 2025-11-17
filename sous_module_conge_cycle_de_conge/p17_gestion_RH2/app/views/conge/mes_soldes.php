<h2>Mes soldes de congé</h2>
<table border="1">
    <tr>
        <th>Type</th>
        <th>Jours acquis</th>
        <th>Jours pris</th>
        <th>Jours restants</th>
    </tr>
    <?php foreach($soldes as $s): ?>
    <tr>
        <td><?= $s['type_nom'] ?></td>
        <td><?= $s['jours_acquis'] ?></td>
        <td><?= $s['jours_pris'] ?></td>
        <td><?= $s['jours_restants'] ?></td>
    </tr>
    <?php endforeach; ?>
</table>