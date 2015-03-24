<%-- 
    Document   : view_friend_requests
    Created on : Mar 15, 2015, 8:47:54 PM
    Author     : sekharb
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="ece356.FriendRequest" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>HealthCareSystem | View Friend Requests</title>
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
        <jsp:useBean id="friendRequests" class="java.util.ArrayList" scope="request"/>
        <jsp:useBean id="user" class="ece356.User" scope="session"/>
        <div class="bs-example">
            <div class="page-header">
                <h1>Health Care System<small><small> An ECE356 Database Design Project</small></small></h1>
            </div>
            <% String confirm_msg = (String) request.getAttribute("confirm_msg"); %>
            <% String nofr_msg = (String) request.getAttribute("nofr_msg"); %>
            <h3>Friend Requests</h3>
            <br>
            <% for (Object o : friendRequests) {
                    FriendRequest fr = (FriendRequest) o;
            %>
            <%= fr.getPatientAlias()%> <%= fr.getEmail()%> 
            <a href="ConfirmFriendServlet?id=0&friend_alias=<%=fr.getPatientAlias()%>">
                Confirm
            </a><br>
            <% } %>
            <br>
            <% if (confirm_msg != null) {%>
            <%= confirm_msg%><br>
            <% } else if (nofr_msg != null) {%>
            <%= nofr_msg%><br>
            <% }%>
            <br><br>
            <a href="PatientProfileServlet" class="btn btn-success" role="button">My Profile</a>
        </div>
    </body>
</html>
