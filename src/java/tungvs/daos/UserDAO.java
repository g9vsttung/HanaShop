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
import tungvs.dtos.UserDTO;
import tungvs.utils.DBUtils;

/**
 *
 * @author USER
 */
public class UserDAO {
    private Connection con;
    private PreparedStatement stm;
    private ResultSet rs;

    public UserDAO() {
        con=null;
        stm=null;
        rs=null;
    }
    public void closeConnection() throws SQLException{
        if(rs!=null) rs.close();
        if(stm!= null) rs.close();
        if(con!= null) con.close();
    }
    public UserDTO checkLogin(String userId, String password) throws SQLException{
        UserDTO user=null;
        try {
            con=DBUtils.getConnection();
            if(con!=null){
                String sql="select userId,password,role from Account where userId=? and password=?";
                stm=con.prepareStatement(sql);
                stm.setString(1, userId);
                stm.setString(2, password);
                rs=stm.executeQuery();
                if(rs.next()){
                    user=new UserDTO(rs.getString("userId"), rs.getString("password"), rs.getString("role"));
                }
            }
        } catch (Exception e) {
        }finally{
            closeConnection();
        }
        return user;
    }
    public boolean checkGoogleExist(String userId) throws SQLException{
        boolean exist=false;
        try {
            con=DBUtils.getConnection();
            if(con!=null){
                String sql="select userId,password,role from Account where userId=?";
                stm=con.prepareStatement(sql);
                stm.setString(1, userId);
                rs=stm.executeQuery();
                if(rs.next()){
                    exist=true;
                }
            }
        } catch (Exception e) {
        }finally{
            closeConnection();
        }
        return exist;
    }
    public void insertGoogleAccount(String userId) throws SQLException{
        boolean exist=false;
        try {
            con=DBUtils.getConnection();
            if(con!=null){
                String sql="insert into Account(userId) values(?)";
                stm=con.prepareStatement(sql);
                stm.setString(1, userId);
                stm.executeUpdate();
            }
        } catch (Exception e) {
        }finally{
            closeConnection();
        }
       
    }
}
