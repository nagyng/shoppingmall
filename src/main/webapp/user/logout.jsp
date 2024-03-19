<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그아웃</title>
</head>
<body>
	<%
		//생성된 모든 세션값을 삭제처리
		session.invalidate();
		response.sendRedirect("/index.jsp");
	%>
</body>
</html>