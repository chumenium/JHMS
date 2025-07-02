package utils;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.io.FileInputStream;
import java.io.IOException;
import java.util.Properties;

/**
 * データベース接続ユーティリティクラス
 * 環境に応じて接続設定を変更可能
 */
public class DBConnection {
  private static final String CONFIG_FILE = "database.properties";
  private static String URL;
  private static String USER;
  private static String PASSWORD;
  
  static {
    loadConfig();
  }
  
  private static void loadConfig() {
    Properties props = new Properties();
    try {
      // 設定ファイルから読み込み
      props.load(new FileInputStream(CONFIG_FILE));
      URL = props.getProperty("db.url", "jdbc:mysql://localhost:3306/jms");
      USER = props.getProperty("db.user", "root");
      PASSWORD = props.getProperty("db.password", "kcsf");
    } catch (IOException e) {
      // 設定ファイルが見つからない場合はデフォルト値を使用
      System.out.println("設定ファイルが見つかりません。デフォルト設定を使用します。");
      URL = "jdbc:mysql://localhost:3306/jms";
      USER = "root";
      PASSWORD = "kcsf";
    }
  }

    /**
     * データベース接続を取得する
     * @return Connection データベース接続オブジェクト
     * @throws SQLException SQL例外
     * @throws ClassNotFoundException クラスが見つからない例外
     */
    public static Connection getConnection() throws SQLException, ClassNotFoundException {
        Class.forName("com.mysql.cj.jdbc.Driver");
        return DriverManager.getConnection(URL, USER, PASSWORD);
    }
}