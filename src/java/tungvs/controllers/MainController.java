/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package tungvs.controllers;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author USER
 */
public class MainController extends HttpServlet {
    private static final String ERROR="invalid.jsp";
    private static final String LOGIN="LoginController";
    private static final String SEARCH_ADMIN="SearchAdminController";
    private static final String GO_TO_ADD_PRODUCT="add_product.jsp";
    private static final String ADD_PRODUCT="AddProductController";
    private static final String GO_TO_PAGE="GoToPageController";
    private static final String LOGOUT="LogoutController";
    private static final String SEARCH_USER="SearchUserController";
    private static final String ADD_TO_CART="AddToCartController";
    private static final String VIEW_CART="cart.jsp";
    private static final String EDIT_QUANTITY="EditQuantityController";
    private static final String REMOVE_FROM_CART="RemoveFromCartController";
    private static final String DELETE="DeleteProductController";
    private static final String UPDATE="update.jsp";
    private static final String UPDATE_PRODUCT="UpdateProductController";
    private static final String GO_TO_CHECKOUT="checkout.jsp";
    private static final String CONFIRM="CheckoutController";
    private static final String HISTORY="SearchHistoryController";
    private static final String DETAIL="OpenDetailController";
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
        String url=ERROR;
        try {
            String action=request.getParameter("btnAction"); 
            
            if(action.matches("[0-9]+")){
                int page=Integer.valueOf(action);
                if(page>0){
                    request.setAttribute("PAGE", page);
                    url=GO_TO_PAGE;
                }
            }
            if("Login".equals(action)){
                url=LOGIN;
            }else if("Search".equals(action)){
                url=SEARCH_ADMIN;
            }else if("Add Product".equals(action)){
                url=GO_TO_ADD_PRODUCT;
            }else if("Insert Product".equals(action)){
                url=ADD_PRODUCT;
            }else if("Logout".equals(action)){
                url=LOGOUT;
            }else if("Search Product".equals(action)){
                url=SEARCH_USER;
            }else if("Add".equals(action)){
                url=ADD_TO_CART;
            }else if("View Cart".equals(action)){
                url=VIEW_CART;
            }else if("Edit".equals(action)){
                url=EDIT_QUANTITY;
            }else if("Remove".equals(action)){
                url=REMOVE_FROM_CART;
            }else if("Delete All Selected".equals(action)){
                url=DELETE;
            }else if("Update".equals(action)){
                url=UPDATE;
            }else if("Update Product".equals(action)){
                url=UPDATE_PRODUCT;
            }else if("Checkout".equals(action)){
                url=GO_TO_CHECKOUT;
            }else if("Confirm".equals(action)){
                url=CONFIRM;
            }else if("Search History".equals(action)){
                url=HISTORY;
            }else if("Detail".equals(action)){
                url=DETAIL;
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
