<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ja">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>企業管理画面</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <style>
        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px;
        }
        
        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 30px;
            padding-bottom: 20px;
            border-bottom: 2px solid #007bff;
        }
        
        .header h1 {
            color: #007bff;
            margin: 0;
        }
        
        .btn {
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            text-decoration: none;
            display: inline-block;
            margin: 5px;
            font-size: 14px;
        }
        
        .btn-primary {
            background-color: #007bff;
            color: white;
        }
        
        .btn-success {
            background-color: #28a745;
            color: white;
        }
        
        .btn-warning {
            background-color: #ffc107;
            color: #212529;
        }
        
        .btn-danger {
            background-color: #dc3545;
            color: white;
        }
        
        .btn-secondary {
            background-color: #6c757d;
            color: white;
        }
        
        .search-form {
            margin-bottom: 20px;
            padding: 15px;
            background-color: #f8f9fa;
            border-radius: 5px;
        }
        
        .search-form input[type="text"] {
            padding: 8px;
            border: 1px solid #ddd;
            border-radius: 4px;
            width: 300px;
            margin-right: 10px;
        }
        
        .company-table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
            background-color: white;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
        
        .company-table th,
        .company-table td {
            padding: 12px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }
        
        .company-table th {
            background-color: #007bff;
            color: white;
            font-weight: bold;
        }
        
        .company-table tr:hover {
            background-color: #f5f5f5;
        }
        
        .form-container {
            background-color: white;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            margin-top: 20px;
        }
        
        .form-group {
            margin-bottom: 20px;
        }
        
        .form-group label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
            color: #333;
        }
        
        .form-group input[type="text"],
        .form-group input[type="email"],
        .form-group input[type="url"],
        .form-group textarea,
        .form-group select {
            width: 100%;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-size: 14px;
        }
        
        .form-group textarea {
            height: 100px;
            resize: vertical;
        }
        
        .error-message {
            color: #dc3545;
            background-color: #f8d7da;
            border: 1px solid #f5c6cb;
            padding: 10px;
            border-radius: 4px;
            margin-bottom: 20px;
        }
        
        .success-message {
            color: #155724;
            background-color: #d4edda;
            border: 1px solid #c3e6cb;
            padding: 10px;
            border-radius: 4px;
            margin-bottom: 20px;
        }
        
        .action-buttons {
            text-align: center;
            margin-top: 20px;
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
    <div class="container">
        <div class="header">
            <h1>企業管理画面</h1>
            <div>
                <a href="CompanyManagementController?action=list" class="btn btn-primary">一覧表示</a>
                <a href="CompanyManagementController?action=add" class="btn btn-success">新規追加</a>
                <a href="DashBoard.jsp" class="btn btn-secondary">ダッシュボード</a>
            </div>
        </div>
        
        <!-- メッセージ表示 -->
        <c:if test="${not empty message}">
            <div class="success-message">${message}</div>
        </c:if>
        
        <c:if test="${not empty errorMessage}">
            <div class="error-message">${errorMessage}</div>
        </c:if>
        
        <!-- 検索フォーム -->
        <div class="search-form">
            <form action="CompanyManagementController" method="GET">
                <input type="hidden" name="action" value="search">
                <input type="text" name="searchKeyword" placeholder="企業名で検索..." 
                       value="${searchKeyword}" required>
                <button type="submit" class="btn btn-primary">検索</button>
            </form>
        </div>
        
        <!-- 企業追加・編集フォーム -->
        <c:if test="${mode == 'add' || mode == 'edit'}">
            <div class="form-container">
                <h2>${mode == 'add' ? '企業追加' : '企業編集'}</h2>
                <form action="CompanyManagementController" method="POST">
                    <input type="hidden" name="action" value="${mode == 'add' ? 'add' : 'update'}">
                    <c:if test="${mode == 'edit'}">
                        <input type="hidden" name="companyId" value="${company.companyId}">
                    </c:if>
                    
                    <div class="form-group">
                        <label for="companyName">企業名 *</label>
                        <input type="text" id="companyName" name="companyName" 
                               value="${company.companyName}" required>
                    </div>
                    
                    <div class="form-group">
                        <label for="industry">業種 *</label>
                        <select id="industry" name="industry" required>
                            <option value="">選択してください</option>
                            <option value="IT・ソフトウェア" ${company.industry == 'IT・ソフトウェア' ? 'selected' : ''}>IT・ソフトウェア</option>
                            <option value="製造業" ${company.industry == '製造業' ? 'selected' : ''}>製造業</option>
                            <option value="金融・保険" ${company.industry == '金融・保険' ? 'selected' : ''}>金融・保険</option>
                            <option value="建設業" ${company.industry == '建設業' ? 'selected' : ''}>建設業</option>
                            <option value="小売・流通" ${company.industry == '小売・流通' ? 'selected' : ''}>小売・流通</option>
                            <option value="サービス業" ${company.industry == 'サービス業' ? 'selected' : ''}>サービス業</option>
                            <option value="その他" ${company.industry == 'その他' ? 'selected' : ''}>その他</option>
                        </select>
                    </div>
                    
                    <div class="form-group">
                        <label for="location">所在地 *</label>
                        <input type="text" id="location" name="location" 
                               value="${company.location}" required>
                    </div>
                    
                    <div class="form-group">
                        <label for="contactPerson">担当者 *</label>
                        <input type="text" id="contactPerson" name="contactPerson" 
                               value="${company.contactPerson}" required>
                    </div>
                    
                    <div class="form-group">
                        <label for="phone">電話番号 *</label>
                        <input type="text" id="phone" name="phone" 
                               value="${company.phone}" required>
                    </div>
                    
                    <div class="form-group">
                        <label for="email">メールアドレス</label>
                        <input type="email" id="email" name="email" 
                               value="${company.email}">
                    </div>
                    
                    <div class="form-group">
                        <label for="website">Webサイト</label>
                        <input type="url" id="website" name="website" 
                               value="${company.website}">
                    </div>
                    
                    <div class="form-group">
                        <label for="description">企業説明</label>
                        <textarea id="description" name="description">${company.description}</textarea>
                    </div>
                    
                    <div class="form-group">
                        <label for="status">ステータス *</label>
                        <select id="status" name="status" required>
                            <option value="">選択してください</option>
                            <option value="アクティブ" ${company.status == 'アクティブ' ? 'selected' : ''}>アクティブ</option>
                            <option value="非アクティブ" ${company.status == '非アクティブ' ? 'selected' : ''}>非アクティブ</option>
                            <option value="保留" ${company.status == '保留' ? 'selected' : ''}>保留</option>
                        </select>
                    </div>
                    
                    <div class="action-buttons">
                        <button type="submit" class="btn btn-success">
                            ${mode == 'add' ? '追加' : '更新'}
                        </button>
                        <a href="CompanyManagementController?action=list" class="btn btn-secondary">キャンセル</a>
                    </div>
                </form>
            </div>
        </c:if>
        
        <!-- 企業一覧テーブル -->
        <c:if test="${mode != 'add' && mode != 'edit'}">
            <c:choose>
                <c:when test="${not empty companies}">
                    <table class="company-table">
                        <thead>
                            <tr>
                                <th>企業ID</th>
                                <th>企業名</th>
                                <th>業種</th>
                                <th>所在地</th>
                                <th>担当者</th>
                                <th>電話番号</th>
                                <th>ステータス</th>
                                <th>操作</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="company" items="${companies}">
                                <tr>
                                    <td>${company.companyId}</td>
                                    <td>${company.companyName}</td>
                                    <td>${company.industry}</td>
                                    <td>${company.location}</td>
                                    <td>${company.contactPerson}</td>
                                    <td>${company.phone}</td>
                                    <td>${company.status}</td>
                                    <td>
                                        <a href="CompanyManagementController?action=edit&id=${company.companyId}" 
                                           class="btn btn-warning">編集</a>
                                        <a href="CompanyManagementController?action=delete&id=${company.companyId}" 
                                           class="btn btn-danger" 
                                           onclick="return confirm('本当に削除しますか？')">削除</a>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </c:when>
                <c:otherwise>
                    <div class="no-data">
                        <c:choose>
                            <c:when test="${not empty searchKeyword}">
                                検索条件「${searchKeyword}」に一致する企業が見つかりませんでした。
                            </c:when>
                            <c:otherwise>
                                登録されている企業がありません。
                            </c:otherwise>
                        </c:choose>
                    </div>
                </c:otherwise>
            </c:choose>
        </c:if>
    </div>
    
    <script>
        // フォームのバリデーション
        document.addEventListener('DOMContentLoaded', function() {
            const form = document.querySelector('form');
            if (form) {
                form.addEventListener('submit', function(e) {
                    const companyName = document.getElementById('companyName');
                    const industry = document.getElementById('industry');
                    const location = document.getElementById('location');
                    const contactPerson = document.getElementById('contactPerson');
                    const phone = document.getElementById('phone');
                    const status = document.getElementById('status');
                    
                    if (!companyName.value.trim()) {
                        alert('企業名を入力してください。');
                        e.preventDefault();
                        return;
                    }
                    
                    if (!industry.value) {
                        alert('業種を選択してください。');
                        e.preventDefault();
                        return;
                    }
                    
                    if (!location.value.trim()) {
                        alert('所在地を入力してください。');
                        e.preventDefault();
                        return;
                    }
                    
                    if (!contactPerson.value.trim()) {
                        alert('担当者を入力してください。');
                        e.preventDefault();
                        return;
                    }
                    
                    if (!phone.value.trim()) {
                        alert('電話番号を入力してください。');
                        e.preventDefault();
                        return;
                    }
                    
                    if (!status.value) {
                        alert('ステータスを選択してください。');
                        e.preventDefault();
                        return;
                    }
                });
            }
        });
    </script>
</body>
</html> 