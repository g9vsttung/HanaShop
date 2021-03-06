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
import tungvs.dtos.InvoiceDetailDTO;
import tungvs.utils.DBUtils;

/**
 *
 * @author USER
 */
public class InvoiceDetailDAO {
    private Connection con;
    private PreparedStatement stm;
    private ResultSet rs;

    public InvoiceDetailDAO() {
        con=null;
        stm=null;
        rs=null;
    }   
    public void closeConnection() throws SQLException{
        if(rs!=null) rs.close();
        if(stm!= null) stm.close();
        if(con!= null) con.close();
    }
    public List<InvoiceDetailDTO> getDetals(String id) throws SQLException{
        List<InvoiceDetailDTO>list=new ArrayList<>();
        try {
            con=DBUtils.getConnection();
            if(con!=null){
                String sql="select proId,quantity from Invoice_Details where invoiceId = ?";
                stm=con.prepareStatement(sql);
                stm.setString(1, id);
                rs=stm.executeQuery();
                while(rs.next()){
                    String proId=rs.getString("proId");
                    int quantity=rs.getInt("quantity");
                    InvoiceDetailDTO invoice=new InvoiceDetailDTO(id, proId, quantity);
                    list.add(invoice);
                }
            }
        } catch (Exception e) {
        }finally{
            closeConnection();
        }
        return list;
    }
}
