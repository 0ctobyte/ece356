<%-- 
    Document   : write_review_form
    Created on : Mar 22, 2015, 6:11:05 PM
    Author     : sekharb
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>HealthCareSystem | Write Review</title>
    </head>
    <body>
        <jsp:useBean id="review_doctor_alias" class="String" scope="session"/>
        <% String wreview_msg = (String)request.getAttribute("wreview_msg"); %>
        <h1>Write Review</h1>
        <%= review_doctor_alias %><br>
        <form name="add_review_form" action="AddReviewServlet" method="POST">
            rating: <select name="add_review_rating">
                <% for(Double i = 0.0; i <= 5.0; i += 0.5) { %>
                    <option><%= i %></option>
                <% } %>
            </select><br>
            comments: <br>
            <textarea name="add_review_comments" rows="4" cols="20"></textarea><br>
            <input type="submit" value="Sumbit Review" name="add_review_submit" />
        </form>
        <% if(wreview_msg != null) { %>
            <%= wreview_msg %><br>
        <% } %>
        <a href="PatientProfileServlet">Profile</a>
    </body>
</html>
