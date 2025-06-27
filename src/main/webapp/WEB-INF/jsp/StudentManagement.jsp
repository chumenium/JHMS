<!--*
：：：色のテーマは緑：：：
学生管理画面


**********

<!--* 画面：学生管理画面
        	
許可されている権限：
・教員：teacher
・校長・教務部長：headmaster
・システム管理者：admin
 
▼▼▼▼
*-->


<!--確認まだ-->

<!--KCS_JMS_PROJECT-->


<!-- 学生管理画面用 -->

<!-- バックエンドとの接続のやり取りがあるためいったん放置 -->


<!--▼▼▼▼▼スコープから取得する情報　これをもとに判定をしていく -->
<% 
  String username = (String) session.getAttribute("username"); 
  String role     = (String) session.getAttribute("role"); 
  
  // リクエストスコープからプルダウン用データを取得
  java.util.List<String> classList = (java.util.List<String>) request.getAttribute("classList");
  java.util.List<String> enrollmentStatusList = (java.util.List<String>) request.getAttribute("enrollmentStatusList");
  java.util.List<String> assistanceList = (java.util.List<String>) request.getAttribute("assistanceList");
  java.util.List<String> firstChoiceIndustryList = (java.util.List<String>) request.getAttribute("firstChoiceIndustryList");
  java.util.List<Integer> graduationYearList = (java.util.List<Integer>) request.getAttribute("graduationYearList");
  
  // エラーメッセージを取得
  String errorMessage = (String) request.getAttribute("errorMessage");
%>
<!--▲▲▲▲▲-->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ja">
<head>
<meta charset="UTF-8">
<title>JMSアプリ - 学生管理</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="本アプリは就職対策アプリです。">
<link rel="stylesheet" href="css/style.css">

