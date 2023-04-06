package com.example.projet_vin;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.util.Arrays;
import java.util.List;
import javax.servlet.http.*;
import javax.servlet.annotation.*;

@WebServlet(name = "servletAdmin", value = "/servlet-admin")
public class ServletAdmin extends HttpServlet {

    public void init() {}

    public void doPost(HttpServletRequest request, HttpServletResponse response){
        doGet(request,response);
    }

    public void doGet(HttpServletRequest request, HttpServletResponse response) {
        System.out.println(request.getParameter("role"));
        String query = getQuery(request);
        List<String> paramNeeded = getParametersNeeded(request);
        Connection conn;
        try { // setup connexion
            Class.forName("com.mysql.jdbc.Driver");
            String jdbc = "jdbc:mysql://localhost:3306/projet_vin";
            conn = DriverManager.getConnection(jdbc, "root", "");

            PreparedStatement stmt = conn.prepareStatement(query);
            for (int i=1; i<paramNeeded.size()+1; i++){
                stmt.setString(i,request.getParameter(paramNeeded.get(i-1)));
            }
            stmt.execute();
            response.sendRedirect("page_admin.jsp");
        }  catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

    public List<String> getParametersNeeded(HttpServletRequest request){
        String action = request.getParameter("action");
        String type = request.getParameter("type");
        if (type.equals("user")){
            if ("ajout".equals(action)){
                return Arrays.asList("login","role","mdp");
            }
            if ("modif".equals(action)){
                return Arrays.asList("login","mdp","id");
            }
            if ("suppr".equals(action)){
                return Arrays.asList("id");
            }
        }
        if (type.equals("vins")){
            if ("ajout".equals(action)){
                return Arrays.asList("nom", "stock", "libelle", "prix", "couleur");
            }
            if ("modif".equals(action)){
                return Arrays.asList("nom", "stock", "libelle", "prix", "couleur","id");
            }
            if ("suppr".equals(action)){
                return Arrays.asList("id");
            }
        }
        return null;
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
            query = "INSERT INTO users(login, role, mdp) VALUES(?,?,?);";
        }
        if ("modif".equals(action)){
            query = "UPDATE users SET login = ?, mdp = ?  WHERE id = ? ;";
        }
        if ("suppr".equals(action)){
            query = "DELETE FROM users WHERE id = ?;";
        }
        return query;
    }

    public String getQueryVins(String action, HttpServletRequest request){
        String query = null;
        if ("ajout".equals(action)){
            query = "INSERT INTO vins (nom, stock, libelle, prix, couleur) " +
                    "VALUES (?,?,?,?,?);";
        }
        if ("modif".equals(action)){
            query =  "UPDATE  vins " +
                    "SET nom = ?, stock = ?," +
                    "libelle = ?, prix = ?, couleur = ? " +
                    "WHERE id = ? ;";
        }
        if ("suppr".equals(action)){
            query = "DELETE FROM vins WHERE id = ? ;";
        }
        return query;
    }
        public void destroy() {
    }
}