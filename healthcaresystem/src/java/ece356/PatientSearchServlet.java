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
public class PatientSearchServlet extends HttpServlet {

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
        String patient_alias = request.getParameter("patient_search_alias");
        String city = request.getParameter("patient_search_city");
        String province = request.getParameter("patient_search_province");
        String update = request.getParameter("update");
        try {
            if(user == null) throw new RuntimeException("Not logged in");
            if(user.getAccountType() != User.AccountType.Patient) throw new RuntimeException("Unauthorized Access");
            if(update != null && update.equals("true")) {
                // The search has already been performed and is in the session
                // Just redisplay the search result page
                url = "/patient_search_result.jsp";
            } else {
                ArrayList<PatientSearch> ps = DBAO.performPatientSearch(user.getUserAlias(), patient_alias, province, city);
                request.getSession().setAttribute("patientSearchResults", ps);
                url = "/patient_search_result.jsp";
            }
        } catch(Exception e) {
            System.err.println(e.getMessage());
            if(e.getMessage().equals("Unauthorized Access")) {
                url = "/unauthorized.jsp";
            } else if(e.getMessage().equals("Not logged in")) {
                url = "/LoginServlet";
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
