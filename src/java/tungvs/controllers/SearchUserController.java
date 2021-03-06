/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package tungvs.controllers;

import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import tungvs.daos.ProductDAO;
import tungvs.dtos.ProductDTO;

/**
 *
 * @author USER
 */
@WebServlet(name = "SearchUserController", urlPatterns = {"/SearchUserController"})
public class SearchUserController extends HttpServlet {
    private static final String SUCCESS="home.jsp";
    private static final String ERROR="invalid.jsp";
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
        response.setContentType("text/html;charset=UTF-8");
        String url=SUCCESS;
        try {
            String search=request.getParameter("txtSearch");
            String category=request.getParameter("cbCategory");
            int from=Integer.valueOf(request.getParameter("txtFrom"));
            ProductDAO dao=new ProductDAO();
            if("All".equals(category)){
                if("".equals(request.getParameter("txtTo"))){
                    if(from<0){
                        request.setAttribute("LESS_THAN_ZERO", "[From] must > 0");
                    }else{
                        List<ProductDTO> list=dao.searchUserAllCategory(search, from);
                        if(!list.isEmpty()){
                            request.setAttribute("SEARCH_LIST", list);
                            url=SUCCESS;
                        }
                    }
                }else{
                    int to=Integer.valueOf(request.getParameter("txtTo"));
                    if(from<0 || to<0){
                        request.setAttribute("LESS_THAN_ZERO", "[From] and [To] must > 0");
                    }else{
                        List<ProductDTO> list=dao.searchUserAllCategory(search, from, to);
                        if(!list.isEmpty()){
                            request.setAttribute("SEARCH_LIST", list);
                            url=SUCCESS;
                        }
                    }
                }
            }else{
                if("".equals(request.getParameter("txtTo"))){
                    if(from<0){
                        request.setAttribute("LESS_THAN_ZERO", "[From] must > 0");
                    }else{
                        List<ProductDTO> list=dao.searchUser(search, from, category);
                        if(!list.isEmpty()){
                            request.setAttribute("SEARCH_LIST", list);
                            url=SUCCESS;
                        }
                    }
                }else{
                    int to=Integer.valueOf(request.getParameter("txtTo"));
                    if(from<0 || to<0){
                        request.setAttribute("LESS_THAN_ZERO", "[From] and [To] must > 0");
                    }else{
                        List<ProductDTO> list=dao.searchUser(search, from, to, category);
                        if(!list.isEmpty()){
                            request.setAttribute("SEARCH_LIST", list);
                            url=SUCCESS;
                        }
                    }
                }
            }                                              
        } catch (Exception e) {
        }finally{
            request.getRequestDispatcher(url).forward(request, response);
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
