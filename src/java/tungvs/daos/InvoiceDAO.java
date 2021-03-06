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
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;
import tungvs.dtos.InvoiceDTO;
import tungvs.utils.DBUtils;

/**
 *
 * @author USER
 */
public class InvoiceDAO {

    private Connection con;
    private PreparedStatement stm;
    private ResultSet rs;

    public InvoiceDAO() {
        con = null;
        stm = null;
        rs = null;
    }

    public void closeConnection() throws SQLException {
        if (rs != null) {
            rs.close();
        }
        if (stm != null) {
            stm.close();
        }
        if (con != null) {
            con.close();
        }
    }

    public void insertInvoice(InvoiceDTO invoice) throws SQLException {
        try {
            con = DBUtils.getConnection();
            if (con != null) {
                String sql = "insert into Invoice(invoiceId,dateOfIssue,total,userId,payment,address,numberphone)"
                        + " values(?,?,?,?,?,?,?)";
                stm = con.prepareStatement(sql);
                stm.setString(1, invoice.getID());
                stm.setDate(2, java.sql.Date.valueOf(invoice.getDate()));
                stm.setFloat(3, invoice.getTotal());
                stm.setString(4, invoice.getUserID());
                stm.setString(5, invoice.getPayment());
                stm.setString(6, invoice.getAddress());
                stm.setString(7, invoice.getNumberPhone());
                stm.executeUpdate();
            }
        } catch (Exception e) {
        } finally {
            closeConnection();
        }
    }

    public void insertInvoiceDetails(String ID, String proId, int quantity) throws SQLException {
        try {
            con = DBUtils.getConnection();
            if (con != null) {
                String sql = "insert into Invoice_Details(invoiceId,proId,quantity)"
                        + " values(?,?,?)";
                stm = con.prepareStatement(sql);
                stm.setString(1, ID);
                stm.setString(2, proId);
                stm.setInt(3, quantity);
                stm.executeUpdate();
            }
        } catch (Exception e) {
        } finally {
            closeConnection();
        }
    }

    public List<InvoiceDTO> getallInvoice(String userID) throws SQLException {
        List<InvoiceDTO> list = new ArrayList<>();
        try {
            con = DBUtils.getConnection();
            if (con != null) {
                String sql = "select invoiceId,dateOfIssue,total,userId,payment,address,numberphone from Invoice where userId=?";
                stm = con.prepareStatement(sql);
                stm.setString(1, userID);
                rs = stm.executeQuery();
                SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
                while (rs.next()) {
                    String ID = rs.getString("invoiceId");
                    String date = dateFormat.format(rs.getDate("dateOfIssue"));
                    float total = rs.getFloat("total");
                    String payment = rs.getString("payment");
                    String address = rs.getString("address");
                    String numberPhone = rs.getString("numberphone");
                    InvoiceDTO invoice = new InvoiceDTO(ID, date, total, userID, payment, address, numberPhone);
                    list.add(invoice);
                }
            }
        } catch (Exception e) {
        } finally {
            closeConnection();
        }
        return list;
    }

    public List<InvoiceDTO> searchInvoice(String search, String dates) throws SQLException {
        List<InvoiceDTO> list = new ArrayList<>();
        try {
            con = DBUtils.getConnection();
            if (con != null) {
                if ("".equals(dates)) {
                    String sql = "select invoiceId,dateOfIssue,total,userId,payment,address,numberphone from Invoice where invoiceId like ?";
                    stm = con.prepareStatement(sql);
                    stm.setString(1, "%" + search + "%");
                    rs = stm.executeQuery();
                    SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
                    while (rs.next()) {
                        String ID = rs.getString("invoiceId");
                        String date = dateFormat.format(rs.getDate("dateOfIssue"));
                        float total = rs.getFloat("total");
                        String userID = rs.getString("userId");
                        String payment = rs.getString("payment");
                        String address = rs.getString("address");
                        String numberPhone = rs.getString("numberphone");
                        InvoiceDTO invoice = new InvoiceDTO(ID, date, total, userID, payment, address, numberPhone);
                        list.add(invoice);
                    }
                } else {
                    String sql = "select invoiceId,dateOfIssue,total,userId,payment,address,numberphone from Invoice where invoiceId like ? and dateOfIssue = ?";
                    stm = con.prepareStatement(sql);
                    stm.setString(1, "%" + search + "%");
                    stm.setDate(2, java.sql.Date.valueOf(dates));
                    rs = stm.executeQuery();
                    SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
                    while (rs.next()) {
                        String ID = rs.getString("invoiceId");
                        String date = dateFormat.format(rs.getDate("dateOfIssue"));
                        float total = rs.getFloat("total");
                        String userID = rs.getString("userId");
                        String payment = rs.getString("payment");
                        String address = rs.getString("address");
                        String numberPhone = rs.getString("numberphone");
                        InvoiceDTO invoice = new InvoiceDTO(ID, date, total, userID, payment, address, numberPhone);
                        list.add(invoice);
                    }
                }

            }
        } catch (Exception e) {
        } finally {
            closeConnection();
        }
        return list;
    }
}
