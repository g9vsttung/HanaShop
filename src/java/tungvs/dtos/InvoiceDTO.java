/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package tungvs.dtos;

import java.util.Date;

/**
 *
 * @author USER
 */
public class InvoiceDTO {
    private String ID;
    private String date;
    private float total;
    private String userID;
    private String payment;
    private String address;
    private String numberPhone;

    public InvoiceDTO() {
    }

    public InvoiceDTO(String ID, String date, float total, String userID, String payment, String address, String numberPhone) {
        this.ID = ID;
        this.date = date;
        this.total = total;
        this.userID = userID;
        this.payment = payment;
        this.address = address;
        this.numberPhone = numberPhone;
    }

    public String getDate() {
        return date;
    }

    public void setDate(String date) {
        this.date = date;
    }
    
   

    public String getID() {
        return ID;
    }

    public void setID(String ID) {
        this.ID = ID;
    }

 

    public float getTotal() {
        return total;
    }

    public void setTotal(float total) {
        this.total = total;
    }

    public String getUserID() {
        return userID;
    }

    public void setUserID(String userID) {
        this.userID = userID;
    }

    public String getPayment() {
        return payment;
    }

    public void setPayment(String payment) {
        this.payment = payment;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getNumberPhone() {
        return numberPhone;
    }

    public void setNumberPhone(String numberPhone) {
        this.numberPhone = numberPhone;
    }
    
}
