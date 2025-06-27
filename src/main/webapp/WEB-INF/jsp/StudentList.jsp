<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!--▼▼▼▼▼スコープから取得する情報　これをもとに判定をしていく -->
<% 
  String username = (String) session.getAttribute("username"); 
  String role     = (String) session.getAttribute("role"); 
%>
<!--▲▲▲▲▲-->

<!DOCTYPE html>
<html lang="ja">
<head>
<meta charset="UTF-8">
<title>JMSアプリ - 学生一覧</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="本アプリは就職対策アプリです。">
<link rel="stylesheet" href="css/style.css">

<style>
    /* 学生一覧画面全体 */
    .student-list-page {
        background: #1a1a1a;
        min-height: 100vh;
        position: relative;
        overflow-x: hidden;
    }

    .student-list-page::before {
        content: '';
        position: absolute;
        top: 0;
        left: 0;
        right: 0;
        bottom: 0;
        background: none;
        z-index: 0;
    }

    .student-list-container {
        max-width: 1200px;
        margin: 0 auto;
        padding: 20px;
        position: relative;
        z-index: 1;
        min-height: 100vh;
    }

    /* ページヘッダー */
    .page-header {
        background: rgba(255, 255, 255, 0.95);
        border-radius: 15px;
        padding: 20px;
        margin-bottom: 30px;
        box-shadow: 0 8px 32px rgba(0, 0, 0, 0.1);
        backdrop-filter: blur(10px);
        border: 1px solid rgba(255, 255, 255, 0.2);
        text-align: center;
        position: relative;
        overflow: hidden;
    }

    .page-header::before {
        content: '';
        position: absolute;
        top: 0;
        left: 0;
        right: 0;
        height: 4px;
        background: linear-gradient(45deg, var(--primary-color), #5CA564);
    }

    .page-title {
        font-size: 2.5rem;
        color: var(--primary-color);
        margin-bottom: 10px;
        font-weight: bold;
        text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.1);
        position: relative;
    }

    .page-title::after {
        content: '';
        position: absolute;
        bottom: -8px;
        left: 50%;
        transform: translateX(-50%);
        width: 50px;
        height: 3px;
        background: linear-gradient(45deg, var(--primary-color), #5CA564);
        border-radius: 2px;
    }

    .page-subtitle {
        font-size: 1.1rem;
        color: #666;
        margin-bottom: 20px;
        line-height: 1.6;
    }

    .breadcrumb {
        display: flex;
        justify-content: center;
        align-items: center;
        gap: 10px;
        font-size: 0.9rem;
        color: #888;
        margin-top: 15px;
    }

    .breadcrumb a {
        color: var(--primary-color);
        text-decoration: none;
        transition: all 0.3s ease;
        padding: 5px 12px;
        border-radius: 15px;
        background: rgba(44, 119, 68, 0.1);
    }

    .breadcrumb a:hover {
        color: #5CA564;
        background: rgba(44, 119, 68, 0.2);
        transform: translateY(-2px);
    }

    .breadcrumb .separator {
        color: #ccc;
        font-weight: bold;
    }

    /* 検索・フィルター機能 */
    .search-filter-section {
        background: rgba(255, 255, 255, 0.95);
        border-radius: 15px;
        padding: 25px;
        box-shadow: 0 8px 32px rgba(0, 0, 0, 0.1);
        backdrop-filter: blur(10px);
        border: 1px solid rgba(255, 255, 255, 0.2);
        margin-bottom: 30px;
        position: relative;
        overflow: hidden;
    }

    .search-filter-section::before {
        content: '';
        position: absolute;
        top: 0;
        left: 0;
        right: 0;
        height: 4px;
        background: linear-gradient(45deg, #667eea, #764ba2);
    }

    .search-filter-section h3 {
        font-size: 1.3rem;
        color: var(--primary-color);
        margin-bottom: 20px;
        text-align: center;
        font-weight: bold;
    }

    .search-form {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
        gap: 15px;
        margin-bottom: 20px;
    }

    .form-group {
        display: flex;
        flex-direction: column;
        gap: 5px;
    }

    .form-group label {
        font-weight: bold;
        color: #333;
        font-size: 0.9rem;
    }

    .form-group input,
    .form-group select {
        padding: 10px 15px;
        border: 2px solid #e0e0e0;
        border-radius: 10px;
        font-size: 1rem;
        transition: all 0.3s ease;
        background: white;
    }

    .form-group input:focus,
    .form-group select:focus {
        outline: none;
        border-color: var(--primary-color);
        box-shadow: 0 0 0 3px rgba(44, 119, 68, 0.1);
    }

    .search-buttons {
        display: flex;
        justify-content: center;
        gap: 15px;
        flex-wrap: wrap;
    }

    .search-btn {
        background: linear-gradient(45deg, var(--primary-color), #5CA564);
        color: white;
        padding: 12px 25px;
        border-radius: 25px;
        text-decoration: none;
        font-weight: bold;
        display: inline-flex;
        align-items: center;
        gap: 8px;
        transition: all 0.3s ease;
        border: none;
        cursor: pointer;
        font-size: 1rem;
        box-shadow: 0 5px 15px rgba(44, 119, 68, 0.3);
    }

    .search-btn:hover {
        transform: translateY(-3px);
        box-shadow: 0 10px 25px rgba(44, 119, 68, 0.4);
        color: white;
        text-decoration: none;
    }

    .reset-btn {
        background: linear-gradient(45deg, #667eea, #764ba2);
        color: white;
        padding: 12px 25px;
        border-radius: 25px;
        text-decoration: none;
        font-weight: bold;
        display: inline-flex;
        align-items: center;
        gap: 8px;
        transition: all 0.3s ease;
        border: none;
        cursor: pointer;
        font-size: 1rem;
        box-shadow: 0 5px 15px rgba(102, 126, 234, 0.3);
    }

    .reset-btn:hover {
        transform: translateY(-3px);
        box-shadow: 0 10px 25px rgba(102, 126, 234, 0.4);
        color: white;
        text-decoration: none;
    }

    /* 学生一覧テーブル */
    .student-table-section {
        background: rgba(255, 255, 255, 0.95);
        border-radius: 15px;
        padding: 25px;
        box-shadow: 0 8px 32px rgba(0, 0, 0, 0.1);
        backdrop-filter: blur(10px);
        border: 1px solid rgba(255, 255, 255, 0.2);
        margin-bottom: 30px;
        position: relative;
        overflow: hidden;
    }

    .student-table-section::before {
        content: '';
        position: absolute;
        top: 0;
        left: 0;
        right: 0;
        height: 4px;
        background: linear-gradient(45deg, var(--primary-color), #5CA564);
    }

    .table-header {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-bottom: 20px;
        flex-wrap: wrap;
        gap: 15px;
    }

    .table-title {
        font-size: 1.5rem;
        color: var(--primary-color);
        font-weight: bold;
    }

    .table-actions {
        display: flex;
        gap: 10px;
        flex-wrap: wrap;
    }

    .action-btn {
        background: linear-gradient(45deg, var(--primary-color), #5CA564);
        color: white;
        padding: 8px 15px;
        border-radius: 20px;
        text-decoration: none;
        font-weight: bold;
        display: inline-flex;
        align-items: center;
        gap: 5px;
        transition: all 0.3s ease;
        border: none;
        cursor: pointer;
        font-size: 0.9rem;
        box-shadow: 0 3px 10px rgba(44, 119, 68, 0.3);
    }

    .action-btn:hover {
        transform: translateY(-2px);
        box-shadow: 0 5px 15px rgba(44, 119, 68, 0.4);
        color: white;
        text-decoration: none;
    }

    .action-btn.secondary {
        background: linear-gradient(45deg, #667eea, #764ba2);
        box-shadow: 0 3px 10px rgba(102, 126, 234, 0.3);
    }

    .action-btn.secondary:hover {
        box-shadow: 0 5px 15px rgba(102, 126, 234, 0.4);
    }

    /* テーブルスタイル */
    .student-table {
        width: 100%;
        border-collapse: collapse;
        background: white;
        border-radius: 10px;
        overflow: hidden;
        box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
    }

    .student-table th {
        background: linear-gradient(45deg, var(--primary-color), #5CA564);
        color: white;
        padding: 15px 10px;
        text-align: left;
        font-weight: bold;
        font-size: 0.95rem;
        border: none;
    }

    .student-table td {
        padding: 12px 10px;
        border-bottom: 1px solid #e0e0e0;
        font-size: 0.9rem;
        color: #333;
    }

    .student-table tr:hover {
        background: rgba(44, 119, 68, 0.05);
    }

    .student-table tr:last-child td {
        border-bottom: none;
    }

    .status-badge {
        padding: 4px 8px;
        border-radius: 12px;
        font-size: 0.8rem;
        font-weight: bold;
        text-align: center;
        display: inline-block;
        min-width: 80px;
    }

    .status-active {
        background: rgba(44, 119, 68, 0.2);
        color: var(--primary-color);
    }

    .status-inactive {
        background: rgba(255, 59, 48, 0.2);
        color: #ff3b30;
    }

    .status-pending {
        background: rgba(255, 149, 0, 0.2);
        color: #ff9500;
    }

    /* ページネーション */
    .pagination {
        display: flex;
        justify-content: center;
        align-items: center;
        gap: 10px;
        margin-top: 20px;
        flex-wrap: wrap;
    }

    .pagination a,
    .pagination span {
        padding: 8px 12px;
        border-radius: 8px;
        text-decoration: none;
        font-weight: bold;
        transition: all 0.3s ease;
        border: 2px solid transparent;
    }

    .pagination a {
        background: rgba(44, 119, 68, 0.1);
        color: var(--primary-color);
    }

    .pagination a:hover {
        background: var(--primary-color);
        color: white;
        transform: translateY(-2px);
    }

    .pagination .current {
        background: var(--primary-color);
        color: white;
        border-color: var(--primary-color);
    }

    .pagination .disabled {
        background: #f0f0f0;
        color: #999;
        cursor: not-allowed;
    }

    /* ダッシュボード用ヘッダー調整 */
    .student-list-page header {
        position: relative;
        background: rgba(255, 255, 255, 0.95);
        backdrop-filter: blur(10px);
        border-bottom: 1px solid rgba(0, 0, 0, 0.1);
    }

    .student-list-page #mainimg {
        display: none;
    }

    .student-list-page main {
        margin-top: 0;
    }

    /* テキストスライドショー用の調整 */
    .student-list-page .text-slide-wrapper {
        margin-top: 0;
        margin-bottom: 0;
        background: rgba(0, 0, 0, 0.3);
        backdrop-filter: blur(10px);
    }

    .student-list-page .text-slide {
        background: linear-gradient(45deg, var(--primary-color), #5CA564);
        color: white;
        padding: 15px 0;
        text-align: center;
        font-weight: bold;
        font-size: 1.2rem;
        letter-spacing: 0.1em;
        text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.3);
        position: relative;
        overflow: hidden;
    }

    .student-list-page .text-slide::before {
        content: '';
        position: absolute;
        top: 0;
        left: -100%;
        width: 100%;
        height: 100%;
        background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.2), transparent);
        animation: slide 3s infinite;
    }

    @keyframes slide {
        0% { left: -100%; }
        50% { left: 100%; }
        100% { left: 100%; }
    }

    /* レスポンシブ対応 */
    @media (max-width: 768px) {
        .search-form {
            grid-template-columns: 1fr;
        }
        
        .table-header {
            flex-direction: column;
            align-items: stretch;
        }
        
        .student-table {
            font-size: 0.8rem;
        }
        
        .student-table th,
        .student-table td {
            padding: 8px 5px;
        }
    }
</style>

</head>
<body class="student-list-page">
<% 
  // 権限名を日本語に変換
  String roleDisplay = "";
  switch(role) {
    case "teacher": roleDisplay = "教員"; break;
    case "headmaster": roleDisplay = "教務部長・校長"; break;
    case "egd": roleDisplay = "就職指導部"; break;
    case "admin": roleDisplay = "システム管理者"; break;
    case "student": roleDisplay = "学生"; break;
    default: roleDisplay = role; break;
  }
%>

<div id="container">
    <!--▼▼▼▼▼ここから「ヘッダー」-->
    <header>
        <h1 id="logo"><a href="javascript:void(0);" onclick="location.reload();"><img src="images/logo.png" alt="jms"></a></h1>
        <nav>
            <ul>
                <li><a href="javascript:void(0);" onclick="location.reload();">ホーム</a></li>
                <!-- 権限に応じた機能リンク -->
                <% if ("teacher".equals(role) || "headmaster".equals(role) || "admin".equals(role)) { %>
                    <li><a href="${pageContext.request.contextPath}/StatusServlet?view=studentManagement">学生管理</a></li>
                <% } %>
                <% if ("egd".equals(role) || "admin".equals(role)) { %>
                    <li><a href="${pageContext.request.contextPath}/StatusServlet?view=CompanyManagement">企業管理</a></li>
                <% } %>
                <% if ("teacher".equals(role) || "headmaster".equals(role) || "egd".equals(role) || "admin".equals(role) || "student".equals(role)) { %>
                    <li><a href="${pageContext.request.contextPath}/StatusServlet?view=jobHunting">就職管理</a></li>
                <% } %>
                <% if ("teacher".equals(role) || "headmaster".equals(role) || "egd".equals(role) || "admin".equals(role)) { %>
                    <li><a href="${pageContext.request.contextPath}/StatusServlet?view=applicantList">受験者一覧</a></li>
                <% } %>
                <% if ("admin".equals(role)) { %>
                    <li><a href="${pageContext.request.contextPath}/StatusServlet?view=adminDatabase.jsp">システム管理</a></li>
                <% } %>
                <li><a href="extension.html">お問い合わせ</a></li>
                <% if (username != null) { %>
                    <li><a href="${pageContext.request.contextPath}/LogoutServlet">ログアウト</a></li>
                <% } %>
            </ul>
        </nav>
    </header>
    <!--▲▲▲▲▲ここまで「ヘッダー」-->

    <main>
        <div class="student-list-container">
            <!-- ページヘッダー -->
            <div class="page-header">
                <h1 class="page-title">学生一覧</h1>
                <p class="page-subtitle">登録されている学生の一覧を表示し、詳細情報の確認や編集を行えます</p>
                <div class="breadcrumb">
                    <a href="javascript:void(0);" onclick="location.reload();">ダッシュボード</a>
                    <span class="separator">/</span>
                    <a href="${pageContext.request.contextPath}/StatusServlet?view=studentManagement">学生管理</a>
                    <span class="separator">/</span>
                    <span>学生一覧</span>
                </div>
            </div>

            <!-- 検索・フィルター機能 -->
            <div class="search-filter-section">
                <h3>🔍 検索・フィルター</h3>
                <form class="search-form" method="GET" action="${pageContext.request.contextPath}/StudentSearchServlet">
                    <div class="form-group">
                        <label for="studentName">学生氏名</label>
                        <input type="text" id="studentName" name="studentName" placeholder="氏名を入力">
                    </div>
                    <div class="form-group">
                        <label for="studentId">学生番号</label>
                        <input type="text" id="studentId" name="studentId" placeholder="学生番号を入力">
                    </div>
                    <div class="form-group">
                        <label for="department">学科</label>
                        <select id="department" name="department">
                            <option value="">すべての学科</option>
                            <option value="情報システム科">情報システム科</option>
                            <option value="情報デザイン科">情報デザイン科</option>
                            <option value="情報ビジネス科">情報ビジネス科</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label for="status">就職状況</label>
                        <select id="status" name="status">
                            <option value="">すべて</option>
                            <option value="active">就職活動中</option>
                            <option value="inactive">未活動</option>
                            <option value="pending">内定待ち</option>
                        </select>
                    </div>
                    <div class="search-buttons">
                        <button type="submit" class="search-btn">
                            <i class="fas fa-search"></i>検索
                        </button>
                        <button type="reset" class="reset-btn">
                            <i class="fas fa-undo"></i>リセット
                        </button>
                    </div>
                </form>
            </div>

            <!-- 学生一覧テーブル -->
            <div class="student-table-section">
                <div class="table-header">
                    <h3 class="table-title">📋 学生一覧</h3>
                    <div class="table-actions">
                        <a href="${pageContext.request.contextPath}/StatusServlet?view=createStudent" class="action-btn">
                            <i class="fas fa-plus"></i>新規登録
                        </a>
                        <a href="${pageContext.request.contextPath}/StudentExportServlet" class="action-btn secondary">
                            <i class="fas fa-download"></i>エクスポート
                        </a>
                    </div>
                </div>

                <table class="student-table">
                    <thead>
                        <tr>
                            <th>学生番号</th>
                            <th>氏名</th>
                            <th>学科</th>
                            <th>学年</th>
                            <th>就職状況</th>
                            <th>最終更新日</th>
                            <th>操作</th>
                        </tr>
                    </thead>
                    <tbody>
                        <!-- サンプルデータ -->
                        <tr>
                            <td>2024001</td>
                            <td>田中 太郎</td>
                            <td>情報システム科</td>
                            <td>3年</td>
                            <td><span class="status-badge status-active">就職活動中</span></td>
                            <td>2024-01-15</td>
                            <td>
                                <a href="${pageContext.request.contextPath}/StudentDetailServlet?id=2024001" class="action-btn">
                                    <i class="fas fa-eye"></i>詳細
                                </a>
                            </td>
                        </tr>
                        <tr>
                            <td>2024002</td>
                            <td>佐藤 花子</td>
                            <td>情報デザイン科</td>
                            <td>3年</td>
                            <td><span class="status-badge status-pending">内定待ち</span></td>
                            <td>2024-01-14</td>
                            <td>
                                <a href="${pageContext.request.contextPath}/StudentDetailServlet?id=2024002" class="action-btn">
                                    <i class="fas fa-eye"></i>詳細
                                </a>
                            </td>
                        </tr>
                        <tr>
                            <td>2024003</td>
                            <td>鈴木 次郎</td>
                            <td>情報ビジネス科</td>
                            <td>2年</td>
                            <td><span class="status-badge status-inactive">未活動</span></td>
                            <td>2024-01-13</td>
                            <td>
                                <a href="${pageContext.request.contextPath}/StudentDetailServlet?id=2024003" class="action-btn">
                                    <i class="fas fa-eye"></i>詳細
                                </a>
                            </td>
                        </tr>
                        <tr>
                            <td>2024004</td>
                            <td>高橋 美咲</td>
                            <td>情報システム科</td>
                            <td>3年</td>
                            <td><span class="status-badge status-active">就職活動中</span></td>
                            <td>2024-01-12</td>
                            <td>
                                <a href="${pageContext.request.contextPath}/StudentDetailServlet?id=2024004" class="action-btn">
                                    <i class="fas fa-eye"></i>詳細
                                </a>
                            </td>
                        </tr>
                        <tr>
                            <td>2024005</td>
                            <td>伊藤 健太</td>
                            <td>情報デザイン科</td>
                            <td>3年</td>
                            <td><span class="status-badge status-pending">内定待ち</span></td>
                            <td>2024-01-11</td>
                            <td>
                                <a href="${pageContext.request.contextPath}/StudentDetailServlet?id=2024005" class="action-btn">
                                    <i class="fas fa-eye"></i>詳細
                                </a>
                            </td>
                        </tr>
                    </tbody>
                </table>

                <!-- ページネーション -->
                <div class="pagination">
                    <a href="?page=1" class="disabled">&laquo; 最初</a>
                    <a href="?page=1" class="disabled">&lsaquo; 前へ</a>
                    <span class="current">1</span>
                    <a href="?page=2">2</a>
                    <a href="?page=3">3</a>
                    <a href="?page=2">次へ &rsaquo;</a>
                    <a href="?page=10">最後 &raquo;</a>
                </div>
            </div>
        </div>
    </main>

    <!--▼▼▼▼▼ここから「テキストスライドショー」-->
    <div class="text-slide-wrapper">
        <div class="text-slide">
            <span>Student List Management</span>
        </div>
    </div>
    <!--▲▲▲▲▲ここまで「テキストスライドショー」-->

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
        <div>
            <ul>
                <li><a href="javascript:void(0);" onclick="location.reload();">ホーム</a></li>
                <!-- 権限に応じた機能リンク -->
                <% if ("teacher".equals(role) || "headmaster".equals(role) || "admin".equals(role)) { %>
                    <li><a href="${pageContext.request.contextPath}/StatusServlet?view=studentManagement">学生管理</a></li>
                <% } %>
                <% if ("egd".equals(role) || "admin".equals(role)) { %>
                    <li><a href="${pageContext.request.contextPath}/StatusServlet?view=CompanyManagement">企業管理</a></li>
                <% } %>
                <% if ("teacher".equals(role) || "headmaster".equals(role) || "egd".equals(role) || "admin".equals(role) || "student".equals(role)) { %>
                    <li><a href="${pageContext.request.contextPath}/StatusServlet?view=jobHunting">就職管理</a></li>
                <% } %>
                <% if ("teacher".equals(role) || "headmaster".equals(role) || "egd".equals(role) || "admin".equals(role)) { %>
                    <li><a href="${pageContext.request.contextPath}/StatusServlet?view=applicantList">受験者一覧</a></li>
                <% } %>
                <% if ("admin".equals(role)) { %>
                    <li><a href="${pageContext.request.contextPath}/StatusServlet?view=adminDatabase.jsp">システム管理</a></li>
                <% } %>
                <li><a href="extension.html">お問い合わせ</a></li>
            </ul>
        </div>
    </footer>
    <!--▲▲▲▲▲ここまで「フッター」-->

    <!--▼▼最下部-->
    <span class="pr"><a href="" target="_blank">@ 2025 Job Management System</a></span>
    <!--▲▲ここまで最下部-->
</div>
<!--/#container-->

<!--ローディング-->
<div id="loading">
    <img src="images/logo.png" alt="Loading">
    <div class="progress-container">
        <div class="progress-bar"></div>
    </div>
</div>

<!--開閉ボタン（ハンバーガーアイコン）-->
<div id="menubar_hdr">
    <span></span><span></span><span></span>
</div>

<!--開閉ブロック-->
<div id="menubar">
    <p class="logo"><img src="images/logo.png" alt="Job Management System"></p>
    <nav>
        <ul>
            <li><a href="javascript:void(0);" onclick="location.reload();">ホーム</a></li>
            <!-- 権限に応じた機能リンク -->
            <% if ("teacher".equals(role) || "headmaster".equals(role) || "admin".equals(role)) { %>
                <li><a href="${pageContext.request.contextPath}/StatusServlet?view=studentManagement">学生管理</a></li>
            <% } %>
            <% if ("egd".equals(role) || "admin".equals(role)) { %>
                <li><a href="${pageContext.request.contextPath}/StatusServlet?view=CompanyManagement">企業管理</a></li>
            <% } %>
            <% if ("teacher".equals(role) || "headmaster".equals(role) || "egd".equals(role) || "admin".equals(role) || "student".equals(role)) { %>
                <li><a href="${pageContext.request.contextPath}/StatusServlet?view=jobHunting">就職管理</a></li>
            <% } %>
            <% if ("teacher".equals(role) || "headmaster".equals(role) || "egd".equals(role) || "admin".equals(role)) { %>
                <li><a href="${pageContext.request.contextPath}/StatusServlet?view=applicantList">受験者一覧</a></li>
            <% } %>
            <% if ("admin".equals(role)) { %>
                <li><a href="${pageContext.request.contextPath}/StatusServlet?view=adminDatabase.jsp">システム管理</a></li>
            <% } %>
            <li><a href="extension.html">お問い合わせ</a></li>
            <% if (username != null) { %>
                <li><a href="${pageContext.request.contextPath}/LogoutServlet">ログアウト</a></li>
            <% } %>
        </ul>
    </nav>
</div>
<!--/#menubar-->

<!--jQueryの読み込み-->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<!--パララックス（inview）-->
<script src="https://cdnjs.cloudflare.com/ajax/libs/protonet-jquery.inview/1.1.2/jquery.inview.min.js"></script>
<script src="js/jquery.inview_set.js"></script>
<!--このテンプレート専用のスクリプト-->
<script src="js/main.js"></script>

</body>
</html> 