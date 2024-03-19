<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.net.URLEncoder" %>
<%@ page import="java.security.SecureRandom" %>
<%@ page import="java.math.BigInteger" %>
<%@ include file="/header.jsp" %>
<!DOCTYPE html>
<html>
<head> 
<!-- 카카오 간편로그인 -->
<script type="text/javascript" src="https://developers.kakao.com/sdk/js/kakao.js"></script>
<script type="text/javascript">
    Kakao.init('caa859e0495a764351ec706cf4e21073');
    function kakaoLogin() {
        Kakao.Auth.login({
            success: function (response) {
                Kakao.API.request({
                    url: '/v2/user/me',
                    success: function (response) {
                        /* alert(JSON.stringify(response)) */

                        console.log(response.id);

                        console.log(response.kakao_account.email);

                        console.log(response.properties['nickname']);
 
                        location.href="insertKakao.jsp?id="+ response.id +"&kaccount_email=" + response.kakao_account.email + "&nickname=" + response.properties['nickname'];
                    },
                    fail: function (error) {
                        alert(JSON.stringify(error))
                    },
                })
            },
            fail: function (error) {
                alert(JSON.stringify(error))
            },
        })
    }
</script>
<!-- 네이버 간편로그인 --> 
<script type="text/javascript" src="https://static.nid.naver.com/js/naverLogin_implicit-1.0.3.js" charset="utf-8"></script>
<script type="text/javascript" src="http://code.jquery.com/jquery-1.11.3.min.js"></script> 
<%@ page import="java.net.URLEncoder" %>
<%@ page import="java.security.SecureRandom" %>
<%@ page import="java.math.BigInteger" %> 
<title>Insert title here</title>
<style type="text/css">
	.loginDiv {
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
			if(!$("#id").val()){
				alert("아이디를 입력하세요!");
				return false;
			}
			
			if(!$("#password").val()){
				alert("비밀번호를 입력하세요!");
				return false;
			}
			
			loginForm.submit();
		}		
	});  
</script>
 
</head>
<body>


	<div class="container loginDiv">
		<div class="p-5">
			<div class="container-fluid">
				<h1 class="display-5 fw-bold text-center">로그인</h1> 
			</div>
		</div>
			<div class="container-fluid col-lg-6 col-md-6 col-sm-6 loginBody">
			<form name="loginForm" action="login_process.jsp" method="post">
				<div class="input-group input-group-lg mb-3">
					<div class="input-group-prepend">
					  <label class="input-group-text " id="inputGroup-sizing-lg">아이디</label>
					</div>
					<input name="id" id="id" type="text" class="form-control " aria-label="Sizing example input" aria-describedby="inputGroup-sizing-lg" placeholder="ID" required>
				</div>
				<div class="input-group input-group-lg mb-3">
					<div class="input-group-prepend">
					<label class="input-group-text" id="inputGroup-sizing-lg">비밀번호</label> 
					</div>
					<input name="password" type="password" id="password" class="form-control " aria-label="Sizing example input" aria-describedby="inputGroup-sizing-lg" placeholder="PW" required> 
				</div>
								
				<div class="mb-3 container text-center"> 
					<div class="col-sm-offset-2 messenger">
						<input type="submit" class="btn btn-primary" value="로그인 " onclick="checkValue();"> 
						<a href="id_find.jsp" class="btn btn-secondary" >ID 찾기</a>
						<a href="pw_find.jsp" class="btn btn-secondary" >PW 찾기</a>
					</div>
				</div>
			</form>
					
			<br>
				<div style="text-align: center; border: 1px solid lightgrey;">
					<div class="p-5">
					<h4 class="mb-3">간편 로그인</h4>
					<!-- 카카오 버튼 -->
					<a href="javascript:kakaoLogin()"><img class="" alt="kakao_login" src="/fntimg/kakao_login_medium_narrow.png"></a> <p></p>
					<!-- 네이버 버튼 -->
					<div class="col messenger" id="naver_id_login">
					 <script type="text/javascript">  
			          
					  	var naver_id_login = new naver_id_login("lVPaApcKGtZqtle3aNBz", "http://localhost:8080/user/insertNaver.jsp"); 
					  	
					  	naver_id_login.setButton("white", 2, 40);
					  	naver_id_login.setDomain("https://nid.naver.com/oauth2.0/authorize?svctype=0");
					  	naver_id_login.setState(state);
					  	naver_id_login.setPopup();
					  	naver_id_login.init_naver_id_login();   
 
					  	var state = naver_id_login.getUniqState();
				          console.log(naver_id_login);

				          const nickname	=naver_id_login.getProfileData('nickname');
				          const age			=naver_id_login.getProfileData('age');
				          const birthday	=naver_id_login.getProfileData('birthday');
				          const email		=naver_id_login.getProfileData('email');
				          const id			=naver_id_login.getProfileData('id');
				          const gender		=naver_id_login.getProfileData('gender');
				          
				          console.log(nickname);
				          console.log(age);
				          console.log(birthday);
				          console.log(email);
				          console.log(id);
				          console.log(gender);
					  	 
					  </script>  
					</div>
				</div>
			</div> 
		</div>
	</div>
	
<%@ include file="/footer.jsp" %>
</body>
</html>