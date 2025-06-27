package service;

import dao.DocumentStatusDAO;
import dto.DocumentStatusDto;

import java.sql.SQLException;
import java.util.List;

/**
 * 書類提出チェック用のServiceクラス
 */
public class DocumentCheckService {
    
    private DocumentStatusDAO documentStatusDAO;
    
    public DocumentCheckService() {
        this.documentStatusDAO = new DocumentStatusDAO();
    }
    
    /**
     * 全書類提出状況を取得
     */
    public List<DocumentStatusDto> getAllDocumentSubmissions() throws SQLException, ClassNotFoundException {
        return documentStatusDAO.getAllDocumentSubmissions();
    }
    
    /**
     * 学生IDで書類提出状況を取得
     */
    public List<DocumentStatusDto> getDocumentSubmissionsByStudentId(String studentId) throws SQLException, ClassNotFoundException {
        return documentStatusDAO.getDocumentSubmissionsByStudentId(studentId);
    }
    
    /**
     * 提出状況で書類提出状況を取得
     */
    public List<DocumentStatusDto> getDocumentSubmissionsByStatus(String status) throws SQLException, ClassNotFoundException {
        return documentStatusDAO.getDocumentSubmissionsByStatus(status);
    }
    
    /**
     * 書類提出状況を更新（教師のコメントとチェック状況）
     */
    public boolean updateDocumentSubmission(int id, String teacherComment, String checkedBy) throws SQLException, ClassNotFoundException {
        return documentStatusDAO.updateDocumentSubmission(id, teacherComment, checkedBy);
    }
    
    /**
     * 書類提出状況を追加
     */
    public boolean addDocumentSubmission(DocumentStatusDto submission) throws SQLException, ClassNotFoundException {
        return documentStatusDAO.addDocumentSubmission(submission);
    }
    
    /**
     * 書類種別一覧を取得
     */
    public List<String> getDocumentTypes() throws SQLException, ClassNotFoundException {
        return documentStatusDAO.getDocumentTypes();
    }
    
    /**
     * 学生名で検索
     */
    public List<DocumentStatusDto> searchDocumentSubmissionsByStudentName(String studentName) throws SQLException, ClassNotFoundException {
        return documentStatusDAO.searchDocumentSubmissionsByStudentName(studentName);
    }
    
    /**
     * 未提出の書類を取得
     */
    public List<DocumentStatusDto> getUnsubmittedDocuments() throws SQLException, ClassNotFoundException {
        return documentStatusDAO.getDocumentSubmissionsByStatus("未提出");
    }
    
    /**
     * 提出済みの書類を取得
     */
    public List<DocumentStatusDto> getSubmittedDocuments() throws SQLException, ClassNotFoundException {
        return documentStatusDAO.getDocumentSubmissionsByStatus("提出済み");
    }
    
    /**
     * チェック済みの書類を取得
     */
    public List<DocumentStatusDto> getCheckedDocuments() throws SQLException, ClassNotFoundException {
        return documentStatusDAO.getDocumentSubmissionsByStatus("チェック済み");
    }
} 