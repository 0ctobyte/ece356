<%-- 
    Document   : patient_profile_own
    Created on : Mar 15, 2015, 12:51:56 PM
    Author     : sekharb
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>HealthCareSystem | Patient Profile</title>
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
        <jsp:useBean id="patientProfile" class="ece356.PatientProfile" scope="request"/>
        <div class="bs-example">
            <div class="page-header">
                <h1>Health Care System <small><small>An ECE356 Database Design Project</small></small></h1>
            </div>
            <h3><%= patientProfile.getFirstName() + " " + patientProfile.getLastName()%> <small><%= patientProfile.getPatientAlias() %></small></h3>
            <br>
            <table class="table table-hover">
                <tr>
                    <th>Email</th>
                    <th>City</th>
                    <th>Province</th>
                </tr>
                <tr>
                    <td><%= patientProfile.getEmail() %></td>
                    <td><%= patientProfile.getCity() %></td>
                    <td><%= patientProfile.getProvince() %></td>
                </tr>
            </table>
            <ul class="list-inline">
                <li><a href="ViewFriendRequestsServlet">View friend requests</a></li>
                <li><a href="PatientSearchFormServlet">Patient search</a></li>
                <li><a href="DoctorSearchFormServlet">Doctor search</a></li>
            </ul><br>
            <a href="LogoutServlet" class="btn btn-danger" role="button">Logout</a>
        </div>
    </body>
</html>
