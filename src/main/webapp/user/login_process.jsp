<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	
	<%@ include file="/dbconnection.jsp" %>
	
	<sql:query var="resultSet" dataSource="${conn}">
	   select * 
	     from user 
	    where user_id = ? 
	      and user_pw = ? 
	    <sql:param value="${param.id}"/>   
		<sql:param value="${param.password}"/>
	</sql:query>
	
	<!-- 아이디,비밀번호가 맞으면 sessionId 세션 속성값 생성 -->
	<c:if test="${resultSet.rowCount > 0}">
		<c:set var="sessionId"
		       value="${param.id}" 
			   scope="session"/> 
		<c:redirect url="/index.jsp"/>	
	</c:if>
	
	<!-- 아이디 혹은 비밀번호가 맞지 않으면 로그인 화면으로 이동 -->
	<c:if test="${resultSet.rowCount == 0}">
		<script>
			alert("로그인 정보를 다시 확인하세요.");
			history.back();
		</script>
		<!-- <c:out value='로그인 정보를 다시 확인하세요.'></c:out> -->
		<%-- <c:redirect url="login.jsp"/> --%>
	</c:if>


	 
	
	
</body>
</html>