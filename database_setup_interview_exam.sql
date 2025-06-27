-- 試験・面接情報管理用テーブル作成

-- 試験・面接情報テーブル
CREATE TABLE IF NOT EXISTS interview_exam_info (
    id INT AUTO_INCREMENT PRIMARY KEY,
    company_name VARCHAR(255) NOT NULL,
    job_title VARCHAR(100),
    exam_type VARCHAR(50),
    exam_date DATE,
    exam_venue VARCHAR(100),
    exam_start_time TIME,
    exam_end_time TIME,
    interview_date DATE,
    interview_venue VARCHAR(100),
    interview_format VARCHAR(50),
    interviewer_count VARCHAR(20),
    exam_content TEXT,
    interview_questions TEXT,
    notes TEXT,
    created_by VARCHAR(100),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX idx_company_name (company_name),
    INDEX idx_exam_date (exam_date),
    INDEX idx_interview_date (interview_date)
);

-- サンプルデータ挿入
INSERT INTO interview_exam_info (company_name, job_title, exam_type, exam_date, exam_venue, exam_start_time, exam_end_time, interview_date, interview_venue, interview_format, interviewer_count, exam_content, interview_questions, notes, created_by) VALUES
('株式会社テックソリューション', 'インフラエンジニア', '筆記', '2024-12-15', '校内', '09:00:00', '11:00:00', '2024-12-20', '企業本社', '個人', '2', 'プログラミング基礎、ネットワーク基礎、Linuxコマンド', '志望動機、技術的な経験、将来のキャリアプラン', '筆記試験は難易度が高め。面接は技術的な質問が多い。', 'teacher001'),
('製造工業株式会社', 'アプリ開発エンジニア', '適性', '2024-12-18', 'オンライン', '10:00:00', '11:30:00', '2024-12-25', 'オンライン', '個人', '1', 'SPI、プログラミング適性テスト', '自己PR、チームワーク経験、技術スキル', 'オンライン面接のため、環境設定が重要。', 'teacher002'),
('金融サービス株式会社', 'セキュリティエンジニア', 'なし', NULL, NULL, NULL, NULL, '2024-12-22', '企業本社', '集団', '3', NULL, '志望動機、セキュリティに関する知識、実務経験', '集団面接のため、他の受験者との差別化が重要。', 'teacher001'); 