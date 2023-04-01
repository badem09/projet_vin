<%@ page import="com.example.projet_vin.User" %>
<%@ page import="java.io.PrintWriter" %>

<!DOCTYPE html>
<html>
<head>
  <link rel="stylesheet" href="style.css">
</head>
<body>

<%
  User user = (User) session.getAttribute("user");
  if(user == null) {
    response.sendRedirect("index.jsp");
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

<h1> T connecté le kho <%=user.getLogin()%> <%=user.getRole()%> </h1>

</body>
</html>
