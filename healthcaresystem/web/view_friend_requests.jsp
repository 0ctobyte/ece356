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
        <h1>Friend Requests</h1>
        <% for(Object o: friendRequests) { 
            FriendRequest fr = (FriendRequest)o;
        %>
            <%= fr.getPatientAlias() %> <%= fr.getEmail() %> 
            <a href="AddFriendServlet?patient_alias=<%=fr.getPatientAlias()%>">
                Confirm
            </a><br>
        <% } %>
    </body>
</html>
