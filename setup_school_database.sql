-- 学校サーバー用データベースセットアップスクリプト

-- 1. データベースの作成
CREATE DATABASE IF NOT EXISTS jms CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- 2. 専用ユーザーの作成
CREATE USER 'jms_user'@'%' IDENTIFIED BY 'jms_password';
GRANT ALL PRIVILEGES ON jms.* TO 'jms_user'@'%';
FLUSH PRIVILEGES;

-- 3. データベースの選択
USE jms;

-- 4. 既存のテーブル作成スクリプトを実行
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

-- 勤務地テーブル
CREATE TABLE IF NOT EXISTS work_place_tbl (
    id INT AUTO_INCREMENT PRIMARY KEY,
    work_place VARCHAR(100) NOT NULL UNIQUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 職種テーブル
CREATE TABLE IF NOT EXISTS occupations_tbl (
    occupation_id INT AUTO_INCREMENT PRIMARY KEY,
    occupation VARCHAR(100) NOT NULL UNIQUE,
    industry_name VARCHAR(100),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 学生テーブル
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

-- 学生テーブル（StudentServlet用）
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

-- ユーザーテーブル
CREATE TABLE IF NOT EXISTS users (
    id VARCHAR(8) PRIMARY KEY,
    password VARCHAR(255) NOT NULL,
    role ENUM('student','teacher','headmaster','egd','admin') NOT NULL,
    salt VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- サンプルデータの挿入
INSERT IGNORE INTO classes (class_name) VALUES 
('S3A1'),('S3A2'),('S3B1'),('S3B2'),('S2A1'),('S2A2'),('S2B1'),('S2B2');

INSERT IGNORE INTO enrollment_status (status_name) VALUES 
('在籍'),('休学'),('卒業'),('退学'),('除籍');

INSERT IGNORE INTO assistance_types (assistance_name) VALUES 
('学校斡旋'),('自己応募'),('エージェント'),('紹介'),('その他');

INSERT IGNORE INTO industries (industry_name) VALUES 
('IT・ソフトウェア'),('通信・インターネット'),('製造業'),('金融・保険'),
('建設・不動産'),('小売・流通'),('医療・福祉'),('教育'),('公務員'),('その他');

INSERT IGNORE INTO work_place_tbl (work_place) VALUES 
('東京'),('大阪'),('名古屋'),('福岡'),('札幌'),('仙台'),('広島'),('その他');

INSERT IGNORE INTO occupations_tbl (occupation, industry_name) VALUES 
('システムエンジニア', 'IT・ソフトウェア'),
('プログラマー', 'IT・ソフトウェア'),
('Webデザイナー', 'IT・ソフトウェア'),
('データベースエンジニア', 'IT・ソフトウェア'),
('ネットワークエンジニア', '通信・インターネット'),
('営業職', 'その他'),
('事務職', 'その他'),
('企画職', 'その他');

INSERT IGNORE INTO students (student_id, name, name_kana, graduation_year) VALUES 
('2023001', '山田太郎', 'ヤマダタロウ', 2025),
('2023002', '佐藤花子', 'サトウハナコ', 2025),
('2023003', '田中次郎', 'タナカジロウ', 2024),
('2023004', '鈴木美咲', 'スズキミサキ', 2026),
('2023005', '高橋健一', 'タカハシケンイチ', 2025);

INSERT IGNORE INTO users (id, password, role, salt) VALUES 
('admin', '8c6976e5b5410415bde908bd4dee15dfb167a9c873fc4bb8a81f6f2ab448a918', 'admin', 'salt123'),
('teacher', '9d6976e5b5410415bde908bd4dee15dfb167a9c873fc4bb8a81f6f2ab448a918', 'teacher', 'salt456'),
('student', 'ae6976e5b5410415bde908bd4dee15dfb167a9c873fc4bb8a81f6f2ab448a918', 'student', 'salt789'),
('test', 'bf6976e5b5410415bde908bd4dee15dfb167a9c873fc4bb8a81f6f2ab448a918', 'student', 'testsalt'),
('demo', '5e884898da28047151d0e56f8dc6292773603d0d6aabbdd62a11ef721d1542d8', 'student', 'demosalt');

-- 完了メッセージ
SELECT '学校サーバー用データベースセットアップが完了しました。' AS message; 