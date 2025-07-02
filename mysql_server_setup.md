# このPCをMySQLサーバーとして設定する手順

## 1. MySQLのインストール

### 方法A: MySQL Installer for Windows（推奨）
1. https://dev.mysql.com/downloads/installer/ からMySQL Installerをダウンロード
2. インストーラーを実行
3. 「Developer Default」または「Server only」を選択
4. インストール完了後、MySQL Serverを設定

### 方法B: XAMPP（簡単）
1. https://www.apachefriends.org/ からXAMPPをダウンロード
2. インストール時にMySQLのみを選択
3. XAMPP Control PanelからMySQLを起動

## 2. MySQLの設定

### ポート設定
- デフォルトポート: 3306
- ファイアウォールでポート3306を開放

### ユーザー作成
```sql
-- MySQLにログイン後
CREATE USER 'jms_user'@'%' IDENTIFIED BY 'jms_password';
GRANT ALL PRIVILEGES ON jms.* TO 'jms_user'@'%';
FLUSH PRIVILEGES;
```

## 3. ファイアウォール設定

### Windowsファイアウォール
1. Windows Defenderファイアウォールを開く
2. 「詳細設定」→「受信の規則」
3. 「新しい規則」→「ポート」
4. TCP、特定のローカルポート: 3306
5. 「接続を許可する」を選択
6. ドメイン、プライベート、パブリックを選択
7. 名前: MySQL Server

## 4. ネットワーク設定

### IPアドレスの確認
```cmd
ipconfig
```
- IPv4アドレスをメモ（例: 192.168.1.100）

### ルーター設定（必要に応じて）
- ポートフォワーディング: 外部ポート3306 → 内部IP:3306

## 5. 接続テスト

### ローカル接続テスト
```cmd
mysql -u jms_user -p -h localhost
```

### 外部からの接続テスト
他のPCから:
```cmd
mysql -u jms_user -p -h 192.168.1.100
```

## 6. アプリケーション設定

### database.propertiesの更新
```properties
# このPCをサーバーとして使用
db.url=jdbc:mysql://192.168.1.100:3306/jms
db.user=jms_user
db.password=jms_password
```

## 注意事項
- セキュリティのため、強力なパスワードを使用
- 必要に応じてVPNを使用
- 定期的なバックアップを設定
- ファイアウォール設定を適切に行う 