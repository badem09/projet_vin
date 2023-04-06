<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
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
        String login_client = request.getParameter("login");
        String mdp_client = "Error";
        Connection conn;
        try {
            Class.forName("com.mysql.jdbc.Driver");
            String jdbc = "jdbc:mysql://localhost:3306/projet_vin";
            conn = DriverManager.getConnection(jdbc, "root", "");

            String query = "SELECT * from users WHERE login=?";
            PreparedStatement stmt = conn.prepareStatement(query);
            stmt.setString(1,login_client);
            ResultSet res = stmt.executeQuery();
            while (res.next()) {
                login_client = res.getString("login");
                mdp_client = res.getString("mdp");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    %>
    <div style="display:flex; justify-content: center;" class="divform">
        <form action="servlet-admin" method="post" name="modif_client">
            <fieldset>
                <legend>Informations du client à modifier :</legend>
                <input type="hidden" value="modif_client" name="nom_form">
                <input type="hidden" name="action" value="modif">
                <input type="hidden" name="type" value="user">
                <input type="hidden" name="role" value="client">

                <div>
                    <label for="login">Login </label>
                    <input type="text" id="login" name="login" value="<%=login_client%>" readonly>
                </div>
                <div>
                    <label for="mdp">Mot de passe: </label>
                    <input type="text" id="mdp" name="mdp" value="<%=mdp_client%>" required>
                </div>
                <input type="submit" id="ok" value="Envoyer">
            </fieldset>
        </form>
    </div>
</body>
</html>
<% } %>