/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package tungvs.daos;

import java.io.File;
import java.io.FileInputStream;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import tungvs.dtos.InvoiceDetailDTO;
import tungvs.dtos.ProductDTO;
import tungvs.utils.DBUtils;

/**
 *
 * @author USER
 */
public class ProductDAO {
    private Connection con;
    private PreparedStatement stm;
    private ResultSet rs;

    public ProductDAO() {
        con=null;
        stm=null;
        rs=null;
    }   
    public void closeConnection() throws SQLException{
        if(rs!=null) rs.close();
        if(stm!= null) stm.close();
        if(con!= null) con.close();
    }
    public List<ProductDTO> searchUserAllCategory(String search,int from,int to) throws SQLException{
        List<ProductDTO> list=new ArrayList<>();
        try {
            con=DBUtils.getConnection();
            if(con!=null){
                String sql="select P.proId,P.name,description,price,isAvailable,createDate,updateDate,quantity,P.categoryId,I.img,C.name as cateName"
                        + " from Product P,Image I,Category C"
                        + " where P.proId=I.proId and P.categoryId=C.categoryId and P.name like ? and P.price >= ? and P.price <= ? and isAvailable=?";
                stm=con.prepareStatement(sql);
                stm.setString(1, "%"+search+"%");
                stm.setInt(2, from);
                stm.setInt(3, to);
                stm.setBoolean(4, true);
                rs=stm.executeQuery();
                while(rs.next()){
                    String proId=rs.getString("proId");
                    String name=rs.getString("name");
                    String description=rs.getString("description");
                    float price=rs.getFloat("price");
                    boolean isAvailable=rs.getBoolean("isAvailable");
                    Date createDate=rs.getDate("createDate");
                    Date updateDate=rs.getDate("updateDate");
                    int quantity=rs.getInt("quantity");
                    String categoryId=rs.getString("categoryId");
                    String image=rs.getString("img");
                    String categoryName=rs.getString("cateName");
                    ProductDTO product=new ProductDTO(proId, name, description, price, isAvailable, createDate, updateDate, quantity, categoryId, image, categoryName);
                    list.add(product);
                }
            }
            
        } catch (Exception e) {
        }finally{
            closeConnection();
        }
        return list;
    }
    public List<ProductDTO> searchUserAllCategory(String search,int from) throws SQLException{
        List<ProductDTO> list=new ArrayList<>();
        try {
            con=DBUtils.getConnection();
            if(con!=null){
                String sql="select P.proId,P.name,description,price,isAvailable,createDate,updateDate,quantity,P.categoryId,I.img,C.name as cateName"
                        + " from Product P,Image I,Category C"
                        + " where P.proId=I.proId and P.categoryId=C.categoryId and P.name like ? and P.price >= ? and isAvailable=?";
                stm=con.prepareStatement(sql);
                stm.setString(1, "%"+search+"%");
                stm.setInt(2, from);
                stm.setBoolean(3, true);
                rs=stm.executeQuery();
                while(rs.next()){
                    String proId=rs.getString("proId");
                    String name=rs.getString("name");
                    String description=rs.getString("description");
                    float price=rs.getFloat("price");
                    boolean isAvailable=rs.getBoolean("isAvailable");
                    Date createDate=rs.getDate("createDate");
                    Date updateDate=rs.getDate("updateDate");
                    int quantity=rs.getInt("quantity");
                    String categoryId=rs.getString("categoryId");
                    String image=rs.getString("img");
                    String categoryName=rs.getString("cateName");
                    ProductDTO product=new ProductDTO(proId, name, description, price, isAvailable, createDate, updateDate, quantity, categoryId, image, categoryName);
                    list.add(product);
                }
            }
            
        } catch (Exception e) {
        }finally{
            closeConnection();
        }
        return list;
    }
    public List<ProductDTO> searchUser(String search,int from,int to,String category) throws SQLException{
        List<ProductDTO> list=new ArrayList<>();
        try {
            con=DBUtils.getConnection();
            if(con!=null){
                String sql="select P.proId,P.name,description,price,isAvailable,createDate,updateDate,quantity,P.categoryId,I.img,C.name as cateName"
                        + " from Product P,Image I,Category C"
                        + " where P.proId=I.proId and P.categoryId=C.categoryId and P.name like ? and P.price >= ? and P.price <= ? and C.name like ? and isAvailable=?";
                stm=con.prepareStatement(sql);
                stm.setString(1, "%"+search+"%");
                stm.setInt(2, from);
                stm.setInt(3, to);
                stm.setString(4, category);
                stm.setBoolean(5, true);
                rs=stm.executeQuery();
                while(rs.next()){
                    String proId=rs.getString("proId");
                    String name=rs.getString("name");
                    String description=rs.getString("description");
                    float price=rs.getFloat("price");
                    boolean isAvailable=rs.getBoolean("isAvailable");
                    Date createDate=rs.getDate("createDate");
                    Date updateDate=rs.getDate("updateDate");
                    int quantity=rs.getInt("quantity");
                    String categoryId=rs.getString("categoryId");
                    String image=rs.getString("img");
                    String categoryName=rs.getString("cateName");
                    ProductDTO product=new ProductDTO(proId, name, description, price, isAvailable, createDate, updateDate, quantity, categoryId, image, categoryName);
                    list.add(product);
                }
            }
            
        } catch (Exception e) {
        }finally{
            closeConnection();
        }
        return list;
    }
    public List<ProductDTO> searchUser(String search,int from,String category) throws SQLException{
        List<ProductDTO> list=new ArrayList<>();
        try {
            con=DBUtils.getConnection();
            if(con!=null){
                String sql="select P.proId,P.name,description,price,isAvailable,createDate,updateDate,quantity,P.categoryId,I.img,C.name as cateName"
                        + " from Product P,Image I,Category C"
                        + " where P.proId=I.proId and P.categoryId=C.categoryId and P.name like ? and P.price >= ? and C.name like ? and isAvailable=?";
                stm=con.prepareStatement(sql);
                stm.setString(1, "%"+search+"%");
                stm.setInt(2, from);
                stm.setString(3, category);
                stm.setBoolean(4, true);
                rs=stm.executeQuery();
                while(rs.next()){
                    String proId=rs.getString("proId");
                    String name=rs.getString("name");
                    String description=rs.getString("description");
                    float price=rs.getFloat("price");
                    boolean isAvailable=rs.getBoolean("isAvailable");
                    Date createDate=rs.getDate("createDate");
                    Date updateDate=rs.getDate("updateDate");
                    int quantity=rs.getInt("quantity");
                    String categoryId=rs.getString("categoryId");
                    String image=rs.getString("img");
                    String categoryName=rs.getString("cateName");
                    ProductDTO product=new ProductDTO(proId, name, description, price, isAvailable, createDate, updateDate, quantity, categoryId, image, categoryName);
                    list.add(product);
                }
            }
            
        } catch (Exception e) {
        }finally{
            closeConnection();
        }
        return list;
    }
    public List<ProductDTO> searchList(String search) throws SQLException{
        List<ProductDTO> list=new ArrayList<>();
        try {
            con=DBUtils.getConnection();
            if(con!=null){
                String sql="select P.proId,P.name,description,price,isAvailable,createDate,updateDate,quantity,P.categoryId,I.img,C.name as cateName"
                        + " from Product P,Image I,Category C"
                        + " where P.proId=I.proId and P.categoryId=C.categoryId and P.name like ?";
                stm=con.prepareStatement(sql);
                stm.setString(1, "%"+search+"%");
                rs=stm.executeQuery();
                while(rs.next()){
                    String proId=rs.getString("proId");
                    String name=rs.getString("name");
                    String description=rs.getString("description");
                    float price=rs.getFloat("price");
                    boolean isAvailable=rs.getBoolean("isAvailable");
                    Date createDate=rs.getDate("createDate");
                    Date updateDate=rs.getDate("updateDate");
                    int quantity=rs.getInt("quantity");
                    String categoryId=rs.getString("categoryId");
                    String image=rs.getString("img");
                    String categoryName=rs.getString("cateName");
                    ProductDTO product=new ProductDTO(proId, name, description, price, isAvailable, createDate, updateDate, quantity, categoryId, image, categoryName);
                    list.add(product);
                }
            }
            
        } catch (Exception e) {
        }finally{
            closeConnection();
        }
        return list;
    }
    public ProductDTO getProductById(String proId) throws SQLException{
        ProductDTO product=null;
        try {
            con=DBUtils.getConnection();
            if(con!=null){
                String sql="select P.proId,P.name,description,price,isAvailable,createDate,updateDate,quantity,P.categoryId,I.img,C.name as cateName"
                        + " from Product P,Image I,Category C"
                        + " where P.proId=I.proId and P.categoryId=C.categoryId and P.proId = ?";
                stm=con.prepareStatement(sql);
                stm.setString(1, proId);
                rs=stm.executeQuery();
                if(rs.next()){
                    String name=rs.getString("name");
                    String description=rs.getString("description");
                    float price=rs.getFloat("price");
                    boolean isAvailable=rs.getBoolean("isAvailable");
                    Date createDate=rs.getDate("createDate");
                    Date updateDate=rs.getDate("updateDate");
                    int quantity=rs.getInt("quantity");
                    String categoryId=rs.getString("categoryId");
                    String image=rs.getString("img");
                    String categoryName=rs.getString("cateName");
                    product=new ProductDTO(proId, name, description, price, isAvailable, createDate, updateDate, quantity, categoryId, image, categoryName);
                }
            }
            
        } catch (Exception e) {
        }finally{
            closeConnection();
        }
        return product;
    }
    public List<ProductDTO> getAllProducts() throws SQLException{
        List<ProductDTO> list=new ArrayList<>();
        try {
            con=DBUtils.getConnection();
            if(con!=null){
                String sql="select P.proId,P.name,description,price,isAvailable,createDate,updateDate,quantity,P.categoryId,I.img,C.name as cateName"
                        + " from Product P,Image I,Category C"
                        + " where P.proId=I.proId and C.categoryId=P.categoryId";
                stm=con.prepareStatement(sql);
                rs=stm.executeQuery();
                while(rs.next()){
                    String proId=rs.getString("proId");
                    String name=rs.getString("name");
                    String description=rs.getString("description");
                    float price=rs.getFloat("price");
                    boolean isAvailable=rs.getBoolean("isAvailable");
                    Date createDate=rs.getDate("createDate");
                    Date updateDate=rs.getDate("updateDate");
                    int quantity=rs.getInt("quantity");
                    String categoryId=rs.getString("categoryId");
                    String image=rs.getString("img");
                    String categoryName=rs.getString("cateName");
                    ProductDTO product=new ProductDTO(proId, name, description, price, isAvailable, createDate, updateDate, quantity, categoryId, image, categoryName);
                    list.add(product);
                }
            }
            
        } catch (Exception e) {
        }finally{
            closeConnection();
        }
        return list;
    }
    public List<ProductDTO> getAllProductsUser() throws SQLException{
        List<ProductDTO> list=new ArrayList<>();
        try {
            con=DBUtils.getConnection();
            if(con!=null){
                String sql="select P.proId,P.name,description,price,isAvailable,createDate,updateDate,quantity,P.categoryId,I.img,C.name as cateName"
                        + " from Product P,Image I,Category C"
                        + " where P.proId=I.proId and C.categoryId=P.categoryId and isAvailable = ?";
                
                stm=con.prepareStatement(sql);
                stm.setBoolean(1, true);
                rs=stm.executeQuery();
                while(rs.next()){
                    String proId=rs.getString("proId");
                    String name=rs.getString("name");
                    String description=rs.getString("description");
                    float price=rs.getFloat("price");
                    boolean isAvailable=rs.getBoolean("isAvailable");
                    Date createDate=rs.getDate("createDate");
                    Date updateDate=rs.getDate("updateDate");
                    int quantity=rs.getInt("quantity");
                    String categoryId=rs.getString("categoryId");
                    String image=rs.getString("img");
                    String categoryName=rs.getString("cateName");
                    ProductDTO product=new ProductDTO(proId, name, description, price, isAvailable, createDate, updateDate, quantity, categoryId, image, categoryName);
                    list.add(product);
                }
            }
            
        } catch (Exception e) {
        }finally{
            closeConnection();
        }
        return list;
    }
    public void insertImage(String imageName, String proId) throws SQLException{
        try {
            con=DBUtils.getConnection();
            if(con!=null){
                String sql="insert into Image(imgId,img,proId) values(?,?,?)";
                stm=con.prepareStatement(sql);
                stm.setString(1, proId);                              
                stm.setString(2, imageName);
                stm.setString(3, proId);
                int i=stm.executeUpdate();
            }            
        } catch (Exception e) {
        }finally{
            closeConnection();
        }
    }
    public boolean existCategoryID(String categoryID) throws SQLException{
        boolean check=false;
        try {
            con=DBUtils.getConnection();
            if(con!=null){
                String sql="select categoryId from Category where categoryId = ?";
                stm=con.prepareStatement(sql);
                stm.setString(1, categoryID);
                rs=stm.executeQuery();
                if(rs.next()){
                    check=true;
                }
            }
        } catch (Exception e) {
        }finally{
            closeConnection();
        }
        return check;
    }
    public boolean existProductID(String proId) throws SQLException{
        boolean check=false;
        try {
            con=DBUtils.getConnection();
            if(con!=null){
                String sql="select proId from Product where proId = ?";
                stm=con.prepareStatement(sql);
                stm.setString(1, proId);
                rs=stm.executeQuery();
                if(rs.next()){
                    check=true;
                }
            }
        } catch (Exception e) {
        }finally{
            closeConnection();
        }
        return check;
    }
    public int insertProduct(String proId,String name,String description,float price,int quantity,String categoryId,String createDate) throws SQLException{
        int num=0;
        try {
            con=DBUtils.getConnection();
            if(con!=null){
                String sql="insert into Product(proId,name,description,price,isAvailable,createDate,updateDate,quantity,categoryId) "
                             + "values(?,?,?,?,?,?,?,?,?)";
                stm=con.prepareStatement(sql);
                stm.setString(1,proId );
                stm.setString(2, name);
                stm.setString(3,description );
                stm.setFloat(4,price );
                stm.setBoolean(5,true );
                Date date=Date.valueOf(createDate);
                stm.setDate(6, date);
                stm.setDate(7, null);
                stm.setInt(8,quantity );
                stm.setString(9, categoryId);
                num=stm.executeUpdate();
                
            }
        } catch (Exception e) {
        }finally{
            closeConnection();
        }
        return num;
    }
    public int getQuantity(String proId) throws SQLException{
        int quantity=0;
        try {
            con=DBUtils.getConnection();
            if(con!=null){
                String sql="select quantity from Product where proId=?";
                stm=con.prepareStatement(sql);
                stm.setString(1, proId);
                rs=stm.executeQuery();
                if(rs.next()){
                    quantity=rs.getInt("quantity");
                }
            }
        } catch (Exception e) {
        }finally{
            closeConnection();
        }
        return quantity;
    }
    public List<ProductDTO> searchAdminAllCondition(String search,String categoryName,String status) throws SQLException{
        List<ProductDTO> list=new ArrayList<>();
        try {
            con=DBUtils.getConnection();
            if(con!=null){
                String sql="select P.proId,P.name,description,price,isAvailable,createDate,updateDate,quantity,P.categoryId,I.img,C.name as cateName"
                        + " from Product P,Image I,Category C"
                        + " where P.proId=I.proId and P.categoryId=C.categoryId and P.name like ? and C.name like ? and isAvailable = ?";
                stm=con.prepareStatement(sql);
                stm.setString(1, "%"+search+"%");
                stm.setString(2, categoryName);
                stm.setBoolean(3, Boolean.valueOf(status));
                rs=stm.executeQuery();
                while(rs.next()){
                    String proId=rs.getString("proId");
                    String name=rs.getString("name");
                    String description=rs.getString("description");
                    float price=rs.getFloat("price");
                    boolean isAvailable=rs.getBoolean("isAvailable");
                    Date createDate=rs.getDate("createDate");
                    Date updateDate=rs.getDate("updateDate");
                    int quantity=rs.getInt("quantity");
                    String categoryId=rs.getString("categoryId");
                    String image=rs.getString("img");
                    ProductDTO product=new ProductDTO(proId, name, description, price, isAvailable, createDate, updateDate, quantity, categoryId, image, categoryName);
                    list.add(product);
                }
            }
            
        } catch (Exception e) {
        }finally{
            closeConnection();
        }
        return list;
    }
    public List<ProductDTO> searchAdminCategory(String search,String categoryName) throws SQLException{
        List<ProductDTO> list=new ArrayList<>();
        try {
            con=DBUtils.getConnection();
            if(con!=null){
                String sql="select P.proId,P.name,description,price,isAvailable,createDate,updateDate,quantity,P.categoryId,I.img,C.name as cateName"
                        + " from Product P,Image I,Category C"
                        + " where P.proId=I.proId and P.categoryId=C.categoryId and P.name like ? and C.name like ?";
                stm=con.prepareStatement(sql);
                stm.setString(1, "%"+search+"%");
                stm.setString(2, categoryName);
                rs=stm.executeQuery();
                while(rs.next()){
                    String proId=rs.getString("proId");
                    String name=rs.getString("name");
                    String description=rs.getString("description");
                    float price=rs.getFloat("price");
                    boolean isAvailable=rs.getBoolean("isAvailable");
                    Date createDate=rs.getDate("createDate");
                    Date updateDate=rs.getDate("updateDate");
                    int quantity=rs.getInt("quantity");
                    String categoryId=rs.getString("categoryId");
                    String image=rs.getString("img");
                    ProductDTO product=new ProductDTO(proId, name, description, price, isAvailable, createDate, updateDate, quantity, categoryId, image, categoryName);
                    list.add(product);
                }
            }
            
        } catch (Exception e) {
        }finally{
            closeConnection();
        }
        return list;
    }
    public List<ProductDTO> searchAdminStatus(String search,String status) throws SQLException{
        List<ProductDTO> list=new ArrayList<>();
        try {
            con=DBUtils.getConnection();
            if(con!=null){
                String sql="select P.proId,P.name,description,price,isAvailable,createDate,updateDate,quantity,P.categoryId,I.img,C.name as cateName"
                        + " from Product P,Image I,Category C"
                        + " where P.proId=I.proId and P.categoryId=C.categoryId and P.name like ? and isAvailable = ?";
                stm=con.prepareStatement(sql);
                stm.setString(1, "%"+search+"%");
                stm.setBoolean(2, Boolean.valueOf(status));
                rs=stm.executeQuery();
                while(rs.next()){
                    String proId=rs.getString("proId");
                    String name=rs.getString("name");
                    String description=rs.getString("description");
                    float price=rs.getFloat("price");
                    boolean isAvailable=rs.getBoolean("isAvailable");
                    Date createDate=rs.getDate("createDate");
                    Date updateDate=rs.getDate("updateDate");
                    int quantity=rs.getInt("quantity");
                    String categoryId=rs.getString("categoryId");
                    String image=rs.getString("img");
                    String categoryName=rs.getString("cateName");
                    ProductDTO product=new ProductDTO(proId, name, description, price, isAvailable, createDate, updateDate, quantity, categoryId, image, categoryName);
                    list.add(product);
                }
            }
            
        } catch (Exception e) {
        }finally{
            closeConnection();
        }
        return list;
    }
    public void deleteProduct(String proId, String date) throws SQLException{
        try {
            con=DBUtils.getConnection();
            if(con!=null){
                String sql="update Product set isAvailable=?, updateDate=? where proId = ?";
                stm=con.prepareStatement(sql);
                stm.setBoolean(1, false);
                stm.setDate(2, Date.valueOf(date));
                stm.setString(3, proId);
                stm.executeUpdate();
            }
        } catch (Exception e) {
        }finally{
            closeConnection();
        }
    }
    public int updateProduct(String proId,String name,String description,float price,int quantity,String categoryID,boolean isAvailable,String updateDate) throws SQLException{
        int num=0;
        try {
            
            con=DBUtils.getConnection();
            if(con!=null){
                String sql="update Product set name=?, description=?, price=?, quantity=?, categoryId=?,isAvailable=?,updateDate=? where proId = ?";
                stm=con.prepareStatement(sql);
                stm.setString(1, name);
                stm.setString(2, description);
                stm.setFloat(3, price);
                stm.setInt(4, quantity);
                stm.setString(5, categoryID);
                stm.setBoolean(6, isAvailable);
                stm.setDate(7, Date.valueOf(updateDate));
                stm.setString(8, proId);               
                num=stm.executeUpdate();
            }
        } catch (Exception e) {
        }finally{
            closeConnection();
        }
        return num;
    }
    public void updateImage(String itemName,String proId) throws SQLException{
        try {
            con=DBUtils.getConnection();
            if(con!=null){
                String sql="update Image set img=? where imgId=?";
                stm=con.prepareStatement(sql);
                stm.setString(1, itemName);
                stm.setString(2, proId);
                stm.executeUpdate();
            }
        } catch (Exception e) {
        }finally{
            closeConnection();
        }
    }
   
