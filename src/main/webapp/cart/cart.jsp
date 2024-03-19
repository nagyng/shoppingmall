<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/header.jsp" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="dto.Product" %>    
<%@ page import="dao.ProductRepository" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>장바구니</title>
<style>
.cartDiv {
	min-height:700px;
}
</style>

<!-- jquery 선언 -->
<script type="text/javascript">
	$(document).ready(function(){
		/* 증가, 감소 버튼 클릭시 처리 */
		$(".cart_qtyUp , .cart_qtyDown").click(function(){ 
			/* this	:	현재 행의 모든 정보를 가져온다 */
			var cart_qtyUp = $(this);
			console.log("cart_qtyUp " + cart_qtyUp);
			/* 현재 작업 중인 행번호를 가져온다 */
			var tr = cart_qtyUp.parent().parent();
			console.log("tr " + tr);
			/* 현재 행의 모든 td 정보를 변수에 대입 */
			var td = tr.children();		 
			console.log("td " + td);
			/* 아이디를 분리 */
			var pd_no = td.eq(0).text().split('-')[0].trim();		//가운데정렬 때문에 앞공백 인식 -> trim() 추가 
			console.log("pd_no " + pd_no); 
			/* 현재 행의 가격을 가져온다 */
			var price = Number(td.eq(1).text());
			console.log("price " + price); 
			var cart_qty = 0;
			
			//증가 
			if($(this).hasClass('cart_qtyUp')){   
				cart_qty = Number(td.children("input.cart_qty").val()) + 1;
			} else {  //감소
					if(Number(td.children("input.cart_qty").val()) == 1) {
					alert("주문 수량은 1개 이상이 되어야 합니다.");
					return false;
				}
				cart_qty = Number(td.children("input.cart_qty").val()) - 1;  
			}
			
			$(this).parent().parent().children("td").children("input.cart_qty").val(cart_qty);
			
			document.cartQtyUpdate.pd_no.value = pd_no;
			document.cartQtyUpdate.cart_qty.value = cart_qty;
			document.cartQtyUpdate.submit();
			
			
		});
	});
</script>

