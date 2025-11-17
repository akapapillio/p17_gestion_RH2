<?php 

$_SESSION['user'] = [
    'id_personne' => 1,
    'nom' => 'Test',
    'prenom' => 'User'
];



?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>demande de conge</title>
</head>
<body>
    <h2>Nouvelle demande de congé</h2>
<?php if(isset($error)): ?>
    <div style="color:red;"><?= $error ?></div>
<?php endif; ?>

<form method="POST" action="/conges/creer">
    <label>Type de congé :</label>
    <select name="id_type_conge" required>
        <?php foreach($types as $type): ?>
            <option value="<?= $type['id_type_conge'] ?>"><?= $type['nom'] ?></option>
        <?php endforeach; ?>
    </select>

    <label>Date début :</label>
    <input type="date" name="date_debut" required>

    <label>Date fin :</label>
    <input type="date" name="date_fin" required>

    <label>Motif (optionnel) :</label>
    <textarea name="motif_texte"></textarea>

    <button type="submit">Soumettre</button>
</form>
</body>
</html>