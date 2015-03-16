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
        
    public static Review getReview(int review_id)
            throws ClassNotFoundException, SQLException, NamingException {

        Connection con = null;
        PreparedStatement pstmt = null;
        Review r;

        try {
            con = getConnection();
            String reviewQuery = "u.name_first, u.name_last, r.patient_alias,"
                    + " r.star_rating, r.date, r.comments FROM Review as r"
                    + " INNER JOIN User as u ON u.user_alias = r.doctor_alias"
                    + " WHERE r.review_id = ?";

            pstmt = con.prepareStatement(reviewQuery);
            pstmt.setInt(1, review_id);

            ResultSet resultSet;
            resultSet = pstmt.executeQuery();

            if (!resultSet.first()) {
                throw new RuntimeException("No Reviews found with review ID: " + review_id);
            }

            r = new Review(
                resultSet.getString("u.name_first"),
                resultSet.getString("u.name_last"),
                resultSet.getString("r.patient_alias"),
                resultSet.getInt("r.star_rating"),
                resultSet.getString("r.date"),
                resultSet.getString("r.comments")
            );

        } finally {
            if (pstmt != null) {
                pstmt.close();
            }
            if (con != null) {
                con.close();
            }
        }
        
        return r;
    }
    
    public static ArrayList<FriendRequest> getFriendRequests(String patient_alias)
            throws ClassNotFoundException, SQLException, NamingException {
        
        Connection con = null;
        PreparedStatement pstmt = null;
        ArrayList<FriendRequest> ret = new ArrayList<>();
        
        try {
            con = getConnection();
            String friendRequestQuery = "SELECT patient_alias, email"
                    + " FROM PatientFriendRequestView WHERE friend_alias = ?";
                    
            pstmt = con.prepareStatement(friendRequestQuery);
            pstmt.setString(1, patient_alias);
            
            ResultSet resultSet;
            resultSet = pstmt.executeQuery();
            
            if (!resultSet.first()) return ret;
            
            resultSet.beforeFirst();
            while (resultSet.next()) {
                FriendRequest f = new FriendRequest(
                        resultSet.getString("patient_alias"),
                        resultSet.getString("email")
                );
                ret.add(f);
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
    
    public static ArrayList<Integer> getReviewIDs(String doctor_alias)
        throws ClassNotFoundException, SQLException, NamingException {
        
        
        Connection con = null;
        PreparedStatement pstmt = null;
        ArrayList<Integer> ret = new ArrayList<>();
        
        try {
            con = getConnection();
            String reviewIDQuery = "SELECT review_id FROM Review WHERE"
                    + " doctor_alias = ? ORDER BY DATE DESC";
            
            pstmt = con.prepareStatement(reviewIDQuery);
            pstmt.setString(1, doctor_alias);
            
            ResultSet resultSet;
            resultSet = pstmt.executeQuery();
            
            if (!resultSet.first()) return ret;
            
            resultSet.beforeFirst();
            while (resultSet.next()) {
                ret.add(resultSet.getInt("Review.review_id"));
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
    
    public static ArrayList<WorkAddress> getWorkAddresses(String doctor_alias)
            throws ClassNotFoundException, SQLException, NamingException {
        
        
        Connection con = null;
        PreparedStatement pstmt = null;
        ArrayList<WorkAddress> ret = new ArrayList<>();
        
        try {
            con = getConnection();
            String workAddressQuery = "SELECT unit_number, street_number,"
                    + " street_name, postal_code, city, province FROM WorkAddress"
                    + " NATURAL JOIN City WHERE doctor_alias = ?";
            
            pstmt = con.prepareStatement(workAddressQuery);
            pstmt.setString(1, doctor_alias);
            
            ResultSet resultSet;
            resultSet = pstmt.executeQuery();
            
            if (!resultSet.first()) return ret;
            
            resultSet.beforeFirst();
            while (resultSet.next()) {
                WorkAddress w = new WorkAddress
                (
                    doctor_alias,
                    resultSet.getInt("WorkAddress.unit_number"),
                    resultSet.getInt("WorkAddress.street_number"),
                    resultSet.getString("WorkAddress.street_name"),
                    resultSet.getString("WorkAddress.postal_code"),
                    resultSet.getString("City.city"),
                    resultSet.getString("City.province")
                );
                ret.add(w);
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
    
    public static ArrayList<Specialization> getSpecializations(String doctor_alias)
            throws ClassNotFoundException, SQLException, NamingException {
        
        Connection con = null;
        PreparedStatement pstmt = null;
        ArrayList<Specialization> ret = new ArrayList<>();
                
        try {
            
            con = getConnection();
            
            String specializationQuery = "SELECT specialization_name FROM Specialization WHERE Specialization.doctor_alias = ?";
            
            pstmt = con.prepareStatement(specializationQuery);
            pstmt.setString(1, doctor_alias);
        
            ResultSet resultSet;
            resultSet = pstmt.executeQuery();

            if (!resultSet.first()) return ret;
            
            resultSet.beforeFirst();
            while(resultSet.next()) {
                Specialization s = new Specialization
                (
                    doctor_alias,
                    resultSet.getString("Specialization.specialization_name")
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
            
            String dopQuery = "SELECT * FROM DoctorOwnProfileView WHERE doctor_alias = ?";
            
            pstmt = con.prepareStatement(dopQuery);
            pstmt.setString(1, user_alias);
            
            ResultSet resultSet = pstmt.executeQuery();
            
            if (!resultSet.first()) throw new RuntimeException("No Doctor Found with alias: " + user_alias);
           
            dop = new DoctorOwnProfile(
                    resultSet.getString("DoctorOwnProfileView.doctor_alias"),
                    resultSet.getString("DoctorOwnProfileView.email"),
                    resultSet.getString("DoctorOwnProfileView.name_first"),
                    resultSet.getString("DoctorOwnProfileView.name_middle"),
                    resultSet.getString("DoctorOwnProfileView.name_last"),
                    (resultSet.getString("DoctorOwnProfileView.gender").equals("M")) ? DoctorOwnProfile.Gender.M : DoctorOwnProfile.Gender.F,
                    resultSet.getInt("DoctorOwnProfileView.num_years_licensed"),
                    resultSet.getDouble("DoctorOwnProfileView.avg_rating"),
                    resultSet.getInt("DoctorOwnProfileView.num_reviews")
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
    /*
    *        public String patient_alias;
    public String email;
    public String name_first;
    public String name_middle;
    public String name_last;
    public String city;
    public String province;
    
    */
    public static PatientOwnProfile patientOwnProfileView(String user_alias)
        throws ClassNotFoundException, SQLException, NamingException {
        Connection con = null;
        PreparedStatement pstmt = null;

        PatientOwnProfile pop;

        try {
            con = getConnection();

            String popQuery = "SELECT * FROM PatientOwnProfileView WHERE patient_alias = ?";

            pstmt = con.prepareStatement(popQuery);
            pstmt.setString(1, user_alias);

            ResultSet resultSet = pstmt.executeQuery();

            if (!resultSet.first()) {
                throw new RuntimeException("No Patient Found with alias: " + user_alias);
            }

            pop = new PatientOwnProfile(
                resultSet.getString("PatientOwnProfileView.patient_alias"),
                resultSet.getString("PatientOwnProfileView.email"),
                resultSet.getString("PatientOwnProfileView.name_first"),
                resultSet.getString("PatientOwnProfileView.name_middle"),
                resultSet.getString("PatientOwnProfileView.name_last"),
                resultSet.getString("PatientOwnProfileView.city"),
                resultSet.getString("PatientOwnProfileView.province")
            );

        } finally {
            if (pstmt != null) {
                pstmt.close();
            }
            if (con != null) {
                con.close();
            }
        }

        return pop;
    }
    
    
    public static User loginUser(String user_alias, String password_hash)
        throws ClassNotFoundException, SQLException, NamingException {

        
        Connection con = null;
        PreparedStatement pstmt = null;
        
        User u;
        
        try {
            con = getConnection();
                
            String userLoginQuery = "SELECT * FROM User WHERE user_alias = ? AND password_hash = password(?)";
            pstmt = con.prepareStatement(userLoginQuery);
            
            pstmt.setString(1, user_alias);
            pstmt.setString(2, password_hash);

            ResultSet resultSet = pstmt.executeQuery();
            
                        
            if(!resultSet.first()) throw new RuntimeException("Cannot login user with alias: " + user_alias);
             
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
