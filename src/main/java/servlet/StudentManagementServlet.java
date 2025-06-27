package servlet;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import dao.DropdownDataDAO;

/**
 * Servlet implementation class StudentManagementServlet
 */

public class StudentManagementServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public StudentManagementServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// セッションから権限を取得
        HttpSession session = request.getSession();
        String role = (String) session.getAttribute("role");
        
        // 権限チェック
        if (role == null || 
            (!"teacher".equals(role) && 
             !"headmaster".equals(role) && 
             !"admin".equals(role))) {
            response.sendRedirect("login.html");
            return;
        }
        
        try {
            DropdownDataDAO dao = new DropdownDataDAO();
            List<String> classes = dao.getClasses();
            List<String> statuses = dao.getEnrollmentStatuses();
            List<String> mediations = dao.getMediationStatuses();
            List<String> industries = dao.getIndustries();
            List<Integer> years = dao.getGraduationYears();

            // JSPファイルが期待する属性名で設定
            request.setAttribute("classList", classes);
            request.setAttribute("enrollmentStatusList", statuses);
            request.setAttribute("assistanceList", mediations);
            request.setAttribute("firstChoiceIndustryList", industries);
            request.setAttribute("graduationYearList", years);
        } catch (Exception e) {
            // データベースエラーが発生した場合の処理
            System.err.println("StudentManagementServlet Error: " + e.getMessage());
            e.printStackTrace();
            
            // 空のリストを設定してエラーを回避
            request.setAttribute("classList", new ArrayList<String>());
            request.setAttribute("enrollmentStatusList", new ArrayList<String>());
            request.setAttribute("assistanceList", new ArrayList<String>());
            request.setAttribute("firstChoiceIndustryList", new ArrayList<String>());
            request.setAttribute("graduationYearList", new ArrayList<Integer>());
            
            // エラーメッセージを設定
            request.setAttribute("errorMessage", "データの取得中にエラーが発生しました: " + e.getMessage());
        }

        RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/StudentManagement.jsp");
        dispatcher.forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
} 