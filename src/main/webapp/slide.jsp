<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<style type="text/css">
.carousel-item {
	width: 100%;
	height: 600px;
    position: relative;
}
.carousel-item > img {
    position: absolute;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%); 	/* 이미지 세로 중앙 정렬 */
    height: 100%;
    object-fit: cover;
}
</style>
</head>
<body>
 
		<div id="carouselExampleIndicators" class="carousel slide" data-ride="carousel">
		  <ol class="carousel-indicators">
		    <li data-target="#carouselExampleIndicators" data-slide-to="0" class="active"></li>
		    <li data-target="#carouselExampleIndicators" data-slide-to="1"></li>
		    <li data-target="#carouselExampleIndicators" data-slide-to="2"></li>
		    <li data-target="#carouselExampleIndicators" data-slide-to="3"></li>
		    <li data-target="#carouselExampleIndicators" data-slide-to="4"></li>
		    <li data-target="#carouselExampleIndicators" data-slide-to="5"></li>
		  </ol>
		  <div class="carousel-inner">
		    <div class="carousel-item">
		      <img src="\fntimg\sub_kv_pillow.jpg" class="d-block w-100" alt=" "> 
		    </div>
		    <div class="carousel-item active">
		      <img src="\fntimg\sub_kv_frame.jpg" class="d-block w-100" alt=" ">
		    </div>
		    <div class="carousel-item">
		      <img src="\fntimg\sub_kv_mattress.jpg" class="d-block w-100" alt=" ">
		    </div>
		    <div class="carousel-item">
		      <img src="\fntimg\sub_kv_topper.jpg" class="d-block w-100" alt=" "> 
		    </div><!-- 
		    <div class="carousel-item">
		      <img src="\fntimg\ikea.png" class="d-block w-100" alt=" "> 
		    </div>
		    <div class="carousel-item">
		      <img src="\fntimg\ikea2.png" class="d-block w-100" alt=" ">
		    </div>
		    <div class="carousel-item">
		      <img src="\fntimg\ikea3.png" class="d-block w-100" alt=" ">
		    </div>
		    <div class="carousel-item">
		      <img src="\fntimg\ikea4.png" class="d-block w-100" alt=" ">
		    </div>
		    <div class="carousel-item">
		      <img src="\fntimg\ikea5.png" class="d-block w-100" alt=" ">
		    </div>
		    <div class="carousel-item">
		      <img src="\fntimg\ikea7.png" class="d-block w-100" alt=" ">
		    </div> -->
		  </div>
		  <button class="carousel-control-prev" type="button" data-target="#carouselExampleIndicators" data-slide="prev">
		    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
		    <span class="sr-only">Previous</span>
		  </button>
		  <button class="carousel-control-next" type="button" data-target="#carouselExampleIndicators" data-slide="next">
		    <span class="carousel-control-next-icon" aria-hidden="true"></span>
		    <span class="sr-only">Next</span>
		  </button>
		</div> 
</body>
</html>