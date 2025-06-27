<!--*
：：：色のテーマは緑：：：
書類提出チェック画面

******教師専用ページ****
******権限チェック付き****

**

*-->

<!--▼▼▼▼▼スコープから取得する情報　これをもとに判定をしていく -->
<% 
  String username = (String) session.getAttribute("username"); 
  String role     = (String) session.getAttribute("role"); 
%>
<!--▲▲▲▲▲-->

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ja">
<head>
<meta charset="UTF-8">
<title>書類提出チェック - JMSアプリ</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="本アプリは就職対策アプリです。">
<link rel="stylesheet" href="css/style.css">
<style>
.document-check-container {
    max-width: 1200px;
    margin: 0 auto;
    padding: 20px;
}

.search-section {
    background: #f5f5f5;
    padding: 20px;
    border-radius: 8px;
    margin-bottom: 20px;
}

.search-form {
    display: flex;
    gap: 15px;
    align-items: center;
    flex-wrap: wrap;
}

.search-form input[type="text"],
.search-form select {
    padding: 8px 12px;
    border: 1px solid #ddd;
    border-radius: 4px;
    font-size: 14px;
}

.search-form button {
    background: #4CAF50;
    color: white;
    padding: 8px 16px;
    border: none;
    border-radius: 4px;
    cursor: pointer;
    font-size: 14px;
}

.search-form button:hover {
    background: #45a049;
}

.document-table {
    width: 100%;
    border-collapse: collapse;
    margin-top: 20px;
    background: white;
    box-shadow: 0 2px 4px rgba(0,0,0,0.1);
}

.document-table th,
.document-table td {
    padding: 12px;
    text-align: left;
    border-bottom: 1px solid #ddd;
}

.document-table th {
    background: #4CAF50;
    color: white;
    font-weight: bold;
}

.document-table tr:hover {
    background: #f9f9f9;
}

.status-badge {
    padding: 4px 8px;
    border-radius: 12px;
    font-size: 12px;
    font-weight: bold;
    text-align: center;
    display: inline-block;
    min-width: 80px;
}

.status-submitted {
    background: #4CAF50;
    color: white;
}

.status-unsubmitted {
    background: #f44336;
    color: white;
}

.status-checked {
    background: #2196F3;
    color: white;
}

.comment-section {
    margin-top: 10px;
}

.comment-textarea {
    width: 100%;
    min-height: 60px;
    padding: 8px;
    border: 1px solid #ddd;
    border-radius: 4px;
    resize: vertical;
}

.update-button {
    background: #4CAF50;
    color: white;
    padding: 6px 12px;
    border: none;
    border-radius: 4px;
    cursor: pointer;
    font-size: 12px;
    margin-top: 5px;
}

.update-button:hover {
    background: #45a049;
}

.add-document-section {
    background: #e8f5e8;
    padding: 20px;
    border-radius: 8px;
    margin-bottom: 20px;
}

.add-document-form {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
    gap: 15px;
    align-items: end;
}

.add-document-form input,
.add-document-form select {
    padding: 8px 12px;
    border: 1px solid #ddd;
    border-radius: 4px;
    font-size: 14px;
}

.add-document-form button {
    background: #4CAF50;
    color: white;
    padding: 10px 20px;
    border: none;
    border-radius: 4px;
    cursor: pointer;
    font-size: 14px;
    font-weight: bold;
}

.add-document-form button:hover {
    background: #45a049;
}

.message {
    padding: 10px;
    border-radius: 4px;
    margin-bottom: 20px;
}

.success-message {
    background: #d4edda;
    color: #155724;
    border: 1px solid #c3e6cb;
}

.error-message {
    background: #f8d7da;
    color: #721c24;
    border: 1px solid #f5c6cb;
}

.no-data {
    text-align: center;
    padding: 40px;
    color: #666;
    font-style: italic;
}
</style>
</head>

<body>
<div id="container">

<!--▼▼▼▼▼ここから「ヘッダー」-->
<header>
<h1 id="logo"><a href="index.html"><img src="images/logo.png" alt="jms"></a></h1>

<nav>
<ul>
<% if (username != null) { %>
    <li>こんにちは、<%= username %>さん</li>
    <li><%= username %>さんの権限は<%= role %>です</li>
<% } else { %>
    <li><a href="login.html">ログイン</a></li>
<% } %>

