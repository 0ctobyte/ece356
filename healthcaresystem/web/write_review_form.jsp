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
        <jsp:useBean id="review_doctor_alias" class="String" scope="session"/>
        <% String wreview_msg = (String)request.getAttribute("wreview_msg"); %>
        <div class="bs-example">
            <div class="page-header">
                <h1>Health Care System <small><small>An ECE356 Database Design Project</small></small></h1>
            </div>
            <h3>Write Review <small><%= review_doctor_alias %></small></h3>
            <br>
            <h5><%= review_doctor_alias %></h5>
            <form name="add_review_form" action="AddReviewServlet" method="POST">
            <div class="row">
                <div class="col-xs-2">
                    <div class="form-group">
                        <label>Give a rating:</label>
                        <select class="form-control input-sm" name="add_review_rating">
                            <% for (Double i = 0.0; i <= 5.0; i += 0.5) {%>
                            <option><%= i%></option>
                            <% } %>
                        </select>
                    </div>
                </div>
            </div>
            <br>
            <div class="row">
                <div class="col-xs-3">
                    <% if (wreview_msg != null) {%>
                    <div class="alert alert-warning"><%= wreview_msg%></div>
                    <% }%>
                    <textarea class="form-control input-sm" name="add_review_comments" rows="4" cols="20" placeholder="Write a comment..."></textarea><br>
                </div>
            </div>
            <div class="row">
                <div class="col-xs-2">
                    <input type="submit" class="btn btn-primary bt-xs" value="Sumbit Review" name="add_review_submit" />
                </div>
            </div>
            </form>
            <br><br>
            <a href="PatientProfileServlet" class="btn btn-success" role="button">My Profile</a>
        </div>
    </body>
</html>
