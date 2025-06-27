-- 斡旋種類テーブルの追加
-- このスクリプトを実行して斡旋の種類を管理できるようにします

-- 斡旋種類テーブルを作成
CREATE TABLE IF NOT EXISTS mediation_types (
    mediation_type_id INT AUTO_INCREMENT PRIMARY KEY,
    mediation_type_name VARCHAR(50) NOT NULL UNIQUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 斡旋種類のサンプルデータを挿入
INSERT IGNORE INTO mediation_types (mediation_type_name) VALUES 
('学校斡旋'),
('自己応募'),
('エージェント'),
('紹介'),
('その他');

-- students_tblに斡旋種類IDのカラムを追加（オプション）
-- 注意: 既存のデータがある場合は慎重に実行してください
-- ALTER TABLE students_tbl ADD COLUMN mediation_type_id INT;
-- ALTER TABLE students_tbl ADD FOREIGN KEY (mediation_type_id) REFERENCES mediation_types(mediation_type_id); 