<%-- 
    Document   : doctor_search_result
    Created on : Mar 22, 2015, 4:12:35 PM
    Author     : sekharb
--%>

<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ page import="ece356.DoctorSearch" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>HealthCareSystem | Doctor Search Results</title>
    </head>
    <body>
        <jsp:useBean id="doctorSearchResults" class="java.util.ArrayList" scope="request"/>
        <jsp:useBean id="user" class="ece356.User" scope="session"/>
        <h1>Doctor Search Results</h1>
        <table border=1>
            <tr>
                <th>name</th>
                <th>gender</th>
                <th>average rating</th>
                <th>number of reviews</th>
            </tr>
            <% for(Object o: doctorSearchResults) { 
                DoctorSearch ds = (DoctorSearch)o;
            %>
                <tr>
                    <td><%= ds.getFirstName() + " " + ds.getLastName() %></td>
                    <td><%= ds.getGender() %></td>
                    <td><%= ds.getAvgRating() %></td>
                    <td><%= ds.getNumReviews() %></td>
                </tr>
            <% } %>
        </table>
    </body>
</html>
