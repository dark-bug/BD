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

    public static void main(String[] args) {
        String url = "jdbc:mysql://localhost:3306/";
        String dbName = "newdatabase";
        String driver = "com.mysql.jdbc.Driver";
        String userName = "root";
       

        try {
             Class.forName(driver).newInstance();
             Connection conn = DriverManager.getConnection(url+dbName,userName,"");
             
             conn.close();
        }catch(Exception e){
            e.printStackTrace();
        }

    }
}
