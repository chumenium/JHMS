package dao;

import dto.DocumentStatusDto;
import utils.DBConnection;

import java.sql.*;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

/**
 * 書類提出状況用のDAOクラス
 */
public class DocumentStatusDAO {
    
    /**
     * 全書類提出状況を取得
     */
    public List<DocumentStatusDto> getAllDocumentSubmissions() throws SQLException, ClassNotFoundException {
        List<DocumentStatusDto> submissions = new ArrayList<>();
        String sql = "SELECT * FROM document_submissions ORDER BY student_name, document_type";
        
        try (Connection conn = utils.DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            
            while (rs.next()) {
                DocumentStatusDto submission = mapResultSetToDto(rs);
                submissions.add(submission);
            }
        }
        return submissions;
    }
    
    /**
     * 学生IDで書類提出状況を取得
     */
    public List<DocumentStatusDto> getDocumentSubmissionsByStudentId(String studentId) throws SQLException, ClassNotFoundException {
        List<DocumentStatusDto> submissions = new ArrayList<>();
        String sql = "SELECT * FROM document_submissions WHERE student_id = ? ORDER BY document_type";
        
        try (Connection conn = utils.DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, studentId);
            
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    DocumentStatusDto submission = mapResultSetToDto(rs);
                    submissions.add(submission);
                }
            }
        }
        return submissions;
    }
    
    /**
     * 提出状況で書類提出状況を取得
     */
    public List<DocumentStatusDto> getDocumentSubmissionsByStatus(String status) throws SQLException, ClassNotFoundException {
        List<DocumentStatusDto> submissions = new ArrayList<>();
        String sql = "SELECT * FROM document_submissions WHERE submission_status = ? ORDER BY student_name, document_type";
        
        try (Connection conn = utils.DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, status);
            
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    DocumentStatusDto submission = mapResultSetToDto(rs);
                    submissions.add(submission);
                }
            }
        }
        return submissions;
    }
    
    /**
     * 書類提出状況を更新（教師のコメントとチェック状況）
     */
    public boolean updateDocumentSubmission(int id, String teacherComment, String checkedBy) throws SQLException, ClassNotFoundException {
        String sql = "UPDATE document_submissions SET teacher_comment = ?, checked_by = ?, checked_at = NOW(), updated_at = NOW() WHERE id = ?";
        
        try (Connection conn = utils.DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, teacherComment);
            stmt.setString(2, checkedBy);
            stmt.setInt(3, id);
            
            int result = stmt.executeUpdate();
            return result > 0;
        }
    }
    
    /**
     * 書類提出状況を追加
     */
    public boolean addDocumentSubmission(DocumentStatusDto submission) throws SQLException, ClassNotFoundException {
        String sql = "INSERT INTO document_submissions (student_id, student_name, document_type, company_name, submission_date, submission_status, document_file_path, teacher_comment, checked_by) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
        
        try (Connection conn = utils.DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, submission.getStudentId());
            stmt.setString(2, submission.getStudentName());
            stmt.setString(3, submission.getDocumentType());
            stmt.setString(4, submission.getCompanyName());
            
            if (submission.getSubmissionDate() != null) {
                stmt.setDate(5, java.sql.Date.valueOf(submission.getSubmissionDate()));
            } else {
                stmt.setNull(5, java.sql.Types.DATE);
            }
            
            stmt.setString(6, submission.getSubmissionStatus());
            stmt.setString(7, submission.getDocumentFilePath());
            stmt.setString(8, submission.getTeacherComment());
            stmt.setString(9, submission.getCheckedBy());
            
            int result = stmt.executeUpdate();
            return result > 0;
        }
    }
    
    /**
     * 書類種別一覧を取得
     */
    public List<String> getDocumentTypes() throws SQLException, ClassNotFoundException {
        List<String> documentTypes = new ArrayList<>();
        String sql = "SELECT document_name FROM document_types ORDER BY document_name";
        
        try (Connection conn = utils.DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            
            while (rs.next()) {
                documentTypes.add(rs.getString("document_name"));
            }
        }
        return documentTypes;
    }
    
    /**
     * 学生名で検索
     */
    public List<DocumentStatusDto> searchDocumentSubmissionsByStudentName(String studentName) throws SQLException, ClassNotFoundException {
        List<DocumentStatusDto> submissions = new ArrayList<>();
        String sql = "SELECT * FROM document_submissions WHERE student_name LIKE ? ORDER BY student_name, document_type";
        
        try (Connection conn = utils.DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, "%" + studentName + "%");
            
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    DocumentStatusDto submission = mapResultSetToDto(rs);
                    submissions.add(submission);
                }
            }
        }
        return submissions;
    }
    
    /**
     * ResultSetをDTOにマッピング
     */
    private DocumentStatusDto mapResultSetToDto(ResultSet rs) throws SQLException {
        DocumentStatusDto submission = new DocumentStatusDto();
        submission.setId(rs.getInt("id"));
        submission.setStudentId(rs.getString("student_id"));
        submission.setStudentName(rs.getString("student_name"));
        submission.setDocumentType(rs.getString("document_type"));
        submission.setCompanyName(rs.getString("company_name"));
        
        Date submissionDate = rs.getDate("submission_date");
        if (submissionDate != null) {
            submission.setSubmissionDate(submissionDate.toLocalDate());
        }
        
        submission.setSubmissionStatus(rs.getString("submission_status"));
        submission.setDocumentFilePath(rs.getString("document_file_path"));
        submission.setTeacherComment(rs.getString("teacher_comment"));
        submission.setCheckedBy(rs.getString("checked_by"));
        submission.setCheckedAt(rs.getString("checked_at"));
        submission.setCreatedAt(rs.getString("created_at"));
        submission.setUpdatedAt(rs.getString("updated_at"));
        
        return submission;
    }
} 