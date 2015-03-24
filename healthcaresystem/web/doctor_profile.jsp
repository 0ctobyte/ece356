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
        <title>HealthCareSystem | Doctor Profile</title>
        
        <!-- Latest compiled and minified CSS -->
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/css/bootstrap.min.css">
        <!-- Optional theme -->
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/css/bootstrap-theme.min.css">
        <!-- Latest compiled and minified JavaScript -->
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/js/bootstrap.min.js"></script>

        <style type="text/css">
            .bs-example{
                margin: 20px;
            }
        </style>
        
    </head>
    <body>
        <jsp:useBean id="doctorProfile" class="ece356.DoctorProfile" scope="request"/>
        <jsp:useBean id="specializations" class="java.util.ArrayList" scope="request"/>
        <jsp:useBean id="workAddresses" class="java.util.ArrayList" scope="request"/>
        <jsp:useBean id="reviewIDs" class="java.util.ArrayList" scope="request"/>
        <jsp:useBean id="user" class="ece356.User" scope="session"/>
        <div class="bs-example">
            <div class="page-header">
                <h1>Health Care System<small><small> An ECE356 Database Design Project</small></small></h1>
            </div>
            
            <h3><%= doctorProfile.getFirstName() + " " + doctorProfile.getLastName() %> <small><%= doctorProfile.getDoctorAlias() %></small></h3>
            <br>
            <% if(user.getAccountType() == User.AccountType.Doctor) { %>
            <p><b>Email:</b>    <%= doctorProfile.getEmail() %></p>
            <% }%>
            <p><b>Gender:</b>   <%= doctorProfile.getGender()%><p>
            <p><b>Years Licensed:</b>    <%= doctorProfile.getNumYearsLicensed() %><p>
            <p><b>Average Rating:</b>    <%= doctorProfile.getAvgRating()%><p>
            <p><b>Number of Reviews:</b>   <%= doctorProfile.getNumReviews()%><p>
            <p><b>Specializations:</b></p>
            <ul>
            <% for(Object o: specializations) {
                Specialization s = (Specialization)o;
            %>
                <li><%= s.getSpecializationName() %></li>
            <% } %>
            </ul>
            <p><b>Work Addresses:</b></p>
            <% for (Object o : workAddresses) {
                    WorkAddress w = (WorkAddress) o;
            %>
                <% if (w.getUnitNumber() != 0) {%>
                    Unit <%= w.getUnitNumber()%><br>
                <% }%>
                <%= w.getStreetNumber()%> <%= w.getStreetName()%><br>
                <%= w.getCity()%>, <%= w.getProvince()%><br>
                <%= w.getPostalCode()%><br>
                <br>
            <% } %>
            <p><b>Review IDs:</b></p>
            <ul>
                <% for (Object o : reviewIDs) {%>
                    <li><a href="ReviewDetailServlet?rid=<%= (Integer) o%>"><%= (Integer) o%></a></li>
                <% } %>
            </ul>
            
            <% if (user.getAccountType() == user.getAccountType().Patient) {%>
                <a href="WriteReviewFormServlet?doctor_alias=<%= doctorProfile.getDoctorAlias()%>">Write a review</a><br>
                <a href="PatientProfileServlet">Profile</a>
            <% }%>
            <br><br>
            <a href="LogoutServlet" class="btn btn-danger" role="button">Logout</a>
        </div>
    </body>
</html>
