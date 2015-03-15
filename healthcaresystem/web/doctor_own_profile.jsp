<%--
    Document   : doctor_profile_own
    Created on : Mar 15, 2015, 12:52:25 PM
    Author     : sekharb
--%>

<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ page import="ece356.Specialization" %>
<%@ page import="ece356.WorkAddress" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>HealthCareSystem | Profile</title>
    </head>
    <body>
        <jsp:useBean id="docProfile" class="ece356.DoctorOwnProfile" scope="request"/>
        <jsp:useBean id="specializations" class="java.util.ArrayList" scope="request"/>
        <jsp:useBean id="workAddresses" class="java.util.ArrayList" scope="request"/>
        <jsp:useBean id="reviewIDs" class="java.util.ArrayList" scope="request"/>
        Name: <%= docProfile.getFirstName() + " " + docProfile.getLastName() %><br>
        Gender: <%= docProfile.getGender() %><br>
        Years Licensed: <%= docProfile.getNumYearsLicensed() %><br>
        Average Rating: <%= docProfile.getAvgRating() %><br>
        Number of Reviews: <%= docProfile.getNumReviews() %><br><br>
        
        Specializations:<br>
        <ul>
        <% for(Object o: specializations) {
            Specialization s = (Specialization)o;
        %>
            <li><%= s.getSpecializationName() %></li>
        <% } %>
        </ul><br>
        
        Work Addresses:<br>
        <% for(Object o: workAddresses) { 
            WorkAddress w = (WorkAddress)o;
        %>
            Unit <%= w.getUnitNumber() %><br>
            <%= w.getStreetNumber() %> <%= w.getStreetName() %><br>
            <%= w.getCity() %>, <%= w.getProvince() %><br>
            <%= w.getPostalCode() %><br>
            <br>
        <% } %>
        
        Review IDs:<br>
        <ul>
            <% for(Object o: reviewIDs) { %>
                <li><a href="ReviewDetailServlet?rid=<%= (Integer)o %>"><%= (Integer)o %></a></li>
            <% } %>
        </ul>
        
    </body>
</html>
