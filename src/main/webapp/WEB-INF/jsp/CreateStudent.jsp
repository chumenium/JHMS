<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ja">
<head>
<meta charset="UTF-8">
<title>JMSアプリ - 新規学生登録</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="本アプリは就職対策アプリです。">
<link rel="stylesheet" href="css/style.css">
<style>
    /* システム上見やすさを追求した新規学生登録画面デザイン */
    
    /* 全体の設定 */
    .create-student-page {
        background: #f8f9fa;
        color: #2c3e50;
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        line-height: 1.6;
    }

    .create-student-container {
        max-width: 800px;
        margin: 0 auto;
        padding: 24px;
        min-height: 100vh;
        background: #ffffff;
        box-shadow: 0 0 20px rgba(0, 0, 0, 0.05);
    }

    /* ページヘッダー - 視認性向上 */
    .page-header {
        background: linear-gradient(135deg, #2C7744 0%, #5CA564 100%);
        border-radius: 12px;
        padding: 32px;
        margin-bottom: 32px;
        box-shadow: 0 4px 20px rgba(44, 119, 68, 0.15);
        color: #000000;
        text-align: center;
        position: relative;
        overflow: hidden;
    }

    .page-title {
        font-size: 32px;
        color: #000000;
        margin-bottom: 12px;
        font-weight: 700;
        text-shadow: 0 1px 2px rgba(255, 255, 255, 0.3);
    }

    .breadcrumb {
        display: flex;
        justify-content: center;
        align-items: center;
        gap: 12px;
        font-size: 14px;
        color: #000000;
        margin-top: 16px;
    }

    .breadcrumb a {
        color: #000000;
        text-decoration: none;
        transition: all 0.2s ease;
        padding: 6px 12px;
        border-radius: 6px;
        background: rgba(255, 255, 255, 0.3);
        border: 1px solid rgba(255, 255, 255, 0.4);
        font-weight: 600;
    }

    .breadcrumb a:hover {
        background: rgba(255, 255, 255, 0.5);
        transform: translateY(-1px);
        color: #000000;
    }

    .breadcrumb .separator {
        color: #000000;
        font-weight: 600;
    }

    /* 登録フォーム - 視認性と操作性の向上 */
    .registration-form {
        background: white;
        border-radius: 12px;
        padding: 32px;
        box-shadow: 0 2px 12px rgba(0, 0, 0, 0.08);
        border: 1px solid #e9ecef;
        margin-bottom: 24px;
    }

    .form-group {
        margin-bottom: 24px;
    }

    .form-group label {
        display: block;
        margin-bottom: 8px;
        font-weight: 600;
        color: #2c3e50;
        font-size: 16px;
    }

    .form-group input,
    .form-group select {
        width: 100%;
        padding: 12px 16px;
        border: 1px solid #e9ecef;
        border-radius: 8px;
        font-size: 16px;
        transition: all 0.2s ease;
        box-sizing: border-box;
    }

    .form-group input:focus,
    .form-group select:focus {
        outline: none;
        border-color: #2C7744;
        box-shadow: 0 0 0 3px rgba(44, 119, 68, 0.1);
    }

    .form-row {
        display: grid;
        grid-template-columns: 1fr 1fr;
        gap: 16px;
    }

    .required {
        color: #e74c3c;
        font-weight: 600;
    }

    /* ボタン */
    .form-buttons {
        display: flex;
        gap: 16px;
        justify-content: center;
        margin-top: 32px;
    }

    .btn {
        padding: 14px 28px;
        border-radius: 8px;
        font-size: 16px;
        font-weight: 600;
        cursor: pointer;
        transition: all 0.2s ease;
        border: none;
        text-decoration: none;
        display: inline-block;
        text-align: center;
        min-width: 120px;
    }

    .btn-primary {
        background: linear-gradient(135deg, #2C7744 0%, #5CA564 100%);
        color: white;
        box-shadow: 0 2px 8px rgba(44, 119, 68, 0.2);
    }

    .btn-primary:hover {
        transform: translateY(-1px);
        box-shadow: 0 4px 15px rgba(44, 119, 68, 0.3);
        color: white;
        text-decoration: none;
    }

    .btn-secondary {
        background: linear-gradient(135deg, #6c757d 0%, #495057 100%);
        color: white;
        box-shadow: 0 2px 8px rgba(108, 117, 125, 0.2);
    }

    .btn-secondary:hover {
        transform: translateY(-1px);
        box-shadow: 0 4px 15px rgba(108, 117, 125, 0.3);
        color: white;
        text-decoration: none;
    }
</style>
</head>
<body class="create-student-page">
    <div class="create-student-container">
        <!-- ページヘッダー -->
        <div class="page-header">
            <h1 class="page-title">新規学生登録</h1>
            <div class="breadcrumb">
                <a href="StatusServlet?status=dashboard">ダッシュボード</a>
                <span class="separator">></span>
                <a href="StatusServlet?status=studentManagement">学生管理</a>
                <span class="separator">></span>
                <span>新規学生登録</span>
            </div>
        </div>

        <!-- エラーメッセージ表示 -->
        <% if (request.getAttribute("errorMessage") != null) { %>
            <div class="message error-message" style="background: #f8d7da; color: #721c24; border: 1px solid #f5c6cb; border-radius: 8px; padding: 16px; margin-bottom: 24px; text-align: center; font-weight: 600;">
                ❌ <%= request.getAttribute("errorMessage") %>
            </div>
        <% } %>

        <!-- 登録フォーム -->
        <div class="registration-form">
            <form action="StudentServlet" method="post">
                <input type="hidden" name="action" value="create">
                
                <!-- 基本情報 -->
                <h3 style="margin-bottom: 20px; color: #2c3e50; border-bottom: 2px solid #2C7744; padding-bottom: 8px;">基本情報</h3>
                
                <div class="form-row">
                    <div class="form-group">
                        <label for="admissionYear">入学年（西暦）<span class="required">*</span></label>
                        <input type="number" id="admissionYear" name="admissionYear" min="2000" max="2099" required placeholder="例: 2022">
                    </div>
                    <div class="form-group">
                        <label for="className">クラス <span class="required">*</span></label>
                        <select id="className" name="className" required>
                            <option value="">選択してください</option>
                            <option value="RxAx">RxAx</option>
                            <option value="SxAx">SxAx</option>
                            <option value="MxGx">MxGx</option>
                            <option value="JxSx">JxSx</option>
                            <option value="GxGx">GxGx</option>
                        </select>
                    </div>
                </div>
                <div class="form-row">
                    <div class="form-group">
                        <label for="attendanceNo">出席番号 <span class="required">*</span></label>
                        <input type="number" id="attendanceNo" name="attendanceNo" min="1" max="999" required placeholder="例: 1">
                    </div>
                    <div class="form-group">
                        <label for="schoolYears">年制</label>
                        <input type="text" id="schoolYears" name="schoolYears" readonly>
                    </div>
                </div>
                <div class="form-group">
                    <label for="studentId">学籍番号 <span class="required">*</span></label>
                    <input type="text" id="studentId" name="studentId" required maxlength="7" readonly placeholder="自動生成">
                </div>
                <div class="form-row">
                    <div class="form-group">
                        <label for="name">氏名 <span class="required">*</span></label>
                        <input type="text" id="name" name="name" required placeholder="例: 山田太郎">
                    </div>
                    <div class="form-group">
                        <label for="kana">フリガナ <span class="required">*</span></label>
                        <input type="text" id="kana" name="kana" required placeholder="例: ヤマダタロウ">
                    </div>
                </div>

                <div class="form-row">
                    <div class="form-group">
                        <label for="email">メールアドレス <span class="required">*</span></label>
                        <input type="email" id="email" name="email" required placeholder="例: yamada@example.com">
                    </div>
                </div>

                <div class="form-row">
                    <div class="form-group">
                        <label for="phone">電話番号</label>
                        <input type="tel" id="phone" name="phone" placeholder="例: 090-1234-5678">
                    </div>
                    <div class="form-group">
                        <label for="birthDate">生年月日</label>
                        <input type="date" id="birthDate" name="birthDate">
                    </div>
                </div>

                <!-- 学籍情報 -->
                <h3 style="margin: 32px 0 20px 0; color: #2c3e50; border-bottom: 2px solid #2C7744; padding-bottom: 8px;">学籍情報</h3>
                
                <div class="form-row">
                    <div class="form-group">
                        <label for="department">学部 <span class="required">*</span></label>
                        <select id="department" name="department" required>
                            <option value="情報工学">情報工学</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label for="grade">学年 <span class="required">*</span></label>
                        <select id="grade" name="grade" required>
                            <option value="1">1年</option>
                            <option value="2">2年</option>
                            <option value="3">3年</option>
                            <option value="4">4年</option>
                        </select>
                    </div>
                </div>

                <div class="form-group">
                    <label for="major">専攻・学科</label>
                    <select id="major" name="major" required>
                        <option value="大学併修">大学併修</option>
                        <option value="エンジニア・クリエータ科システム分野">エンジニア・クリエータ科システム分野</option>
                        <option value="エンジニア・クリエータ科ゲーム分野">エンジニア・クリエータ科ゲーム分野</option>
                        <option value="プログラム・デザイン科システム分野">プログラム・デザイン科システム分野</option>
                        <option value="プログラム・デザイン科ゲーム分野">プログラム・デザイン科ゲーム分野</option>
                    </select>
                </div>

                <!-- 就活情報 -->
                <h3 style="margin: 32px 0 20px 0; color: #2c3e50; border-bottom: 2px solid #2C7744; padding-bottom: 8px;">就活情報</h3>
                
                <div class="form-row">
                    <div class="form-group">
                        <label for="jobHuntingStatus">就活状況</label>
                        <select id="jobHuntingStatus" name="jobHuntingStatus">
                            <option value="">選択してください</option>
                            <option value="未開始">未開始</option>
                            <option value="準備中">準備中</option>
                            <option value="活動中">活動中</option>
                            <option value="内定済み">内定済み</option>
                            <option value="就職決定">就職決定</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label for="targetIndustry">希望業界</label>
                        <select id="targetIndustry" name="targetIndustry">
                            <option value="">選択してください</option>
                            <option value="IT・通信">IT・通信</option>
                            <option value="製造業">製造業</option>
                            <option value="金融・保険">金融・保険</option>
                            <option value="商社・流通">商社・流通</option>
                            <option value="建設・不動産">建設・不動産</option>
                            <option value="メディア・広告">メディア・広告</option>
                            <option value="サービス業">サービス業</option>
                            <option value="公務員">公務員</option>
                            <option value="その他">その他</option>
                        </select>
                    </div>
                </div>

                <div class="form-group">
                    <label for="notes">備考</label>
                    <textarea id="notes" name="notes" rows="4" style="width: 100%; padding: 12px 16px; border: 1px solid #e9ecef; border-radius: 8px; font-size: 16px; resize: vertical;" placeholder="特記事項があれば記入してください"></textarea>
                </div>

                <!-- ボタン -->
                <div class="form-buttons">
                    <button type="submit" class="btn btn-primary">登録する</button>
                    <a href="StatusServlet?status=studentManagement" class="btn btn-secondary">キャンセル</a>
                </div>
            </form>
        </div>
    </div>

    <script>
        // フォームバリデーション
        document.querySelector('form').addEventListener('submit', function(e) {
            const studentId = document.getElementById('studentId').value;
            const name = document.getElementById('name').value;
            const kana = document.getElementById('kana').value;
            const email = document.getElementById('email').value;
            const department = document.getElementById('department').value;
            const grade = document.getElementById('grade').value;

            // 必須項目チェック
            if (!studentId || !name || !kana || !email || !department || !grade) {
                e.preventDefault();
                alert('必須項目を入力してください。');
                return;
            }

            // 学籍番号の形式チェック
            if (!/^\d{6}$/.test(studentId)) {
                e.preventDefault();
                alert('学籍番号は6桁の数字で入力してください。');
                return;
            }

            // メールアドレスの形式チェック
            const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
            if (!emailRegex.test(email)) {
                e.preventDefault();
                alert('正しいメールアドレスを入力してください。');
                return;
            }
        });

        // リアルタイムバリデーション
        document.getElementById('studentId').addEventListener('input', function() {
            this.value = this.value.replace(/[^0-9]/g, '').substring(0, 6);
        });

        document.getElementById('kana').addEventListener('input', function() {
            this.value = this.value.toUpperCase();
        });

        // --- 学籍番号自動生成・年制自動反映 ---
        const classYearMap = {
            'RxAx': { code: '11', years: '4年' },
            'SxAx': { code: '21', years: '3年' },
            'MxGx': { code: '22', years: '3年' },
            'JxSx': { code: '31', years: '2年' },
            'GxGx': { code: '32', years: '2年' }
        };
        function pad(num, size) {
            let s = String(num);
            while (s.length < size) s = '0' + s;
            return s;
        }
        function updateStudentId() {
            const year = document.getElementById('admissionYear').value;
            const className = document.getElementById('className').value;
            const attNo = document.getElementById('attendanceNo').value;
            let studentId = '';
            if (year && className && attNo) {
                const yy = year.slice(-2);
                const code = classYearMap[className]?.code || '';
                const no = pad(attNo, 2);
                studentId = yy + code + no;
            }
            document.getElementById('studentId').value = studentId;
        }
        function updateSchoolYears() {
            const className = document.getElementById('className').value;
            document.getElementById('schoolYears').value = classYearMap[className]?.years || '';
        }
        document.getElementById('admissionYear').addEventListener('input', updateStudentId);
        document.getElementById('className').addEventListener('change', function() {
            updateSchoolYears();
            updateStudentId();
        });
        document.getElementById('attendanceNo').addEventListener('input', updateStudentId);
        // --- 既存バリデーションの下に追記 ---
    </script>
</body>
</html> 