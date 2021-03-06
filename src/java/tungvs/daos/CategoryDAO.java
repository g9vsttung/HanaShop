/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package tungvs.daos;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import tungvs.dtos.CartDTO;
import tungvs.dtos.CategoryDTO;
import tungvs.utils.DBUtils;

/**
 *
 * @author USER
 */
public class CategoryDAO {
    private Connection con;
    private PreparedStatement stm;
    private ResultSet rs;

    public CategoryDAO() {
        con=null;
        stm=null;
        rs=null;
    }   
    public void closeConnection() throws SQLException{
        if(rs!=null) rs.close();
        if(stm!= null) stm.close();
        if(con!= null) con.close();
    }
    public List<String> getAllCategory() throws SQLException{
        List<String> list=new ArrayList<>();
        try {
            con=DBUtils.getConnection();
            if(con!=null){
                String sql="select name from Category";
                stm=con.prepareStatement(sql);
                rs=stm.executeQuery();
                while(rs.next()){
                    list.add(rs.getString("name"));
                }
            }
        } catch (Exception e) {
        }finally{
            closeConnection();
        }
        return list;
    }
    public List<CategoryDTO> getAllCategoryWithID() throws SQLException{
        List<CategoryDTO> list=new ArrayList<>();
        try {
            con=DBUtils.getConnection();
            if(con!=null){
                String sql="select categoryId,name from Category";
                stm=con.prepareStatement(sql);
                rs=stm.executeQuery();
                while(rs.next()){
                    String ID=rs.getString("categoryId");
                    String name=rs.getString("name");
                    CategoryDTO cate=new CategoryDTO(ID, name);
                    list.add(cate);
                }
            }
        } catch (Exception e) {
        }finally{
            closeConnection();
        }
        return list;
    }
    
}
