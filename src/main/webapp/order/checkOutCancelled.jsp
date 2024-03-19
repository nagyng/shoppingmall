<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/header.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>주문 취소 페이지 작성하기</title>
<style type="text/css">
.cancelledDiv {
	min-height:700px;
}
</style>
</head>
<body>  
<%@ include file="/top.jsp" %>

<div class="container py-4 cancelledDiv">

	<div class="container-fluid p-5">
		<div class="container-fluid">
			<h1 class="container-fluid p-5 text-center"> 주문 취소</h1> 
			<svg xmlns="http://www.w3.org/2000/svg" width="200" height="200" fill="currentColor" class="container-fluid bi bi-check-circle-fill" viewBox="0 0 16 16" color="salmon">
				<path d="M16 8A8 8 0 1 1 0 8a8 8 0 0 1 16 0m-3.97-3.03a.75.75 0 0 0-1.08.022L7.477 9.417 5.384 7.323a.75.75 0 0 0-1.06 1.06L6.97 11.03a.75.75 0 0 0 1.079-.02l3.992-4.99a.75.75 0 0 0-.01-1.05z"/>
			</svg> 
		</div>
	</div>

	<div class="container-fluid text-center">		
		<h2 class=""> 주문이 취소되었습니다.</h2>	
	</div>
	
	<div class="container-fluid text-center">
		<p> <a href="/index.jsp" class="btn btn-secondary">  돌아가기</a>
	</div>
	
</div>

<%@ include file="/footer.jsp" %>

</body>
</html>