    public void updateQuantityCheckout(String proId, int newQuantity) throws SQLException{
        try {
            con=DBUtils.getConnection();
            if(con!=null){
                String sql="";
                if(newQuantity==0){
                    sql="update Product set isAvailable=?, quantity=? where proId=?";
                    stm=con.prepareStatement(sql);
                    stm.setBoolean(1, false);
                    stm.setInt(2, newQuantity);
                    stm.setString(3, proId);
                    stm.executeUpdate();
                }else{
                    sql="update Product set quantity=? where proId=?";
                    stm=con.prepareStatement(sql);
                    stm.setInt(1, newQuantity);
                    stm.setString(2, proId);
                    stm.executeUpdate();
                }
                    
                
            }
        } catch (Exception e) {
        }finally{
            closeConnection();
        }
    }
    public void updateStatusQuantityOver(String proId) throws SQLException{
        try {
            con=DBUtils.getConnection();
            if(con!=null){
                
                String sql="update Product set isAvailable=?,quantity=0 where proId=?";
                    stm=con.prepareStatement(sql);
                    stm.setBoolean(1, false);
                    stm.setString(2, proId);
                    stm.executeUpdate();
                                    
            }
        } catch (Exception e) {
        }finally{
            closeConnection();
        }
    }
    public ProductDTO getDetail(InvoiceDetailDTO invoice) throws SQLException{
        ProductDTO product=new ProductDTO();
        try {
            con=DBUtils.getConnection();
            if(con!=null){
                String sql="select P.proId,P.name,description,price,isAvailable,createDate,updateDate,quantity,P.categoryId,I.img,C.name as cateName"
                        + " from Product P,Image I,Category C"
                        + " where P.proId=I.proId and P.categoryId=C.categoryId and P.proId = ?";
                stm=con.prepareStatement(sql);
                stm.setString(1, invoice.getProId());

                rs=stm.executeQuery();
                while(rs.next()){
                    String proId=rs.getString("proId");
                    String name=rs.getString("name");
                    String description=rs.getString("description");
                    float price=rs.getFloat("price");
                    boolean isAvailable=rs.getBoolean("isAvailable");
                    Date createDate=rs.getDate("createDate");
                    Date updateDate=rs.getDate("updateDate");
                    int quantity=invoice.getQuantity();
                    String categoryId=rs.getString("categoryId");
                    String categoryName=rs.getString("cateName");
                    String image=rs.getString("img");
                    product=new ProductDTO(proId, name, description, price, isAvailable, createDate, updateDate, quantity, categoryId, image, categoryName);
                   
                }
            }
            
        } catch (Exception e) {
        }finally{
            closeConnection();
        }
        return product;
    }
 

    
}
