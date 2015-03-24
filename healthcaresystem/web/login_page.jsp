<%-- 
    Document   : login_page
    Created on : Mar 15, 2015, 1:18:57 PM
    Author     : sekharb
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>HealtCareSystem | Login</title>
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
        <% String login_msg = (String)request.getAttribute("login_msg"); %>
        <div class="bs-example">
            <div class="page-header">
                <h1>Health Care System<small><h5> An ECE356 Database Design Project</h5></small></h1>
            </div>
            <form name="login_form" action="LoginServlet" method="POST">
                <div class="row">
                    <div class="col-xs-2">
                        <label for="user_alias">Username</label>
                        <input type="text" name="user_alias" class="form-control" id="user_alias"/><br>
                    </div>
                </div>
                
                <div class="row">
                    <div class="col-xs-2">
                    <label for="user_pwd">Password</label>
                    <input type="password" name="user_pwd" class="form-control" is=""user_pwd/><br>
                    </div>
                </div>
                <% if (login_msg != null) {%>
                <%= login_msg%><br>
                <% }%>
                <input type="submit" value="Sign in" name="user_signin_button" class="btn btn-primary"/>
            </form> 
        </div>
    </body>
</html>
