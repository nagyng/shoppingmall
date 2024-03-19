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
int qna_no2 = Integer.parseInt(request.getParameter("qna_no")); 
int cm_no = Integer.parseInt(request.getParameter("cm_no"));
int qna_no = Integer.parseInt(request.getParameter("qna_no"));
String user_id = request.getParameter("user_id"); 
String cm_content = request.getParameter("cm_content"); 
String cm_createtime = request.getParameter("cm_createtime"); 
System.out.println("cm_no" + cm_no); 

%>
		
	<div class="container input-group">
		<table class="table table-hover table-sm table-bordered table-striped">
			<thead class="table-active">
				<tr>
					<th class="text-center">No.</th>
					<th class="text-center">아이디</th>
					<th class="text-center">내용</th>
					<th class="text-center">작성일</th>
					<th class="text-center">편집</th>
				</tr>
			</thead>
			 <!-- CONCAT(cm_no, '-', qna_no)  as cm_no,  -->
			<sql:query var="resultSet" dataSource="${conn}">
			   SELECT 		cm_no as cm_no, 
			   				qna_no as qna_no,
							user_id as user_id,
							cm_content as cm_content,
							cm_createtime as cm_createtime
				FROM 		comment 
			   WHERE 		qna_no = ?
			   ORDER BY		cm_createtime asc
			   <sql:param value="<%=qna_no2 %>" />
			</sql:query>
			<c:forEach var="row" items="${resultSet.rows}">
			
			<tr>
				<td><input type="text" value="<c:out value='${row.cm_no }'/>" readonly></td>
				<td><input type="text" value="<c:out value='${row.user_id }'/>" readonly></td>
				<td><input type="text" value="<c:out value='${row.cm_content }'/>"></td>
				<td><input type="text" value="<c:out value='${row.cm_createtime }'/>" readonly></td>
				
				<sql:query var="resultSet2" dataSource="${conn}">
					select * 
					from user
					where user_id = ? 
				<sql:param value="${sessionId}"/>   
				</sql:query>
				<c:forEach var="row2" items="${resultSet2.rows}">
				<!-- grade 가 10일때 -->
				<form action="" method="post">
				<c:if test="${row2.grade == 10}">
					<td>
						<input type="button" value="수정" onclick="location.href='/comment/comment_update_process.jsp?cm_no=<c:out value='${row.cm_no }'/>'">
						<input type="button" value="삭제" onclick="location.href='/comment/comment_delete.jsp?cm_no=<c:out value='${row.cm_no }'/>'">
					</td>
				</c:if>
				</c:forEach> 
			</tr>
			</c:forEach>
		</table>
	</div>



</body>
</html>