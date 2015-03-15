/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ece356;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import org.mindrot.jbcrypt.BCrypt;

/**
 *
 * @author sekharb
 */
public class LoginServlet extends HttpServlet {

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
        String url = "/index.jsp";
        String queryID = request.getParameter("id");
        if(queryID != null && queryID.equals("0")) {
            url = "/login_page.jsp";
        } else {
            String user_alias = request.getParameter("user_alias");
            String password_hash = request.getParameter("user_pwd");
            try {
                if(user_alias.equals("") || password_hash.equals("")) {
                    throw new RuntimeException();
                }
                
                // loginUser throws runtime exception if user DNE
                User user = DBAO.loginUser(user_alias, password_hash);
                
                if(user.getAccountType() == User.AccountType.Doctor) {
                    DoctorOwnProfile docProfile = DBAO.doctorOwnProfileView(user_alias);
                    request.getSession().setAttribute("docProfile", docProfile);
                    url = "/doctor_own_profile.jsp";
                } else {
                    PatientOwnProfile patientProfile = DBAO.patientOwnProfileView(user_alias);
                    request.getSession().setAttribute("patientProfile", patientProfile);
                    url = "/patient_own_profile.jsp";
                }
            } catch(Exception e) {
                request.setAttribute("login_msg", "Invalid username or password");
                url = "/login_page.jsp";
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
