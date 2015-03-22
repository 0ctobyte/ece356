<%-- 
    Document   : doctor_search_form
    Created on : Mar 21, 2015, 9:36:18 PM
    Author     : sekharb
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>HealthCareSystem | Doctor Search</title>
    </head>
    <body>
        <h1>Doctor Search</h1>
        <form name="doctor_search_form" action="DoctorSearchServlet" method="POST">
            alias: <input type="text" name="doctor_search_alias" value="" /><br>
            <input type="submit" value="Search" name="doctor_search_go" />
        </form>
    </body>
</html>
