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
        <jsp:useBean id="cities" class="java.util.ArrayList" scope="request"/>
        <jsp:useBean id="specializations" class="java.util.ArrayList" scope="request"/>
        <jsp:useBean id="user" class="ece356.User" scope="session"/>
        <div class="bs-example">
            <div class="page-header">
                <h1>Health Care System <small><small>An ECE356 Database Design Project</small></small></h1>
            </div>
            <h3>Doctor Search</h3>
            <br>
            <form name="doctor_search_form" action="DoctorSearchServlet" method="POST">
                <div class="form-group">
                    <div class="row">
                        <div class="col-md-4">
                            <div class="input-group">
                                <div class="input-group-addon">first name</div>
                                <input type="text" class="form-control input-sm" name="doctor_search_fname" value="" />
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="input-group">
                                <div class="input-group-addon">last name</div>
                                <input type="text" class="form-control input-sm" name="doctor_search_lname" value="" />
                            </div>
                        </div>
                    </div> 
                    <br>
                    <div class="row">
                        <div class="col-md-4">
                            <div class="input-group">
                                <div class="input-group-addon">min years licensed</div>
                                <input type="number" class="form-control input-sm" value="0" min="0" step="1" name="doctor_search_#yearslicensed" />
                            </div>
                        </div>
                        <div class="col-md-4">
                            <select class="form-control input-sm" name="doctor_search_gender">
                                <option value="" disabled selected >gender</option>
                                <option>F</option>
                                <option>M</option>
                            </select>
                        </div>
                    </div>
                    <br>
                    <div class="row">
                        <div class="col-md-4">
                            <select class="form-control input-sm" name="doctor_search_specialization">
                                <option value="" disabled selected >specialization</option>
                                <% for (Object o : specializations) {
                                        String specialization = (String) o;
                                %>
                                <option><%= specialization%></option>
                                <% } %>
                            </select>
                        </div>
                        <div class="col-md-4">
                            <div class="input-group">
                                <div class="input-group-addon">postal code</div>
                                <input type="text" class="form-control input-sm" name="doctor_search_postal" value="" />
                            </div>
                        </div>
                    </div> 
                    <br>
                    <div class="row">
                        <div class="col-md-4">
                            <select class="form-control input-sm" name="doctor_search_city">
                                <option value="" disabled selected >city</option>
                                <% for (Object o : cities) {
                                        String city = (String) o;
                                %>
                                <option><%= city %></option>
                                <% } %>
                            </select>
                        </div>
                        <div class="col-md-4">
                            <select class="form-control input-sm" name="doctor_search_province">
                                <option value="" disabled selected >province</option>
                                <% for (Object o : provinces) {
                                        String province = (String) o;
                                %>
                                <option><%= province%></option>
                                <% } %>
                            </select>
                        </div>
                    </div>
                    <br>
                    <div class="row">
                        <div class="col-md-4">
                            <div class="input-group">
                                <div class="input-group-addon">keyword</div>
                                <input type="text" class="form-control input-sm" name="doctor_search_keyword" value="" />
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="input-group">
                                <div class="input-group-addon">min rating</div>
                                <input type="number" class="form-control input-sm" value="0" min="0" max="5" step="0.1" name="doctor_search_rating" /><br>
                            </div>
                        </div>
                    </div>
                    <br>
                </div>
                <div class="checkbox">
                    <label>
                        <input type="checkbox" name="doctor_search_friendreviewed" value="1" />
                        reviewed by a friend?
                    </label>
                </div>
                <div>
                    <input type="submit" value="Search" class="btn btn-primary bt-xs"/>
                </div>
            </form>
            <br><br>
            <a href="PatientProfileServlet" class="btn btn-success" role="button">My Profile</a>
        </div>
    </body>
</html>
