/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package tungvs.controllers;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import tungvs.daos.CategoryDAO;
import tungvs.daos.ProductDAO;
import tungvs.dtos.ProductDTO;

/**
 *
 * @author USER
 */
@WebServlet(name = "GoHome", urlPatterns = {"/newjsp.jsp"})
public class GoHome extends HttpServlet {

    private static final String SUCCESS = "home.jsp";

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
        String url = SUCCESS;
        try {
            List<String> cateList = null;
            CategoryDAO cateDAO = new CategoryDAO();
            cateList = cateDAO.getAllCategory();
            if (cateList != null) {
                request.setAttribute("CATE_LIST", cateList);
            }
            ProductDAO dao = new ProductDAO();
            List<ProductDTO> list = dao.getAllProductsUser();
            if (list != null) {
                boolean check = false;
                for (ProductDTO productDTO : list) {
                    if (productDTO.getQuantity() <= 0) {
                        check = true;
                        dao.updateStatusQuantityOver(productDTO.getProId());
                    }
                }
                if (check) {
                    list = dao.getAllProductsUser();
                    if (list != null) {
                        Collections.sort(list, new Comparator<ProductDTO>() {
                            @Override
                            public int compare(ProductDTO o1, ProductDTO o2) {
                                return o2.getCreateDate().compareTo(o1.getCreateDate());
                            }
                        });
                        
                        request.setAttribute("SIZE", list.size());
                        request.setAttribute("LIST", list);
                    }
                } else {
                    Collections.sort(list, new Comparator<ProductDTO>() {
                        @Override
                        public int compare(ProductDTO o1, ProductDTO o2) {
                            return o2.getCreateDate().compareTo(o1.getCreateDate());
                        }
                    });
                    request.setAttribute("LIST", list);
                    request.setAttribute("SIZE", list.size());
                }
            }

        } catch (Exception e) {
        } finally {
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
