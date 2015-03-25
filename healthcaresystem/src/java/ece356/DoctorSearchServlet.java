/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ece356;

import java.io.IOException;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author sekharb
 */
public class DoctorSearchServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String url = "/invalid_access.jsp";
        User user = (User)request.getSession().getAttribute("user");
        String fname = request.getParameter("doctor_search_fname");
        String lname = request.getParameter("doctor_search_lname");
        String gender = request.getParameter("doctor_search_gender");
        String postal_code = request.getParameter("doctor_search_postal");
        String city = request.getParameter("doctor_search_city");
        String province = request.getParameter("doctor_search_province");
        String specialization = request.getParameter("doctor_search_specialization");
        String keyword = request.getParameter("doctor_search_keyword");
        try {
            Integer num_years_licensed = (request.getParameter("doctor_search_#yearslicensed").isEmpty()) ? Integer.MIN_VALUE : Integer.parseInt(request.getParameter("doctor_search_#yearslicensed"));
            Double avg_rating = (request.getParameter("doctor_search_rating").isEmpty()) ? Double.MIN_VALUE : Double.parseDouble(request.getParameter("doctor_search_rating"));
            Integer reviewed_by_friend = (request.getParameter("doctor_search_friendreviewed") == null) ? 0 : 1;
            if(user == null) throw new RuntimeException("Not logged in");
            if(user.getAccountType() != User.AccountType.Patient) throw new RuntimeException("Unauthorized Access");
            if(gender == null) gender = "";
            if(specialization == null) specialization = "";
            if(province == null) province = "";
            if(city == null) city = "";
            
            if(avg_rating < 0 || avg_rating > 5) throw new RuntimeException("Invalid inputs");
            if(num_years_licensed < 0) throw new RuntimeException("Invalid inputs");
            
            ArrayList<DoctorSearch> ds = (ArrayList<DoctorSearch>)DBAO.performDoctorSearch(user.getUserAlias(), fname, lname, gender, postal_code, city, province, specialization, num_years_licensed, avg_rating, reviewed_by_friend, keyword);
            request.setAttribute("doctorSearchResults", ds);
            url = "/doctor_search_result.jsp";
        } catch(Exception e) {
            System.err.println(e.getMessage());
            if(e.getMessage() == null) {
                url = "/invalid_access.jsp";
            } else if(e.getMessage().equals("Unauthorized Access")) {
                url = "/unauthorized.jsp";
            } else if(e.getMessage().equals("Not logged in")) {
                url = "/LoginServlet";
            } else {
                String form_msg = "One or more fields have invalid inputs!";
                request.setAttribute("form_msg", form_msg);
                url = "/DoctorSearchFormServlet";
            }
        }
        getServletContext().getRequestDispatcher(url).forward(request, response);
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
