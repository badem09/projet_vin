<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="com.example.projet_vin.User" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    User user = (User) session.getAttribute("user");
    if(user == null) {
        response.sendRedirect("index.jsp");
    }
    else{
%>
<html lang="fr">

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

<%
    String id = request.getParameter("id");
    Connection conn=null;
    String nom = "Error", prix = "Error", libelle = "Error", couleur = "Error", stock = "Error";
    try {
        Class.forName("com.mysql.jdbc.Driver");
        String jdbc = "jdbc:mysql://localhost:3306/projet_vin";
        conn = DriverManager.getConnection(jdbc, "root", "");
        String query = "SELECT * from vins WHERE id=?";
        PreparedStatement stmt = conn.prepareStatement(query);
        stmt.setString(1,id);
        ResultSet res = stmt.executeQuery();
        while (res.next()) {
            nom = res.getString("nom");
            stock = res.getString("stock");
            couleur = res.getString("couleur");
            libelle = res.getString("libelle");
            prix = res.getString("prix");
            id = res.getString("id");
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
%>

<div style="display:flex; justify-content: center;" class="divform">
    <form action="servlet-admin" method="post" name="modif_vin">
        <fieldset>
            <legend>Informations du vin à modifier :</legend>
            <input type="hidden" value="modif_vin" name="nom_form">
            <input type="hidden" name="id" value="<%=id%>">
            <input type="hidden" name="action" value="modif">
            <input type="hidden" name="type" value="vins">
            <div>
                <label for="nom">Nom : </label>
                <input type="text" id="nom" name="nom" value="<%=nom%>" required>
            </div>
            <div>
                <label for="stock">Stock : </label>
                <input type="number" id="stock" name="stock" value="<%=stock%>" required>
            </div>
            <label for="couleur">Couleur : </label>
            <select name="couleur" id="couleur" required>
                <option value="blanc" <%if(couleur.equals("blanc")){%> selected <%} %>>Blanc</option>
                <option value="rose" <%if(couleur.equals("rose")){%> selected <%} %>>Rosé</option>
                <option value="rouge" <%if(couleur.equals("rouge")){%> selected <%} %>>Rouge</option>
            </select>
            <div>
                <label for="libelle">Libelle : </label>
                <input type="text" id="libelle" name="libelle" value="<%=libelle%>" required>
            </div>
            <div>
                <label for="prix"> Prix : </label>
                <input type="number" step="0.01" id="prix" name="prix" value="<%=prix%>" required>
            </div>
            <input type="submit" id="ok" value="Envoyer">
        </fieldset>
    </form>
</div>

</body>
</html>
<%}%>