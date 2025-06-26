package utils; 

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException; 

//PCが変わるたび変更をすること
public class DBConnection {
  private static final String URL = "jdbc:mysql://localhost:3306/jms?useSSL=false&serverTimezone=UTC&allowPublicKeyRetrieval=true";
  private static final String USER = "root";
  private static final String PASSWORD = "kcsf";

  public static Connection getConnection() throws SQLException {
      try {
          // MySQL Connector/J 8.0以降のドライバークラス名
      Class.forName("com.mysql.cj.jdbc.Driver");
      } catch (ClassNotFoundException e) {
          // 古いバージョンのドライバーを試す
          try {
              Class.forName("com.mysql.jdbc.Driver");
          } catch (ClassNotFoundException e2) {
              throw new SQLException("MySQL JDBC Driver not found", e2);
          }
      }
      return DriverManager.getConnection(URL, USER, PASSWORD);
  }
}