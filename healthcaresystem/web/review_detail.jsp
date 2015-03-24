<%-- 
    Document   : review_detail
    Created on : Mar 15, 2015, 7:06:44 PM
    Author     : sekharb
--%>

<%@page import="ece356.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>HealthCareSystem | Review Detail</title>
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
        <jsp:useBean id="review" class="ece356.Review" scope="request"/>
        <jsp:useBean id="user" class="ece356.User" scope="session"/>
        <% Integer next_rid = (Integer)request.getAttribute("next_rid"); %>
        <% Integer prev_rid = (Integer)request.getAttribute("prev_rid"); %>
        <div class="bs-example">
            <div class="page-header">
                <h1>Health Care System <small><small>An ECE356 Database Design Project</small></small></h1>
            </div>
            <h3>Review Detail</h3>
            <br>
            <%= review.getFirstName() + " " + review.getLastName() %><br>
            Rating: <%= review.getStarRating() %><br>
            By <%= review.getPatientAlias() %> on <%= review.getDate() %><br>
            <br>
            <%= review.getComments() %><br>
            <br>
            <% if(prev_rid > 0) { %>
                <a href="ReviewDetailServlet?rid=<%=prev_rid%>">prev</a>
            <% } %>
            <% if(next_rid > 0) { %>
                <a href="ReviewDetailServlet?rid=<%=next_rid%>">next</a>
            <% } %>
            <br>
            <% if(user.getAccountType() == User.AccountType.Doctor) { %>
                <a href="DoctorProfileServlet">Profile</a>
            <% } else { %>
                <a href="PatientProfileServlet">Profile</a>
            <% } %>
        </div>
    </body>
</html>
