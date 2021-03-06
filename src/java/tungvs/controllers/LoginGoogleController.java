/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package tungvs.controllers;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import tungvs.daos.UserDAO;
import tungvs.dtos.GoogleDTO;
import tungvs.dtos.UserDTO;
import tungvs.google.GooglePojo;
import tungvs.google.GoogleUtils;

/**
 *
 * @author USER
 */
@WebServlet("/login-google")
public class LoginGoogleController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    public LoginGoogleController() {
        super();
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
        String code = request.getParameter("code");
        if (code == null || code.isEmpty()) {
             RequestDispatcher dis = request.getRequestDispatcher("login.jsp");
             dis.forward(request, response);
        } else {
            String accessToken = GoogleUtils.getToken(code);
            GooglePojo googlePojo = GoogleUtils.getUserInfo(accessToken);
             String id=googlePojo.getId();
             String name=googlePojo.getName();
             String userId=googlePojo.getEmail();
            UserDAO dao=new UserDAO();
            boolean exist=false;
            try {
                exist=dao.checkGoogleExist(userId);
            } catch (SQLException ex) {
                Logger.getLogger(LoginGoogleController.class.getName()).log(Level.SEVERE, null, ex);
            }
            if(!exist){
                try {
                    dao.insertGoogleAccount(userId);
                } catch (SQLException ex) {
                    Logger.getLogger(LoginGoogleController.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
            UserDTO user=new UserDTO(userId, "", "user");
            HttpSession session=request.getSession();
            
            session.setAttribute("LOGIN_USER", user);
            RequestDispatcher dis = request.getRequestDispatcher("home.jsp");
             dis.forward(request, response);
        }
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
        doGet(request, response);

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
