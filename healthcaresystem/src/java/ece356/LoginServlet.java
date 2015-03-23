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
        User user = (User)request.getSession().getAttribute("user");
        try {
            if(user != null) {
                if(user.getAccountType() == User.AccountType.Doctor) {
                    url = "/DoctorProfileServlet";
                } else {
                    url = "/PatientProfileServlet";
                }
            } else if(queryID != null && queryID.equals("0")) {
                url = "/login_page.jsp";
            } else {
                String user_alias = request.getParameter("user_alias");
                String password = request.getParameter("user_pwd");
                if(user_alias.isEmpty() || password.isEmpty()) {
                    throw new RuntimeException("user_alias and/or password_hash is empty");
                }
                // loginUser throws runtime exception if user DNE
                user = DBAO.loginUser(user_alias, password);
                request.getSession().setAttribute("user", user);

                if(user.getAccountType() == User.AccountType.Doctor) {
                    url = "/DoctorProfileServlet";
                } else {
                    url = "/PatientProfileServlet";
                }
            }
        } catch(Exception e) {
            System.err.println(e.getMessage());
            request.setAttribute("login_msg", "Invalid username or password");
            url = "/login_page.jsp";
        }
        if(url.contains(".jsp")) {
            getServletContext().getRequestDispatcher(url).forward(request, response);
        } else {
            response.sendRedirect(request.getContextPath()+url);
        }
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
