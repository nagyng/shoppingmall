<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ include file="/header.jsp" %>
<%@ include file="/dbconnection.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>아이디 찾기</title>
<style type="text/css">
	.idFindDiv {
		height: 700px;
	}
	.messenger {
		margin: auto;
		display: inline;
	}
</style>
</head>
<body>
<% 
String username = request.getParameter("username");
String phone = request.getParameter("phone"); 
%>

	<!-- var		:	select문을 수행 후 리턴값을 가지는 변수
		dataSource	:	데이터베이스 연결을 설정하는 속성 -->
	<sql:query var="resultSet" dataSource="${conn}"> 
	select	count(*) as cnt, max(user_id) as user_id  
	from	user
	where 	username=?
	and		phone=?
	<sql:param value="${param.username}" />
	<sql:param value="${param.phone}" />
	</sql:query>
	
	
	
	<div class="container idFindDiv">
	<c:forEach var="row" items="${resultSet.rows}">
 		<c:if test="${row.cnt > 0}">
			<div class="p-5">
				<div class="container-fluid">
					<h1 class="display-5 fw-bold text-center">아이디 찾기</h1> 
				</div>
			</div>
				<div class="container-fluid col-lg-8 col-md-12 col-sm-12 ">
	
					<div class="input-group input-group-lg mb-3">
						<div class="input-group-prepend">
						  <label class="input-group-text " id="inputGroup-sizing-lg">아이디</label>
						</div>
						<input value="<c:out value='${row.user_id }'/>" name="id" id="id" type="text" class="form-control " aria-label="Sizing example input" aria-describedby="inputGroup-sizing-lg" readonly> 
					</div>
					<div class="mb-3 container text-center">
						<div class="col-sm-offset-2 col-sm-10 messenger">
							<input type="button" class="btn btn-primary " value="로그인 화면으로 돌아가기" onclick="location.href='login.jsp'">
							<input type="button" class="btn btn-secondary" value="비밀번호 찾기" onclick="location.href='pw_find.jsp'">
						</div>
					</div>
			</div>
		</c:if>
		
		<c:if test="${row.cnt == 0}"> 
			<c:redirect url="findError.jsp" />
		</c:if> 
	</c:forEach>
	</div> 
		 


	
 
<%@ include file="/footer.jsp" %>


</body>
</html>