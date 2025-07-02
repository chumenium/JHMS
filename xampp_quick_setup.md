# XAMPPでの簡単MySQLサーバー設定

## 1. XAMPP Control Panelを起動
- スタートメニューから「XAMPP Control Panel」を検索して起動

## 2. MySQLを起動
- XAMPP Control Panelで「MySQL」の「Start」ボタンをクリック
- ステータスが「Running」になることを確認

## 3. ファイアウォール設定（自動で表示される場合）
- Windowsファイアウォールの警告が表示されたら「アクセスを許可」をクリック

## 4. 外部接続を許可する設定
1. XAMPP Control Panelで「MySQL」の「Config」ボタンをクリック
2. 「my.ini」を選択
3. 以下の行を探して編集：

```ini
# この行を探す
bind-address = 127.0.0.1

# 以下のように変更
bind-address = 0.0.0.0
```

4. ファイルを保存
5. MySQLを再起動（Stop → Start）

## 5. 接続確認
- このPCのIPアドレス: 10.22.107.3
- ポート: 3306
- 他のPCから接続可能になる

## 6. データベース作成（手動で実行）
- phpMyAdminにアクセス: http://localhost/phpmyadmin
- または、MySQLコマンドラインで実行

## 注意事項
- XAMPPを起動するたびにMySQLを手動で起動する必要があります
- 自動起動したい場合は、XAMPP Control Panelの「Config」→「Service and Port Settings」で設定可能 