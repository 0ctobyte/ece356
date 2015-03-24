<%-- 
    Document   : patient_search_result
    Created on : Mar 21, 2015, 10:30:20 PM
    Author     : sekharb
--%>

<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ page import="ece356.PatientSearch" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>HealthCareSystem | Patient Search Results</title>
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
        <jsp:useBean id="patientSearchResults" class="java.util.ArrayList" scope="session"/>
        <jsp:useBean id="user" class="ece356.User" scope="session"/>
        <div class="bs-example">
            <div class="page-header">
                <h1>Health Care System <small><small>An ECE356 Database Design Project</small></small></h1>
            </div>
            <h3>Patient Search Results</h3>
            <br>
            <% if(patientSearchResults.size() > 0) { %>
                <table class="table table-hover">
                    <tr>
                        <th>Alias</th>
                        <th>Province</th>
                        <th>City</th>
                        <th>Friend status</th>
                    </tr>
                    <% for(Integer i = 0; i < patientSearchResults.size(); ++i) {
                        PatientSearch ps = (PatientSearch)patientSearchResults.get(i);
                        String frStatus = "";
                        if(ps.getAccepted()) {
                            frStatus = "added";
                        } else if(ps.getFriendAlias() == null) {
                            frStatus = "add";
                        } else if(ps.getFriendAlias().equals(user.getUserAlias())) {
                            frStatus = "confirm";
                        } else if(ps.getFriendAlias().equals(ps.getPatientAlias())) {
                            frStatus = "pending";
                        }
                    %>
                        <tr>
                            <td><%= ps.getPatientAlias() %></td>
                            <td><%= ps.getProvince() %></td>
                            <td><%= ps.getCity() %></td>
                            <td>
                                <% if(frStatus.equals("confirm")) { %>
                                    <a href="ConfirmFriendServlet?id=1&index=<%= i %>&friend_alias=<%= ps.getPatientAlias() %>">
                                        <%= frStatus %>
                                    </a>
                                <% } else if(frStatus.equals("add")) { %>
                                    <a href="AddFriendRequestServlet?index=<%= i %>&friend_alias=<%= ps.getPatientAlias() %>">
                                    <%= frStatus %>
                                    </a>
                                <% } else { %>
                                    <%= frStatus %>
                                <% } %>
                            </td>
                        </tr>
                    <% } %>
                </table>
            <% } else { %>
                <div class="alert alert-warning"><strong>Uh oh!</strong> Your search returned no results</div>
            <% } %>
            <a href="PatientSearchFormServlet" class="btn btn-primary" role="button">Search again</a><br>
            <br><br>
            <a href="PatientProfileServlet" class="btn btn-success" role="button">My Profile</a>
        </div>
    </body>
</html>
