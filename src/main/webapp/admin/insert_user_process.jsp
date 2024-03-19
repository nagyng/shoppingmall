<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/dbconnection.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
		request.setCharacterEncoding("utf-8");
	
		String user_id = request.getParameter("id");
		String user_pw = request.getParameter("password");
		String username = request.getParameter("name");
		String birthday = request.getParameter("birthday");
		String phone = request.getParameter("phone");
		String email1 = request.getParameter("email1");
		String email2 = request.getParameter("email2");
		String email = email1 + "@" + email2;
		String gender = request.getParameter("gender");
		String zipcode = request.getParameter("zipcode");
		String addr1 = request.getParameter("addr1");
		String addr2 = request.getParameter("addr2");
		int grade = Integer.parseInt(request.getParameter("grade"));

		 
	%>
	
	
	<sql:update var="resultSet" dataSource="${conn}">
		insert into user values(?,?,?,?,?,?,?,?,?,?,?,now(),null)
		
		<sql:param value="<%=user_id%>"/>		
		<sql:param value="<%=user_pw%>"/>
		<sql:param value="<%=username%>"/>
		<sql:param value="<%=birthday%>"/>
		<sql:param value="<%=phone%>"/>
		
		<sql:param value="<%=email%>"/>
		<sql:param value="<%=gender%>"/>
		<sql:param value="<%=zipcode%>"/>
		<sql:param value="<%=addr1%>"/>
		<sql:param value="<%=addr2%>"/>
		<sql:param value="<%=grade%>"/>
	</sql:update>
	
	<%
	out.println("<script>");
	out.println("alert('회원 등록이 완료되었습니다.');");
	out.println("location.href='/admin/userListAjax.jsp';");
	out.println("</script>");
	%>
	
	
</body>
</html>