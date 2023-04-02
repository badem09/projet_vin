package com.example.projet_vin;

import java.sql.Connection;
import java.sql.DriverManager;
import javax.servlet.http.*;
import javax.servlet.annotation.*;

@WebServlet(name = "servletAdmin", value = "/servlet-admin")
public class ServletAdmin extends HttpServlet {

    public void init() {}

    public void doPost(HttpServletRequest request, HttpServletResponse response){
        doGet(request,response);
    }

    public void doGet(HttpServletRequest request, HttpServletResponse response) {
        String query = getQuery(request);
        Connection conn;
        try {
            Class.forName("com.mysql.jdbc.Driver");
            String jdbc = "jdbc:mysql://localhost:3306/projet_vin";
            String root = "root";
            conn = DriverManager.getConnection(jdbc, root, "");

            conn.prepareStatement(query).executeUpdate();
            response.sendRedirect("page_admin.jsp");
        }  catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

    public String getQuery(HttpServletRequest request){
        String action = request.getParameter("action");
        String type = request.getParameter("type");
        String query = null;
        if ("vins".equals(type)){
            query = getQueryVins(action, request);
        }
        if ("user".equals(type)){
            query = getQueryUser(action,request);
        }
        return query;
    }

    public String getQueryUser(String action, HttpServletRequest request){
        String login = request.getParameter("login");
        String mdp = request.getParameter("mdp");
        String id = request.getParameter("id");
        String query = null;

        if ("ajout".equals(action)){
            query = "INSERT INTO users(login, role, mdp) VALUES('" + login + "', 'client', '" + mdp + "');";
        }
        if ("modif".equals(action)){
            query = "UPDATE users SET login = '" + login + "', mdp = '" + mdp + "'  WHERE id=" + id + ";";
        }
        if ("suppr".equals(action)){
            query = "DELETE FROM users WHERE id=" + id + ";";
        }
        return query;
    }

    public String getQueryVins(String action, HttpServletRequest request){
        String query = null;
        String id = request.getParameter("id");
        String nom = request.getParameter("nom");
        String stock = request.getParameter("stock");
        String libelle = request.getParameter("libelle");
        String prix = request.getParameter("prix");
        String couleur = request.getParameter("couleur");

        if ("ajout".equals(action)){
            query = "INSERT INTO vins (nom, stock, libelle, prix, couleur) " +
                    "VALUES ('" + nom + "', " + stock +", '" + libelle + "', "+ prix + ", '" + couleur + "');";
        }
        if ("modif".equals(action)){
            query =  "UPDATE  vins " +
                    "SET nom = '" + nom + "', stock = " + stock + " ," +
                    "libelle = '" + libelle + "', prix = " + prix + ", couleur = '" + couleur + "'" +
                    "WHERE id=" + id + ";";
        }
        if ("suppr".equals(action)){
            query = "DELETE FROM vins WHERE id=" + id + ";";
        }
        return query;
    }
        public void destroy() {
    }
}