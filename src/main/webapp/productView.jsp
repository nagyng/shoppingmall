<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="dto.Product"%>
<%@ page import="dao.ProductRepository" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="header.jsp" %>
<!DOCTYPE html>
<html>
<head><!-- 
<link rel="stylesheet" href="css/my_gradient_rainbow_1.css" /> -->
<meta charset="UTF-8">
<title>상세보기</title>
<style type="text/css">
.productViewDiv {
	min-height:700px;
}  
.pvth {
	color: lightgray;
	
}
</style>
<script> 
	//장바구니에 상품을 추가하는 함수 선언
	function addToCart(){
		if(confirm("장바구니에 추가하시겠습니까?")){
			document.addForm.submit();
		}else{
			document.addForm.reset();
		}
	}  
</script>
</head>
<body>
<%@ include file="top.jsp" %> 
<%@ include file="nav.jsp" %> 
<%@ include file="dbconnection.jsp" %>

	<jsp:useBean id="productDAO" 
	             class="dao.ProductRepository" 
	             scope="session"/>
	<%
	    //모든 정보를 리턴받아 변수에 대입처리
		ProductRepository dao = ProductRepository.getInstance();
		ArrayList<Product> listOfProducts = dao.getAllProducts();							
	%>


	<sql:query var="resultSet" dataSource="${conn}"> 
	   SELECT 	* 
	   FROM	 	product p, color cl, room rm, category ct
	   WHERE	p.pd_color = cl.pd_color 
	   and 		p.pd_category = ct.pd_category
	   and 		p.pd_room = rm.pd_room  
	   and	 	p.pd_no = ?
	<sql:param value="${param.pd_no}" />
	</sql:query>
	<c:forEach var="row" items="${resultSet.rows}">

	<div class="productViewDiv col-9 container mt-5" style="min-height:700px;">
		<div class="row">
			<div class="col text-center">
				<img alt="<c:out value='${row.pd_img}'/>" src="/fntimg/<c:out value='${row.pd_img}'/>" style="max-width:450px; max-height:450px;">
			</div>
			<div class="col">
				<badge class="badge badge-pill badge-warning mb-3">번호: <input type="text" name="pd_no" value="<c:out value='${row.pd_no}'/>" readonly size="2" style="border: none; background-color:transparent;" ></input></badge>
				<table>
					<tr>
						<th style="font-size: 30px;" colspan="2"><c:out value='${row.pd_name}'/></th> 
					</tr>
					<tr>
						<th class="pvth">종류</th>
						<td><c:out value='${row.category_name}'/></td>
					</tr>
					<tr>
						<th class="pvth">색상</th>
						<td><c:out value='${row.color_name}'/></td>
					</tr>
					<tr>
						<th class="pvth">사이즈</th>
						<td><c:out value='${row.pd_size}'/></td>
					</tr>
					<tr>
						<th class="pvth">공간</th>
						<td><c:out value='${row.room_name}'/></td>
					</tr>
					<tr>
						<td colspan="2" class="pvth">기존가 <span class="pdPrice" style="font-size: 20px; color:darkgrey; text-decoration-line: line-through;">
							<fmt:formatNumber value='${row.pd_price}' pattern="#,##0"/>원</span></td>
					</tr>
					<tr>
						<td colspan="2" class="pvth">할인가 <span class="pdSalePrice" style="font-size: 30px; font-weight:bold; color:gold;">
							<fmt:formatNumber value='${row.pd_saleprice}' pattern="#,##0"/>원</span></td>
					</tr>
					<tr>
						<td colspan="2" class="p-5"> <c:out value='${row.pd_detail}'/> </td>
					</tr> 
					
					 	<sql:query var="resultSet2" dataSource="${conn}">
						   select * 
						     from user
						    where user_id = ? 
						<sql:param value="${sessionId}"/>   
						</sql:query>
						<c:forEach var="row2" items="${resultSet2.rows}">
						 <!-- grade 가 10일때 -->
							<c:if test="${row2.grade == 10}">
								<tr>
									<td colspan="2">
										<button type="button" class="btn btn-light btn-lg" onclick="location.href='/admin/update_product.jsp?pd_no=<c:out value='${row.pd_no}'/>'">수정</button>
										<button type="button" class="btn btn-secondary btn-lg" onclick="location.href='/admin/delete_product.jsp?pd_no=<c:out value='${row.pd_no}'/>'">삭제</button>
									</td>
								</tr>
							</c:if>
							
							<c:if test="${row.pd_stock > 19}">
								<tr>
									<td colspan="2"> 
									<p class="mb-2"></p>
									<form name="addForm" action="/cart/addCart.jsp?pd_no=<c:out value='${row.pd_no}'/>"> 
										<span class="mt-3 badge badge-success p-3">재고 남아있음</span>
										<a href="/cart/addCart.jsp?pd_no=<c:out value='${row.pd_no}'/>"> 
										<button type="button" class="btn btn-light btn-lg" onclick=" addToCart() ">장바구니에 담기 
											<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-basket2" viewBox="0 0 16 16">
											  <path d="M4 10a1 1 0 0 1 2 0v2a1 1 0 0 1-2 0zm3 0a1 1 0 0 1 2 0v2a1 1 0 0 1-2 0zm3 0a1 1 0 1 1 2 0v2a1 1 0 0 1-2 0z"/>
											  <path d="M5.757 1.071a.5.5 0 0 1 .172.686L3.383 6h9.234L10.07 1.757a.5.5 0 1 1 .858-.514L13.783 6H15.5a.5.5 0 0 1 .5.5v1a.5.5 0 0 1-.5.5h-.623l-1.844 6.456a.75.75 0 0 1-.722.544H3.69a.75.75 0 0 1-.722-.544L1.123 8H.5a.5.5 0 0 1-.5-.5v-1A.5.5 0 0 1 .5 6h1.717L5.07 1.243a.5.5 0 0 1 .686-.172zM2.163 8l1.714 6h8.246l1.714-6z"/>
											</svg>
										</button>
										</a> 
									</form> 
									</td>
								</tr>  
							</c:if>
							
							<c:if test="${row.pd_stock < 20 && row.pd_stock > 0}">
								<tr>
									<td colspan="2"> 
									<form name="addForm" action="/cart/addCart.jsp?pd_no=<c:out value='${row.pd_no}'/>"> 
										<span class="mt-3 badge p-3" style="background-color: orange; color:white;">품절 임박!</span>
										<span class="mt-3 p-3" >(남은 재고 수: <c:out value='${row.pd_stock}'/>)</span>
										<a href="/cart/addCart.jsp?pd_no=<c:out value='${row.pd_no}'/>"> 
										<button type="button" class="btn btn-light btn-lg" onclick=" addToCart() ">장바구니에 담기 
											<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-basket2" viewBox="0 0 16 16">
											  <path d="M4 10a1 1 0 0 1 2 0v2a1 1 0 0 1-2 0zm3 0a1 1 0 0 1 2 0v2a1 1 0 0 1-2 0zm3 0a1 1 0 1 1 2 0v2a1 1 0 0 1-2 0z"/>
											  <path d="M5.757 1.071a.5.5 0 0 1 .172.686L3.383 6h9.234L10.07 1.757a.5.5 0 1 1 .858-.514L13.783 6H15.5a.5.5 0 0 1 .5.5v1a.5.5 0 0 1-.5.5h-.623l-1.844 6.456a.75.75 0 0 1-.722.544H3.69a.75.75 0 0 1-.722-.544L1.123 8H.5a.5.5 0 0 1-.5-.5v-1A.5.5 0 0 1 .5 6h1.717L5.07 1.243a.5.5 0 0 1 .686-.172zM2.163 8l1.714 6h8.246l1.714-6z"/>
											</svg>
										</button>
										</a> 
									</form> 
									</td>
								</tr>  
							</c:if>
							<c:if test="${row.pd_stock == 0}">
								<tr>
									<td colspan="2"> 
										<span class="mt-3 badge badge-danger p-3">품절</span>
									</td>
								</tr>  
							</c:if>
						</c:forEach>	
				</table>
				
				
				
				<!-- 품목별 리뷰 테이블 -->
				<h3 class="mt-5 mb-3">Reviews</h3>
				<table class="table p-5 mb-5 table-striped table-hover">
					<sql:query var="resultSet3" dataSource="${conn}"> 
						SELECT	rv_no as 'rv_no',
								user_id as 'user_id',
								pd_no as 'pd_no',
								rv_title as 'rv_title',
								date_format(rv_createtime, "%Y-%m-%d") as 'rv_createtime'
						 FROM	review
						WHERE 	pd_no = ?
					ORDER BY	rv_createtime desc
					LIMIT 		0, 3
					<sql:param value="${param.pd_no}" />
					</sql:query>
					<c:forEach var="row" items="${resultSet3.rows}">
						<tr>
							<th>${row.user_id}</th>
							<td>${row.rv_title}</td>
							<td>${row.rv_createtime}</td>
						</tr>
					</c:forEach>
				</table>
			</div>
		</div>
	</div>
	</c:forEach>
		
<%@ include file="footer.jsp" %>
</body>
</html>