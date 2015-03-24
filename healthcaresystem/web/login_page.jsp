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
                <h1>Health Care System <small><small>An ECE356 Database Design Project</small></small></h1>
            </div>
            <form name="login_form" action="LoginServlet" method="POST">
                <div class="row">
                    <div class="col-xs-3">
                        <div class="form-group">
                            <div class="input-group">
                                <div class="input-group-addon">username</div>
                                <input type="text" name="user_alias" class="form-control input-sm" />
                            </div>
                            <br>
                            <div class="input-group">
                                <div class="input-group-addon">password</div>
                                <input type="password" name="user_pwd" class="form-control input-sm" />
                            </div>
                        </div>
                        <% if (login_msg != null) {%>
                        <div class="alert alert-danger"><strong>Error!</strong> <%= login_msg%></div>
                        <% }%>
                        <input type="submit" value="Log in" class="btn btn-primary btn-xs-6"/>
                    </div>
                </div>
            </form> 
        </div>
    </body>
</html>
