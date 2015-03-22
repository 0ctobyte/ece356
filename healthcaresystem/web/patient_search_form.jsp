<%-- 
    Document   : patient_search_form
    Created on : Mar 21, 2015, 9:08:48 PM
    Author     : sekharb
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>HealthCareSystem | Patient Search</title>
    </head>
    <body>
        <jsp:useBean id="provinces" class="java.util.ArrayList" scope="request"/>
        <jsp:useBean id="user" class="ece356.User" scope="session"/>
        <h1>Patient Search</h1>
        <form name="patient_search_form" action="PatientSearchServlet" method="POST">
            Patient alias: <input type="text" name="patient_search_alias" value="" /><br>
            city: <input type="text" name="patient_search_city" value="" /><br>
            province: <select name="patient_search_province">
                <option></option>
                <% for(Object o: provinces) {
                    String province = (String)o;
                %>
                    <option><%= province %></option>
                <% } %>
            </select><br>
            <input type="submit" value="Search" name="patient_search_go" />
        </form>
        <a href="PatientProfileServlet">Profile</a>
    </body>
</html>
