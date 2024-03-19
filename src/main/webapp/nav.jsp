<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<style>
	.smN {
		margin: 30px 0; 
} 
.dropdown-toggle {
	width: 200px;
}
.priceSearchInput {
	width: 200px;
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
.ul1 > div > li > a:focus { 
	background-color:white;
} 
.ul1 > div > li > a:focused { 
	background-color:white;
} 
</style>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script>
	$(document).ready(function(){
		checkValue = function(){
			if(!$("#min").val()){
				alert("최소 금액을 입력하세요!");
				return false;
			}
			if(!$("#max").val()){
				alert("최대 금액을 입력하세요!");
				return false;
			}
			priceForm.submit();
		}		
	});
</script>
</head>
<body> 

<div class="container-fluid col-9">
	<ul class="nav nav-pills ul1">
	  <li class="nav-item dropdown smN">
	    <a class="nav-link dropdown-toggle" data-toggle="dropdown" href="#" role="button" aria-expanded="false">사이즈</a>
	    <div class="dropdown-menu">
	      <a class="dropdown-item" href="/productListAjax.jsp?pd_size=large">대</a>
	      <div class="dropdown-divider"></div>
	      <a class="dropdown-item" href="/productListAjax.jsp?pd_size=medium">중</a>
	      <div class="dropdown-divider"></div>
	      <a class="dropdown-item" href="/productListAjax.jsp?pd_size=small">소</a>
	    </div>
	    
	  </li>
	  <li class="nav-item dropdown smN">
	    <a class="nav-link dropdown-toggle" data-toggle="dropdown" href="#" role="button" aria-expanded="false">가격</a>
	    <div class="dropdown-menu">
	      <a class="dropdown-item" href="/productListAjax.jsp?pd_price_list=low">낮은 가격순</a>
	      <div class="dropdown-divider"></div>
	      <a class="dropdown-item" href="/productListAjax.jsp?pd_price_list=high">높은 가격순</a>
	    </div>
	  </li>
	  <li class="nav-item dropdown smN">
	    <a class="nav-link dropdown-toggle" data-toggle="dropdown" href="#" role="button" aria-expanded="false">색상</a>
	    <div class="dropdown-menu">
	      <a class="dropdown-item" href="/productListAjax.jsp?color_name=red">레드</a>
	      <a class="dropdown-item" href="/productListAjax.jsp?color_name=orange">오렌지</a>
	      <a class="dropdown-item" href="/productListAjax.jsp?color_name=yellow">옐로우</a>
	      <a class="dropdown-item" href="/productListAjax.jsp?color_name=green">그린</a>
	      <a class="dropdown-item" href="/productListAjax.jsp?color_name=blue">블루</a>
	      <a class="dropdown-item" href="/productListAjax.jsp?color_name=brown">브라운</a>
	      <a class="dropdown-item" href="/productListAjax.jsp?color_name=purple">퍼플</a>
	      <a class="dropdown-item" href="/productListAjax.jsp?color_name=pink">핑크</a>
	      <div class="dropdown-divider"></div>
	      <a class="dropdown-item" href="/productListAjax.jsp?color_name=black">블랙</a>
	      <a class="dropdown-item" href="/productListAjax.jsp?color_name=gray">그레이</a>
	      <a class="dropdown-item" href="/productListAjax.jsp?color_name=white">화이트</a>
	    </div>
	  </li>
	
	  <li class="smN">
		  	<div class="priceSearch" align="right">
		  		<div class="input-group input-group-sm mb-3">
				  <form action="/productListAjax.jsp" method="post" name="priceForm" style="display: inline-block;">
					  <div class="input-group-prepend priceInput" style="display: inline-block;">
					    <span class="input-group-text" id="inputGroup-sizing-md">가격대</span>
					  </div>
					  <input type="text" class="priceSearchInput form-control" aria-label="Sizing example input" aria-describedby="inputGroup-sizing-lg"  style="display: inline-block;" aria-describedby="inputGroup-sizing-sm" name="min" id="min" placeholder="최소" size="10">
					   ~ 
					  <input type="text" class="priceSearchInput form-control" aria-label="Sizing example input" aria-describedby="inputGroup-sizing-lg"  style="display: inline-block;" aria-describedby="inputGroup-sizing-sm" name="max" id="max" placeholder="최대" size="10">
					  <div class="input-group-append" style="display: inline-block;">
					    <button class="btn btn-outline-secondary" type="button" id="button-addon2" onclick="checkValue();" style="display: inline-block;"><i class="bi bi-search"></i></button>
					  </div>
				  </form>
				</div>
		  	</div>
	  </li>
	</ul>
</div>


</body>
</html>