<%--
    Document   : doctor_profile_own
    Created on : Mar 15, 2015, 12:52:25 PM
    Author     : sekharb
--%>

<%@page import="ece356.User"%>
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
        <jsp:useBean id="doctorProfile" class="ece356.DoctorProfile" scope="request"/>
        <jsp:useBean id="specializations" class="java.util.ArrayList" scope="request"/>
        <jsp:useBean id="workAddresses" class="java.util.ArrayList" scope="request"/>
        <jsp:useBean id="reviewIDs" class="java.util.ArrayList" scope="request"/>
        <jsp:useBean id="user" class="ece356.User" scope="session"/>
        <h1>Profile</h1>
        <%= doctorProfile.getDoctorAlias() %><br>
        Name: <%= doctorProfile.getFirstName() + " " + doctorProfile.getLastName() %><br>
        <% if(user.getAccountType() == User.AccountType.Doctor) { %>
            Email: <%= doctorProfile.getEmail() %><br>
        <% } %>
        Gender: <%= doctorProfile.getGender() %><br>
        Years Licensed: <%= doctorProfile.getNumYearsLicensed() %><br>
        Average Rating: <%= doctorProfile.getAvgRating() %><br>
        Number of Reviews: <%= doctorProfile.getNumReviews() %><br><br>
        
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
            <% if(w.getUnitNumber() != 0) { %>
                Unit <%= w.getUnitNumber() %><br>
            <% } %>
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
        <% if(user.getAccountType() == user.getAccountType().Patient) { %>
            <a href="WriteReviewFormServlet?doctor_alias=<%= doctorProfile.getDoctorAlias() %>">Write review</a><br>
            <a href="PatientProfileServlet">Profile</a>
        <% } %>
        <a href="LogoutServlet">Logout</a>
    </body>
</html>
