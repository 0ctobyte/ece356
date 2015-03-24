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
                <h1>Health Care System <small><small>An ECE356 Database Design Project</small></small></h1>
            </div>
            
            <h3><%= doctorProfile.getFirstName() + " " + doctorProfile.getLastName() %> <small><%= doctorProfile.getDoctorAlias() %></small></h3>
            <br>
            <% if(user.getAccountType() == User.AccountType.Doctor) { %>
            <p><b>Email:</b> <%= doctorProfile.getEmail() %></p>
            <% }%>
            <table class="table table-hover">
                <tr>
                    <th>Gender</th>
                    <th>Years licensed</th>
                    <th>Average rating</th>
                    <th>Number of reviews</th>
                </tr>
                <tr>
                    <td><%= doctorProfile.getGender()%></td>
                    <td><%= doctorProfile.getNumYearsLicensed() %></td>
                    <td><%= doctorProfile.getAvgRating()%></td>
                    <td><%= doctorProfile.getNumReviews()%></td>
                </tr>
            </table>
            <p><b>Specializations:</b></p>
            <ul class="list-inline">
            <% for(Object o: specializations) {
                Specialization s = (Specialization)o;
            %>
                <li><%= s.getSpecializationName() %></li>
            <% } %>
            </ul><br>
            <p><b>Work Addresses:</b></p>
            <table class="table table-hover">
                <tr>
                    <th>Street #</th>
                    <th>Street name</th>
                    <th>City</th>
                    <th>Province</th>
                    <th>Postal code</th>
                </tr>
                <% for (Object o : workAddresses) {
                        WorkAddress w = (WorkAddress) o;
                %>
                    <tr>
                        <td><%= w.getStreetNumber()%></td>
                        <td><%= w.getStreetName()%></td>
                        <td><%= w.getCity()%></td>
                        <td><%= w.getProvince()%></td>
                        <td><%= w.getPostalCode()%></td>
                    </tr>
                <% } %>
            </table>
            <p><b>Review IDs:</b></p>
            <ul class="list-inline">
                <% for (Object o : reviewIDs) {%>
                    <li><a href="ReviewDetailServlet?rid=<%= (Integer) o%>"><%= (Integer) o%></a></li>
                <% } %>
            </ul><br>
            <% if (user.getAccountType() == user.getAccountType().Patient) {%>
                <ul class="list-inline">
                    <li><a href="WriteReviewFormServlet?doctor_alias=<%= doctorProfile.getDoctorAlias()%>">Write a review</a></li>
                    <li><a href="PatientProfileServlet">Profile</a></li>
                </ul><br>
            <% }%>
            <a href="LogoutServlet" class="btn btn-danger" role="button">Logout</a>
        </div>
    </body>
</html>
