package controller;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import service.CompanyManagementService;
import dto.CompanyInfoDto;

import java.io.IOException;
import java.util.List;

/**
 * 企業管理用のControllerクラス
 */
public class CompanyManagementController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    private CompanyManagementService companyService;
    
    public void init() throws ServletException {
        companyService = new CompanyManagementService();
    }
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // セッション確認（テスト用に一時的に無効化）
        /*
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("login.html");
            return;
        }
        */
        
        String action = request.getParameter("action");
        
        if (action == null) {
            action = "list";
        }
        
        switch (action) {
            case "list":
                listCompanies(request, response);
                break;
            case "add":
                showAddForm(request, response);
                break;
            case "edit":
                showEditForm(request, response);
                break;
            case "delete":
                deleteCompany(request, response);
                break;
            case "search":
                searchCompanies(request, response);
                break;
            default:
                listCompanies(request, response);
                break;
        }
    }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // セッション確認（テスト用に一時的に無効化）
        /*
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("login.html");
            return;
        }
        */
        
        String action = request.getParameter("action");
        
        if (action == null) {
            response.sendRedirect("CompanyManagementController?action=list");
            return;
        }
        
        switch (action) {
            case "add":
                addCompany(request, response);
                break;
            case "update":
                updateCompany(request, response);
                break;
            case "search":
                searchCompanies(request, response);
                break;
            default:
                response.sendRedirect("CompanyManagementController?action=list");
                break;
        }
    }
    
    /**
     * 企業一覧を表示
     */
    private void listCompanies(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        List<CompanyInfoDto> companies = companyService.getAllCompanies();
        request.setAttribute("companies", companies);
        request.setAttribute("message", request.getParameter("message"));
        
        RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/companyManagement.jsp");
        dispatcher.forward(request, response);
    }
    
    /**
     * 企業追加フォームを表示
     */
    private void showAddForm(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        request.setAttribute("mode", "add");
        RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/companyManagement.jsp");
        dispatcher.forward(request, response);
    }
    
    /**
     * 企業編集フォームを表示
     */
    private void showEditForm(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String companyIdStr = request.getParameter("id");
        if (companyIdStr == null || companyIdStr.trim().isEmpty()) {
            response.sendRedirect("CompanyManagementController?action=list&message=企業IDが指定されていません。");
            return;
        }
        
        try {
            int companyId = Integer.parseInt(companyIdStr);
            CompanyInfoDto company = companyService.getCompanyById(companyId);
            
            if (company == null) {
                response.sendRedirect("CompanyManagementController?action=list&message=指定された企業が見つかりません。");
                return;
            }
            
            request.setAttribute("company", company);
            request.setAttribute("mode", "edit");
            RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/companyManagement.jsp");
            dispatcher.forward(request, response);
            
        } catch (NumberFormatException e) {
            response.sendRedirect("CompanyManagementController?action=list&message=無効な企業IDです。");
        }
    }
    
    /**
     * 企業を追加
     */
    private void addCompany(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // リクエストパラメータを取得
        CompanyInfoDto company = new CompanyInfoDto();
        company.setCompanyName(request.getParameter("companyName"));
        company.setIndustry(request.getParameter("industry"));
        company.setLocation(request.getParameter("location"));
        company.setContactPerson(request.getParameter("contactPerson"));
        company.setPhone(request.getParameter("phone"));
        company.setEmail(request.getParameter("email"));
        company.setWebsite(request.getParameter("website"));
        company.setDescription(request.getParameter("description"));
        company.setStatus(request.getParameter("status"));
        
        // バリデーション
        String errorMessage = companyService.getErrorMessage(company);
        if (!errorMessage.isEmpty()) {
            request.setAttribute("company", company);
            request.setAttribute("mode", "add");
            request.setAttribute("errorMessage", errorMessage);
            RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/companyManagement.jsp");
            dispatcher.forward(request, response);
            return;
        }
        
        // 企業を追加
        boolean success = companyService.addCompany(company);
        
        if (success) {
            response.sendRedirect("CompanyManagementController?action=list&message=企業を正常に追加しました。");
        } else {
            request.setAttribute("company", company);
            request.setAttribute("mode", "add");
            request.setAttribute("errorMessage", "企業の追加に失敗しました。");
            RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/companyManagement.jsp");
            dispatcher.forward(request, response);
        }
    }
    
    /**
     * 企業を更新
     */
    private void updateCompany(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String companyIdStr = request.getParameter("companyId");
        if (companyIdStr == null || companyIdStr.trim().isEmpty()) {
            response.sendRedirect("CompanyManagementController?action=list&message=企業IDが指定されていません。");
            return;
        }
        
        try {
            int companyId = Integer.parseInt(companyIdStr);
            
            // リクエストパラメータを取得
            CompanyInfoDto company = new CompanyInfoDto();
            company.setCompanyId(companyId);
            company.setCompanyName(request.getParameter("companyName"));
            company.setIndustry(request.getParameter("industry"));
            company.setLocation(request.getParameter("location"));
            company.setContactPerson(request.getParameter("contactPerson"));
            company.setPhone(request.getParameter("phone"));
            company.setEmail(request.getParameter("email"));
            company.setWebsite(request.getParameter("website"));
            company.setDescription(request.getParameter("description"));
            company.setStatus(request.getParameter("status"));
            
            // バリデーション
            String errorMessage = companyService.getErrorMessage(company);
            if (!errorMessage.isEmpty()) {
                request.setAttribute("company", company);
                request.setAttribute("mode", "edit");
                request.setAttribute("errorMessage", errorMessage);
                RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/companyManagement.jsp");
                dispatcher.forward(request, response);
                return;
            }
            
            // 企業を更新
            boolean success = companyService.updateCompany(company);
            
            if (success) {
                response.sendRedirect("CompanyManagementController?action=list&message=企業を正常に更新しました。");
            } else {
                request.setAttribute("company", company);
                request.setAttribute("mode", "edit");
                request.setAttribute("errorMessage", "企業の更新に失敗しました。");
                RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/companyManagement.jsp");
                dispatcher.forward(request, response);
            }
            
        } catch (NumberFormatException e) {
            response.sendRedirect("CompanyManagementController?action=list&message=無効な企業IDです。");
        }
    }
    
    /**
     * 企業を削除
     */
    private void deleteCompany(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String companyIdStr = request.getParameter("id");
        if (companyIdStr == null || companyIdStr.trim().isEmpty()) {
            response.sendRedirect("CompanyManagementController?action=list&message=企業IDが指定されていません。");
            return;
        }
        
        try {
            int companyId = Integer.parseInt(companyIdStr);
            boolean success = companyService.deleteCompany(companyId);
            
            if (success) {
                response.sendRedirect("CompanyManagementController?action=list&message=企業を正常に削除しました。");
            } else {
                response.sendRedirect("CompanyManagementController?action=list&message=企業の削除に失敗しました。");
            }
            
        } catch (NumberFormatException e) {
            response.sendRedirect("CompanyManagementController?action=list&message=無効な企業IDです。");
        }
    }
    
    /**
     * 企業を検索
     */
    private void searchCompanies(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String searchKeyword = request.getParameter("searchKeyword");
        List<CompanyInfoDto> companies = companyService.searchCompaniesByName(searchKeyword);
        
        request.setAttribute("companies", companies);
        request.setAttribute("searchKeyword", searchKeyword);
        request.setAttribute("message", request.getParameter("message"));
        
        RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/companyManagement.jsp");
        dispatcher.forward(request, response);
    }
} 