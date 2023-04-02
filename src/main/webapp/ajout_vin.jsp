<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>
    <ul class="navbar">
        <li class="navbar-item"><a href="accueil.jsp" class="navbar-link">
            <img src="logo.png" alt="logo" width="50" height="50"></a></li>
        <li class="navbar-item" style="float: right;"><a href="page_admin.jsp" class="navbar-link">Administration</a></li>
        <li class="navbar-item" style="float: right;"><a href="servlet-deconnexion" class="navbar-link">Deconnexion</a></li>
    </ul>
    <div style="display:flex; justify-content: center;" class="divform">
        <form action="servlet-admin" method="post" name="ajout_vin">
            <fieldset>
                <input type="hidden" value="ajout_vin" name="nom_form">
                <input type="hidden" name="action" value="ajout">
                <input type="hidden" name="type" value="vins">
                <div>
                    <label for="nom">Nom : </label>
                    <input type="text" id="nom" name="nom" required>
                </div>
                <div>
                    <label for="stock">Stock : </label>
                    <input type="number" id="stock" name="stock" required>
                </div>
                <div>
                    <label for="couleur">Couleur : </label>
                    <select name="couleur" id="couleur" required>
                        <option value="blanc">Blanc</option>
                        <option value="rose">Rosé</option>
                        <option value="rouge">Rouge</option>
                    </select>
                </div>
                <div>
                    <label for="libelle">Libelle : </label>
                    <input type="text" id="libelle" name="libelle" required>
                </div>
                <div>
                    <label for="prix"> Prix : </label>
                    <input type="number" id="prix" name="prix" required>
                </div>
                <input type="submit" id="ok" value="Envoyer">
            </fieldset>
        </form>
    </div>
</body>
</html>
