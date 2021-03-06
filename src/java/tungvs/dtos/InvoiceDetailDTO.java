/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package tungvs.dtos;

/**
 *
 * @author USER
 */
public class InvoiceDetailDTO {
    private String id;
    private String proId;
    private int quantity;

    public InvoiceDetailDTO() {
    }

    public InvoiceDetailDTO(String id, String proId, int quantity) {
        this.id = id;
        this.proId = proId;
        this.quantity = quantity;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getProId() {
        return proId;
    }

    public void setProId(String proId) {
        this.proId = proId;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }
    
}
