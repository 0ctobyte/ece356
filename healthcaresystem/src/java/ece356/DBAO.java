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

import org.mindrot.jbcrypt.BCrypt;
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
    
    public static ArrayList<String> getSpecializations()
            throws ClassNotFoundException, SQLException, NamingException 
    {
        Connection con = null;
        PreparedStatement pstmt = null;
        ArrayList<String> ret = new ArrayList<>();

        try {
            con = getConnection();
            String selectAllSpecializations = "SELECT DISTINCT specialization_name FROM Specialization";

            pstmt = con.prepareStatement(selectAllSpecializations);

            ResultSet resultSet;
            resultSet = pstmt.executeQuery();

            if (!resultSet.first()) {
                return ret;
            }

            resultSet.beforeFirst();
            while (resultSet.next()) {
                ret.add(resultSet.getString("specialization_name"));
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
    
    public static ArrayList<String> getProvinces()
            throws ClassNotFoundException, SQLException, NamingException {
        
        Connection con = null;
        PreparedStatement pstmt = null;
        ArrayList<String> ret = new ArrayList<>();

        try {
            con = getConnection();
            String selectAllProvinces = "SELECT * FROM Province";

            pstmt = con.prepareStatement(selectAllProvinces);

            ResultSet resultSet;
            resultSet = pstmt.executeQuery();

            if (!resultSet.first()) {
                return ret;
            }

            resultSet.beforeFirst();
            while (resultSet.next()) {
                ret.add(resultSet.getString("province"));
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
    
    
    public static void addFriendRequest(String patient_alias, String friend_alias)
        throws ClassNotFoundException, SQLException, NamingException
    {         
        Connection con = null;
        PreparedStatement pstmt = null;
        
        try {
            con = getConnection();
            String confirmFriendRequestUpdate = "INSERT INTO FriendRequest"
                    + " VALUES (?, ?, 0)";

            pstmt = con.prepareStatement(confirmFriendRequestUpdate);
            pstmt.setString(1, patient_alias);
            pstmt.setString(2, friend_alias);

            pstmt.executeUpdate();

        } finally {
            if (pstmt != null) {
                pstmt.close();
            }
            if (con != null) {
                con.close();
            }
        }     
    }
    
    public static void addDoctorReview (String patient_alias, String doctor_alias, Double star_rating, String comments)
            throws ClassNotFoundException, SQLException, NamingException
    {
        
        Connection con = null;
        PreparedStatement pstmt = null;

        try {
            con = getConnection();
            String addDoctorReivewUpdate = "INSERT INTO Review(patient_alias, doctor_alias,"
                    + " star_rating, comments)"
                    + " VALUES (?, ?, ?, ?)";

            pstmt = con.prepareStatement(addDoctorReivewUpdate);
            pstmt.setString(1, patient_alias);
            pstmt.setString(2, doctor_alias);
            pstmt.setDouble(3, star_rating);
            pstmt.setString(4, comments);

            pstmt.executeUpdate();

        } finally {
            if (pstmt != null) {
                pstmt.close();
            }
            if (con != null) {
                con.close();
            }
        }
    }
    
    public static DoctorProfile patientDoctorProfileView(String selected_doctor_alias)
            throws ClassNotFoundException, SQLException, NamingException {

        Connection con = null;
        PreparedStatement pstmt = null;

        DoctorProfile pdp;

        try {
            con = getConnection();

            String dpQuery = "SELECT * FROM PatientDoctorProfile WHERE user_alias = ?";

            pstmt = con.prepareStatement(dpQuery);
            pstmt.setString(1, selected_doctor_alias);

            ResultSet resultSet = pstmt.executeQuery();

            if (!resultSet.first()) {
                throw new RuntimeException("No Doctor Found with alias: " + selected_doctor_alias);
            }

            pdp = new DoctorProfile (
                    resultSet.getString("PatientDoctorProfile.doctor_alias"),
                    null,
                    resultSet.getString("PatientDoctorProfile.name_first"),
                    resultSet.getString("PatientDoctorProfile.name_middle"),
                    resultSet.getString("PatientDoctorProfile.name_last"),
                    (resultSet.getString("PatientDoctorProfile.gender").equals("M")) ? DoctorProfile.Gender.M : DoctorProfile.Gender.F,
                    resultSet.getInt("PatientDoctorProfile.num_years_licensed"),
                    resultSet.getDouble("PatientDoctorProfile.avg_rating"),
                    resultSet.getInt("PatientDoctorProfile.num_reviews")
            );
        } finally {
            if (pstmt != null) {
                pstmt.close();
            }
            if (con != null) {
                con.close();
            }
        }

        return pdp;
    }
    
    public static ArrayList<DoctorSearch> performDoctorSearch(String user_alias, String first_name,
            String middle_name, String last_name, String gender, Integer num_years_licensed,
            Integer street_number, String street_name, String postal_code, String city, 
            String province, String specialization, Double avg_rating,
            Integer review_by_friend, String keyword)
        throws ClassNotFoundException, SQLException, NamingException {
        
        Connection con = null;
        PreparedStatement pstmt = null;
        ArrayList<DoctorSearch> r = new ArrayList<>();
        String filteredString = "";
        
        try {
            con = getConnection();
                
            // Construct a filtered string for the DB search.
            if (!first_name.isEmpty()) {
                filteredString += " AND u.name_first LIKE ?";
            }

            if (!middle_name.isEmpty()) {
                filteredString += " AND u.name_middle LIKE ?";
            }

            if (!last_name.isEmpty()) {
                filteredString += " AND u.name_last LIKE ?";
            }
            
            if (!gender.isEmpty()){
                filteredString += " AND d.gender = ?";
            }
            
            if (num_years_licensed != Integer.MIN_VALUE){
                filteredString += " AND num_years_licensed >= ?";
            }
            
            if (street_number != Integer.MIN_VALUE){
                filteredString += " AND w.street_number = ?";
            }
            
            if (!street_name.isEmpty()){
                filteredString += " AND w.street_name LIKE ?";
            }
            
            if (!postal_code.isEmpty()){
                filteredString += " AND w.postal_code LIKE ?";
            }
            
            if (!city.isEmpty()){
                filteredString += " AND c.city LIKE ?";
            }
            
            if (!province.isEmpty()){
                filteredString += " AND c.province LIKE ?";
            }
            
            if (!specialization.isEmpty()){
                filteredString += " AND s.specialization_name LIKE ?";
            }
            
            if (avg_rating != Double.MIN_VALUE){
                filteredString += " AND ar.avg_rating >= ?";
            }
            
            if (review_by_friend != 0){
                filteredString += " AND t.reviewed_by_friend = ?";
            }
            
            if (!keyword.isEmpty()){
                filteredString += " AND t.comments COLLATE UTF8_GENERAL_CI LIKE ?";
            }
            
            String doctorSearchQuery = "SELECT DISTINCT d.doctor_alias, d.num_years_licensed,"
                    + " u.name_first, u.name_middle, u.name_last, d.gender,"
                    + " ar.avg_rating, nr.num_reviews"
                    + " FROM ((((((((SELECT *, (YEAR(current_timestamp)-license_year) "
                    + " AS num_years_licensed FROM Doctor) AS d INNER JOIN User AS u"
                    + " ON d.doctor_alias=u.user_alias) NATURAL JOIN"
                    + " Specialization AS s) NATURAL JOIN WorkAddress as w)"
                    + " NATURAL JOIN City AS c) NATURAL JOIN Province as p)"
                    + " LEFT JOIN (SELECT AVG(star_rating) AS avg_rating,"
                    + " doctor_alias FROM Review GROUP BY doctor_alias) AS ar"
                    + " ON d.doctor_alias=ar.doctor_alias) INNER JOIN (SELECT"
                    + " r.doctor_alias, r.comments, fr.accepted AS reviewed_by_friend"
                    + " FROM Review AS r LEFT JOIN (SELECT * FROM FriendRequest"
                    + " WHERE patient_alias=? OR friend_alias=?) AS fr ON"
                    + " r.patient_alias=fr.patient_alias OR r.patient_alias=fr.friend_alias)"
                    + " AS t ON t.doctor_alias=d.doctor_alias) LEFT JOIN (SELECT"
                    + " doctor_alias, COUNT(DISTINCT review_id) AS num_reviews"
                    + " FROM Review GROUP BY doctor_alias) AS nr ON"
                    + " d.doctor_alias=nr.doctor_alias WHERE TRUE" + filteredString;
            
            pstmt = con.prepareStatement(doctorSearchQuery);

            int num = 0;
            pstmt.setString(++num, user_alias);
            pstmt.setString(++num, user_alias);
            
            if (!first_name.isEmpty()) {
                pstmt.setString(++num, "%"+first_name+"%");
            }

            if (!middle_name.isEmpty()) {
                pstmt.setString(++num, "%"+middle_name+"%");
            }

            if (!last_name.isEmpty()) {
                pstmt.setString(++num, "%"+last_name+"%");
            }
            
            if (!gender.isEmpty()){
                pstmt.setString(++num, gender);
            }
            
            if (num_years_licensed != Integer.MIN_VALUE){
                pstmt.setInt(++num, num_years_licensed);
            }
            
            if (street_number != Integer.MIN_VALUE){
                pstmt.setInt(++num, street_number);
            }
            
            if (!street_name.isEmpty()){
                pstmt.setString(++num, "%"+street_name+"%");
            }
            
            if (!postal_code.isEmpty()){
                pstmt.setString(++num, "%"+postal_code+"%");
            }
            
            if (!city.isEmpty()){
                pstmt.setString(++num, "%"+city+"%");
            }
            
            if (!province.isEmpty()){
                pstmt.setString(++num, "%"+province+"%");
            }
            
            if (!specialization.isEmpty()){
                pstmt.setString(++num, "%"+specialization+"%");
            }
            
            if (avg_rating != Double.MIN_VALUE){
                pstmt.setDouble(++num, avg_rating);
            }
            
            if (review_by_friend != 0){
                pstmt.setInt(++num, review_by_friend);
            }
            
            if (!keyword.isEmpty()){
                pstmt.setString(++num, "%"+keyword+"%");
            }
            
            ResultSet resultSet;
            resultSet = pstmt.executeQuery();

            if (!resultSet.first()) {
                return r;
            }

            resultSet.beforeFirst();
            while (resultSet.next()) {
                DoctorSearch ds = new DoctorSearch(
                        resultSet.getString("d.doctor_alias"),
                        resultSet.getString("u.name_first"),
                        resultSet.getString("u.name_middle"),
                        resultSet.getString("u.name_last"),
                        resultSet.getString("d.gender"),
                        resultSet.getInt("nr.num_reviews"),
                        resultSet.getDouble("ar.avg_rating")
                );
                r.add(ds);
            }
            
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

    public static ArrayList<PatientSearch> performPatientSearch(String user_alias, String patient_alias, String province, String city)
            throws ClassNotFoundException, SQLException, NamingException {
        
        Connection con = null;
        PreparedStatement pstmt = null;
        ArrayList<PatientSearch> r = new ArrayList<>();
        String filteredString = "";
        
        try {
            con = getConnection();
            
            // Construct a filtered string for the DB search.
            if (!patient_alias.isEmpty())
            {
                filteredString += " AND patient_alias LIKE ?";
            }
            
            if (!province.isEmpty()) {
                filteredString += " AND province LIKE ?";
            }
            
            if (!city.isEmpty()) {
                filteredString += " AND city LIKE ?";
            }
            
            String patientSearchQuery = "SELECT pcr.*, fr.friend_alias, fr.accepted"
                    + " FROM (SELECT pc.*, COUNT(DISTINCT review_id) AS num_reviews,"
                    + " max(r.date) as last_review FROM (SELECT p.patient_alias,"
                    + " c.city, c.province FROM Patient AS p NATURAL JOIN City as c"
                    + " WHERE TRUE" + filteredString + ") AS pc"
                    + " LEFT JOIN Review AS r ON r.patient_alias = pc.patient_alias"
                    + " GROUP BY patient_alias) AS pcr LEFT JOIN FriendRequest AS fr"
                    + " ON (fr.patient_alias = ? AND fr.friend_alias = pcr.patient_alias)"
                    + " OR (fr.patient_alias = pcr.patient_alias AND fr.friend_alias = ?)";
            
            pstmt = con.prepareStatement(patientSearchQuery);

            int num = 0;
            if (!patient_alias.isEmpty()) {
                pstmt.setString(++num, "%"+patient_alias+"%");
            }
            if (!province.isEmpty()) {
                pstmt.setString(++num, "%"+province+"%");
            }
            if (!city.isEmpty()) {
                pstmt.setString(++num, "%"+city+"%");
            }
            
            pstmt.setString(++num, user_alias);
            pstmt.setString(++num, user_alias);
            
            ResultSet resultSet;
            resultSet = pstmt.executeQuery();

            if (!resultSet.first()) {
                return r;
            }

            resultSet.beforeFirst();
            while (resultSet.next()) {
                if(resultSet.getString("pcr.patient_alias").equals(user_alias)) continue;
                PatientSearch ps = new PatientSearch(
                        resultSet.getString("pcr.patient_alias"),
                        resultSet.getString("pcr.city"),
                        resultSet.getString("pcr.province"),
                        resultSet.getInt("pcr.num_reviews"),
                        resultSet.getString("pcr.last_review"),
                        resultSet.getString("fr.friend_alias"),
                        resultSet.getBoolean("fr.accepted")
                );
                r.add(ps);
            }
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

    public static Integer getNextReview(int review_id)
            throws ClassNotFoundException, SQLException, NamingException {

        Connection con = null;
        PreparedStatement pstmt = null;
        Integer r;

        try {
            con = getConnection();
            String reviewQuery = "SELECT r.review_id FROM (SELECT doctor_alias,"
                    + " date FROM Review WHERE review_id = ?) AS rd"
                    + " INNER JOIN Review as r ON rd.doctor_alias = r.doctor_alias"
                    + " WHERE r.date > rd.date"
                    + " ORDER BY r.date ASC LIMIT 1";

            pstmt = con.prepareStatement(reviewQuery);
            pstmt.setInt(1, review_id);

            ResultSet resultSet;
            resultSet = pstmt.executeQuery();

            if (!resultSet.first()) return 0;

            r = resultSet.getInt("r.review_id");

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
    
    
    public static void confirmFriendRequest(String patient_alias, String friend_alias)
            throws ClassNotFoundException, SQLException, NamingException {
        
        Connection con = null;
        PreparedStatement pstmt = null;
        
        try {
            con = getConnection();
            String confirmFriendRequestUpdate = "UPDATE FriendRequest"
                    + " SET accepted = 1"
                    + " WHERE (patient_alias = ? AND friend_alias = ?)"
                    + " OR (patient_alias = ? AND friend_alias = ?)";
            
            pstmt = con.prepareStatement(confirmFriendRequestUpdate);
            pstmt.setString(1, patient_alias);
            pstmt.setString(2, friend_alias);
            pstmt.setString(3, friend_alias);
            pstmt.setString(4, patient_alias);
            
            pstmt.executeUpdate();
            
        } finally {
            if (pstmt != null) {
                pstmt.close();
            }
            if (con != null) {
                con.close();
            }
        }
    }

    public static Integer getPreviousReview(int review_id)
            throws ClassNotFoundException, SQLException, NamingException {
        
        Connection con = null;
        PreparedStatement pstmt = null;
        Integer r;
        
        try {
            con = getConnection();
            String reviewQuery = "SELECT r.review_id FROM (SELECT doctor_alias,"
                    + " review_id, date FROM Review WHERE review_id = ?) AS rd"
                    + " INNER JOIN Review as r ON rd.doctor_alias = r.doctor_alias"
                    + " WHERE r.date <= rd.date AND r.review_id != rd.review_id"
                    + " ORDER BY r.date DESC LIMIT 1";

            pstmt = con.prepareStatement(reviewQuery);
            pstmt.setInt(1, review_id);

            ResultSet resultSet;
            resultSet = pstmt.executeQuery();

            if (!resultSet.first()) return 0;

            r = resultSet.getInt("r.review_id");

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
        
    public static Review getReview(int review_id)
            throws ClassNotFoundException, SQLException, NamingException {

        Connection con = null;
        PreparedStatement pstmt = null;
        Review r;

        try {
            con = getConnection();
            String reviewQuery = "SELECT u.name_first, u.name_last, r.patient_alias,"
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
                resultSet.getDouble("r.star_rating"),
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
    
    
    public static DoctorProfile doctorOwnProfileView(String doctor_alias)
            throws ClassNotFoundException, SQLException, NamingException {
        
        Connection con = null;
        PreparedStatement pstmt = null;
        
        DoctorProfile dop;

        try {
            con = getConnection();
            
            String dopQuery = "SELECT * FROM DoctorOwnProfileView WHERE doctor_alias = ?";
            
            pstmt = con.prepareStatement(dopQuery);
            pstmt.setString(1, doctor_alias);
            
            ResultSet resultSet = pstmt.executeQuery();
            
            if (!resultSet.first()) throw new RuntimeException("No Doctor Found with alias: " + doctor_alias);
           
            dop = new DoctorProfile(
                    resultSet.getString("DoctorOwnProfileView.doctor_alias"),
                    resultSet.getString("DoctorOwnProfileView.email"),
                    resultSet.getString("DoctorOwnProfileView.name_first"),
                    resultSet.getString("DoctorOwnProfileView.name_middle"),
                    resultSet.getString("DoctorOwnProfileView.name_last"),
                    (resultSet.getString("DoctorOwnProfileView.gender").equals("M")) ? DoctorProfile.Gender.M : DoctorProfile.Gender.F,
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

    public static PatientProfile patientOwnProfileView(String patient_alias)
        throws ClassNotFoundException, SQLException, NamingException {
        Connection con = null;
        PreparedStatement pstmt = null;

        PatientProfile pop;

        try {
            con = getConnection();

            String popQuery = "SELECT * FROM PatientOwnProfileView WHERE patient_alias = ?";

            pstmt = con.prepareStatement(popQuery);
            pstmt.setString(1, patient_alias);

            ResultSet resultSet = pstmt.executeQuery();

            if (!resultSet.first()) {
                throw new RuntimeException("No Patient Found with alias: " + patient_alias);
            }

            pop = new PatientProfile(
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
    
    
    public static User loginUser(String user_alias, String password)
        throws ClassNotFoundException, SQLException, NamingException {

        
        Connection con = null;
        PreparedStatement pstmt = null;
        
        User u;
        try {
            con = getConnection();
                
            String userLoginQuery = "SELECT * FROM User WHERE user_alias = ?";
            pstmt = con.prepareStatement(userLoginQuery);
            
            pstmt.setString(1, user_alias);

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
            
            if(BCrypt.checkpw(password, u.getPasswordHash())) {
                return u;
            } else {
                throw new RuntimeException("Invalid password");
            }
        } finally {
            if (pstmt != null) {
                pstmt.close();
            }
            if (con != null) {
                con.close();
            }
        }
    }
}