<style>
    /* 学生管理画面全体 */
    .student-management-container {
        max-width: 1200px;
        margin: 0 auto;
        padding: 20px;
        min-height: 100vh;
    }

    /* ページヘッダー */
    .page-header {
        background: rgba(255, 255, 255, 0.95);
        border-radius: 15px;
        padding: 30px;
        margin-bottom: 40px;
        box-shadow: 0 8px 32px rgba(0, 0, 0, 0.1);
        backdrop-filter: blur(10px);
        border: 1px solid rgba(255, 255, 255, 0.2);
        text-align: center;
    }

    .page-title {
        font-size: 2.5rem;
        color: #2C7744;
        margin-bottom: 10px;
        font-weight: bold;
    }

    .page-subtitle {
        font-size: 1.1rem;
        color: #666;
        margin-bottom: 20px;
    }

    .breadcrumb {
        display: flex;
        justify-content: center;
        align-items: center;
        gap: 10px;
        font-size: 0.9rem;
        color: #888;
    }

    .breadcrumb a {
        color: #2C7744;
        text-decoration: none;
        transition: color 0.3s ease;
    }

    .breadcrumb a:hover {
        color: #5CA564;
    }

    .breadcrumb .separator {
        color: #ccc;
    }

    /* メインコンテンツ */
    .management-main {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(350px, 1fr));
        gap: 30px;
        margin-bottom: 40px;
    }

    /* 機能カード */
    .management-card {
        background: rgba(255, 255, 255, 0.95);
        border-radius: 20px;
        padding: 40px 30px;
        box-shadow: 0 8px 32px rgba(0, 0, 0, 0.1);
        backdrop-filter: blur(10px);
        border: 1px solid rgba(255, 255, 255, 0.2);
        transition: all 0.3s ease;
        position: relative;
        overflow: hidden;
        text-align: center;
    }

    .management-card::before {
        content: '';
        position: absolute;
        top: 0;
        left: 0;
        right: 0;
        height: 5px;
        background: linear-gradient(45deg, #2C7744, #5CA564);
    }

    .management-card:hover {
        transform: translateY(-8px);
        box-shadow: 0 20px 50px rgba(0, 0, 0, 0.15);
    }

    .card-icon {
        font-size: 4rem;
        margin-bottom: 20px;
        display: block;
        background: linear-gradient(45deg, #2C7744, #5CA564);
        -webkit-background-clip: text;
        -webkit-text-fill-color: transparent;
        background-clip: text;
    }

    .card-title {
        font-size: 1.5rem;
        font-weight: bold;
        color: #333;
        margin-bottom: 15px;
    }

    .card-description {
        color: #666;
        margin-bottom: 25px;
        line-height: 1.6;
    }

    .card-stats {
        display: flex;
        justify-content: space-around;
        margin-bottom: 25px;
        padding: 15px;
        background: rgba(44, 119, 68, 0.05);
        border-radius: 10px;
    }

    .stat-item {
        text-align: center;
    }

    .stat-number {
        font-size: 1.8rem;
        font-weight: bold;
        color: #2C7744;
        display: block;
    }

    .stat-label {
        font-size: 0.9rem;
        color: #666;
        margin-top: 5px;
    }

    .card-link {
        background: linear-gradient(45deg, #2C7744, #5CA564);
        color: white;
        padding: 15px 30px;
        border-radius: 25px;
        text-decoration: none;
        font-weight: bold;
        display: inline-block;
        transition: all 0.3s ease;
        border: none;
        cursor: pointer;
        width: 100%;
        text-align: center;
        box-sizing: border-box;
        font-size: 1.1rem;
    }

    .card-link:hover {
        transform: translateY(-2px);
        box-shadow: 0 10px 30px rgba(44, 119, 68, 0.3);
        color: white;
        text-decoration: none;
    }

    /* クイックアクション */
    .quick-actions {
        background: rgba(255, 255, 255, 0.95);
        border-radius: 15px;
        padding: 30px;
        box-shadow: 0 8px 32px rgba(0, 0, 0, 0.1);
        backdrop-filter: blur(10px);
        border: 1px solid rgba(255, 255, 255, 0.2);
        margin-bottom: 30px;
    }

    .quick-actions h3 {
        font-size: 1.3rem;
        color: #2C7744;
        margin-bottom: 20px;
        text-align: center;
    }

    .action-buttons {
        display: flex;
        gap: 15px;
        justify-content: center;
        flex-wrap: wrap;
    }

    .action-btn {
        background: linear-gradient(45deg, #2C7744, #5CA564);
        color: white;
        padding: 12px 25px;
        border-radius: 20px;
        text-decoration: none;
        font-weight: bold;
        transition: all 0.3s ease;
        border: none;
        cursor: pointer;
        display: inline-flex;
        align-items: center;
        gap: 8px;
        font-size: 0.95rem;
    }

    .action-btn:hover {
        transform: translateY(-2px);
        box-shadow: 0 8px 25px rgba(44, 119, 68, 0.3);
        color: white;
        text-decoration: none;
    }

    .action-btn.secondary {
        background: linear-gradient(45deg, #6c757d, #495057);
    }

    .action-btn.secondary:hover {
        box-shadow: 0 8px 25px rgba(108, 117, 125, 0.3);
    }

    /* アニメーション */
    @keyframes fadeInUp {
        from {
            opacity: 0;
            transform: translateY(30px);
        }
        to {
            opacity: 1;
            transform: translateY(0);
        }
    }

    .management-card {
        animation: fadeInUp 0.6s ease forwards;
    }

    .management-card:nth-child(1) { animation-delay: 0.1s; }
    .management-card:nth-child(2) { animation-delay: 0.2s; }

    /* レスポンシブ対応 */
    @media (max-width: 768px) {
        .student-management-container {
            padding: 10px;
        }
        
        .page-title {
            font-size: 2rem;
        }
        
        .management-main {
            grid-template-columns: 1fr;
        }
        
        .action-buttons {
            flex-direction: column;
            align-items: center;
        }
        
        .action-btn {
            width: 100%;
            max-width: 300px;
            justify-content: center;
        }
    }

    /* ダッシュボード用ヘッダー調整 */
    .student-management-page header {
        position: relative;
        background: rgba(255, 255, 255, 0.95);
        backdrop-filter: blur(10px);
        border-bottom: 1px solid rgba(255, 255, 255, 0.2);
    }

    .student-management-page #mainimg {
        display: none;
    }

    .student-management-page main {
        margin-top: 0;
    }
</style>

</head>
<body class="student-management-page">
<% 
  String username = (String) session.getAttribute("username"); 
  String role = (String) session.getAttribute("role"); 
  
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
        <div class="student-management-container">
            <!-- ページヘッダー -->
            <div class="page-header">
                <h1 class="page-title">学生管理</h1>
                <p class="page-subtitle">学生情報の管理と就職活動の進捗を把握できます</p>
                <div class="breadcrumb">
                    <a href="javascript:void(0);" onclick="location.reload();">ダッシュボード</a>
                    <span class="separator">/</span>
                    <span>学生管理</span>
                </div>
            </div>

            <!-- クイックアクション -->
            <div class="quick-actions">
                <h3>🚀 クイックアクション</h3>
                <div class="action-buttons">
                    <a href="StatusServlet?view=studentList" class="action-btn">
                        <i class="fas fa-list"></i>学生一覧を表示
                    </a>
                    <a href="StatusServlet?view=createStudent" class="action-btn">
                        <i class="fas fa-plus"></i>新規学生登録
                    </a>
                    <a href="StatusServlet?view=studentSearch" class="action-btn secondary">
                        <i class="fas fa-search"></i>学生検索
                    </a>
                    <a href="StatusServlet?view=studentExport" class="action-btn secondary">
                        <i class="fas fa-download"></i>データエクスポート
                    </a>
                </div>
            </div>

            <!-- メインコンテンツ -->
            <div class="management-main">
                
                <!-- 学生一覧管理 -->
                <div class="management-card">
                    <span class="card-icon">📋</span>
                    <h3 class="card-title">学生一覧管理</h3>
                    <p class="card-description">
                        登録されている学生の一覧を表示し、詳細情報の確認や編集を行えます。
                    </p>
                    <div class="card-stats">
                        <div class="stat-item">
                            <span class="stat-number">150</span>
                            <span class="stat-label">総学生数</span>
                        </div>
                        <div class="stat-item">
                            <span class="stat-number">45</span>
                            <span class="stat-label">就職活動中</span>
                        </div>
                    </div>
                    <a href="StatusServlet?view=studentList" class="card-link">
                        学生一覧を表示
                    </a>
                </div>

                <!-- 新規学生登録 -->
                <div class="management-card">
                    <span class="card-icon">👤</span>
                    <h3 class="card-title">新規学生登録</h3>
                    <p class="card-description">
                        新しい学生の情報を登録し、システムに追加できます。
                    </p>
                    <div class="card-stats">
                        <div class="stat-item">
                            <span class="stat-number">12</span>
                            <span class="stat-label">今月登録</span>
                        </div>
                        <div class="stat-item">
                            <span class="stat-number">3</span>
                            <span class="stat-label">未完了</span>
                        </div>
                    </div>
                    <a href="StatusServlet?view=createStudent" class="card-link">
                        新規学生を登録
                    </a>
                </div>
            </div>
        </div>
    </main>

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