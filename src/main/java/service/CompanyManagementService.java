package service;

import dao.CompanyManagementDAO;
import dto.CompanyInfoDto;

import java.sql.SQLException;
import java.util.List;

/**
 * 企業管理用のServiceクラス
 */
public class CompanyManagementService {
    
    private CompanyManagementDAO companyDAO;
    
    public CompanyManagementService() {
        this.companyDAO = new CompanyManagementDAO();
    }
    
    /**
     * 全企業一覧を取得
     */
    public List<CompanyInfoDto> getAllCompanies() {
        try {
            return companyDAO.getAllCompanies();
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            return null;
        }
    }
    
    /**
     * 企業IDで企業情報を取得
     */
    public CompanyInfoDto getCompanyById(int companyId) {
        try {
            return companyDAO.getCompanyById(companyId);
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            return null;
        }
    }
    
    /**
     * 企業情報を追加
     */
    public boolean addCompany(CompanyInfoDto company) {
        try {
            // バリデーション
            if (!validateCompany(company)) {
                return false;
            }
            
            return companyDAO.addCompany(company);
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    /**
     * 企業情報を更新
     */
    public boolean updateCompany(CompanyInfoDto company) {
        try {
            // バリデーション
            if (!validateCompany(company)) {
                return false;
            }
            
            return companyDAO.updateCompany(company);
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    /**
     * 企業情報を削除
     */
    public boolean deleteCompany(int companyId) {
        try {
            return companyDAO.deleteCompany(companyId);
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    /**
     * 企業名で検索
     */
    public List<CompanyInfoDto> searchCompaniesByName(String companyName) {
        try {
            if (companyName == null || companyName.trim().isEmpty()) {
                return getAllCompanies();
            }
            return companyDAO.searchCompaniesByName(companyName.trim());
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            return null;
        }
    }
    
    /**
     * 企業情報のバリデーション
     */
    private boolean validateCompany(CompanyInfoDto company) {
        if (company == null) {
            return false;
        }
        
        // 企業名は必須
        if (company.getCompanyName() == null || company.getCompanyName().trim().isEmpty()) {
            return false;
        }
        
        // 業種は必須
        if (company.getIndustry() == null || company.getIndustry().trim().isEmpty()) {
            return false;
        }
        
        // 所在地は必須
        if (company.getLocation() == null || company.getLocation().trim().isEmpty()) {
            return false;
        }
        
        // 担当者は必須
        if (company.getContactPerson() == null || company.getContactPerson().trim().isEmpty()) {
            return false;
        }
        
        // 電話番号は必須
        if (company.getPhone() == null || company.getPhone().trim().isEmpty()) {
            return false;
        }
        
        // メールアドレスの形式チェック（入力されている場合）
        if (company.getEmail() != null && !company.getEmail().trim().isEmpty()) {
            if (!isValidEmail(company.getEmail())) {
                return false;
            }
        }
        
        // ステータスは必須
        if (company.getStatus() == null || company.getStatus().trim().isEmpty()) {
            return false;
        }
        
        return true;
    }
    
    /**
     * メールアドレスの形式チェック
     */
    private boolean isValidEmail(String email) {
        String emailRegex = "^[a-zA-Z0-9_+&*-]+(?:\\.[a-zA-Z0-9_+&*-]+)*@(?:[a-zA-Z0-9-]+\\.)+[a-zA-Z]{2,7}$";
        return email.matches(emailRegex);
    }
    
    /**
     * エラーメッセージを取得
     */
    public String getErrorMessage(CompanyInfoDto company) {
        if (company == null) {
            return "企業情報が入力されていません。";
        }
        
        if (company.getCompanyName() == null || company.getCompanyName().trim().isEmpty()) {
            return "企業名は必須項目です。";
        }
        
        if (company.getIndustry() == null || company.getIndustry().trim().isEmpty()) {
            return "業種は必須項目です。";
        }
        
        if (company.getLocation() == null || company.getLocation().trim().isEmpty()) {
            return "所在地は必須項目です。";
        }
        
        if (company.getContactPerson() == null || company.getContactPerson().trim().isEmpty()) {
            return "担当者は必須項目です。";
        }
        
        if (company.getPhone() == null || company.getPhone().trim().isEmpty()) {
            return "電話番号は必須項目です。";
        }
        
        if (company.getEmail() != null && !company.getEmail().trim().isEmpty()) {
            if (!isValidEmail(company.getEmail())) {
                return "メールアドレスの形式が正しくありません。";
            }
        }
        
        if (company.getStatus() == null || company.getStatus().trim().isEmpty()) {
            return "ステータスは必須項目です。";
        }
        
        return "";
    }
} 