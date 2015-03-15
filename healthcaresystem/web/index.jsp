<%-- 
    Document   : index
    Created on : Mar 15, 2015, 1:10:40 PM
    Author     : sekharb
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>HealthCareSystem | Login</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        
        <%! String login_msg = (String)request.getAttribute("login_msg");%>
        
    </head>
    <body>
        <form name="login_form" action="LoginServlet" method="POST">
            Username: <input type="text" name="user_name" value="" /><br>
            Password: <input type="password" name="user_password" value="" /><br>
            <input type="submit" value="Sign in" name="user_signin_button" />
        </form>
    </body>
</html>


 
