<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%> 
<%
	String id = request.getParameter("id");	
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;

	String driver = "com.mysql.cj.jdbc.Driver";
 	String url="jdbc:mysql://localhost:3307/project?serverTimezone=Asia/Seoul"; 
	Class.forName(driver);
 	conn = DriverManager.getConnection(url,"project","project");
	String sql = "SELECT * FROM user WHERE user_id=?";
	pstmt = conn.prepareStatement(sql);
	pstmt.setString(1, id);
	rs = pstmt.executeQuery();

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>중복 확인</title>
</head>
<body>
	<%if(rs.next()) { %>
	<script>
	alert('중복입니다.')
	location.href = "/user/join.jsp";	
	</script>
	<% } else { %>
	<script>
	alert('사용가능한 아이디 입니다.')
	location.href = "/user/join.jsp";	
	</script>
	<% } %>
</body>
</html>