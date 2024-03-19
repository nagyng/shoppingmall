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
%>
		
	<div class="container input-group">
		<table class="table table-hover table-sm table-bordered table-striped">
			<thead class="table-active">
				<tr>
					<th class="text-center">No.</th>
					<th class="text-center">댓글 번호</th>
					<th class="text-center">아이디</th>
					<th class="text-center">내용</th>
					<th class="text-center">작성일</th>
					<th class="text-center">편집</th>
				</tr>
			</thead> 
			
			
			<!-- 댓글 정보 가져오기 -->
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
			
				<!-- 세션 로그인한 사용자 정보 불러오기 -->
				<sql:query var="resultSet2" dataSource="${conn}">
					select * 
					from user
					where user_id = ? 
				<sql:param value="${sessionId}"/> 
				</sql:query> 
				<c:forEach var="row2" items="${resultSet2.rows}">
					
					<!-- 본인 아이디와 댓글 작성자가 일치하지 않을 때 --><!-- 관리자가 아닐 때 -->
					<c:if test="${row2.grade != 10}">
					<td><c:out value='${row.cm_no }'/></td>
					<td><c:out value='${row.qna_no }'/></td>
					<td><c:out value='${row.user_id }'/></td>
					<td><c:out value='${row.cm_content }'/></td>
					<td><c:out value='${row.cm_createtime }'/></td>
					<td> </td>
					</c:if>
					  
					<!-- 본인 아이디로 적은 댓글이거나, 관리자 등급인 10 일때 -->  
				<form action="/comment/comment_update_process.jsp" method="post">
					<c:if test="${row.user_id == row2.user_id or row2.grade == 10}"> 
					<td><input type="text" name="cm_no" class="input-group-text"  size=1  value="<c:out value='${row.cm_no }'/>" readonly></td>
					<td><input type="text" name="qna_no" class="input-group-text"  size=1  value="<c:out value='${row.qna_no }'/>" readonly></td>
					<td><input type="text" name="user_id" class="input-group-text"  size=5  value="<c:out value='${row.user_id }'/>" readonly></td>
					<td><input type="text" name="cm_content"  class="input-group-text"  maxlength=50  size=65  value="<c:out value='${row.cm_content }'/>" required></td>
					<td><input type="text" name="cm_createtime" class="input-group-text"  size=5  value="<c:out value='${row.cm_createtime }'/>" readonly></td> 
						<td>
							<input type="submit" value="수정">
							<input type="button" value="삭제" onclick="location.href='/comment/comment_delete.jsp?cm_no=<c:out value='${row.cm_no }'/>'">
						</td>
					</c:if> 
				</form>
				</c:forEach> 
			</tr>
			</c:forEach>
		</table>
	</div>



</body>
</html>