<!--* 画面：学生管理画面
    許可されている権限：
    ・教員：teacher
    ・校長・教務部長：headmaster
    ・システム管理者：admin
    ▼▼▼▼
*-->
<% if ("teacher".equals(role) 
       || "headmaster".equals(role) 
       || "admin".equals(role)) { %>
  <li>
    <a href="StatusServlet?view=studentManagement">
      📚 学生管理画面
    </a>
  </li>
<% } %>

<!--* 画面：企業管理画面
許可されている権限：
・就職指導部：egd
・システム管理者：admin
▼▼▼▼
*-->
<% if ("egd".equals(role) 
       || "admin".equals(role)) { %>
  <li>
    <a href="StatusServlet?view=CompanyManagement">
      🏢 企業管理画面
    </a>
  </li>
<% } %>

<!--* 画面：就職管理画面
許可されている権限：
・教員：teacher
・校長・教務部長：headmaster
・就職指導部：egd
・システム管理者：admin
・学生： student
▼▼▼▼
*-->
<% if ("teacher".equals(role) 
       || "headmaster".equals(role) 
       || "egd".equals(role) 
       || "admin".equals(role) 
       || "student".equals(role)) { %>
  <li>
    <a href="StatusServlet?view=jobHunting">
      📄 就職管理画面
    </a>
  </li>
<% } %>

<!--* 画面：受験者一覧画面
許可されている権限：
・教員：teacher
・校長・教務部長：headmaster
・就職指導部：egd
・システム管理者：admin
▼▼▼▼
*-->
<% if ("teacher".equals(role) 
       || "headmaster".equals(role) 
       || "egd".equals(role) 
       || "admin".equals(role)) { %>
  <li>
    <a href="StatusServlet?view=applicantList">
      📊 受験者一覧画面
    </a>
  </li>
<% } %>

<!--* 画面：書類提出チェック画面
許可されている権限：
・教員：teacher
・校長・教務部長：headmaster
・システム管理者：admin
▼▼▼▼
*-->
<% if ("teacher".equals(role) 
       || "headmaster".equals(role) 
       || "admin".equals(role)) { %>
  <li>
    <a href="DocumentSubmissionCheckController">
      📋 書類提出チェック画面
    </a>
  </li>
<% } %>

<!--* 画面：管理者DB
許可されている権限：
・システム管理者：admin
▼▼▼▼
*-->
<% if ("admin".equals(role)) { %>
  <li>
    <a href="StatusServlet?view=adminDatabase.jsp">
      🛠 管理者DB
    </a>
  </li>
<% } %>

<%-- 想定外の role／未定義の権限チェック --%>
<% if (username != null
       && !("teacher".equals(role)
         || "headmaster".equals(role)
         || "egd".equals(role)
         || "admin".equals(role)
         || "student".equals(role))) { %>
  <li>アクセスできません</li>
<% } %>

<%-- ログアウト --%>
<% if (username != null) { %>
  <li><a href="LogoutServlet">ログアウト</a></li>
<% } %>
</ul>
</nav>
</header>
<!--▲▲▲▲▲ここまで「ヘッダー」-->

<section class="bg1 bg-pattern1 arrow"></section>

