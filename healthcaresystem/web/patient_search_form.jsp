<%-- 
    Document   : patient_search_form
    Created on : Mar 21, 2015, 9:08:48 PM
    Author     : sekharb
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>HealthCareSystem | Patient Search</title>
    </head>
    <body>
        <h1>Patient Search</h1>
        <form name="patient_search_form" action="PatientSearchServlet" method="POST">
            alias: <input type="text" name="patient_search_alias" value="" /><br>
            city: <input type="text" name="patient_search_city" value="" /><br>
            province: <input type="text" name="patient_search_province" value="" /><br>
            <input type="submit" value="Search" name="patient_search_go" />
        </form>
    </body>
</html>
