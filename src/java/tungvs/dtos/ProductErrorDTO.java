/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package tungvs.dtos;

import java.sql.Date;

/**
 *
 * @author USER
 */
public class ProductErrorDTO {
    private String proIdError;
    private String nameError;
    private String descriptionError;
    private String priceError;
    private String isAvailableError;
    private String createDateError;
    private String updateDateError;
    private String quantityError;
    private String categoryIdError;
    private String imageError;

    public ProductErrorDTO() {
    }

    public ProductErrorDTO(String proIdError, String nameError, String descriptionError, String priceError, String isAvailableError, String createDateError, String updateDateError, String quantityError, String categoryIdError, String imageError) {
        this.proIdError = proIdError;
        this.nameError = nameError;
        this.descriptionError = descriptionError;
        this.priceError = priceError;
        this.isAvailableError = isAvailableError;
        this.createDateError = createDateError;
        this.updateDateError = updateDateError;
        this.quantityError = quantityError;
        this.categoryIdError = categoryIdError;
        this.imageError = imageError;
    }

    public String getProIdError() {
        return proIdError;
    }

    public void setProIdError(String proIdError) {
        this.proIdError = proIdError;
    }

    public String getNameError() {
        return nameError;
    }

    public void setNameError(String nameError) {
        this.nameError = nameError;
    }

    public String getDescriptionError() {
        return descriptionError;
    }

    public void setDescriptionError(String descriptionError) {
        this.descriptionError = descriptionError;
    }

    public String getPriceError() {
        return priceError;
    }

    public void setPriceError(String priceError) {
        this.priceError = priceError;
    }

    public String getIsAvailableError() {
        return isAvailableError;
    }

    public void setIsAvailableError(String isAvailableError) {
        this.isAvailableError = isAvailableError;
    }

    public String getCreateDateError() {
        return createDateError;
    }

    public void setCreateDateError(String createDateError) {
        this.createDateError = createDateError;
    }

    public String getUpdateDateError() {
        return updateDateError;
    }

    public void setUpdateDateError(String updateDateError) {
        this.updateDateError = updateDateError;
    }

    public String getQuantityError() {
        return quantityError;
    }

    public void setQuantityError(String quantityError) {
        this.quantityError = quantityError;
    }

    public String getCategoryIdError() {
        return categoryIdError;
    }

    public void setCategoryIdError(String categoryIdError) {
        this.categoryIdError = categoryIdError;
    }

    public String getImageError() {
        return imageError;
    }

    public void setImageError(String imageError) {
        this.imageError = imageError;
    }

    
    
}
