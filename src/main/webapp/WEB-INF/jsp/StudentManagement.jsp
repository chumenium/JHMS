

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
<!DOCTYPE html>
<html lang="ja">
<head>
<meta charset="UTF-8">
<title>学生管理画面</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="本アプリは就職対策アプリです。">
<link rel="stylesheet" href="css/style.css">

<!-- 上の検索用CSS -->
<style>
/*----------------------------------------------
  カラー変数
----------------------------------------------*/
:root {
  --primary: #4a90e2;
  --bg: #fff;
  --surface: #f5f7fa;
  --border: #ccc;
  --text: #333;
}

/*----------------------------------------------
  ベースリセット
----------------------------------------------*/
*,
*::before,
*::after {
  box-sizing: border-box;
}
body {
  margin: 0;
  font-family: "Segoe UI", sans-serif;
  background: var(--bg);
  color: var(--text);
  line-height: 1.5;
}
main {
  max-width: 900px;
  padding: 1rem;
  margin: 0 auto;
}
h1 {
  text-align: center;
  margin-bottom: 1.5rem;
}

/*----------------------------------------------
  グリッドフォーム
----------------------------------------------*/
.grid-form .grid-container {
  display: grid;
  grid-template-columns: repeat(3, 1fr);
  gap: 1rem;
}
.field {
  display: flex;
  flex-direction: column;
}
.field label {
  margin-bottom: 0.4rem;
  font-weight: bold;
}
.field input,
.field select {
  padding: 0.5rem;
  border: 1px solid var(--border);
  border-radius: 4px;
  font-size: 1rem;
}
.field input:focus,
.field select:focus {
  border-color: var(--primary);
  outline: none;
  box-shadow: 0 0 0 3px rgba(74,144,226,0.3);
}

/*----------------------------------------------
  ボタン
----------------------------------------------*/
.btn-wrap {
  margin-top: 1.5rem;
  text-align: center;
}
.btn-wrap button {
  padding: 0.6rem 1.2rem;
  margin: 0 0.5rem;
  font-size: 1rem;
  border: none;
  border-radius: 4px;
  cursor: pointer;
  transition: background-color 0.2s;
}
.btn-wrap button[type="submit"] {
  background: var(--primary);
  color: #fff;
}
.btn-wrap button[type="submit"]:hover {
  background: #357ab8;
}
.btn-wrap button[type="reset"] {
  background: var(--surface);
  color: var(--text);
  border: 1px solid var(--border);
}
.btn-wrap button[type="reset"]:hover {
  background: #e2e6ea;
}

/*----------------------------------------------
  レスポンシブ：小画面は1列表示
----------------------------------------------*/
@media (max-width: 600px) {
  .grid-form .grid-container {
    grid-template-columns: 1fr;
  }
}
/* main の制限を打ち消し、ビューポート全幅表示 */
.full-bleed {
  position: relative;
  left: 50%;
  width: 100vw;        /* ビューポート幅 */
  margin-left: -50vw;  /* left:50% 分を戻す */
}

/* arrow や text-slide-wrapper に適用 */
.arrow,
.text-slide-wrapper {
  /* 既存クラスに加えて .full-bleed を一緒に読み込む */
  position: relative;
  left: 50%;
  width: 100vw;
  margin-left: -50vw;
}
</style>

</head>
<body>
<div id="container">
<!--▼▼▼▼▼ここから「ヘッダー」-->
<header>
<!-- ▼▼▼▼ 画面上部アイコン-->
<h1 id="logo"><a href="index.html"><img src="images/logo.png" alt="jms"></a></h1>
<!-- ▲▲▲▲ -->

<!--ヘッダー上部分のリスト-->

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



  <!--* 画面：受験者一覧画面
        	
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
<!-- ▲▲▲ヘッダー上部分のリスト-->
</header>
<!--▲▲▲▲▲ここまで「ヘッダー」-->


<!-- デザインいらなかったら外す -->


<!--▼▼▼▼▼ここから「メイン画像」-->
<div id="mainimg">
<div>

<div class="text">
<p>あなたのベストな、<br>
ワンランク上の<br>
就職先を提案します。</p>
</div>

