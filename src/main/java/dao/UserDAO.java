package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

//UserDAO.java

//https://riucc.tistory.com/408


public class UserDAO {

	private Connection conn;

	public UserDAO() { // 생성자를 통한 db 연결

		try {

			String dbURL = "jdbc:mysql://localhost:3306/register";

			String dbID = "root";

			String dbPW = "wlgns930";

			Class.forName("com.mysql.jdbc.Driver");

			conn = DriverManager.getConnection(dbURL, dbID, dbPW);

		} catch(Exception e) {

			e.printStackTrace();

		}

	}



	// 입력받은 유저 아이디 디비에서 있는지를 체크해서 값 반환
	public int registerCheck(String userID) {
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String SQL = "select * from user where userID = ?";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			rs = pstmt.executeQuery();
			if(rs.next() || userID.equals("")) { // 결과가 있다면
				return 0; // 이미 존재하는 아이디
			} else {
				return 1; // 가입 가능한 아이디
			} 
		}catch(Exception e) {
			e.printStackTrace();
		} finally {	
			try {	
				if(rs != null) rs.close();
				if(pstmt !=null) pstmt.close();
			} catch(Exception e) {
				e.printStackTrace();
			}
		}
		return -1; // 데이터베이스 오류
	}
}