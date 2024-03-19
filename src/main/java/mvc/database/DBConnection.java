package mvc.database;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {

	public static Connection getConnection() throws SQLException, ClassNotFoundException {
		Connection conn = null;
		
		String driver = "com.mysql.cj.jdbc.Driver";
	 	String url="jdbc:mysql://localhost:3307/project?serverTimezone=Asia/Seoul";
	 	String user="project";
	 	String password="project";
		
		Class.forName(driver);
		conn = DriverManager.getConnection(url, user, password);
		
		return conn;
	}
}
