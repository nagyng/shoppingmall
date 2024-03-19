<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="dbconnection.jsp" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
	.sale {
		margin: 30px auto;
	}
	.colorBox {
		width: 100%;
		height: 300px;
  		overflow: auto;
  		white-space: nowrap;
	}
	.serviceBox {
		margin: 30px;
		text-align: center;
		background-color: #F5F5F5;
		display: inline-block;
		width: 200px;
		height: 200px;
		border-radius: 30px;
	}  
	.serviceBox  > p {
		padding-top: 80px;
	}
	.section {
		margin: 50px;
	}
	.naverTalk { 
		display: inline-block;
	} 
	.indexCard:hover {
		background-color: whitesmoke;
	}
	button:hover {
    text-decoration: none !important; 
	}
</style>
</head>
<body>
<!--  
https://www.zinus.co.kr/main/index.php
https://store.hanssem.com/goods/171733?rccode=GOOD001_A005&goodsdetail=with_goods
-->


	<!-- 헤더 -->
	<!-- 로고 검색창 로그인 -->
		<div class="header">
			<%@ include file="header.jsp" %>
		</div>
	
	<!-- 분류 1 -->
		<div class="top">
			<%@ include file="top.jsp" %> 
		</div>

	<!-- 분류 2 -->
		<div class="nav">
			<%@ include file="nav.jsp" %> 
		</div>



 
	<!-- 섹션 -->
	 
		<!-- 슬라이드 --> 
		<div class="slide.jsp" style="font-size: 30px; text-align:center; width:100%; margin:0; background-color:whitesmoke;">
			<%@ include file="slide.jsp" %>
		</div>
		 
				
	<div class="section container-fluid col-9 mb-5"> 
		<p style="font-size: 30px; margin-top:100px; text-align:center;">이런 테마 어때요? 색상별 제품 보러 가기</p>
		<div class="colorBox">
			<%@ include file="colorBox.jsp" %>
		</div>
		
		<!-- 서비스 분류 -->
		<p style="font-size: 30px; margin-top:100px; text-align:center;">다양한 회원 서비스	
		
		  <!-- Talk Talk Banner Script start -->
		  <script type="text/javascript" src="https://partner.talk.naver.com/banners/script"></script>
		  <div class="talk_banner_div" data-id="143267" style="margin: 35px;"></div>
		  <!-- Talk Talk Banner Script end -->
 			
			<a href="/service/store.jsp"> 
				<div class="serviceBox"> 
					<p>매장 안내
				</div>
			</a>
			<a href="/service/call.jsp"> 
				<div class="serviceBox"> 
					<p>전화 상담
				</div>
			</a>
			<a href="/QnaListAction.qdo?pageNum=1"> 
				<div class="serviceBox"> 
					<p>문의 게시판 
				</div> 
			</a>
		  
		
		
		<!-- 모든 제품 보러가기 --> 
			<div class="text-center">
				<form action="/productListAjax.jsp?all=all" method="post">
					<p style="font-size: 30px; margin-top:100px; text-align:center;"> 모든 제품 보러가기  
					
					<sql:query var="rs" dataSource="${conn}"> 
						SELECT 	    * 
						FROM  	    product p, color cl, room rm, category ct
						WHERE 	    p.pd_color = cl.pd_color
						AND		   	p.pd_room = rm.pd_room
						AND			p.pd_category = ct.pd_category
						order by	pd_no desc
						LIMIT 		0, 6
					</sql:query> 
					<c:forEach var="row" items="${rs.rows}"> 
						<div class="card container border-light h-100 mt-5 mb-5 indexCard text-center" style="width: 25rem; display: inline-block;">
							<a href="productView.jsp?pd_no=<c:out value='${row.pd_no}'/>" class="card-link">
						  	<img src="/fntimg/<c:out value='${row.pd_img}'/>" class="card-img-top p-5" style="margin:auto;">
						  	<div class="card-body">
						    	<h5 class="card-title"><c:out value='${row.pd_name}'/></h5>
						    	<p class="card-text"> 
						    		<span style="color: lightgrey;">설명 </span> 
						    		<c:choose>
        								<c:when test="${fn:length(row.pd_detail) gt 41}"> <c:out value='${fn:substring(row.pd_detail, 0, 40)}'/>...</c:when>
        							</c:choose>
        						</p>
						  	</div>
						  	<ul class="list-group list-group-flush">
						    	<li class="list-group-item"><span style="color: lightgrey;">용도 </span><c:out value='${row.category_name}'/></li>
						    	<li class="list-group-item"><span style="color: lightgrey;">색상 </span><c:out value='${row.color_name}'/></li>
						    	<li class="list-group-item"><span style="color: lightgrey;">공간 </span><c:out value='${row.room_name}'/></li>
						  	</ul>
						  	<div class="card-body">
						    	<a href="#" class="card-link"><span class="pdPrice" style="font-size: 15px; color:darkgrey; text-decoration-line: line-through;">
								<fmt:formatNumber value='${row.pd_price}' pattern="#,##0"/>원</span></a>
						    	<a href="#" class="card-link"><span class="pdSalePrice" style="font-size: 25px; color:gold;">
								<fmt:formatNumber value='${row.pd_saleprice}' pattern="#,##0"/>원</span></a>
						  	</div>
							</a>
						</div>
					</c:forEach>

					<button type="submit" class="btn btn-link m-5 text-center container moreBtn" style="font-size:20px">더 보러가기 ≫</button>

				</form>
			</div>

	


	</div> 
	
	<!-- 주소창 -->
	<div class="footer">
		<%@ include file="footer.jsp" %>
	</div>
	
</body>
</html>