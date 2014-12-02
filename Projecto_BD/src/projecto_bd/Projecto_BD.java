/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package projecto_bd;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;

/**
 *
 * @author daniel
 */
public class Projecto_BD {

    public static void main(String[] args) {
        String nome = "daniel";
        String pass = "1111";
        String job = "dasd";
        Connection conn = null;
        Statement stmt = null;

        try {
            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost/projecto" + "user=root");
            System.out.println("Connected.\n");
            
            stmt =conn.createStatement();
            String cmd = "INSERT INTO User" + "VALUES (1,'DANIEL','a','B','ffff')";
            
            stmt.executeUpdate(cmd);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (stmt != null) {
                    conn.close();
                }
            } catch (SQLException se) {
            }
            try {
                if (conn != null) {
                    conn.close();
                }
            } catch (SQLException se) {
                se.printStackTrace();
            }
        }
    }

    

}
