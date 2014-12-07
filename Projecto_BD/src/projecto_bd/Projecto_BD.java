/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package projecto_bd;

import java.sql.*;

/**
 *
 * @author daniel
 */
public class Projecto_BD {

    static Connection conn;

    public static void main(String[] args) {
        String url = "jdbc:mysql://localhost:3306/";
        String dbName = "mydb";
        String driver = "com.mysql.jdbc.Driver";
        String userName = "root";
        String cUser;
        int n_users, res;

        try {
            Class.forName(driver).newInstance();
            conn = DriverManager.getConnection(url + dbName, userName, "");
            Statement st = conn.createStatement();

            // int val = st.executeUpdate("INSERT into User VALUES(4,'daniel','amaral','emprego','zau')");
            // System.out.println(val);
            res = login("amaral", "zau");
            n_users = countColumn("Meeting");
            System.out.println(n_users);
            //printInfo();
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }

    }

    private static int login(String username, String pass) throws SQLException {

        Statement st = conn.createStatement();
        ResultSet res = st.executeQuery("SELECT username,pass from User where username ='" + username + "' and pass = '" + pass + "'");
        while (res.next()) {
            System.out.println("Autenticado com sucesso.\n");
            return 1;
        }
        System.out.println("Problema na autenticação.\n");
        return 0;
    }

    private static int registerUser(int n_users, String nome, String username, String job, String pass) throws SQLException {

        n_users = countColumn("User");
        Statement st = conn.createStatement();
        ResultSet res = st.executeQuery("SELECT username from User where username ='" + username + "'");
        while (res.next()) {
            System.out.println("Utilizador ja registado.\n");
            return 0;
        }
        int val = st.executeUpdate("INSERT into User(nome,username,job, pass) VALUES('" + n_users + "','" + nome + "','" + job + "','" + "','" + pass + "'");
        if (val > 0) {
            System.out.println("Registado.\n");
        }
        return 1;
    }

    private static void printInfo(String column) throws SQLException {

        switch (column) {
            case "User":
                Statement st = conn.createStatement();
                ResultSet res = st.executeQuery("SELECT * from User ");
                while (res.next()) {
                    String nome = res.getString("nome");
                    String pass = res.getString("pass");
                    System.out.println(nome + "," + pass);
                }
                break;
            default:
                System.out.println("Invalid column name.\n");
                break;
        }
    }

    private static int countColumn(String column) throws SQLException {
        int n = 0;
        switch (column) {
            case "User":
                Statement st = conn.createStatement();
                ResultSet n_rows = st.executeQuery("SELECT * from User");
                while (n_rows.next()) {
                    n++;
                }
                break;
            case "Meeting":
                st = conn.createStatement();
                n_rows = st.executeQuery("SELECT * from Meeting");
                while (n_rows.next()) {
                    n++;

                }
                break;
            default:
                System.out.println("Invalid column name.\n");
                break;

        }
        return n;

    }

    private void initMeeting() throws SQLException {

    }

}
