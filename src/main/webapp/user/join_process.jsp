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

		 
	%>
	
	
	<sql:update var="resultSet" dataSource="${conn}">
		insert into user values(?,?,?,?,?,?,?,?,?,?,1,now(),null)
		
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
	</sql:update>
	
	
		
	<sql:query var="resultSet2" dataSource="${conn}">
	   select * 
	     from user 
	    where user_id = ? 
	      and user_pw = ? 
	    <sql:param value="${param.user_id}"/>   
		 <sql:param value="${param.user_pw}"/>
	</sql:query>
	
	<c:forEach var="row2" items="${resultSet2.rows}">
	<c:if test="${resultSet2.rowCount > 0}">
		<script>
			alert("중복된 계정으로 가입하실 수 없습니다.");
			history.back();
		</script>
	</c:if>
	</c:forEach>
	
	
	
	
	
	
	<%
	out.println("<script>");
	out.println("alert('회원가입을 완료했습니다!');");
	out.println("location.href='/index.jsp';");
	out.println("</script>");
	%>
	
	
</body>
</html>