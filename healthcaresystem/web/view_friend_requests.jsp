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
    </head>
    <body>
        <jsp:useBean id="friendRequests" class="java.util.ArrayList" scope="request"/>
        <jsp:useBean id="user" class="ece356.User" scope="session"/>
        <% String confirm_msg = (String)request.getAttribute("confirm_msg"); %>
        <h1>Friend Requests</h1>
        <% for(Object o: friendRequests) { 
            FriendRequest fr = (FriendRequest)o;
        %>
            <%= fr.getPatientAlias() %> <%= fr.getEmail() %> 
            <a href="AddFriendServlet?friend_alias=<%=fr.getPatientAlias()%>">
                Confirm
            </a><br>
        <% } %>
        <br>
        <% if(confirm_msg != null) { %>
                <%= confirm_msg %><br>
        <% } %>
        <br>
        <a href="PatientProfileServlet?patient_alias=<%=user.getUserAlias()%>">
            Profile
        </a>
    </body>
</html>
