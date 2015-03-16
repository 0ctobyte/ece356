<%-- 
    Document   : review_detail
    Created on : Mar 15, 2015, 7:06:44 PM
    Author     : sekharb
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>HealthCareSystem | Review Detail</title>
    </head>
    <body>
        <jsp:useBean id="review" class="ece356.Review" scope="request"/>
        <% Integer next_rid = (Integer)request.getAttribute("next_rid"); %>
        <% Integer prev_rid = (Integer)request.getAttribute("prev_rid"); %>
        <h1>Review Detail</h1>
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
    </body>
</html>
