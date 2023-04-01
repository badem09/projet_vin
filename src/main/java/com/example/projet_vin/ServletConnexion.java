package com.example.projet_vin;

import java.io.*;
import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.http.*;
import javax.servlet.annotation.*;

@WebServlet(name = "servletConnexion", value = "/servlet-connexion")
public class ServletConnexion extends HttpServlet {

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        HttpSession session = request.getSession();
        String login = request.getParameter("login");
        String mdp = request.getParameter("mdp");

        Connection conn = null;
        try {
            Class.forName("com.mysql.jdbc.Driver");
            String jdbc = "jdbc:mysql://localhost:3306/projet_vin";
            String root = "root";
            conn = DriverManager.getConnection(jdbc, root, "");
        } catch (Exception e) {
            e.printStackTrace();
        }

        String query = "SELECT * from users WHERE login='" + login + "' and mdp='" + mdp +"'";
        try {
            ResultSet res = conn.prepareStatement(query).executeQuery();
            if (! res.next()){
                session.setAttribute("erreur","erreur");
                response.sendRedirect("connexion.jsp");
            }
            else{
                String role = res.getString("role");
                User user = new User(login,role,mdp);
                session.setAttribute("user", user);
                response.sendRedirect("accueil.jsp");
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }


    }

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        doGet(request,response);
    }

    public void destroy() {
    }

}
