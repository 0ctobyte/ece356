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
            middle name: <br>
            last name: <br><br>
            street #: <br>
            street name: <br>
            postal code: <br>
            city: <br>
            province: <select name="doctor_search_province">
                <option></option>
                <% for(Object o: provinces) {
                    String province = (String)o;
                %>
                    <option><%= province %></option>
                <% } %>
            </select><br><br>
            # of years licensed: <br>
            specialization: <select name="doctor_search_specialization">
                <option></option>
                <% for(Object o: specializations) {
                    String specialization = (String)o;
                %>
                    <option><%= specialization %></option>
                <% } %>
            </select><br>
            <input type="submit" value="Search" name="doctor_search_go" />
        </form>
        <a href="PatientProfileServlet">Profile</a>
    </body>
</html>
