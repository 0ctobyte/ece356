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

/**
 *
 * @author sekharb
 */
public class AddReviewServlet extends HttpServlet {

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
        User user = (User)request.getSession().getAttribute("user");
        String doctor_alias = (String)request.getSession().getAttribute("review_doctor_alias");
        String rating = request.getParameter("add_review_rating");
        String comments = request.getParameter("add_review_comments");
        try {
            if(comments.isEmpty()) {
                String wreview_msg = "Comments field must not be empty!";
                request.setAttribute("wreview_msg", wreview_msg);
                url = "/write_review_form.jsp";
            } else {
                DBAO.addDoctorReview(user.getUserAlias(), doctor_alias, Double.parseDouble(rating), comments);
                url = "/PatientDoctorProfileServlet?doctor_alias=" + doctor_alias;
            }
        } catch(Exception e) {
            System.err.println(e.getMessage());
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
