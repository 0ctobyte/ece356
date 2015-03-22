<%-- 
    Document   : patient_profile_own
    Created on : Mar 15, 2015, 12:51:56 PM
    Author     : sekharb
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>HealthCareSystem | Profile</title>
    </head>
    <body>
        <jsp:useBean id="patientProfile" class="ece356.PatientOwnProfile" scope="request"/>
        <h1>Profile</h1>
        <%= patientProfile.getPatientAlias() %><br>
        Name: <%= patientProfile.getFirstName() + " " + patientProfile.getLastName() %><br>
        Email: <%= patientProfile.getEmail() %><br>
        Location: <%= patientProfile.getCity() + ", " + patientProfile.getProvince() %><br>
        <br>
        
        <ul>
            <li>
                <a href="ViewFriendRequestsServlet?user_alias=<%=patientProfile.getPatientAlias()%>">
                    View friend requests
                </a>
            </li>
            <li>
                <a href="patient_search_form.jsp">Patient search</a>
            </li>
            <li>
                <a href="doctor_search_form.jsp">Doctor search</a>
            </li>
        </ul>
        
    </body>
</html>
