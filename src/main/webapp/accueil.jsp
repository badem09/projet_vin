<%@ page import="com.example.projet_vin.User" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.PreparedStatement" %>

<!DOCTYPE html>
<html>
<head>
  <title>Accueil</title>
  <link rel="stylesheet" href="style.css">
</head>
<body>
  <%
    User user = (User) session.getAttribute("user");
    if(user == null) {
      response.sendRedirect("index.jsp");
    }
    else{
      String nom, stock, couleur, libelle, prix  ;
      Connection conn= null;
    try {
      Class.forName("com.mysql.jdbc.Driver");
      String jdbc = "jdbc:mysql://localhost:3306/projet_vin";
      conn = DriverManager.getConnection(jdbc, "root", "");
    } catch (Exception e) {
      e.printStackTrace();
    }
  %>

  <ul class="navbar">
    <%  %>
    <li class="navbar-item"><a href="accueil.jsp" class="navbar-link">
      <img src="logo.png" alt="logo" width="50" height="50"></a></li>
    <% if (user != null){
        if ("admin".equals( user.getRole())){%>
    <li class="navbar-item" style="float: right;"><a href="page_admin.jsp" class="navbar-link">Administration</a></li>
    <%}%>

    <li class="navbar-item" style="float: right;"><a href="servlet-deconnexion" class="navbar-link">Deconnexion</a></li>
    <%}
    else{ %>
    <li class="navbar-item" style=
            "float: right;"><a href="connexion.jsp" class="navbar-link">Connexion</a></li>
    <% }
    %>
  </ul>

  <div class="container" style="flex-direction: column;">
    <h1> Bienvenu <%=user.getLogin()%> ! </h1>
    <h3> Les vins </h3>
      <table>
        <tr>
          <th>Nom</th>
          <th>Stock</th>
          <th>Couleur</th>
          <th>Libellé</th>
          <th>Prix unitaire</th>
        </tr>
        <%
          try {

            String sel="SELECT * from vins";
            PreparedStatement st=conn.prepareStatement(sel);
            ResultSet res=st.executeQuery();
            while (res.next()) {
              nom = res.getString("nom");
              stock = res.getString("stock");
              couleur = res.getString("couleur");
              libelle = res.getString("libelle");
              prix = res.getString("prix");
        %>
        <tr>
          <td><%= nom%></td>
          <td><%= stock%></td>
          <td><%= couleur%></td>
          <td><%= libelle%></td>
          <td><%= prix%></td>
        </tr>
        <% }
            %>
      </table>
  </div>
<%
          }
          catch (Exception e){
            throw new RuntimeException();
          }
    }
%>
</body>
</html>
