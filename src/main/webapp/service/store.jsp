<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/header.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=caa859e0495a764351ec706cf4e21073&libraries=services,clusterer,drawing"></script>
<!--
	2. 설치 스크립트
	* 지도 퍼가기 서비스를 2개 이상 넣을 경우, 설치 스크립트는 하나만 삽입합니다.
-->
<script charset="UTF-8" class="daum_roughmap_loader_script" src="https://ssl.daumcdn.net/dmaps/map_js_init/roughmapLoader.js"></script>
<title>Insert title here</title> 
<style type="text/css">
</style>
</head>
<body>
<%@ include file="/top.jsp" %> 
<%@ include file="/dbconnection.jsp" %>


<div class="col-9 container" style="min-height:800px;">
	<sql:query var="resultSet" dataSource="${conn}"> 
	   SELECT * FROM store 
	</sql:query> 
	 
	 
	 
	<div class="row row-cols-1 row-cols-md-2">
	<c:forEach var="row" items="${resultSet.rows}">
	  <div class="col mb-4 p-5">
	    <div class="card text-center border-light">
	      <img src="/fntimg/arch.jpg" class="card-img-top" alt=" " style="width:100%; height:400px; object-fit: cover;">
	      <div class="card-body" style="background-color: lightgray;">
	        <h5 class="card-title"><c:out value='${row.store_name }'/></h5>
	        <p class="card-text">
	        	평일 11:00 AM - 07:00PM
	        	<br>주말 11:00 AM - 08:30PM
	        	<br>주차장 이용 안내주차 요금 : 무료
	        	<br>주소: <c:out value='${row.store_address }'/>
	        </p> 
			<a href="https://map.kakao.com/link/map/<c:out value='${row.latitude }'/>,<c:out value='${row.longitude }'/>" class="btn btn-warning">카카오맵</a>
	      </div>
	    </div>
	  </div>
	 </c:forEach>
	 </div>
</div>

<%@ include file="/footer.jsp" %>
</body>
</html>