<div class="document-check-container">
    <h1>📋 書類提出チェック画面</h1>
    
    <!-- メッセージ表示 -->
    <c:if test="${not empty successMessage}">
        <div class="message success-message">${successMessage}</div>
    </c:if>
    <c:if test="${not empty errorMessage}">
        <div class="message error-message">${errorMessage}</div>
    </c:if>
    
    <!-- 検索・フィルター機能 -->
    <div class="search-section">
        <h3>🔍 検索・フィルター</h3>
        <form class="search-form" method="get" action="DocumentSubmissionCheckController">
            <div>
                <label for="searchStudentName">学生名：</label>
                <input type="text" id="searchStudentName" name="searchStudentName" 
                       value="${searchStudentName}" placeholder="学生名を入力">
            </div>
            <div>
                <label for="filterStatus">提出状況：</label>
                <select id="filterStatus" name="filterStatus">
                    <option value="all" ${filterStatus == 'all' ? 'selected' : ''}>すべて</option>
                    <option value="未提出" ${filterStatus == '未提出' ? 'selected' : ''}>未提出</option>
                    <option value="提出済み" ${filterStatus == '提出済み' ? 'selected' : ''}>提出済み</option>
                    <option value="チェック済み" ${filterStatus == 'チェック済み' ? 'selected' : ''}>チェック済み</option>
                </select>
            </div>
            <button type="submit">検索</button>
            <a href="DocumentSubmissionCheckController" class="update-button">リセット</a>
        </form>
    </div>
    
    <!-- 新規書類提出状況追加 -->
    <div class="add-document-section">
        <h3>➕ 新規書類提出状況追加</h3>
        <form class="add-document-form" method="post" action="DocumentSubmissionCheckController">
            <input type="hidden" name="action" value="add">
            <div>
                <label for="studentId">学籍番号：</label>
                <input type="text" id="studentId" name="studentId" required>
            </div>
            <div>
                <label for="studentName">学生名：</label>
                <input type="text" id="studentName" name="studentName" required>
            </div>
            <div>
                <label for="documentType">書類種別：</label>
                <select id="documentType" name="documentType" required>
                    <option value="">選択してください</option>
                    <c:forEach var="docType" items="${documentTypes}">
                        <option value="${docType}">${docType}</option>
                    </c:forEach>
                </select>
            </div>
            <div>
                <label for="companyName">企業名：</label>
                <input type="text" id="companyName" name="companyName">
            </div>
            <div>
                <label for="submissionStatus">提出状況：</label>
                <select id="submissionStatus" name="submissionStatus" required>
                    <option value="未提出">未提出</option>
                    <option value="提出済み">提出済み</option>
                    <option value="チェック済み">チェック済み</option>
                </select>
            </div>
            <div>
                <label for="teacherComment">教師コメント：</label>
                <textarea id="teacherComment" name="teacherComment" rows="2"></textarea>
            </div>
            <div>
                <button type="submit">追加</button>
            </div>
        </form>
    </div>
    
    <!-- 書類提出状況一覧 -->
    <div class="document-list-section">
        <h3>📋 書類提出状況一覧</h3>
        
        <c:choose>
            <c:when test="${empty submissions}">
                <div class="no-data">
                    書類提出状況のデータがありません。
                </div>
            </c:when>
            <c:otherwise>
                <table class="document-table">
                    <thead>
                        <tr>
                            <th>学籍番号</th>
                            <th>学生名</th>
                            <th>書類種別</th>
                            <th>企業名</th>
                            <th>提出日</th>
                            <th>提出状況</th>
                            <th>教師コメント</th>
                            <th>チェック者</th>
                            <th>チェック日時</th>
                            <th>操作</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="submission" items="${submissions}">
                            <tr>
                                <td>${submission.studentId}</td>
                                <td>${submission.studentName}</td>
                                <td>${submission.documentType}</td>
                                <td>${submission.companyName}</td>
                                <td>${submission.submissionDate}</td>
                                <td>
                                    <span class="status-badge 
                                        <c:choose>
                                            <c:when test="${submission.submissionStatus == '提出済み'}">status-submitted</c:when>
                                            <c:when test="${submission.submissionStatus == '未提出'}">status-unsubmitted</c:when>
                                            <c:when test="${submission.submissionStatus == 'チェック済み'}">status-checked</c:when>
                                        </c:choose>">
                                        ${submission.submissionStatus}
                                    </span>
                                </td>
                                <td>
                                    <form method="post" action="DocumentSubmissionCheckController" class="comment-section">
                                        <input type="hidden" name="action" value="update">
                                        <input type="hidden" name="submissionId" value="${submission.id}">
                                        <textarea name="teacherComment" class="comment-textarea" 
                                                  placeholder="コメントを入力してください">${submission.teacherComment}</textarea>
                                        <button type="submit" class="update-button">更新</button>
                                    </form>
                                </td>
                                <td>${submission.checkedBy}</td>
                                <td>${submission.checkedAt}</td>
                                <td>
                                    <c:if test="${not empty submission.documentFilePath}">
                                        <a href="${submission.documentFilePath}" target="_blank" class="update-button">ファイル確認</a>
                                    </c:if>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </c:otherwise>
        </c:choose>
    </div>
</div>

<!--▼▼▼▼▼ここから「フッター」-->
<footer>
<div>
<p class="logo"><img src="images/logo.png" alt="Job Management System"></p>
<ul class="icons">
<li><a href="#"><i class="fa-brands fa-x-twitter"></i></a></li>
<li><a href="#"><i class="fab fa-line"></i></a></li>
<li><a href="#"><i class="fab fa-youtube"></i></a></li>
<li><a href="#"><i class="fab fa-instagram"></i></a></li>
</ul>

