/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ece356;

import java.sql.*;
import java.util.ArrayList;
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
    
    public static ArrayList<Specialization> getSpecializations(String doctor_alias)
            throws ClassNotFoundException, SQLException, NamingException {
        
        Connection con = null;
        PreparedStatement pstmt = null;
        ArrayList<Specialization> ret = null;
                
        try {
            
            con = getConnection();
            
            String specializationQuery = "SELECT specialization FROM Specialization WHERE Specialization.doctor_alias = ?";
            
            pstmt = con.prepareStatement(specializationQuery);
            pstmt.setString(0, "doctor_alias");
        
            ResultSet resultSet;
            resultSet = pstmt.executeQuery();

            ret = new ArrayList<>();
            while (resultSet.next()) {
                Specialization s = new Specialization(
                    resultSet.getString("doctor_alias"),
                    resultSet.getString("specialization_name")
                );
                ret.add(s);
            }
        } finally {
            if (pstmt != null) {
                pstmt.close();
            }
            if (con != null) {
                con.close();
            }
        }
        
        return ret;
    }
    
    
    public static DoctorOwnProfile doctorOwnProfileView(String user_alias)
            throws ClassNotFoundException, SQLException, NamingException {
        
        Connection con = null;
        PreparedStatement pstmt = null;
        
        DoctorOwnProfile dop;

        try {
            con = getConnection();
            
            String dopQuery = "SELECT * FROM DoctorOwnProfile WHERE user_alias = ?";
            
            pstmt = con.prepareStatement(dopQuery);
            pstmt.setString(0, user_alias);
            
            ResultSet resultSet = pstmt.executeQuery();
            
            if (!resultSet.first()) throw new RuntimeException();
            
            dop = new DoctorOwnProfile(
                    resultSet.getString("DoctorOwnProfile.user_alias"),
                    resultSet.getString("DoctorOwnProfile.name_first"),
                    resultSet.getString("DoctorOwnProfile.name_middle"),
                    resultSet.getString("DoctorOwnProfile.name_last"),
                    (resultSet.getString("DoctorOwnProfile.gender").equals("M")) ? DoctorOwnProfile.Gender.M : DoctorOwnProfile.Gender.F,
                    resultSet.getInt("DoctorOwnProfile.num_years_licensed"),
                    resultSet.getDouble("DoctorOwnProfile.avg_rating"),
                    resultSet.getInt("DoctorOwnProfile.num_reviews")
            );
            
        } finally {
            if (pstmt != null) {
                pstmt.close();
            }
            if (con != null) {
                con.close();
            }
        }
        
        return dop;
    }
    
    public static PatientOwnProfile patientOwnProfileView(String user_alias)
    {
        
        
        return null;
    }
    
    
    public static User loginUser(String user_alias, String password_hash)
        throws ClassNotFoundException, SQLException, NamingException {

        
        Connection con = null;
        PreparedStatement pstmt = null;
        
        User u;
        
        try {
            con = getConnection();
                
            String userLoginQuery = "SELECT * FROM User WHERE user_alias = ? AND password_hash = ?";
            pstmt = con.prepareStatement(userLoginQuery);
            
            pstmt.setString(0, user_alias);
            pstmt.setString(1, password_hash);

            ResultSet resultSet = pstmt.executeQuery();
                        
            if(!resultSet.first()) throw new RuntimeException();
             
            u = new User(
                    resultSet.getString("User.user_alias"),
                    resultSet.getString("User.email"),
                    resultSet.getString("User.password_hash"),
                    resultSet.getString("User.name_first"),
                    resultSet.getString("User.name_middle"),
                    resultSet.getString("User.name_last"),
                    (resultSet.getString("User.account_type").equals("Doctor")) ? User.AccountType.Doctor : User.AccountType.Patient
            );
            
        } finally {
                if (pstmt != null) {
                    pstmt.close();
                }
                if (con != null) {
                    con.close();
                }
            }
               
        return u;
        
    }
    
}
