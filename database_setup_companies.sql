-- 企業管理用テーブル作成
CREATE TABLE IF NOT EXISTS companies (
    company_id INT AUTO_INCREMENT PRIMARY KEY,
    company_name VARCHAR(255) NOT NULL,
    industry VARCHAR(100) NOT NULL,
    location VARCHAR(255) NOT NULL,
    contact_person VARCHAR(100) NOT NULL,
    phone VARCHAR(20) NOT NULL,
    email VARCHAR(255),
    website VARCHAR(255),
    description TEXT,
    status VARCHAR(50) NOT NULL DEFAULT 'アクティブ',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX idx_company_name (company_name),
    INDEX idx_industry (industry),
    INDEX idx_status (status)
);

-- サンプルデータ挿入
INSERT INTO companies (company_name, industry, location, contact_person, phone, email, website, description, status) VALUES
('株式会社テックソリューション', 'IT・ソフトウェア', '東京都渋谷区', '田中太郎', '03-1234-5678', 'tanaka@techsolution.co.jp', 'https://www.techsolution.co.jp', 'Webアプリケーション開発を専門とするIT企業です。', 'アクティブ'),
('製造工業株式会社', '製造業', '大阪府大阪市', '佐藤花子', '06-2345-6789', 'sato@manufacturing.co.jp', 'https://www.manufacturing.co.jp', '自動車部品の製造を手がける製造業です。', 'アクティブ'),
('金融サービス株式会社', '金融・保険', '東京都千代田区', '鈴木一郎', '03-3456-7890', 'suzuki@financial.co.jp', 'https://www.financial.co.jp', '個人向け金融サービスを提供する企業です。', 'アクティブ'),
('建設開発株式会社', '建設業', '愛知県名古屋市', '高橋美咲', '052-4567-8901', 'takahashi@construction.co.jp', 'https://www.construction.co.jp', '住宅建設を専門とする建設会社です。', 'アクティブ'),
('小売流通株式会社', '小売・流通', '福岡県福岡市', '渡辺健太', '092-5678-9012', 'watanabe@retail.co.jp', 'https://www.retail.co.jp', '食品小売を中心とした流通企業です。', 'アクティブ'),
('サービスプロバイダー株式会社', 'サービス業', '北海道札幌市', '伊藤麻衣', '011-6789-0123', 'ito@service.co.jp', 'https://www.service.co.jp', '顧客サービスを専門とする企業です。', '非アクティブ'),
('ITスタートアップ株式会社', 'IT・ソフトウェア', '東京都新宿区', '山田次郎', '03-7890-1234', 'yamada@startup.co.jp', 'https://www.startup.co.jp', 'AI技術を活用したスタートアップ企業です。', '保留'); 