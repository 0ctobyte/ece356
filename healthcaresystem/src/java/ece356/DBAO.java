/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ece356;

import java.sql.*;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;
/**
 *
 * @author sekharb
 */
public class DBAO {
    public static final String host = "eceweb.uwaterloo.ca";
    public static final String url = "jdbc:mysql://" + host + ":3306/";
    public static final String nid = "s4bhatta";
    public static final String user = "user_" + nid;
    public static final String pwd = "user_" + nid;
    
    public static void testConnection()
            throws ClassNotFoundException, SQLException, NamingException {
        Connection con = null;
        try {
            con = getConnection();
        } finally {
            if (con != null) {
                con.close();
            }
        }
    }

    public static Connection getConnection()
            throws ClassNotFoundException, SQLException, NamingException {
        Class.forName("com.mysql.jdbc.Driver");
        Connection con = null;
        Statement stmt = null;
        try {
            InitialContext cxt = new InitialContext();
            if(cxt == null) {
                throw new RuntimeException("Unable to create naming context!");
            }
            Context dbContext = (Context)cxt.lookup("java:comp/env");
            DataSource ds = (DataSource)dbContext.lookup("jdbc/myDatasource");
            if(ds == null) {
                throw new RuntimeException("Data source not found!");
            }
            con = ds.getConnection();
            stmt = con.createStatement();
            stmt.execute("USE ece356db_" + nid);
        } finally {
            if (stmt != null) {
                stmt.close();
            }
        }
        return con;
    }
}
