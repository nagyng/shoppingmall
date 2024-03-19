<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css" > 
	<script src="https://cdn.jsdelivr.net/npm/jquery@3.5.1/dist/jquery.min.js" ></script>
	<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.min.js" ></script> 
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
	<!-- 드롭다운 -->
	<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.min.js"></script>
	<!-- 최신 버전 제이쿼리 사용 -->
	<script  src="http://code.jquery.com/jquery-latest.min.js"></script> 
	<!-- 카카오 우편 번호 -->
	<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script> 
	<!-- fontawesome 아이콘 표시를 위해서 선언 -->
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
 
<title></title>

<style type="text/css">

html, body {
	margin: 0;
	padding: 0;
	width: 100%; 
	font-family: 'GmarketSansMedium';
}
body {
	display: flex, flex-direction: column;
	position: relative;
}
.headerNav {
	margin: 20px;
} 
#title:hover {
	text-decolation: none !important;
}
a {
	color: black;
	text-decolation: none;
} 
a:hover {
	color: black; 
	text-decolation: none !important;
} 
a:active { 
	text-decolation: none;
	font-weight: bold;
}
a:visited { 
	text-decolation: none;
	font-weight: bold;
}
a:focus { 
	text-decolation: none;
	font-weight: bold;
}
a:link { 
	text-decolation: none;
}  
.addressDiv {
	width:100%;
	background-color: darkgrey;
	height: 200px;
	margin: auto; 
	text-align: center;
}
.userMenu { 
	color: red;
} 
.input-group-text {
	min-width: 100px;
} 
/* productList 와 colorList CSS */
	.productListDiv {
		min-height: 450px;
		/* max-height: 600px;
		overflow-y: auto; */
	}
	.pd-title {
		font-weight:bolder;
		margin-top: 20px;
	}   
@font-face {
    font-family: 'GmarketSansMedium';
    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2001@1.1/GmarketSansMedium.woff') format('woff');
    font-weight: normal;
    font-style: normal;
} 
div.pagingDiv { 
	width: 100%;
	display: inline-flex;
	align-items: center;
	margin-top: 20px;
	justify-content: center; 
}
</style>
</head>
<body>
	
<div class="container-fluid col-12" style="background-color: whitesmoke;">
	<div class="container-fluid col-9">
		<header class="row">
			<div class="col-2 pt-4"><a href="/index.jsp" class="title" id="title" style="font-size: 30px;">GAGU</a></div>
			<div class="col-6 col-sm-6 headerNav p-3">
				    <form class="form-inline my-2 my-lg-0" method="post" action="/search_process.jsp">
      				<input class="container form-control mr-sm-2" type="search" placeholder="검색어를 입력하세요." aria-label="Search" style="width:80%" name="searchText">
    				<button class="btn btn-light my-2 my-sm-0" type="submit" style="font-size:15px;"><i class="bi bi-search"></i></button>
    				</form>
			</div>
			
				<!-- session 값 가져오기 -->
				<% 
					String id = (String) session.getAttribute("sessionId");
				%>
				
				<c:if test="${sessionId == null}"> 
				<div class="col-3  headerNav" align=right style="font-size:15px;">
					<a href="/user/login.jsp" class="userMenu">로그인</a>
						혹은 
					<a href="/user/join.jsp" class="userMenu">회원가입</a>
				</div>
				</c:if>
				
				<c:if test="${sessionId != null}">
				<div class="col-3  headerNav" align=right>
						<svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" class="bi bi-person-square" viewBox="0 0 16 16">
						  <path d="M11 6a3 3 0 1 1-6 0 3 3 0 0 1 6 0"/>
						  <path d="M2 0a2 2 0 0 0-2 2v12a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V2a2 2 0 0 0-2-2zm12 1a1 1 0 0 1 1 1v12a1 1 0 0 1-1 1v-1c0-1-1-4-6-4s-6 3-6 4v1a1 1 0 0 1-1-1V2a1 1 0 0 1 1-1z"/>
						</svg>
						<span><a href="/user/userPage.jsp" class="userMenu" style="font-size:15px;">${sessionId}</a>님 환영합니다.</span> 
						 
						 
						 <p></p>
						 <a href="/cart/cart.jsp" class="userMenu" style="margin-right: 10px;font-size:15px;">
						 	<svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" class="bi bi-basket2" viewBox="0 0 16 16">
							  <path d="M4 10a1 1 0 0 1 2 0v2a1 1 0 0 1-2 0zm3 0a1 1 0 0 1 2 0v2a1 1 0 0 1-2 0zm3 0a1 1 0 1 1 2 0v2a1 1 0 0 1-2 0z"/>
							  <path d="M5.757 1.071a.5.5 0 0 1 .172.686L3.383 6h9.234L10.07 1.757a.5.5 0 1 1 .858-.514L13.783 6H15.5a.5.5 0 0 1 .5.5v1a.5.5 0 0 1-.5.5h-.623l-1.844 6.456a.75.75 0 0 1-.722.544H3.69a.75.75 0 0 1-.722-.544L1.123 8H.5a.5.5 0 0 1-.5-.5v-1A.5.5 0 0 1 .5 6h1.717L5.07 1.243a.5.5 0 0 1 .686-.172zM2.163 8l1.714 6h8.246l1.714-6z"/>
							</svg>
						 	장바구니
						 </a>
						  
						<a href="/user/logout.jsp" class="userMenu" style="font-size:15px;">
						<svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" class="bi bi-x-circle" viewBox="0 0 16 16">
						  <path d="M8 15A7 7 0 1 1 8 1a7 7 0 0 1 0 14m0 1A8 8 0 1 0 8 0a8 8 0 0 0 0 16"/>
						  <path d="M4.646 4.646a.5.5 0 0 1 .708 0L8 7.293l2.646-2.647a.5.5 0 0 1 .708.708L8.707 8l2.647 2.646a.5.5 0 0 1-.708.708L8 8.707l-2.646 2.647a.5.5 0 0 1-.708-.708L7.293 8 4.646 5.354a.5.5 0 0 1 0-.708"/>
						</svg>
						로그아웃</a> 
					</div>
				</c:if>
		</header>
	</div>		
</div>

</body>
</html>