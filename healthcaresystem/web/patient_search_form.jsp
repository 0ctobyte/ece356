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
        <jsp:useBean id="provinces" class="java.util.ArrayList" scope="request"/>
        <jsp:useBean id="user" class="ece356.User" scope="session"/>
        <div class="bs-example">
            <div class="page-header">
                <h1>Health Care System<small><small> An ECE356 Database Design Project</small></small></h1>
            </div>
            <h3>Patient Search</h3>
            <br>
            
            <form name="patient_search_form" action="PatientSearchServlet" method="POST">
                <div class="row">
                    <div class="col-xs-2">
                        <label for="patient_search_alias">Patient Alias</label>
                        <input type="text" name="patient_search_alias" value="" class="form-control input-sm" id="patient_search_alias" /><br>
                    </div>
                </div>
                <div class="row">
                    <div class="col-xs-2">
                        <label for="patient_search_city">City</label>
                        <input type="text" name="patient_search_city" value="" class="form-control input-sm" id="patient_search_city" /><br>
                    </div>
                </div>
                <div class="row">
                    <div class="col-xs-2">
                        <label for="patient_search_province">Province</label>
                        <select name="patient_search_province">
                            <option></option>
                            <% for(Object o: provinces) {
                                String province = (String)o;
                            %>
                                <option><%= province %></option>
                            <% } %>
                        </select><br>
                    </div>
                </div>
                <br>
                <input type="submit" value="Search" name="patient_search_go" class="btn btn-primary bt-xs"/>
            </form>
            <br><br>
            <a href="PatientProfileServlet" class="btn btn-success" role="button">My Profile</a>
        </div>
    </body>
</html>
