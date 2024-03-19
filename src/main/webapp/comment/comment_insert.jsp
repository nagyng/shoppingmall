<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ include file="/dbconnection.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body> 
<%@ include file="/header.jsp" %>
<%
int qna_no3 = Integer.parseInt(request.getParameter("qna_no")); 
System.out.println("qna_no3" + qna_no3);
%>  

	<sql:query var="resultSet3" dataSource="${conn}">
		select * 
		from user
		where user_id = ? 
	<sql:param value="${sessionId}"/>   
	</sql:query>
	<c:forEach var="row" items="${resultSet3.rows}">
	
	<div class="container input-group"> 
	<!-- grade 가 10일때 -->
	<c:if test="${row.grade == 10}">
	 <form action="comment_insert_process.jsp" method="post"> 	<!-- form -->
		<table class="table   table-sm table-bordered  "> 
			<tr>  
				<td><input type="text" class="input-group-text"  size=5 readonly></td>
				<td><input type="text" class="input-group-text"  id="user_id" name="user_id" size=5 value="  <c:out value=' ${row.user_id }' />" readonly></td>
				<td><input type="text" class="input-group-text"  id="cm_content" name="cm_content" size=75 required></td>
				<td><input type="text" class="input-group-text"  id="cm_createtime" name="cm_createtime" size=10></td>
				<td>
					<input type="submit" value="등록" > 
					<input type="button" value="취소">
				</td> 
			</tr> 
		</table>
	 </form>
	</c:if>
				
	</div>
	</c:forEach>
<%@ include file="/footer.jsp" %>

</body>
</html>