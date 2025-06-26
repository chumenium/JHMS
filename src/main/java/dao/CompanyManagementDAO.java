package dao;

import dto.CompanyInfoDto;
import utils.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * 企業管理用のDAOクラス
 */
public class CompanyManagementDAO {
    
    /**
     * 全企業一覧を取得
     */
    public List<CompanyInfoDto> getAllCompanies() throws SQLException, ClassNotFoundException {
        List<CompanyInfoDto> companies = new ArrayList<>();
        String sql = "SELECT * FROM companies ORDER BY company_name";
        
        try (Connection conn = utils.DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            
            while (rs.next()) {
                CompanyInfoDto company = new CompanyInfoDto();
                company.setCompanyId(rs.getInt("company_id"));
                company.setCompanyName(rs.getString("company_name"));
                company.setIndustry(rs.getString("industry"));
                company.setLocation(rs.getString("location"));
                company.setContactPerson(rs.getString("contact_person"));
                company.setPhone(rs.getString("phone"));
                company.setEmail(rs.getString("email"));
                company.setWebsite(rs.getString("website"));
                company.setDescription(rs.getString("description"));
                company.setStatus(rs.getString("status"));
                company.setCreatedAt(rs.getString("created_at"));
                company.setUpdatedAt(rs.getString("updated_at"));
                
                companies.add(company);
            }
        }
        return companies;
    }
    
    /**
     * 企業IDで企業情報を取得
     */
    public CompanyInfoDto getCompanyById(int companyId) throws SQLException, ClassNotFoundException {
        String sql = "SELECT * FROM companies WHERE company_id = ?";
        
        try (Connection conn = utils.DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, companyId);
            
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    CompanyInfoDto company = new CompanyInfoDto();
                    company.setCompanyId(rs.getInt("company_id"));
                    company.setCompanyName(rs.getString("company_name"));
                    company.setIndustry(rs.getString("industry"));
                    company.setLocation(rs.getString("location"));
                    company.setContactPerson(rs.getString("contact_person"));
                    company.setPhone(rs.getString("phone"));
                    company.setEmail(rs.getString("email"));
                    company.setWebsite(rs.getString("website"));
                    company.setDescription(rs.getString("description"));
                    company.setStatus(rs.getString("status"));
                    company.setCreatedAt(rs.getString("created_at"));
                    company.setUpdatedAt(rs.getString("updated_at"));
                    
                    return company;
                }
            }
        }
        return null;
    }
    
    /**
     * 企業情報を追加
     */
    public boolean addCompany(CompanyInfoDto company) throws SQLException, ClassNotFoundException {
        String sql = "INSERT INTO companies (company_name, industry, location, contact_person, phone, email, website, description, status, created_at, updated_at) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, NOW(), NOW())";
        
        try (Connection conn = utils.DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, company.getCompanyName());
            stmt.setString(2, company.getIndustry());
            stmt.setString(3, company.getLocation());
            stmt.setString(4, company.getContactPerson());
            stmt.setString(5, company.getPhone());
            stmt.setString(6, company.getEmail());
            stmt.setString(7, company.getWebsite());
            stmt.setString(8, company.getDescription());
            stmt.setString(9, company.getStatus());
            
            int result = stmt.executeUpdate();
            return result > 0;
        }
    }
    
    /**
     * 企業情報を更新
     */
    public boolean updateCompany(CompanyInfoDto company) throws SQLException, ClassNotFoundException {
        String sql = "UPDATE companies SET company_name=?, industry=?, location=?, contact_person=?, " +
                     "phone=?, email=?, website=?, description=?, status=?, updated_at=NOW() " +
                     "WHERE company_id=?";
        
        try (Connection conn = utils.DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, company.getCompanyName());
            stmt.setString(2, company.getIndustry());
            stmt.setString(3, company.getLocation());
            stmt.setString(4, company.getContactPerson());
            stmt.setString(5, company.getPhone());
            stmt.setString(6, company.getEmail());
            stmt.setString(7, company.getWebsite());
            stmt.setString(8, company.getDescription());
            stmt.setString(9, company.getStatus());
            stmt.setInt(10, company.getCompanyId());
            
            int result = stmt.executeUpdate();
            return result > 0;
        }
    }
    
    /**
     * 企業情報を削除
     */
    public boolean deleteCompany(int companyId) throws SQLException, ClassNotFoundException {
        String sql = "DELETE FROM companies WHERE company_id = ?";
        
        try (Connection conn = utils.DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, companyId);
            
            int result = stmt.executeUpdate();
            return result > 0;
        }
    }
    
    /**
     * 企業名で検索
     */
    public List<CompanyInfoDto> searchCompaniesByName(String companyName) throws SQLException, ClassNotFoundException {
        List<CompanyInfoDto> companies = new ArrayList<>();
        String sql = "SELECT * FROM companies WHERE company_name LIKE ? ORDER BY company_name";
        
        try (Connection conn = utils.DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, "%" + companyName + "%");
            
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    CompanyInfoDto company = new CompanyInfoDto();
                    company.setCompanyId(rs.getInt("company_id"));
                    company.setCompanyName(rs.getString("company_name"));
                    company.setIndustry(rs.getString("industry"));
                    company.setLocation(rs.getString("location"));
                    company.setContactPerson(rs.getString("contact_person"));
                    company.setPhone(rs.getString("phone"));
                    company.setEmail(rs.getString("email"));
                    company.setWebsite(rs.getString("website"));
                    company.setDescription(rs.getString("description"));
                    company.setStatus(rs.getString("status"));
                    company.setCreatedAt(rs.getString("created_at"));
                    company.setUpdatedAt(rs.getString("updated_at"));
                    
                    companies.add(company);
                }
            }
        }
        return companies;
    }
} 