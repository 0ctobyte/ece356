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
    </head>
    <body>
        <% String login_msg = (String)request.getAttribute("login_msg"); %>
        <h1>Login</h1>
        <form name="login_form" action="LoginServlet" method="POST">
            Username: <input type="text" name="user_alias" value="" /><br>
            Password: <input type="password" name="user_pwd" value="" /><br>
            <% if(login_msg != null) { %>
                <%= login_msg %><br>
            <% } %>
            <input type="submit" value="Sign in" name="user_signin_button" />
        </form>
    </body>
</html>