<!--▼【拡張機能　現状】-->
<div class="btn">
<p><a href="extension.html"><i class="fa-regular fa-envelope"></i>お問い合わせ</a></p>
<p><a href="extension.html"><i class="fa-regular fa-file-lines"></i>資料請求</a></p>
</div>

</div>
</div>


<!--▲▲▲▲▲ここまで「メイン画像」-->


<section class="bg1 bg-pattern1 arrow full-bleed">
</section>


<!-- ここから機能部分を記述 -->
<main>
<section class="bg3 bg-pattern3" id="main">
<div class="title">
<h2>学生情報検索<span>search</span></h2>
</div>
<!--/.title-->

<%-- エラーメッセージの表示 --%>
<% if (errorMessage != null && !errorMessage.isEmpty()) { %>
  <div style="color: red; margin-bottom: 1rem; padding: 0.5rem; background-color: #ffe6e6; border: 1px solid #ff9999; border-radius: 4px;">
    <%= errorMessage %>
  </div>
<% } %>

    <form class="grid-form" action="StudentServlet" method="post">
      <input type="hidden" name="action" value="searchStudents">
      <div class="grid-container">
        <div class="field">
          <label for="student_id">学生番号</label>
          <input id="student_id" name="student_id" type="text" placeholder="例: 2023001">
        </div>
        <div class="field">
          <label for="class">クラス</label>
          <select id="class" name="class">
            <option value="">選択してください</option>
            <% 
              java.util.List<String> classes = (java.util.List<String>) request.getAttribute("classes");
              if (classes != null) { 
                for (String className : classes) { 
            %>
                <option value="<%= className %>"><%= className %></option>
            <% 
                } 
              } 
            %>
          </select>
        </div>
        <div class="field">
          <label for="number">クラス番号</label>
          <input id="number" name="number" type="text" placeholder="例: 16">
        </div>
        <div class="field">
          <label for="name_reading">名前（カナ）</label>
          <input id="name_reading" name="name_reading" type="text" placeholder="例: ヤマダタロウ">
        </div>
        <div class="field">
          <label for="enrollment_status">在籍状況</label>
          <select id="enrollment_status" name="enrollment_status">
            <option value="">選択してください</option>
            <% 
              java.util.List<String> enrollmentStatuss = (java.util.List<String>) request.getAttribute("enrollmentStatuss");
              if (enrollmentStatuss != null) { 
                for (String status : enrollmentStatuss) { 
            %>
                <option value="<%= status %>"><%= status %></option>
            <% 
                } 
              } 
            %>
          </select>
        </div>
        <div class="field">
          <label for="gender">性別</label>
          <select id="gender" name="gender">
            <option value="">選択してください</option>
            <option value="男性">男性</option>
            <option value="女性">女性</option>
            <option value="その他">その他</option>
          </select>
        </div>
        <div class="field">
          <label for="mediation_status">斡旋</label>
          <select id="mediation_status" name="mediation_status">
            <option value="">選択してください</option>
            <% 
              java.util.List<String> assistanceTypes = (java.util.List<String>) request.getAttribute("assistanceTypes");
              if (assistanceTypes != null) { 
                for (String assistance : assistanceTypes) { 
            %>
                <option value="<%= assistance %>"><%= assistance %></option>
            <% 
                } 
              } 
            %>
          </select>
        </div>
        <div class="field">
          <label for="desired_job_type_1st">第一希望業種</label>
          <select id="desired_job_type_1st" name="desired_job_type_1st">
            <option value="">選択してください</option>
            <% 
              java.util.List<String> industries = (java.util.List<String>) request.getAttribute("industries");
              if (industries != null) { 
                for (String industry : industries) { 
            %>
                <option value="<%= industry %>"><%= industry %></option>
            <% 
                } 
              } 
            %>
          </select>
        </div>
        <div class="field">
          <label for="graduation_year">卒業年</label>
          <select id="graduation_year" name="graduation_year">
            <option value="">選択してください</option>
            <% 
              java.util.List<String> graduationYears = (java.util.List<String>) request.getAttribute("graduationYears");
              if (graduationYears != null) { 
                for (String year : graduationYears) { 
            %>
                <option value="<%= year %>"><%= year %></option>
            <% 
                } 
              } 
            %>
          </select>
        </div>
      </div>
      <div class="btn-wrap">
        <button type="submit">検索</button>
        <button type="reset">クリア</button>
      </div>
    </form>

    <%-- 検索結果の表示 --%>
    <% 
      java.util.List<java.util.List<String>> students = (java.util.List<java.util.List<String>>) request.getAttribute("students");
      if (students != null && !students.isEmpty()) { 
    %>
    <div style="margin-top: 2rem;">
      <h3>検索結果</h3>
      <div style="overflow-x: auto;">
        <table style="width: 100%; border-collapse: collapse; margin-top: 1rem;">
          <thead>
            <tr style="background-color: #4a90e2; color: white;">
              <th style="padding: 0.5rem; border: 1px solid #ddd;">学生番号</th>
              <th style="padding: 0.5rem; border: 1px solid #ddd;">クラス</th>
              <th style="padding: 0.5rem; border: 1px solid #ddd;">クラス番号</th>
              <th style="padding: 0.5rem; border: 1px solid #ddd;">名前</th>
              <th style="padding: 0.5rem; border: 1px solid #ddd;">名前（カナ）</th>
              <th style="padding: 0.5rem; border: 1px solid #ddd;">性別</th>
              <th style="padding: 0.5rem; border: 1px solid #ddd;">在籍状況</th>
              <th style="padding: 0.5rem; border: 1px solid #ddd;">斡旋</th>
              <th style="padding: 0.5rem; border: 1px solid #ddd;">第一希望業種</th>
              <th style="padding: 0.5rem; border: 1px solid #ddd;">卒業年</th>
            </tr>
          </thead>
          <tbody>
            <% 
              int studentCount = students.get(0).size(); // 学生番号のリストのサイズ
              for (int i = 0; i < studentCount; i++) { 
            %>
            <tr style="background-color: <%= i % 2 == 0 ? "#f9f9f9" : "white" %>;">
              <td style="padding: 0.5rem; border: 1px solid #ddd;"><%= students.get(0).get(i) %></td>
              <td style="padding: 0.5rem; border: 1px solid #ddd;"><%= students.get(1).get(i) %></td>
              <td style="padding: 0.5rem; border: 1px solid #ddd;"><%= students.get(2).get(i) %></td>
              <td style="padding: 0.5rem; border: 1px solid #ddd;"><%= students.get(3).get(i) %></td>
              <td style="padding: 0.5rem; border: 1px solid #ddd;"><%= students.get(4).get(i) %></td>
              <td style="padding: 0.5rem; border: 1px solid #ddd;"><%= students.get(5).get(i) %></td>
              <td style="padding: 0.5rem; border: 1px solid #ddd;"><%= students.get(6).get(i) %></td>
              <td style="padding: 0.5rem; border: 1px solid #ddd;"><%= students.get(7).get(i) %></td>
              <td style="padding: 0.5rem; border: 1px solid #ddd;"><%= students.get(8).get(i) %></td>
              <td style="padding: 0.5rem; border: 1px solid #ddd;"><%= students.get(9).get(i) %></td>
            </tr>
            <% } %>
          </tbody>
        </table>
      </div>
      <p style="margin-top: 1rem; color: #666;">検索結果: <%= studentCount %>件</p>
    </div>
    <% } else if (students != null && students.isEmpty()) { %>
    <div style="margin-top: 2rem; text-align: center; color: #666;">
      <p>検索条件に一致する学生が見つかりませんでした。</p>
    </div>
    <% } %>
</section>
</main>
<!-- ここまで機能部分を記述 -->


<section class="bg1 bg-pattern1 arrow full-bleed">
</section>

<!--▼▼▼▼▼ここから「テキストスライドショー」-->
<div class="text-slide-wrapper full-bleed">
<div class="text-slide">
<span>Job Management System</span>
</div>
</div>
<!--▲▲▲▲▲ここまで「テキストスライドショー」-->




<!--▼▼▼▼▼ここから「フッター」-->
<footer>
<div>
<p class="logo"><img src="images/logo.png" alt="Job Management System"></p>
<small>Copyright&copy; @ 2025 Job Management System All Rights Reserved.</small>
</div>
<div>
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



  <!--* 画面：受験者一覧画面
        	
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



  <!--* 画面：受験者一覧画面
        	
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