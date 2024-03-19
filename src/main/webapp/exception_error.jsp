<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page isErrorPage="true" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>오류 페이지</title>
<style type="text/css">
.errorDiv {
	min-height:700px;
}
</style>
</head>
<body>
<%@ include file="header.jsp" %>
<%@ include file="top.jsp" %>
<div class="errorDiv">
	<p>오류가 발생하였습니다.
	<p>예외: <%=exception %>
	<p>toString() : <%=exception.toString() %>		
	<p>getClass().getName() : <%=exception.getClass().getName() %>		
	<p>getMessage() : <%=exception.getMessage() %>
</div>
<%@ include file="footer.jsp" %>
</body>
</html>