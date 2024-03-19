<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.net.URLEncoder" %>
<%@ page import="java.security.SecureRandom" %>
<%@ page import="java.math.BigInteger" %>
<%@ include file="/header.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 탈퇴</title>
<style type="text/css">
	.deleteDiv {
		height: 700px;
	}
	.messenger {
		margin: auto;
		display: inline;
	}
</style>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script>

$(document).ready(function(){
	
	checkValue = function(){
		
		if(!$("#user_pw").val()){
			alert("비밀번호를 입력하세요!");
			return false;
		}
		
		deleteUser.submit();
	}		
	
});
</script>
</head>
<body>
<%@ include file="/dbconnection.jsp" %>


	<sql:query var="resultSet" dataSource="${conn}"> 
	   SELECT * FROM user WHERE user_id = ?
	<sql:param value="${sessionId}" />
	</sql:query>
	<c:forEach var="row" items="${resultSet.rows}">


	<div class="container deleteDiv">
		<div class="p-5">
			<div class="container-fluid">
				<h1 class="display-5 fw-bold text-center">회원 탈퇴</h1> 
			</div>
		</div>
		<div class="container-fluid col-lg-8 col-md-12 col-sm-12 ">
			<form name="deleteUser" action="delete_process.jsp" method="post">
				<div class="input-group input-group-lg mb-3">
					<div class="input-group-prepend">
					<label class="input-group-text" id="inputGroup-sizing-lg">비밀번호 확인</label>
					</div>
					<input name="user_pw" id="user_pw" type="text" class="form-control" aria-label="Sizing example input" aria-describedby="inputGroup-sizing-lg" placeholder="password">
				</div>
				<div class="mb-3 text-center">
					<div class="messenger">
						<input type="button" class="btn btn-secondary " value="탈퇴하기" onclick="checkValue();">
					</div>
				</div>
			</form>
		</div>
	</div>
	
	</c:forEach>
	
<%@ include file="/footer.jsp" %>

</body>
</html>