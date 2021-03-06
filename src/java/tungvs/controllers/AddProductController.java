/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package tungvs.controllers;

import java.io.File;
import java.io.IOException;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Hashtable;
import java.util.Iterator;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.tomcat.util.http.fileupload.FileItem;
import org.apache.tomcat.util.http.fileupload.FileItemFactory;
import org.apache.tomcat.util.http.fileupload.disk.DiskFileItemFactory;
import org.apache.tomcat.util.http.fileupload.servlet.ServletFileUpload;
import org.apache.tomcat.util.http.fileupload.servlet.ServletRequestContext;
import tungvs.daos.ProductDAO;
import tungvs.dtos.ProductErrorDTO;

/**
 *
 * @author USER
 */
@WebServlet(name = "AddProductController", urlPatterns = {"/AddProductController"})
public class AddProductController extends HttpServlet {
    private static final String SUCCESS = "result.jsp";
    private static final String ERROR = "add_product.jsp";
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
        boolean isMulti=ServletFileUpload.isMultipartContent(request);
        if(isMulti){
            FileItemFactory factory=new DiskFileItemFactory();
            ServletFileUpload upload=new ServletFileUpload(factory);
            List<FileItem> items=null;
            boolean check=true;
            try {
                items=upload.parseRequest(new ServletRequestContext(request));
            } catch (Exception e) {
                e.printStackTrace();
            }
            Iterator iter=items.iterator();
            Hashtable params=new Hashtable();
            String fileName=null;
            String realPath="";
            String path="";
            String itemName="";
            while(iter.hasNext()){
                FileItem item=(FileItem) iter.next();
                if(item.isFormField()){
                    params.put(item.getFieldName(), item.getString());
                }else{
                    try {
                        itemName=item.getName();                        
                        //System.out.println("Path "+itemName);                        
                        path=getServletContext().getRealPath("/").split("build")[0]+"web\\images";
                        realPath=path+"\\"+itemName;
                        String link=realPath+itemName;
                        //System.out.println("Real Path "+realPath);
                        File file=new File(path);
                        if(!file.exists()){
                            file.mkdir();
                        }
                        File saveFile=new File(realPath);                       
                        request.setAttribute("NAME", realPath);
                        item.write(saveFile);
                        
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                }
            }
            ProductErrorDTO error=new ProductErrorDTO("", "", "", "", "", "", "", "", "", "");
            String proId=(String)params.get("txtID");
            String name=(String)params.get("txtName");
            String description=(String)params.get("txtDescription");
            float price=Float.parseFloat((String)params.get("txtPrice"));
            int quantity=Integer.parseInt((String)params.get("txtQuantity"));
            String categoryId=(String)params.get("txtCategoryID");
            if(!proId.matches("[a-zA-Z0-9]{3,12}")){
                check=false;
                error.setProIdError("Product ID must normal chars and number (no special chars) [3-12]");
            }
            if(!name.matches("[a-zA-Z0-9\\s]{3,25}")){
                check=false;
                error.setNameError("Product name must normal chars and number (no special chars) [3-25]");
            }
            if(!description.matches("[a-zA-Z0-9\\s]{5,100}")||description.length()<5){
                check=false;
                error.setDescriptionError("Description must normal chars and number (no special chars) [5-100]");
            }
            if(price<=0){
                check=false;
                error.setPriceError("Price not <= 0 !!!");
            }           
            if(quantity<=0){
                check=false;
                error.setQuantityError("Quantity not <= 0 !!!");
            }
            ProductDAO dao=new ProductDAO();
            try {
                if(!dao.existCategoryID(categoryId)){
                    check=false;
                    error.setCategoryIdError("Category ID is not exist!!!");
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
            
            if(!itemName.split("\\.")[1].equals("jpg")&&!itemName.split("\\.")[1].equals("png")){
                check=false;
                error.setImageError("Must select filel .jpg or .png !!!");
            }
            if(check){
                boolean idExist=false;
                try {
                    idExist=dao.existProductID(proId);
                       
                } catch (SQLException ex) {
                    Logger.getLogger(AddProductController.class.getName()).log(Level.SEVERE, null, ex);
                }
                if(!idExist){
                    url=SUCCESS;
                    Date date=new Date();
                    SimpleDateFormat dateFormat=new SimpleDateFormat("yyyy-MM-dd");
                    String createDate=dateFormat.format(date);
                    try{
                        int num=dao.insertProduct(proId, name, description, price, quantity, categoryId, createDate);
                        if(num==1){
                            dao.insertImage(itemName, proId);
                            request.setAttribute("SUCCESS_INSERT", "Insert successful");
                        }                    
                    } catch (SQLException ex) {
                        ex.printStackTrace();
                    } 
                }else{
                    error.setProIdError("Id is exist!!!");
                    request.setAttribute("txtID", proId);
                    request.setAttribute("txtName", name);
                    request.setAttribute("txtDescription", description);
                    request.setAttribute("txtPrice", price);
                    request.setAttribute("txtQuantity", quantity);
                    request.setAttribute("txtCategoryID", categoryId);
                    request.setAttribute("ERROR", error);
                }
                                              
            }else{
                request.setAttribute("txtID", proId);
                request.setAttribute("txtName", name);
                request.setAttribute("txtDescription", description);
                request.setAttribute("txtPrice", price);
                request.setAttribute("txtQuantity", quantity);
                request.setAttribute("txtCategoryID", categoryId);
                request.setAttribute("ERROR", error);
            }
            
        }
        getServletContext().getRequestDispatcher("/"+url).forward(request, response);
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
