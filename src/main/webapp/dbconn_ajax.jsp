<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>  

	<%
		//데이터베이스 연결 객체
		Connection conn = null;
	
		//예외처리를 선언
		try {
		 
			String driver = "com.mysql.cj.jdbc.Driver";
		 	String url="jdbc:mysql://localhost:3307/project?serverTimezone=Asia/Seoul";
		 	String user="project";
		 	String password="project";
		 	
		 	//mysql jdbc 드라이버를 메모리에 로딩
			Class.forName(driver);
			
		 	//데이터베이스 연결
		 	conn = DriverManager.getConnection(url,user,password);
		 	
		 	//out.println("project 연결 성공!");

			
		}catch(SQLException e){
			out.println("project 연결 실패!");
			out.println("SQLException:" + e.getMessage());
		}
		
	%>