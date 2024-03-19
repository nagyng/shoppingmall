<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<!-- 데이터베이스를 연결하기 위해 선언 -->
	<%@ include file="/dbc_notsql.jsp" %>
	
	<%
		String id = request.getParameter("id");
		String passwd = request.getParameter("passwd");
		String name = request.getParameter("name");
		
		//sql문장을 실행시키기 위해서 준비작업을 수행하는 객체
		PreparedStatement pstmt = null;
		
		try {
			
			String sql = "insert into member values(?,?,?)";
			
			//sql문장을 실행하기 준비
			pstmt = conn.prepareStatement(sql);
			
			//첫번째 ?에 아이디 변수값을 대입
			pstmt.setString(1,id);
			pstmt.setString(2,passwd);
			pstmt.setString(3,name);
			
			//insert,update,delete
			//select를 실행시에는 pstmt.executeQuery()
			pstmt.executeUpdate();
			
			out.println("member 테이블에 추가 성공");
			
		}catch(SQLException e){
			out.println("member 테이블에 추가 실패");
			out.println("SQLException:" + e.getMessage());
		}finally{
			//반드시 실행되는 명령문을 선언
			//데이터베이스 사용시 close() 수행
			if(pstmt != null) pstmt.close();
			if(conn != null) conn.close();
		}
	%>

</body>
</html>





