-- プルダウン用データベーステーブル作成スクリプト

-- クラステーブル
CREATE TABLE IF NOT EXISTS classes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    class_name VARCHAR(50) NOT NULL UNIQUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 在籍状況テーブル
CREATE TABLE IF NOT EXISTS enrollment_status (
    id INT AUTO_INCREMENT PRIMARY KEY,
    status_name VARCHAR(50) NOT NULL UNIQUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 斡旋タイプテーブル
CREATE TABLE IF NOT EXISTS assistance_types (
    id INT AUTO_INCREMENT PRIMARY KEY,
    assistance_name VARCHAR(100) NOT NULL UNIQUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 業種テーブル
CREATE TABLE IF NOT EXISTS industries (
    id INT AUTO_INCREMENT PRIMARY KEY,
    industry_name VARCHAR(100) NOT NULL UNIQUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 勤務地テーブル（StudentServletで参照されている）
CREATE TABLE IF NOT EXISTS work_place_tbl (
    id INT AUTO_INCREMENT PRIMARY KEY,
    work_place VARCHAR(100) NOT NULL UNIQUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 職種テーブル（StudentServletで参照されている）
CREATE TABLE IF NOT EXISTS occupations_tbl (
    occupation_id INT AUTO_INCREMENT PRIMARY KEY,
    occupation VARCHAR(100) NOT NULL UNIQUE,
    industry_name VARCHAR(100),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 学生テーブル（卒業年を取得するため）
CREATE TABLE IF NOT EXISTS students (
    id INT AUTO_INCREMENT PRIMARY KEY,
    student_id VARCHAR(20) NOT NULL UNIQUE,
    name VARCHAR(100) NOT NULL,
    name_kana VARCHAR(100),
    class_id INT,
    class_number INT,
    enrollment_status_id INT,
    gender VARCHAR(10),
    assistance_id INT,
    first_choice_industry_id INT,
    graduation_year INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (class_id) REFERENCES classes(id),
    FOREIGN KEY (enrollment_status_id) REFERENCES enrollment_status(id),
    FOREIGN KEY (assistance_id) REFERENCES assistance_types(id),
    FOREIGN KEY (first_choice_industry_id) REFERENCES industries(id)
);

-- 学生テーブル（StudentServletで参照されている）
CREATE TABLE IF NOT EXISTS students_tbl (
    student_id VARCHAR(20) PRIMARY KEY,
    department VARCHAR(10),
    class VARCHAR(10),
    number VARCHAR(10),
    name VARCHAR(100),
    name_reading VARCHAR(100),
    gender VARCHAR(10),
    enrollment_status VARCHAR(20),
    mediation_status VARCHAR(50),
    desired_job_type_1st_id INT,
    desired_job_type_2nd_id INT,
    desired_job_type_3rd_id INT,
    graduation_year INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- ユーザーテーブル（ログイン機能用）
CREATE TABLE IF NOT EXISTS users (
    id VARCHAR(20) PRIMARY KEY,
    password VARCHAR(255) NOT NULL,
    role VARCHAR(20) NOT NULL,
    salt VARCHAR(255) NOT NULL,
    username VARCHAR(100),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- サンプルデータの挿入

-- クラスデータ
INSERT IGNORE INTO classes (class_name) VALUES 
('S3A1'),
('S3A2'),
('S3B1'),
('S3B2'),
('S2A1'),
('S2A2'),
('S2B1'),
('S2B2');

-- 在籍状況データ
INSERT IGNORE INTO enrollment_status (status_name) VALUES 
('在籍'),
('休学'),
('卒業'),
('退学'),
('除籍');

-- 斡旋データ
INSERT IGNORE INTO assistance_types (assistance_name) VALUES 
('学校斡旋'),
('自己応募'),
('エージェント'),
('紹介'),
('その他');

-- 業種データ
INSERT IGNORE INTO industries (industry_name) VALUES 
('IT・ソフトウェア'),
('通信・インターネット'),
('製造業'),
('金融・保険'),
('建設・不動産'),
('小売・流通'),
('医療・福祉'),
('教育'),
('公務員'),
('その他');

-- 勤務地データ
INSERT IGNORE INTO work_place_tbl (work_place) VALUES 
('東京'),
('大阪'),
('名古屋'),
('福岡'),
('札幌'),
('仙台'),
('広島'),
('その他');

-- 職種データ
INSERT IGNORE INTO occupations_tbl (occupation, industry_name) VALUES 
('システムエンジニア', 'IT・ソフトウェア'),
('プログラマー', 'IT・ソフトウェア'),
('Webデザイナー', 'IT・ソフトウェア'),
('データベースエンジニア', 'IT・ソフトウェア'),
('ネットワークエンジニア', '通信・インターネット'),
('営業職', 'その他'),
('事務職', 'その他'),
('企画職', 'その他');

-- サンプル学生データ（卒業年データのため）
INSERT IGNORE INTO students (student_id, name, name_kana, graduation_year) VALUES 
('2023001', '山田太郎', 'ヤマダタロウ', 2025),
('2023002', '佐藤花子', 'サトウハナコ', 2025),
('2023003', '田中次郎', 'タナカジロウ', 2024),
('2023004', '鈴木美咲', 'スズキミサキ', 2026),
('2023005', '高橋健一', 'タカハシケンイチ', 2025);

-- サンプルユーザーデータ（ログイン機能用）
INSERT IGNORE INTO users (id, password, role, salt, username) VALUES 
('admin', 'admin123', 'admin', 'salt123', '管理者'),
('teacher', 'teacher123', 'teacher', 'salt456', '教師'),
('student', 'student123', 'student', 'salt789', '学生');

UPDATE users SET password = 'b1e0e2e6e2e2e2e2e2e2e2e2e2e2e2e2e2e2e2e2e2e2e2e2e2e2e2e2e2e2e2e2e2e2e2e2' WHERE id = 'admin';
UPDATE users SET password = 'c2f1f3f4f5f6f7f8f9fafbfcfdfeff00112233445566778899aabbccddeeff00' WHERE id = 'teacher';
UPDATE users SET password = 'd3e4e5e6e7e8e9eaebecedeeeff00112233445566778899aabbccddeeff0011' WHERE id = 'student'; 