<%@ page import="com.example.projet_vin.User" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="fr">
<head>
    <title>Title</title>
    <link rel="stylesheet" href="style.css">
</head>

<%
    User user = (User) session.getAttribute("user");
    if(user == null) {
        response.sendRedirect("index.jsp");
    }
    else{
%>
<body>
    <ul class="navbar">
        <li class="navbar-item"><a href="accueil.jsp" class="navbar-link">
            <img src="logo.png" alt="logo" width="50" height="50"></a></li>
        <li class="navbar-item" style="float: right;"><a href="page_admin.jsp" class="navbar-link">Administration</a></li>
        <li class="navbar-item" style="float: right;"><a href="servlet-deconnexion" class="navbar-link">Deconnexion</a></li>
    </ul>
    <div style="display:flex; justify-content: center;" class="divform">
        <%
            String error = (String) session.getAttribute("error");
            if (error != null){
        %> <p class="erreur"> <%=error%> </p>
        <%  session.setAttribute("error", null);
            }%>
        <form action="servlet-admin" method="post" name="ajout_client">
            <fieldset>
                <legend>Client à ajouter :</legend>
                <input type="hidden" value="ajout_client" name="nom_form">
                <input type="hidden" name="action" value="ajout">
                <input type="hidden" name="type" value="user">
                <input type="hidden" name="role" value="client">
                <div>
                    <label for="login">Login </label>
                    <input type="text" id="login" name="login" required>
                </div>
                <div>
                    <label for="mdp">Mot de passe: </label>
                    <input type="text" id="mdp" name="mdp" required>
                </div>
                <input type="submit" id="ok" value="Envoyer">
            </fieldset>
        </form>
    </div>
</body>
</html>
<%}%>