<small>Copyright&copy; @ 2025 Job Management System All Rights Reserved.</small>
</div>
</footer>
<!--▲▲▲▲▲ここまで「フッター」-->

</div>
<!--/#container-->

<!--ローディング-->
<div id="loading">
<img src="images/logo.png" alt="Loading">
<div class="progress-container">
<div class="progress-bar"></div>
</div>
</div>

<!--開閉ボタン（ハンバーガーアイコン）【画面右上部分のハンバーガー】-->
<div id="menubar_hdr">
<span></span><span></span><span></span>
</div>
<!--開閉ブロック-->
<div id="menubar">
<p class="logo"><img src="images/logo.png" alt="Job Management System"></p>
<nav>
<ul>
<%-- ユーザ名・権限表示 --%>
<% if (username != null) { %>
  <li>こんにちは、<%= username %>さん</li>
  <li><%= username %>さんの権限は<%= role %>です</li>
<% } else { %>
  <li><a href="login.html">ログイン</a></li>
<% } %>

<!--* 画面：学生管理画面
許可されている権限：
・教員：teacher
・校長・教務部長：headmaster
・システム管理者：admin
▼▼▼▼
*-->
<% if ("teacher".equals(role) 
       || "headmaster".equals(role) 
       || "admin".equals(role)) { %>
  <li>
    <a href="StatusServlet?view=studentManagement">
      📚 学生管理画面
    </a>
  </li>
<% } %>

<!--* 画面：企業管理画面
許可されている権限：
・就職指導部：egd
・システム管理者：admin
▼▼▼▼
*-->
<% if ("egd".equals(role) 
       || "admin".equals(role)) { %>
  <li>
    <a href="StatusServlet?view=CompanyManagement">
      🏢 企業管理画面
    </a>
  </li>
<% } %>

<!--* 画面：就職管理画面
許可されている権限：
・教員：teacher
・校長・教務部長：headmaster
・就職指導部：egd
・システム管理者：admin
・学生： student
▼▼▼▼
*-->
<% if ("teacher".equals(role) 
       || "headmaster".equals(role) 
       || "egd".equals(role) 
       || "admin".equals(role) 
       || "student".equals(role)) { %>
  <li>
    <a href="StatusServlet?view=jobHunting">
      📄 就職管理画面
    </a>
  </li>
<% } %>

<!--* 画面：受験者一覧画面
許可されている権限：
・教員：teacher
・校長・教務部長：headmaster
・就職指導部：egd
・システム管理者：admin
▼▼▼▼
*-->
<% if ("teacher".equals(role) 
       || "headmaster".equals(role) 
       || "egd".equals(role) 
       || "admin".equals(role)) { %>
  <li>
    <a href="StatusServlet?view=applicantList">
      📊 受験者一覧画面
    </a>
  </li>
<% } %>

<!--* 画面：書類提出チェック画面
許可されている権限：
・教員：teacher
・校長・教務部長：headmaster
・システム管理者：admin
▼▼▼▼
*-->
<% if ("teacher".equals(role) 
       || "headmaster".equals(role) 
       || "admin".equals(role)) { %>
  <li>
    <a href="DocumentSubmissionCheckController">
      📋 書類提出チェック画面
    </a>
  </li>
<% } %>

<!--* 画面：管理者DB
許可されている権限：
・システム管理者：admin
▼▼▼▼
*-->
<% if ("admin".equals(role)) { %>
  <li>
    <a href="StatusServlet?view=adminDatabase.jsp">
      🛠 管理者DB
    </a>
  </li>
<% } %>

<%-- 想定外の role／未定義の権限チェック --%>
<% if (username != null
       && !("teacher".equals(role)
         || "headmaster".equals(role)
         || "egd".equals(role)
         || "admin".equals(role)
         || "student".equals(role))) { %>
  <li>アクセスできません</li>
<% } %>

<%-- ログアウト --%>
<% if (username != null) { %>
  <li><a href="LogoutServlet">ログアウト</a></li>
<% } %>
</ul>
</nav>
</div>
<!--/#menubar-->

<!--jQueryの読み込み-->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script src="js/main.js"></script>

</body>
</html> 