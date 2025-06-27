package utils;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 * データベース接続ユーティリティクラス
 * PCが変わるたび変更をすること
 */
public class DBConnection {
    private static final String URL = "jdbc:mysql://localhost:3306/jms";
    private static final String USER = "root";
    private static final String PASSWORD = "kcsf";

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