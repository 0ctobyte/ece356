<%-- 
    Document   : doctor_search_form
    Created on : Mar 21, 2015, 9:36:18 PM
    Author     : sekharb
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>HealthCareSystem | Doctor Search</title>
    </head>
    <body>
        <jsp:useBean id="provinces" class="java.util.ArrayList" scope="request"/>
        <jsp:useBean id="specializations" class="java.util.ArrayList" scope="request"/>
        <jsp:useBean id="user" class="ece356.User" scope="session"/>
        <h1>Doctor Search</h1>
        <form name="doctor_search_form" action="DoctorSearchServlet" method="POST">
            first name: <input type="text" name="doctor_search_fname" value="" /><br>
            middle name: <input type="text" name="doctor_search_mname" value="" /><br>
            last name: <input type="text" name="doctor_search_lname" value="" /><br><br>
            street #: <input type="text" name="doctor_search_street#" value="" /><br>
            street name: <input type="text" name="doctor_search_streetname" value="" /><br>
            postal code: <input type="text" name="doctor_search_postal" value="" /><br>
            city: <input type="text" name="doctor_search_city" value="" /><br>
            province: <select name="doctor_search_province">
                <option></option>
                <% for(Object o: provinces) {
                    String province = (String)o;
                %>
                    <option><%= province %></option>
                <% } %>
            </select><br><br>
            # of years licensed: <input type="number" value="0" min="0" step="1" name="doctor_search_#yearslicensed" /><br>
            gender : <select name="doctor_search_gender">
                <option></option>
                <option>F</option>
                <option>M</option>
            </select><br>
            specialization: <select name="doctor_search_specialization">
                <option></option>
                <% for(Object o: specializations) {
                    String specialization = (String)o;
                %>
                    <option><%= specialization %></option>
                <% } %>
            </select><br>
            rating threshold: <input type="number" value="0" min="0" max="5" step="0.1" name="doctor_search_rating" /><br>
            reviewed by friend? <input type="checkbox" name="doctor_search_friendreviewed" value="1" /><br>
            keyword: <input type="text" name="doctor_search_keyword" value="" /><br>
            <input type="submit" value="Search" name="doctor_search_go" />
        </form>
        <a href="PatientProfileServlet">Profile</a>
    </body>
</html>
