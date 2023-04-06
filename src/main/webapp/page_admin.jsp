<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="com.example.projet_vin.User" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Administration</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>
<%
    User user = (User) session.getAttribute("user");
    if(user == null) {
        response.sendRedirect("index.jsp");
    }
    else{
    String nom, stock, couleur, libelle, prix, id  ;
    Connection conn=null;
    try {
        Class.forName("com.mysql.jdbc.Driver");
        String jdbc = "jdbc:mysql://localhost:3306/projet_vin";
        String root = "root";
        String mdp = "";
        conn = DriverManager.getConnection(jdbc, root, mdp);
    } catch (Exception e) {
        e.printStackTrace();
    }
%>
    <ul class="navbar">
        <li class="navbar-item"><a href="accueil.jsp" class="navbar-link">
            <img src="logo.png" alt="logo" width="50" height="50"></a></li>
        <li class="navbar-item" style="float: right;"><a href="page_admin.jsp" class="navbar-link">Administration</a></li>
        <li class="navbar-item" style="float: right;"><a href="servlet-deconnexion" class="navbar-link">Deconnexion</a></li>
    </ul>
    <div class="container">
        <div class="content">
            <h3> Les vins </h3>
            <div style="padding: 20px; display:inline-flex; flex-direction: column">
                <a href="ajout_vin.jsp"><button style="float: left; margin-bottom: 10px; ">Ajouter</button></a>
                <table>
                    <tr>
                        <th>Nom</th>
                        <th>Stock</th>
                        <th>Couleur</th>
                        <th>Libellé</th>
                        <th>Prix unitaire (en euros)</th>
                        <th colspan="3"></th>
                    </tr>
                        <tbody style="overflow: auto;">
                <%
                String sel="SELECT * from vins";
                PreparedStatement st=conn.prepareStatement(sel);
                ResultSet res=st.executeQuery();
                while (res.next()) {
                    nom = res.getString("nom");
                    stock = res.getString("stock");
                    couleur = res.getString("couleur");
                    libelle = res.getString("libelle");
                    prix = res.getString("prix");
                    id = res.getString("id");
                %>
                        <tr>
                            <td><%= nom%></td>
                            <td><%= stock%></td>
                            <td><%= couleur%></td>
                            <td><%= libelle%></td>
                            <td><%= prix%></td>
                            <td><a href="modif_vin.jsp?id=<%=id%>"><img src="red_pen.png" class="icon"></a></td>
                            <td><a href="servlet-admin?action=suppr&type=vins&id=<%=id%>" onclick="confirm('Etes-vous sûr de vouloir supprimer ce vin?');"><img src="red_cross.png" class="icon"></a></td>
                        </tr>
                    <% } %>
                        </tbody>
                </table>
            </div>
        </div>
        <%
        String login,mdp;
        String query2="SELECT * from users WHERE role='client'";
        ResultSet res2=conn.prepareStatement(query2).executeQuery();
        %>
        <div class="vl"></div>
        <div class="content">
            <h3> Les clients </h3>
            <div style="padding: 20px; display:inline-flex; flex-direction: column">
                <a href="ajout_client.jsp"><button style="float: left; margin-bottom: 10px; ">Ajouter</button></a>
                <table>
                <tr>
                    <th>Login</th>
                    <th>Mot de passe</th>
                    <th colspan="3"></th>
                </tr>
                    <tbody style="overflow: auto;">
            <%
            while (res2.next()) {
                login = res2.getString("login");
                mdp = res2.getString("mdp");
                id = res2.getString("id");
            %>
                    <tr>
                        <td><%= login%></td>
                        <td><%= mdp%></td>
                        <td><a href="modif_client.jsp?id=<%=id%>"><img src="red_pen.png" class="icon"></a></td>
                        <td><a href="servlet-admin?action=suppr&type=user&id=<%=id%>" onclick="confirm('Etes-vous sûr de vouloir supprimer ce client ?')"><img src="red_cross.png" class="icon"></a></td>
                    </tr>
                <% } %>
                    </tbody>

                </table>
            </div>
        </div>
    </div>
<%}%>
</body>
</html>
