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
<title>아이디 찾기</title>
<style type="text/css">
	.pwFindDiv {
		height: 700px;
	}
	.messenger {
		margin: auto;
		display: inline;
	}
	.input-group-text {
		min-width: 150px;
	}
</style>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script>
	$(document).ready(function(){
		checkValue = function(){

			if(!$("#user_id").val()){
				alert("아이디를 입력하세요!");
				return false;
			}
			pwFind.submit();
		}		
	});
</script>
</head>
<body>
	<div class="container pwFindDiv">
		<div class="p-5">
			<div class="container-fluid">
				<h1 class="display-5 fw-bold text-center">비밀번호 찾기</h1> 
			</div>
		</div>
			<div class="container-fluid col-lg-8 col-md-12 col-sm-12 ">
			<form name="pwFind" action="pw_find_process.jsp" method="post">
				<div class="input-group input-group-lg mb-3">
					<div class="input-group-prepend">
					  <label class="input-group-text " id="inputGroup-sizing-lg">아이디</label>
					</div>
					<input name="user_id" id="user_id" type="text" class="form-control " aria-label="Sizing example input" aria-describedby="inputGroup-sizing-lg" placeholder="ID" required>
				</div>
				<div class="input-group input-group-lg mb-3">
					<div class="input-group-prepend">
					  <label class="input-group-text " id="inputGroup-sizing-lg">연락처</label>
					</div>
					<input name="phone" id="phone" type="text" class="form-control " aria-label="Sizing example input" aria-describedby="inputGroup-sizing-lg" placeholder="phone" required>
				</div>
				<div class="mb-3 container text-center">
					<div class="col-sm-offset-2 col-sm-10 messenger" id="naver_id_login">
						<input type="button" class="btn btn-primary " value="비밀번호 찾기" onclick="checkValue();">
						<input type="button" class="btn btn-secondary " value="아이디 찾기" onclick="location.href='id_find.jsp'">
						 
					</div>
				</div>
			</form>
		</div>
	</div>
	
<%@ include file="/footer.jsp" %>

</body>
</html>