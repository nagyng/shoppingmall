<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ include file="/dbconnection.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<style type="text/css">
.dropdown:hover .dropdown-menu {
    display: block;
    margin-top: 0;
}
#ul1 {
	margin: 0;
	width: 100%;
	padding: 30px 0px 30px 0px;
	/* background-color: #F5F5F5; */
}
#ul1 > div > li {
	height: 100%;
	width: 200px;
	float: left;
}
.dropdown-menu {
	width: 200px;
}
.topUl > li > a {
	width: 100%;
	height: 100%;
	text-decoration: none;
	color: black;
}
</style>
</head>
<body>

 	<ul class="nav nav-tabs" id="ul1">
	<div class="container col-9">
	
	  <li class="nav-item dropdown">
	    <a class="nav-link" data-bs-toggle="dropdown" href="#" role="button" aria-expanded="true">전체 보기</a>
	    <ul class="dropdown-menu">
	      <!-- <li><a class="dropdown-item" href="/productList.jsp">ALL</a></li> -->
	      <li><a class="dropdown-item topA" href="/productListAjax.jsp?pd_category=1">수납 정리</a></li>
	      <li><a class="dropdown-item topA" href="/productListAjax.jsp?pd_category=2">의자</a></li>
	      <li><a class="dropdown-item topA" href="/productListAjax.jsp?pd_category=3">침대</a></li>
	      <li><a class="dropdown-item topA" href="/productListAjax.jsp?pd_category=4">주방용품</a></li>
	      <li><a class="dropdown-item topA" href="/productListAjax.jsp?pd_category=5">욕실용품</a></li> 
	      <li><a class="dropdown-item topA" href="/productListAjax.jsp?pd_category=6">반려동물</a></li>
	      <li><a class="dropdown-item topA" href="/productListAjax.jsp?pd_category=7">아웃도어</a></li> 
	    </ul>
	  </li>
	
	  <li class="nav-item dropdown">
	    <a class="nav-link" data-bs-toggle="dropdown" href="#" role="button" aria-expanded="false">공간 별 쇼핑하기</a>
	    <ul class="dropdown-menu topUl">
	      <li><a class="dropdown-item" href="/productListAjax.jsp?pd_room=1">거실</a></li>
	      <li><a class="dropdown-item" href="/productListAjax.jsp?pd_room=2">침실</a></li>
	      <li><a class="dropdown-item" href="/productListAjax.jsp?pd_room=3">주방</a></li>
	      <li><a class="dropdown-item" href="/productListAjax.jsp?pd_room=4">욕실</a></li>
	      <li><a class="dropdown-item" href="/productListAjax.jsp?pd_room=5">어린이</a></li>
	      <li><a class="dropdown-item" href="/productListAjax.jsp?pd_room=6">사무실</a></li>
	      <li><a class="dropdown-item" href="/productListAjax.jsp?pd_room=7">다이닝</a></li>
	      <li><a class="dropdown-item" href="/productListAjax.jsp?pd_room=8">세탁실</a></li>
	      <li><a class="dropdown-item" href="/productListAjax.jsp?pd_room=9">베란다 야외</a></li>
	    </ul>
	  </li>
	  <li class="nav-item dropdown">
	    <a class="nav-link" data-bs-toggle="dropdown" href="#" role="button" aria-expanded="false">고객 서비스</a>
	    <ul class="dropdown-menu">
	      <li><a class="dropdown-item" href="/service/store.jsp">매장안내</a></li>
	      <li><a class="dropdown-item" href="/service/call.jsp">전화 상담 신청</a></li>
	      <li><a class="dropdown-item" href="/BoardListAction.do?pageNum=1">공지사항</a></li>
	      <li><a class="dropdown-item" href="/QnaListAction.qdo?pageNum=1">QnA</a></li>
	      <li><a class="dropdown-item" href="/ReviewListAction.rdo?pageNum=1">Reviews</a></li>
	      <!-- <li><a class="dropdown-item" href="/service/membership.jsp">멤버십 가입</a></li> -->
	      <!-- <li><a class="dropdown-item" href="/service/service.jsp">고객지원</a></li> -->
	      <!-- <li><a class="dropdown-item" href="/CommentListAction.cdo?pageNum=1">댓글 게시판 (임시)</a></li> -->
	    </ul>
	  </li>

	  
 	<sql:query var="resultSet2" dataSource="${conn}">
	   select * 
	     from user
	    where user_id = ? 
	    <sql:param value="${sessionId}"/>   
	</sql:query>
	<c:forEach var="row2" items="${resultSet2.rows}">
	 <!-- grade 가 10일때 -->
		<c:if test="${row2.grade == 10}">
			<li class="nav-item dropdown">
				<a class="nav-link" data-bs-toggle="dropdown" href="/admin/adminMod.jsp" role="button" aria-expanded="false">관리자 모드</a>
	   			<ul class="dropdown-menu">
	      			<li><a class="dropdown-item" href="/admin/productListAjax.jsp?firstDate=1920-01-01&lastDate=2099-01-01&searchType=all">품목 관리</a></li>
	      			<li><a class="dropdown-item" href="/admin/userListAjax.jsp">고객 관리</a></li>
	      			<li><a class="dropdown-item" href="/admin/orderListAjax.jsp">주문 관리</a></li>
	   			</ul>
			</li>
		</c:if>
	</c:forEach>
	
	
	</div>
	</ul>


</body>
</html>