<script>
function checkOrder(){
	<% 
		//장바구니에 내역이 있는지 여부를 체크
		ArrayList<Product> list = (ArrayList<Product>)session.getAttribute("cartlist");
		
		if(list == null || list.size() == 0){
	%>		
		alert("장바구니가 비었습니다."); 
		return false;
	<%		
		}
	%>
		  
}		
</script>
</head>
<body>
<%@ include file="/top.jsp" %>

	<%
		/* 서버가 클라이언트에 응답처리시 JSessionID 값을 전송 */
		String cartId = session.getId();		
	%>
	
	
	<div class="container-fluid cartDiv col-12">
		<div class="p-5  ">
			<div class="container-fluid  ">
				<h1 class=" text-center fw-bold">장바구니</h1> 
			</div>
		</div>
	
		<div class=" col-10 text-center container-fluid">
			<div class=" ">
				<table width="100%">
					<tr>
						<td align="left">
						</td>
						<td align="right">
							<!-- 장바구니 모두 삭제 -->
							<a href="deleteCart.jsp?cartId=<%=cartId%>" class="btn btn-outline-danger">삭제하기</a>
							<a href="/order/shippingInfo.jsp?cartId=<%=cartId%>" class="btn btn-warning" onclick="return checkOrder();">
							   주문하기
							</a>
						</td>
					</tr>
				</table>
			</div>
			
			<div style="padding-top: 50px">
				<table class="table table-hover" style="width:100%;">
					<tr> 
						<th>품목</th>
						<th>가격</th>
						<th>수량</th>
						<th> </th>
						<th>할인율</th>
						<th>소계</th>
						<th>비고</th>
					</tr>
					<%
					
						/* 3/7 등급별 할인율 추가 */
						String sale="";
						int total=0;
					
						/* 장바구니 가격 합계 */
						int sum=0;
						//cartlist라는 세션정보를 가져와서 변수에 대입
						ArrayList<Product> cartList = (ArrayList<Product>)session.getAttribute("cartlist");
						
						//장바구니에 담긴 내역이 없는 경우
						if(cartList == null){
							cartList = new ArrayList<Product>();
						}
						
						for(int i=0;i<cartList.size();i++){
							
							Product product = cartList.get(i); 
							total = product.getPd_saleprice() * product.getCart_qty(); 
					%>
					<tr>
						<td class="text-center">
							<%=product.getPd_no()%>-<%=product.getPd_name()%>
						</td>
						<td class="text-center  "><fmt:formatNumber value='<%=product.getPd_saleprice()%>' pattern="#,##0" /></td>
						<td class="text-center" style="width:150px; height:200px;" > 
							<input type="text" readonly 
									name="cart_qty" class="cart_qty form-control  mb-2" 
									value="<%=product.getCart_qty() %>"  >  
							<i class="fa fa-arrow-circle-up fa-lg cart_qtyUp" style="color:green;"></i>&nbsp;&nbsp;
							<i class="fa fa-arrow-circle-down fa-lg cart_qtyDown" style="color:gold;"></i>
						</td>
						<td>
							<img alt="" src="/fntimg/<%=product.getPd_img()%>" width="150" height="150">
						</td>  
						
						
				<sql:query var="resultSet" dataSource="${conn}"> 
				   SELECT 	* 
				   FROM 	user 
				   WHERE 	user_id = ?
				<sql:param value="${sessionId}" />
				</sql:query>
							
				<c:forEach var="row" items="${resultSet.rows}">      
					<c:if test="${row.grade == 1}">  
						<%  sale = total + "<br> - " + 0 + "(0%)"; %>  
						<td class="text-center text-info" style="font-size: 15px;"><%=sale %></td>
					</c:if>
					<c:if test="${row.grade == 2}"> 
						<%  sale = total + "<br> - " + Math.ceil((total * 0.1)) + " (10%)";
						total = (int) Math.ceil((total * 0.9)); %>  
						<td class="text-center text-info" style="font-size: 15px;"><%=sale %></td>
					</c:if>
					<c:if test="${row.grade == 3}"> 
						<%  sale = total + "<br> - " + (total * 0.2) + " (20%)";
						total = (int) Math.ceil((total * 0.8)); %>  
						<td class="text-center text-info" style="font-size: 15px;"><%=sale %></td>
					</c:if>
					<c:if test="${row.grade == 4}"> 
						<%  sale = total + "<br> - " + (total * 0.3) + " (30%)";
						total = (int) Math.ceil((total * 0.7)); %>  
						<td class="text-center text-info" style="font-size: 15px;"><%=sale %></td>
					</c:if>
					<c:if test="${row.grade > 4}"> 
						<%  sale = total + "<br> - " + Math.ceil(total * 0.4) + " (40%)";
						total = (int) Math.ceil((total * 0.6)); %>  
						<td class="text-center text-info" style="font-size: 15px;"><%=sale %></td>
					</c:if>  
				</c:forEach>
				 
						<td class="text-center  "><fmt:formatNumber value='<%=total%>' pattern="#,##0"/></td>  
						<td class="text-center  ">
							<!-- 선택 삭제 -->
							<a href="removeCart.jsp?pd_no=<%=product.getPd_no()%>" class="badge text-bg-danger">삭제</a>
						</td>
					</tr>
					<%
						sum += total; 
						}
					%>
					<tr>
						<th></th>
						<th></th>
						<th></th>
						<th></th>
						<th>총액</th>
						<th><fmt:formatNumber value='<%=sum%>' pattern="#,##0"/></th>
						<th></th>
					</tr>
				</table>
				
				<a href="/productListAjax.jsp?all=all" class="btn btn-secondary mb-5">
					&laquo; 쇼핑 계속하기
				</a>
			</div>
		</div>
	</div>
	<%@ include file="/footer.jsp" %>
	
	
	
	<!-- 장바구니 ArrayList 수량을 변경하기 위한 form 선언 -->
	<form name="cartQtyUpdate" 
	      action="cartUpdate.jsp" method="post">
		<input type="hidden" name="pd_no">
		<input type="hidden" name="cart_qty">
	</form>
	
	
</body>
</html>





