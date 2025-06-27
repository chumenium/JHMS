<!--*
：：：色のテーマは緑：：：
ダッシュボード用画面

******教員-生徒-どちらにも表示されるページ****
******権限によって表示されるボタンが変わる****

:::権限一覧:::

{
  "teacher":           "教員",
  "headmaster": "教務部長_校長",
  "egd":      "就職指導部",
  "admin":             "管理者",
  "student":           "学生"
}

||**すべての中心**||

**

*-->

<!--KCS_JMS_PROJECT-->

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ja">
<head>
<meta charset="UTF-8">
<title>JMSアプリ - ダッシュボード</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="本アプリは就職対策アプリです。">
<link rel="stylesheet" href="css/style.css">

<style>
    /* ダッシュボード全体 */
    .dashboard-container {
        max-width: 1200px;
        margin: 0 auto;
        padding: 20px;
        background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
        min-height: 100vh;
    }

    /* ヘッダー */
    .dashboard-header {
        background: rgba(255, 255, 255, 0.95);
        border-radius: 15px;
        padding: 20px;
        margin-bottom: 30px;
        box-shadow: 0 8px 32px rgba(0, 0, 0, 0.1);
        backdrop-filter: blur(10px);
        border: 1px solid rgba(255, 255, 255, 0.2);
    }

    .user-info {
        display: flex;
        justify-content: space-between;
        align-items: center;
        flex-wrap: wrap;
        gap: 15px;
    }

    .user-welcome {
        display: flex;
        align-items: center;
        gap: 10px;
    }

    .user-avatar {
        width: 50px;
        height: 50px;
        border-radius: 50%;
        background: linear-gradient(45deg, #2C7744, #5CA564);
        display: flex;
        align-items: center;
        justify-content: center;
        color: white;
        font-weight: bold;
        font-size: 20px;
    }

    .user-details h2 {
        margin: 0;
        color: #333;
        font-size: 1.5rem;
    }

    .role-badge {
        background: linear-gradient(45deg, #2C7744, #5CA564);
        color: white;
        padding: 5px 15px;
        border-radius: 20px;
        font-size: 0.9rem;
        font-weight: bold;
        text-transform: uppercase;
    }

    .logout-btn {
        background: #ff4757;
        color: white;
        padding: 10px 20px;
        border: none;
        border-radius: 25px;
        cursor: pointer;
        font-weight: bold;
        transition: all 0.3s ease;
        text-decoration: none;
        display: inline-block;
    }

    .logout-btn:hover {
        background: #ff3742;
        transform: translateY(-2px);
        box-shadow: 0 5px 15px rgba(255, 71, 87, 0.3);
    }

    /* メインコンテンツ */
    .dashboard-main {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
        gap: 25px;
        margin-bottom: 30px;
    }

    /* 機能カード */
    .feature-card {
        background: rgba(255, 255, 255, 0.95);
        border-radius: 15px;
        padding: 25px;
        box-shadow: 0 8px 32px rgba(0, 0, 0, 0.1);
        backdrop-filter: blur(10px);
        border: 1px solid rgba(255, 255, 255, 0.2);
        transition: all 0.3s ease;
        position: relative;
        overflow: hidden;
    }

    .feature-card::before {
        content: '';
        position: absolute;
        top: 0;
        left: 0;
        right: 0;
        height: 4px;
        background: linear-gradient(45deg, #2C7744, #5CA564);
    }

    .feature-card:hover {
        transform: translateY(-5px);
        box-shadow: 0 15px 40px rgba(0, 0, 0, 0.15);
    }

    .feature-icon {
        font-size: 3rem;
        margin-bottom: 15px;
        display: block;
    }

    .feature-title {
        font-size: 1.3rem;
        font-weight: bold;
        color: #333;
        margin-bottom: 10px;
    }

    .feature-description {
        color: #666;
        margin-bottom: 20px;
        line-height: 1.5;
    }

    .feature-link {
        background: linear-gradient(45deg, #2C7744, #5CA564);
        color: white;
        padding: 12px 25px;
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
    }

    .feature-link:hover {
        transform: translateY(-2px);
        box-shadow: 0 8px 25px rgba(44, 119, 68, 0.3);
        color: white;
        text-decoration: none;
    }

    /* レスポンシブ対応 */
    @media (max-width: 768px) {
        .dashboard-container {
            padding: 10px;
        }
        
        .user-info {
            flex-direction: column;
            text-align: center;
        }
        
        .dashboard-main {
            grid-template-columns: 1fr;
        }
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

    .feature-card {
        animation: fadeInUp 0.6s ease forwards;
    }

    .feature-card:nth-child(1) { animation-delay: 0.1s; }
    .feature-card:nth-child(2) { animation-delay: 0.2s; }
    .feature-card:nth-child(3) { animation-delay: 0.3s; }
    .feature-card:nth-child(4) { animation-delay: 0.4s; }
    .feature-card:nth-child(5) { animation-delay: 0.5s; }

    /* ダッシュボード用ヘッダー調整 */
    .dashboard-page header {
        position: relative;
        background: rgba(255, 255, 255, 0.95);
        backdrop-filter: blur(10px);
        border-bottom: 1px solid rgba(255, 255, 255, 0.2);
    }

    .dashboard-page #mainimg {
        display: none;
    }

    .dashboard-page main {
        margin-top: 0;
    }
</style>
</head>

<body class="dashboard-page">
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
        <h1 id="logo"><a href="index.html"><img src="images/logo.png" alt="jms"></a></h1>
        <nav>
            <ul>
                <li><a href="index.html">ホーム</a></li>
                <!-- 権限に応じた機能リンク -->
                <% if ("teacher".equals(role) || "headmaster".equals(role) || "admin".equals(role)) { %>
                    <li><a href="StatusServlet?view=studentManagement">学生管理</a></li>
                <% } %>
                <% if ("egd".equals(role) || "admin".equals(role)) { %>
                    <li><a href="StatusServlet?view=CompanyManagement">企業管理</a></li>
                <% } %>
                <% if ("teacher".equals(role) || "headmaster".equals(role) || "egd".equals(role) || "admin".equals(role) || "student".equals(role)) { %>
                    <li><a href="StatusServlet?view=jobHunting">就職管理</a></li>
                <% } %>
                <% if ("teacher".equals(role) || "headmaster".equals(role) || "egd".equals(role) || "admin".equals(role)) { %>
                    <li><a href="StatusServlet?view=applicantList">受験者一覧</a></li>
                <% } %>
                <% if ("admin".equals(role)) { %>
                    <li><a href="StatusServlet?view=adminDatabase.jsp">システム管理</a></li>
                <% } %>
                <li><a href="extension.html">お問い合わせ</a></li>
                <% if (username != null) { %>
                    <li><a href="LogoutServlet">ログアウト</a></li>
                <% } %>
            </ul>
        </nav>
    </header>
    <!--▲▲▲▲▲ここまで「ヘッダー」-->

    <main>
        <div class="dashboard-container">
            <!-- ダッシュボードヘッダー -->
            <div class="dashboard-header">
                <div class="user-info">
                    <div class="user-welcome">
                        <div class="user-avatar">
                            <%= username != null ? username.charAt(0) : "U" %>
                        </div>
                        <div class="user-details">
                            <h2>こんにちは、<%= username != null ? username : "ゲスト" %>さん</h2>
                            <span class="role-badge"><%= roleDisplay %></span>
                        </div>
                    </div>
                    <% if (username != null) { %>
                        <a href="LogoutServlet" class="logout-btn">ログアウト</a>
                    <% } %>
                </div>
            </div>

            <!-- メインコンテンツ -->
            <div class="dashboard-main">
                
                <!-- 学生管理機能 -->
                <% if ("teacher".equals(role) || "headmaster".equals(role) || "admin".equals(role)) { %>
                    <div class="feature-card">
                        <span class="feature-icon">📚</span>
                        <h3 class="feature-title">学生管理</h3>
                        <p class="feature-description">
                            学生の情報を管理し、就職活動の進捗を把握できます。
                        </p>
                        <a href="StatusServlet?view=studentManagement" class="feature-link">
                            学生管理画面を開く
                        </a>
                    </div>
                <% } %>

                <!-- 企業管理機能 -->
                <% if ("egd".equals(role) || "admin".equals(role)) { %>
                    <div class="feature-card">
                        <span class="feature-icon">🏢</span>
                        <h3 class="feature-title">企業管理</h3>
                        <p class="feature-description">
                            企業情報の登録・編集と求人情報の管理を行います。
                        </p>
                        <a href="StatusServlet?view=CompanyManagement" class="feature-link">
                            企業管理画面を開く
                        </a>
                    </div>
                <% } %>

                <!-- 就職管理機能 -->
                <% if ("teacher".equals(role) || "headmaster".equals(role) || "egd".equals(role) || "admin".equals(role) || "student".equals(role)) { %>
                    <div class="feature-card">
                        <span class="feature-icon">📄</span>
                        <h3 class="feature-title">就職管理</h3>
                        <p class="feature-description">
                            就職活動の進捗管理と選考状況の記録を行います。
                        </p>
                        <a href="StatusServlet?view=jobHunting" class="feature-link">
                            就職管理画面を開く
                        </a>
                    </div>
                <% } %>

                <!-- 受験者一覧機能 -->
                <% if ("teacher".equals(role) || "headmaster".equals(role) || "egd".equals(role) || "admin".equals(role)) { %>
                    <div class="feature-card">
                        <span class="feature-icon">📊</span>
                        <h3 class="feature-title">受験者一覧</h3>
                        <p class="feature-description">
                            企業の選考に応募した学生の一覧と進捗を確認できます。
                        </p>
                        <a href="StatusServlet?view=applicantList" class="feature-link">
                            受験者一覧を表示
                        </a>
                    </div>
                <% } %>

                <!-- 管理者DB機能 -->
                <% if ("admin".equals(role)) { %>
                    <div class="feature-card">
                        <span class="feature-icon">🛠</span>
                        <h3 class="feature-title">システム管理</h3>
                        <p class="feature-description">
                            データベースの管理とシステム設定を行います。
                        </p>
                        <a href="StatusServlet?view=adminDatabase.jsp" class="feature-link">
                            管理者DBを開く
                        </a>
                    </div>
                <% } %>

                <!-- 権限エラー表示 -->
                <% if (username != null && !("teacher".equals(role) || "headmaster".equals(role) || "egd".equals(role) || "admin".equals(role) || "student".equals(role))) { %>
                    <div class="feature-card" style="background: #ffebee; border-left: 4px solid #f44336;">
                        <span class="feature-icon">⚠️</span>
                        <h3 class="feature-title">アクセスエラー</h3>
                        <p class="feature-description">
                            現在の権限では利用できる機能がありません。
                            システム管理者にお問い合わせください。
                        </p>
                    </div>
                <% } %>
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
                <li><a href="index.html">ホーム</a></li>
                <!-- 権限に応じた機能リンク -->
                <% if ("teacher".equals(role) || "headmaster".equals(role) || "admin".equals(role)) { %>
                    <li><a href="StatusServlet?view=studentManagement">学生管理</a></li>
                <% } %>
                <% if ("egd".equals(role) || "admin".equals(role)) { %>
                    <li><a href="StatusServlet?view=CompanyManagement">企業管理</a></li>
                <% } %>
                <% if ("teacher".equals(role) || "headmaster".equals(role) || "egd".equals(role) || "admin".equals(role) || "student".equals(role)) { %>
                    <li><a href="StatusServlet?view=jobHunting">就職管理</a></li>
                <% } %>
                <% if ("teacher".equals(role) || "headmaster".equals(role) || "egd".equals(role) || "admin".equals(role)) { %>
                    <li><a href="StatusServlet?view=applicantList">受験者一覧</a></li>
                <% } %>
                <% if ("admin".equals(role)) { %>
                    <li><a href="StatusServlet?view=adminDatabase.jsp">システム管理</a></li>
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
            <li><a href="index.html">ホーム</a></li>
            <!-- 権限に応じた機能リンク -->
            <% if ("teacher".equals(role) || "headmaster".equals(role) || "admin".equals(role)) { %>
                <li><a href="StatusServlet?view=studentManagement">学生管理</a></li>
            <% } %>
            <% if ("egd".equals(role) || "admin".equals(role)) { %>
                <li><a href="StatusServlet?view=CompanyManagement">企業管理</a></li>
            <% } %>
            <% if ("teacher".equals(role) || "headmaster".equals(role) || "egd".equals(role) || "admin".equals(role) || "student".equals(role)) { %>
                <li><a href="StatusServlet?view=jobHunting">就職管理</a></li>
            <% } %>
            <% if ("teacher".equals(role) || "headmaster".equals(role) || "egd".equals(role) || "admin".equals(role)) { %>
                <li><a href="StatusServlet?view=applicantList">受験者一覧</a></li>
            <% } %>
            <% if ("admin".equals(role)) { %>
                <li><a href="StatusServlet?view=adminDatabase.jsp">システム管理</a></li>
            <% } %>
            <li><a href="extension.html">お問い合わせ</a></li>
            <% if (username != null) { %>
                <li><a href="LogoutServlet">ログアウト</a></li>
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