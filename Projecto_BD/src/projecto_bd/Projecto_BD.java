/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package projecto_bd;

import java.sql.*;
import java.text.ParseException;
import java.text.SimpleDateFormat;

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
        int n_users = 0, res;

        try {
            Class.forName(driver).newInstance();
            conn = DriverManager.getConnection(url + dbName, userName, "");

            //  login("jojo","passa");
            // registerUser("jorge", "jojo", "punheta", "passa");
            Timestamp temp = stringToTimestamp("16-01-2002" + " " + "7:44:22");
            // System.out.println(temp);
            initMeeting("teste as 500", "leva no cu", temp, "DEI-FCTUC", 4);
            listUpcomingMeetings(4);

            conn.close();
        } catch (ClassNotFoundException | InstantiationException | IllegalAccessException | SQLException | ParseException e) {
            System.out.println("Catch exception: " + e);
        }

    }

    public static int login(String username, String pass) throws SQLException {

        Statement st = conn.createStatement();
        ResultSet res = st.executeQuery("SELECT username,pass from User where username ='" + username + "' and pass = '" + pass + "'");
        while (res.next()) {
            System.out.println("Autenticado com sucesso.\n");
            return 1;
        }
        System.out.println("Problema na autenticação.\n");
        return 0;
    }

    public static int registerUser(String nome, String username, String job, String pass) throws SQLException {

        int n_users = countRow("User");
        Statement st = conn.createStatement();
        ResultSet res = st.executeQuery("SELECT username from User where username ='" + username + "'");
        while (res.next()) {
            System.out.println("Utilizador ja registado.\n");
            return 0;
        }
        String query = "insert into User (idUser,nome,username,job,pass)"
                + "values(?,?,?,?,?)";
        PreparedStatement pStmt = conn.prepareStatement(query);
        pStmt.setInt(1, n_users);
        pStmt.setString(2, nome);
        pStmt.setString(3, username);
        pStmt.setString(4, job);
        pStmt.setString(5, pass);

        pStmt.execute();
        return 1;
    }

    public static void printInfo(String column) throws SQLException {

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

    public static int countRow(String column) throws SQLException {
        int n = 1;
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
            case "Item":
                st = conn.createStatement();
                n_rows = st.executeQuery("SELECT * from Item");
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

    public static int initMeeting(String desiredOutcome, String title, Timestamp data, String location, int idLeader) throws SQLException {

        Statement st = conn.createStatement();
        ResultSet res = st.executeQuery("SELECT date,location from Meeting where date ='" + data + "' and location = '" + location + "'");
        while (res.next()) {
            System.out.println("Já se encontra agendada uma reunião na data indicada para o mesmo local.");
            return 0;
        }
        String query = "insert into Meeting (idMeeting,desiredOutcome,title,date,location,active,User_idUser)"
                + "values(?,?,?,?,?,?,?)";
        PreparedStatement pStmt = conn.prepareStatement(query);
        int idMeet = countRow("Meeting");
        addAgendaItem("Any Other Business", "", idMeet);
        pStmt.setInt(1, idMeet);
        pStmt.setString(2, desiredOutcome);
        pStmt.setString(3, title);
        pStmt.setTimestamp(4, data);
        pStmt.setString(5, location);
        pStmt.setBoolean(6, false);
        pStmt.setInt(7, idLeader);

        pStmt.execute();

        query = "insert into User_has_Meeting (User_idUser,Meeting_idMeeting)" + "values(?,?)";
        pStmt = conn.prepareStatement(query);
        pStmt.setInt(1, idMeet);
        pStmt.setInt(2, idLeader);

        pStmt.execute();

        System.out.println("Inseri a meeting.\n");
        return 1;

    }

    public static Timestamp stringToTimestamp(String date) throws ParseException {
        SimpleDateFormat dateFormat = new SimpleDateFormat("dd-MM-yyyy hh:mm:ss");
        java.util.Date parseTimestamp = dateFormat.parse(date);
        Timestamp ts = new Timestamp(parseTimestamp.getTime());
        return ts;
    }

    public static String listUpcomingMeetings(int id) throws SQLException {
        String output = "";
        Statement st = conn.createStatement();
        ResultSet res = st.executeQuery(
                "SELECT m.title,m.date "
                + "from User_has_Meeting uhm,Meeting m "
                + "where uhm.User_idUser = '" + id + "' and "
                + "uhm.Meeting_idMeeting = m.idMeeting");

        while (res.next()) {

            java.util.Date date = new java.util.Date();
            Timestamp now = new Timestamp(date.getTime());
            if ((res.getTimestamp("date")).after(now)) {
                //  System.out.println(res.getTimestamp("date"));
                output += res.getTimestamp("date");
            }
        }
        return output;
    }

    public static void addAgendaItem(String item, String description, int idMeeting) throws SQLException {

        Statement st = conn.createStatement();

        String query = "insert into Item (idItem,description,idMeeting)"
                + "values(?,?,?)";
        PreparedStatement pStmt = conn.prepareStatement(query);
        int n_item = countRow("Item");
        pStmt.setInt(1, n_item);
        pStmt.setString(2, description);
        pStmt.setInt(3, idMeeting);

        pStmt.execute();

    }
    /*
     public static String seeMeetingOverview(int id) {
     String output = "";

     Statement st = conn.createStatement();
     ResultSet res = st.executeQuery(
     "SELECT ")
     }*/

}
