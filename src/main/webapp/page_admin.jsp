<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Administration</title>
    <link rel="stylesheet" href="style.css">
    <style>
        .container {
            display: flex;
            margin-left:5px;
            margin-right:5px;
            justify-content: center;
            text-align: center;
        }

        .content {
            flex-direction: column;
            flex: 10%;
            padding: 5px;
            display: inline-block;
        }

        table {
            border-collapse: collapse;
            border: 1px solid #ddd;
            margin: auto;
            table-layout: fixed;
        }
        th{
            background-color: #c5c5c5;
            width: auto;
        }
        th, td {
            text-align: left;
            padding: 10px;
            border : 1px solid #dddddd;
        }
    </style>
</head>
<body>

    <ul class="navbar">
        <li class="navbar-item"><a href="index.jsp" class="navbar-link">
            <img src="logo.png" alt="logo" width="50" height="50"></a></li>
        <li class="navbar-item" style="float: right;"><a href="page_admin.jsp" class="navbar-link">Administration</a></li>
        <li class="navbar-item" style="float: right;"><a href="servlet-deconnexion" class="navbar-link">Deconnexion</a></li>
    </ul>

    <%
        String nom, stock, couleur, libelle, prix  ;
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
    <div class="container">
        <div class="content">
            <h3> Les vins </h3>
            <div style="padding: 20px; display: inline-block;">
            <a href="#ajouter"><button style="float: left; margin-bottom: 10px; ">Ajouter</button></a>
            <table>
            <tr>
                <th>Nom</th>
                <th>Stock</th>
                <th>Couleur</th>
                <th>Libellé</th>
                <th>Prix unitaire</th>
                <th colspan="3"></th>
            </tr>
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
            %>
            <tr>
                <td><%= nom%></td>
                <td><%= stock%></td>
                <td><%= couleur%></td>
                <td><%= libelle%></td>
                <td><%= prix%></td>
                <td><a href="#modifier"><button>Modifier</button></a></td>
                <td><a href="#supprimer"><button>Supprimer</button></a></td>
            </tr>
                 <% } %>
        </table>
            </div>
        </div>
        <%
        String login,mdp;
        String query2="SELECT * from users WHERE role='client'";
        ResultSet res2=conn.prepareStatement(query2).executeQuery();
        %>
        <div class="content">
            <h3> Les clients </h3>
            <div style="padding: 20px; display: inline-block;">
                <a href="#ajouter"><button style="float: left; margin-bottom: 10px; ">Ajouter</button></a>            <table>
            <tr>
                <th>Login</th>
                <th>Mot de passe</th>
                <th colspan="3"></th>
            </tr>
            <%
            while (res2.next()) {
                login = res2.getString("login");
                mdp = res2.getString("mdp");
            %>
            <tr>
                <td><%= login%></td>
                <td><%= mdp%></td>
                <td><a href="#modifier"><button>Modifier</button></a></td>
                <td><a href="#supprimer"><button>Supprimer</button></a></td>
            </tr>
                <% } %>
        </table>
            </div>
        </div>
    </div>

</body>
</html>
