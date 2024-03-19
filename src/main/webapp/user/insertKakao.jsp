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

String id = request.getParameter("id");
String kaccount_email = request.getParameter("kaccount_email");
String nickname = request.getParameter("nickname");

%>
 
	
	<sql:query var="resultSet" dataSource="${conn}">
	   select * 
	     from user 
	    where user_id = ?  
	    <sql:param value="<%=id%>"/>    
	</sql:query>

	
	
	<c:if test="${resultSet.rowCount > 0}">
	<c:set var="sessionId"
			value="<%=id%>" 
			scope="session"/> 
		<script>
			alert("로그인되었습니다."); 
		</script>
	<c:redirect url="/index.jsp"/>	
	</c:if>

	<c:if test="${resultSet.rowCount == 0}">
	<sql:update var="resultSet" dataSource="${conn}">
		insert into user values(?,?,?,null,?,?,null,?,?,?,1,now(),now())
		
		<sql:param value="<%=id%>"/>		
		<sql:param value="<%=id%>"/>
		<sql:param value="<%=nickname%>"/> 
		<sql:param value=" "/> 
		<sql:param value="<%=kaccount_email%>"/> 
		<sql:param value=" "/>
		<sql:param value=" "/>
		<sql:param value=" "/> 
	</sql:update>
	
	<c:set var="sessionId"
			value="<%=id%>" 
			scope="session"/> 
		<script>
			alert("로그인되었습니다."); 
		</script>
	<c:redirect url="/index.jsp"/>	
	</c:if>


</body>
</html>