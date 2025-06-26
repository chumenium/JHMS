package dto;

import java.io.Serializable;

/**
 * 企業情報を格納するDTOクラス
 */
public class CompanyInfoDto implements Serializable {
    private static final long serialVersionUID = 1L;
    
    private int companyId;
    private String companyName;
    private String industry;
    private String location;
    private String contactPerson;
    private String phone;
    private String email;
    private String website;
    private String description;
    private String status;
    private String createdAt;
    private String updatedAt;
    
    // デフォルトコンストラクタ
    public CompanyInfoDto() {}
    
    // 全フィールドコンストラクタ
    public CompanyInfoDto(int companyId, String companyName, String industry, String location,
                         String contactPerson, String phone, String email, String website,
                         String description, String status, String createdAt, String updatedAt) {
        this.companyId = companyId;
        this.companyName = companyName;
        this.industry = industry;
        this.location = location;
        this.contactPerson = contactPerson;
        this.phone = phone;
        this.email = email;
        this.website = website;
        this.description = description;
        this.status = status;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
    }
    
    // Getter and Setter methods
    public int getCompanyId() {
        return companyId;
    }
    
    public void setCompanyId(int companyId) {
        this.companyId = companyId;
    }
    
    public String getCompanyName() {
        return companyName;
    }
    
    public void setCompanyName(String companyName) {
        this.companyName = companyName;
    }
    
    public String getIndustry() {
        return industry;
    }
    
    public void setIndustry(String industry) {
        this.industry = industry;
    }
    
    public String getLocation() {
        return location;
    }
    
    public void setLocation(String location) {
        this.location = location;
    }
    
    public String getContactPerson() {
        return contactPerson;
    }
    
    public void setContactPerson(String contactPerson) {
        this.contactPerson = contactPerson;
    }
    
    public String getPhone() {
        return phone;
    }
    
    public void setPhone(String phone) {
        this.phone = phone;
    }
    
    public String getEmail() {
        return email;
    }
    
    public void setEmail(String email) {
        this.email = email;
    }
    
    public String getWebsite() {
        return website;
    }
    
    public void setWebsite(String website) {
        this.website = website;
    }
    
    public String getDescription() {
        return description;
    }
    
    public void setDescription(String description) {
        this.description = description;
    }
    
    public String getStatus() {
        return status;
    }
    
    public void setStatus(String status) {
        this.status = status;
    }
    
    public String getCreatedAt() {
        return createdAt;
    }
    
    public void setCreatedAt(String createdAt) {
        this.createdAt = createdAt;
    }
    
    public String getUpdatedAt() {
        return updatedAt;
    }
    
    public void setUpdatedAt(String updatedAt) {
        this.updatedAt = updatedAt;
    }
    
    @Override
    public String toString() {
        return "CompanyInfoDto{" +
                "companyId=" + companyId +
                ", companyName='" + companyName + '\'' +
                ", industry='" + industry + '\'' +
                ", location='" + location + '\'' +
                ", contactPerson='" + contactPerson + '\'' +
                ", phone='" + phone + '\'' +
                ", email='" + email + '\'' +
                ", website='" + website + '\'' +
                ", description='" + description + '\'' +
                ", status='" + status + '\'' +
                ", createdAt='" + createdAt + '\'' +
                ", updatedAt='" + updatedAt + '\'' +
                '}';
    }
} 