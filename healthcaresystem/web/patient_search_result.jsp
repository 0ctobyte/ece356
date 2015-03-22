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
    </head>
    <body>
        <jsp:useBean id="patientSearchResults" class="java.util.ArrayList" scope="session"/>
        <jsp:useBean id="user" class="ece356.User" scope="session"/>
        <h1>Patient Search Result</h1>
        <table border=1>
            <tr>
                <th>alias</th>
                <th>province</th>
                <th>city</th>
                <th>friend status</th>
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
        <a href="PatientSearchFormServlet">Search again</a><br>
        <a href="PatientProfileServlet">Profile</a>
    </body>
</html>
