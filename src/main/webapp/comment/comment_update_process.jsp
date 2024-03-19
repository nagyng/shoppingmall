<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
<% 
int cm_no = Integer.parseInt(request.getParameter("cm_no")); 
String cm_content = request.getParameter("cm_content"); 
System.out.println("cm_no" + cm_no); 
System.out.println("cm_content" + cm_content); 
%> 
<sql:update var="resultSet" dataSource="${conn}">
	update 	comment
	set		cm_content=?, 
			cm_updatetime=now() 
	where	cm_no=? 
	<sql:param value="<%=cm_content%>" />
	<sql:param value="<%=cm_no%>" />
</sql:update>

<!-- update 문이 성공하면 resultSet 에 1 리턴, 1 리턴되면 강제 이동 -->
<c:if test="${resultSet>=1}">
	<c:redirect url="/QnaListAction.qdo?pageNum=1" />
</c:if>


</body>
</html>