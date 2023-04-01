package com.example.projet_vin;

public class User {
    private String login;
    private String mdp;
    private String role;

    public User(String login,String role, String mdp){
        this.login = login;
        this.role = role;
        this.mdp=mdp;
    }

    public String getLogin() {
        return login;
    }

    public String getMdp() {
        return mdp;
    }

    public String getRole() {
        return role;
    }
}
