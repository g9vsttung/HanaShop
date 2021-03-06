/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package tungvs.controllers;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import tungvs.daos.InvoiceDAO;
import tungvs.daos.ProductDAO;
import tungvs.dtos.CartDTO;
import tungvs.dtos.InvoiceDTO;
import tungvs.dtos.InvoiceErrorDTO;
import tungvs.dtos.ProductDTO;
import tungvs.dtos.UserDTO;

/**
 *
 * @author USER
 */
@WebServlet(name = "CheckoutController", urlPatterns = {"/CheckoutController"})
public class CheckoutController extends HttpServlet {

    private static final String ERROR = "checkout.jsp";
    private static final String SUCCESS = "result_user.jsp";

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
        String url = ERROR;
        try {
            boolean check = true;
            InvoiceErrorDTO error = new InvoiceErrorDTO("", "");
            String address = request.getParameter("txtAddress");
            String numberPhone = request.getParameter("txtPhone");
            String payment = request.getParameter("txtPayment");
            float total = Float.valueOf(request.getParameter("txtTotal"));
            ProductDAO proDAO = new ProductDAO();
            HttpSession session = request.getSession();
            CartDTO cart = (CartDTO) session.getAttribute("CART");
            for (ProductDTO pro : cart.getCart().values()) {
                int quantity = proDAO.getQuantity(pro.getProId());
                if (quantity < pro.getQuantity()) {
                    check = false;
                }
            }
            if (check) {
                if (address.length() > 100 || address.length() < 10) {
                    check = false;
                    error.setAddressError("Address must from 10 to 100 chars!!!");
                }
                if (!numberPhone.matches("[0][0-9]{9}")) {
                    check = false;
                    error.setPhoneError("Phone number must start with 0 and 10 number!!");
                }
                if (check) {
                    String userID = ((UserDTO) session.getAttribute("LOGIN_USER")).getUserId();
                    SimpleDateFormat simple = new SimpleDateFormat("ssddMMmmyyyyHHSSS");
                    Date dateNow = new Date();
                    String ID = simple.format(dateNow);
                    SimpleDateFormat dateFormat=new SimpleDateFormat("yyyy-MM-dd");
                    String date=dateFormat.format(dateNow);
                    InvoiceDTO invoice = new InvoiceDTO(ID, date, total, userID, payment, address, numberPhone);
                    InvoiceDAO invoiceDAO = new InvoiceDAO();
                    invoiceDAO.insertInvoice(invoice);
                    for (ProductDTO pro : cart.getCart().values()) {
                        int newQuantity =proDAO.getQuantity(pro.getProId())-pro.getQuantity();
                        proDAO.updateQuantityCheckout(pro.getProId(), newQuantity);
                        invoiceDAO.insertInvoiceDetails(ID, pro.getProId(), pro.getQuantity());
                    }
                    url=SUCCESS;
                    request.setAttribute("MESSAGE", "Checkout successful, thank you and see you again <3");
                }else{
                    request.setAttribute("ERROR", error);
                }
            }else{                
                request.setAttribute("ERROR_QUANTITY", "Some products have already been bought by someone else before, please check your cart for payment");
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
