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
	String nickname = request.getParameter("nickname");	//nickname 이 undefined 되는 오류 -> 회원이름을 nickname 에서 email 로 교체 
	String age = request.getParameter("age");
	String birthday = request.getParameter("birthday");
	String email = request.getParameter("email");
	String id = request.getParameter("id");
	String gender = request.getParameter("gender");
	
	
	%>
	
	
	<sql:query var="resultSet" dataSource="${conn}">
	   select * 
	     from user 
	    where user_id = ?  
	    <sql:param value="<%=id %>"/>    
	</sql:query>

	
	
	<c:if test="${resultSet.rowCount > 0}">
	<c:set var="sessionId"
			value="<%=email %>" 
			scope="session"/> 
		<script>
			alert("로그인되었습니다."); 
		</script>
	<c:redirect url="/index.jsp"/>	
	</c:if>

	<c:if test="${resultSet.rowCount == 0}">
	<sql:update var="resultSet" dataSource="${conn}">
		insert into user values(?,?,?,?,?,?,?,?,?,?,1,now(),now())
		
		<sql:param value="<%=email %>"/>		
		<sql:param value="<%=email %>"/>
		<sql:param value="<%=email %>"/> 
		<sql:param value="<%=birthday %>"/> 
		<sql:param value=" "/> 
		<sql:param value="<%=email %>"/> 
		<sql:param value="<%=gender %>"/> 
		<sql:param value=" "/>
		<sql:param value=" "/>
		<sql:param value=" "/> 
	</sql:update>
	
	<c:set var="sessionId"
			value="<%=email %>" 
			scope="session"/> 
		<script>
			alert("로그인되었습니다."); 
		</script>
	<c:redirect url="/index.jsp"/>	
	</c:if>
 




</body>
</html>