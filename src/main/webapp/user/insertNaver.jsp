<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/dbconnection.jsp" %> 
<!DOCTYPE html>
<html>
<head> 
<script type="text/javascript" src="https://static.nid.naver.com/js/naverLogin_implicit-1.0.3.js" charset="utf-8"></script>
<script type="text/javascript" src="http://code.jquery.com/jquery-1.11.3.min.js"></script>
<title>네이버로그인</title>
</head>
<body>

<%/* 
String clientId = "lVPaApcKGtZqtle3aNBz";//애플리케이션 클라이언트 아이디값";
String clientSecret = "6tz5agzklW";//애플리케이션 클라이언트 시크릿값";
String code = request.getParameter("code");
String state = request.getParameter("state");
String redirectURI = URLEncoder.encode("YOUR_CALLBACK_URL", "UTF-8");
String apiURL = "https://nid.naver.com/oauth2.0/token?grant_type=authorization_code"
    + "&client_id=" + clientId
    + "&client_secret=" + clientSecret
    + "&redirect_uri=" + redirectURI
    + "&code=" + code
    + "&state=" + state;
String accessToken = "";
String refresh_token = "";


try {
  URL url = new URL(apiURL);
  HttpURLConnection con = (HttpURLConnection)url.openConnection();
  con.setRequestMethod("GET");
  int responseCode = con.getResponseCode();
  BufferedReader br;
  if (responseCode == 200) { // 정상 호출
    br = new BufferedReader(new InputStreamReader(con.getInputStream()));
  } else {  // 에러 발생
    br = new BufferedReader(new InputStreamReader(con.getErrorStream()));
  }
  String inputLine;
  StringBuilder res = new StringBuilder();
  while ((inputLine = br.readLine()) != null) {
    res.append(inputLine); 
  }
  br.close();
  if (responseCode == 200) {
    out.println(res.toString());
  } */
%>
 
  
	<script type="text/javascript">
		var naver_id_login = new naver_id_login("lVPaApcKGtZqtle3aNBz", "http://localhost:8080");
			//접근 토큰 값 출력 
			/* alert(naver_id_login.oauthParams.access_token); */
			//네이버 사용자 프로필 조회
			naver_id_login.get_naver_userprofile("naverSignInCallback()");
			console.log('콜백실행');   
		
		var nickname, age, birthday, email, id, gender;
		  
			//네이버 사용자 프로필 조회 이후 프로필 정보 처리
		 function naverSignInCallback() {
		          nickname	=naver_id_login.getProfileData('nickname');
		          age		=naver_id_login.getProfileData('age');
		          birthday	=naver_id_login.getProfileData('birthday');
		          email		=naver_id_login.getProfileData('email');
		          id		=naver_id_login.getProfileData('id');
		          gender	=naver_id_login.getProfileData('gender');
		    
		          var url = "http://localhost:8080/insertNaver2.jsp" + window.location.hostname + ((location.port==""||location.port==undefined)?"":":" + location.port)
		          
		          post_to_url(url, {'id': id, 'nickname':nickname, 'email':email, 'birthday':birthday, 'age':age, 'gender':gender})
		         
		          console.log(nickname);
		          console.log(age);
		          console.log(birthday);
		          console.log(email);
		          console.log(id);
		          console.log(gender);
			  	 
		          /* 
			alert("nickname:" + naver_id_login.getProfileData('nickname'));
			alert("age:" + naver_id_login.getProfileData('age'));
			alert("birthday:" + naver_id_login.getProfileData('birthday'));
			alert("email:" + naver_id_login.getProfileData('email'));
			alert("id:" + naver_id_login.getProfileData('id'));
			alert("gender:" + naver_id_login.getProfileData('gender'));
			
			 */
		  }


	//url에 넘기면서 정보를 같이 담아서 보내기 
	function post_to_url(path, params, method="post") {
		const form = document.createElement('form');
		form.method = method;
		form.action = path;
		
		for(const key in params) {
			if(params.hasOwnProperty(key)) {
				const hiddenField = document.createElement('input');
				hiddenField.type = 'hidden';
				hiddenField.name = key;
				hiddenField.value = params[key];
				form.appendChild(hiddenField);
			}
		}
		document.body.appendChild(form);
		
		form.submit;
		
		location.href="insertNaver2.jsp?nickname=" + nickname + "&age=" + age + "&birthday=" + birthday + "&email=" + email + "&id=" + id + "&gender="+ gender;
	}
	</script>
	
	<form action="insertNaver2.jsp?nickname=${nickname}&age=${age}&birthday${birthday}&email=${email}&id=${id}&gender=${gender}" 
			method="post" name="form" id="form">
		<input type="hidden" name="nickname" id="" value="${nickname}">
		<input type="hidden" name="age" id="age" value="${age}">
		<input type="hidden" name="birthday" id="birthday" value="${birthday}">
		<input type="hidden" name="email" id="email" value="${email}">
		<input type="hidden" name="id" id="id" value="${id}">
		<input type="hidden" name="gender" id="gender" value="${gender}">
	</form>
	
	
</body>
</html>