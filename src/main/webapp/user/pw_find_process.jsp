<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
</style>
</head>
<body>
<%@ include file="/dbconnection.jsp" %>
<%
String username = request.getParameter("user_id");
String phone = request.getParameter("phone"); 
%>

	<!-- var		:	select문을 수행 후 리턴값을 가지는 변수
		dataSource	:	데이터베이스 연결을 설정하는 속성 -->
	<sql:query var="resultSet" dataSource="${conn}"> 
	select	count(*) as cnt, max(user_pw) as user_pw
	from	user
	where 	user_id=?
	and		phone=?
	<sql:param value="${param.user_id}" />
	<sql:param value="${param.phone}" />
	</sql:query>
	
	
	
 
	<div class="container pwFindDiv">
	<c:forEach var="row" items="${resultSet.rows}">
 		<c:if test="${row.cnt > 0}">
			<div class="p-5">
				<div class="container-fluid">
					<h1 class="display-5 fw-bold text-center">비밀번호 찾기</h1> 
				</div>
			</div>
			<div class="container-fluid col-lg-8 col-md-12 col-sm-12 ">
				<div class="input-group input-group-lg mb-3">
					<div class="input-group-prepend">
					  <label class="input-group-text " id="inputGroup-sizing-lg">비밀번호</label>
					</div>
					<input value="<c:out value='${row.user_pw }'/>" name="user_pw" id="user_pw" type="text" class="form-control " aria-label="Sizing example input" aria-describedby="inputGroup-sizing-lg" readonly> 
				</div>
				<div class="mb-3 container text-center">
					<div class="col-sm-offset-2 col-sm-10 messenger">
						<input type="button" class="btn btn-primary " value="로그인 화면으로 돌아가기" onclick="location.href='login.jsp'">
						<input type="button" class="btn btn-secondary" value="아이디 찾기" onclick="location.href='id_find.jsp'">
					</div>
				</div>
			</div>
		</c:if>
		
		<c:if test="${row.cnt == 0}"> 
			<script>
				alert('일치하는 정보가 없습니다.');
				history.back();
			</script>
			<c:redirect url="findError.jsp" />
		</c:if> 
 		
	</c:forEach>
	</div>
	
	
	
<%@ include file="/footer.jsp" %>


</body>
</html>