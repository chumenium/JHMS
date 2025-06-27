-- 書類提出チェック用テーブル作成

-- 書類提出状況テーブル
CREATE TABLE IF NOT EXISTS document_submissions (
    id INT AUTO_INCREMENT PRIMARY KEY,
    student_id VARCHAR(20) NOT NULL,
    student_name VARCHAR(100) NOT NULL,
    document_type VARCHAR(100) NOT NULL,
    company_name VARCHAR(255),
    submission_date DATE,
    submission_status VARCHAR(50) DEFAULT '未提出',
    document_file_path VARCHAR(500),
    teacher_comment TEXT,
    checked_by VARCHAR(100),
    checked_at TIMESTAMP NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX idx_student_id (student_id),
    INDEX idx_submission_status (submission_status),
    INDEX idx_submission_date (submission_date)
);

-- 書類種別テーブル
CREATE TABLE IF NOT EXISTS document_types (
    id INT AUTO_INCREMENT PRIMARY KEY,
    document_name VARCHAR(100) NOT NULL UNIQUE,
    is_required BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- サンプルデータ挿入

-- 書類種別データ
INSERT IGNORE INTO document_types (document_name, is_required) VALUES 
('履歴書', TRUE),
('エントリーシート', TRUE),
('成績証明書', TRUE),
('卒業見込証明書', TRUE),
('健康診断書', FALSE),
('推薦書', FALSE),
('自己PR書', TRUE),
('志望動機書', TRUE),
('職務経歴書', FALSE),
('資格証明書', FALSE);

-- 書類提出状況サンプルデータ
INSERT INTO document_submissions (student_id, student_name, document_type, company_name, submission_date, submission_status, teacher_comment, checked_by) VALUES
('2023001', '山田太郎', '履歴書', '株式会社テックソリューション', '2024-12-10', '提出済み', '内容は良好。志望動機が明確に書かれている。', 'teacher001'),
('2023001', '山田太郎', 'エントリーシート', '株式会社テックソリューション', '2024-12-10', '提出済み', '自己PRが具体的で良い。企業研究も十分。', 'teacher001'),
('2023001', '山田太郎', '成績証明書', '株式会社テックソリューション', '2024-12-10', '提出済み', '成績は良好。専門科目の成績が優秀。', 'teacher001'),
('2023002', '佐藤花子', '履歴書', '製造工業株式会社', '2024-12-12', '提出済み', '基本的な内容は良いが、志望動機をもう少し具体的に。', 'teacher002'),
('2023002', '佐藤花子', 'エントリーシート', '製造工業株式会社', NULL, '未提出', NULL, NULL),
('2023002', '佐藤花子', '成績証明書', '製造工業株式会社', '2024-12-12', '提出済み', '成績は良好。', 'teacher002'),
('2023003', '田中次郎', '履歴書', '金融サービス株式会社', '2024-12-15', '提出済み', '内容は良いが、誤字脱字がある。再提出を求める。', 'teacher001'),
('2023003', '田中次郎', 'エントリーシート', '金融サービス株式会社', '2024-12-15', '提出済み', '自己PRが抽象的。具体的なエピソードを追加することを推奨。', 'teacher001'),
('2023003', '田中次郎', '成績証明書', '金融サービス株式会社', '2024-12-15', '提出済み', '成績は良好。', 'teacher001'),
('2023004', '鈴木美咲', '履歴書', NULL, NULL, '未提出', NULL, NULL),
('2023004', '鈴木美咲', 'エントリーシート', NULL, NULL, '未提出', NULL, NULL),
('2023004', '鈴木美咲', '成績証明書', NULL, NULL, '未提出', NULL, NULL); 