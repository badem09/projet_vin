<!DOCTYPE html>
<html lang="fr">
<head>
    <link rel="stylesheet" href="style.css">
    <title>Connexion</title>
</head>
<body>

    <ul class="navbar">
        <li class="navbar-item"><a href="index.jsp" class="navbar-link">
            <img src="logo.png" alt="logo" width="50" height="50"></a></li>
        <li class="navbar-item" style="float: right;"><a href="connexion.jsp" class="navbar-link">Se connecter</a></li>
    </ul>

    <div class="container-centrer">
        <form action="servlet-connexion" method="post">
            <label for="login">Login  : </label>
            <input type="text" id="login" name="login" required>
            <label for="mdp">Mot de passe : </label>
            <input type="password" id="mdp" name="mdp" required>
            <input type="submit" id="ok" value="Se connecter">
        </form>
    </div>

</body>
</html>
