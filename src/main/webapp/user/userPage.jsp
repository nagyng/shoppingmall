<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/header.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MY PAGE</title>
<style type="text/css">
.myPageDiv {
	min-height: 800px;
}
</style>
</head>
<body>
<%@ include file="/top.jsp" %> 
<div class="myPageDiv col-9 container-fluid p-5">
	<sql:query var="resultSet" dataSource="${conn}"> 
	   SELECT * FROM user WHERE user_id = ?
	<sql:param value="${sessionId}" />
	</sql:query>
				
	<c:forEach var="row" items="${resultSet.rows}">   
		<c:set var="email" value="${row.email}" />
		<c:set var="email1" value="${email.split('@')[0]}" />
		<c:set var="email2" value="${email.split('@')[1]}" />
		<c:set var="birthday" value="${row.birthday }" />
	
		<div class="jumbotron text-center">
		  <h1 class="display-4 mb-5">안녕하세요, '${row.username}'님!</h1>
		  <div>
		  	<p class="lead">ID: <c:out value='${row.user_id}'/> | EMAIL: <c:out value='${row.email}'/></p>
		  </div>
		  <hr class="my-4">
		  <p>정보, 개인 정보 보호 및 보안 설정을 관리하여 나에게 맞는 방식으로 사용할 수 있습니다.</p>
		  <a class="btn btn-light btn-lg" href="/user/update.jsp" role="button">개인정보 관리</a>
		  <a class="btn btn-warning btn-lg" href="/user/userOrderAjax.jsp" role="button">주문 내역 확인</a>  
		  <a class="btn btn-dark btn-lg" href="/user/delete.jsp" role="button">회원 탈퇴</a> 
		</div>
	</c:forEach>
	
	<div class="text-center p-5">
	  <a class="btn btn-link btn-lg" href="/service/store.jsp" role="button">매장 안내</a> 
	  <a class="btn btn-link btn-lg" href="/service/call.jsp" role="button">전화 상담 안내</a>  
	</div>
</div>
<%@ include file="/footer.jsp" %>
</body>
</html>