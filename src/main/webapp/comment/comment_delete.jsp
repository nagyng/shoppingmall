<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<%@ include file="/dbconnection.jsp"%>
 
	<%
		request.setCharacterEncoding("utf-8"); 
		int cm_no = Integer.parseInt(request.getParameter("cm_no"));

		 
	%>

<sql:update var="resultSet" dataSource="${conn}">
   DELETE 
   FROM comment 
   WHERE cm_no = ?
   <sql:param value="${param.cm_no}" />
</sql:update>


<!-- 정상적으로 삭제처리시  이동 -->
<c:if test="${resultSet>=1}">
	<c:redirect url="/QnaListAction.qdo?pageNum=1" />
</c:if>


</body>
</html>