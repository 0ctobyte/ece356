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
public class DoctorProfileServlet extends HttpServlet {

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
        try {
            if(user == null) throw new RuntimeException("Not logged in");
            if(user.getAccountType() != User.AccountType.Doctor) throw new RuntimeException("Unauthorized Access");
            String doctor_alias = user.getUserAlias();
            DoctorProfile docProfile = DBAO.doctorOwnProfileView(doctor_alias);
            ArrayList<Specialization> specializations = DBAO.getSpecializations(doctor_alias);
            ArrayList<WorkAddress> workAddresses = DBAO.getWorkAddresses(doctor_alias);
            ArrayList<Integer> reviewIDs = DBAO.getReviewIDs(doctor_alias);
            request.setAttribute("doctorProfile", docProfile);
            request.setAttribute("specializations", specializations);
            request.setAttribute("workAddresses", workAddresses);
            request.setAttribute("reviewIDs", reviewIDs);
            url = "/doctor_profile.jsp";
        } catch(Exception e) {
            System.err.println(e.getMessage());
            if(e.getMessage() == null) {
                url = "/invalid_access.jsp";
            } else if(e.getMessage().equals("Unauthorized Access")) {
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
