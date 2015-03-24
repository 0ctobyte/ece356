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
        <jsp:useBean id="doctorSearchResults" class="java.util.ArrayList" scope="request"/>
        <jsp:useBean id="user" class="ece356.User" scope="session"/>
        <div class="bs-example">
            <div class="page-header">
                <h1>Health Care System <small><small>An ECE356 Database Design Project</small></small></h1>
            </div>
            <h3>Doctor Search Results</h3>
            <br>
            <% if(doctorSearchResults.size() > 0) { %>
                <table class="table table-hover">
                    <tr>
                        <th>Name</th>
                        <th>Gender</th>
                        <th>Average rating</th>
                        <th>Number of reviews</th>
                    </tr>
                    <% for(Object o: doctorSearchResults) { 
                        DoctorSearch ds = (DoctorSearch)o;
                    %>
                        <tr>
                            <td>
                                <a href="PatientDoctorProfileServlet?doctor_alias=<%= ds.getDoctorAlias() %>">
                                    <%= ds.getFirstName() + " " + ds.getLastName() %>
                                </a>
                            </td>
                            <td><%= ds.getGender() %></td>
                            <td><%= ds.getAvgRating() %></td>
                            <td><%= ds.getNumReviews() %></td>
                        </tr>
                    <% } %>
                </table>
            <% } else { %>
                <div class="alert alert-warning"><strong>Uh oh!</strong> Your search returned no results</div>
            <% } %>
            <a href="DoctorSearchFormServlet" class="btn btn-primary" role="button">Search again</a><br>
            <br><br>
            <a href="PatientProfileServlet" class="btn btn-success" role="button">My Profile</a>
        </div>
    </body>
</html>
