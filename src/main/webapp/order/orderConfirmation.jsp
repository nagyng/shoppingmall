<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.net.URLDecoder"%>
<%@ page import="dto.Product"%>
<%@ page import="dao.ProductRepository"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="/header.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
	.orderConfirmDiv {
		min-height: 700px;
	}
</style>
</head>
<body>
<%@ include file="/top.jsp"%>

	<%
		/* 서버가 클라이언트에 전송한 JSessionID 값을 가져온다. */
		String cartId = session.getId();
	
		String shipping_cartId = "";
		String shipping_name = "";
		String shipping_shippingDate = ""; 
		String shipping_zipcode = "";
		String shipping_addr1 = "";
		String shipping_addr2 = "";
	
		//생성된 모든 쿠키정보를 가져와서 배열에 대입
		Cookie[] cookies = request.getCookies();
		
		//쿠키정보가 존재하면
		if(cookies != null){
			
			for(int i=0;i<cookies.length;i++){
				
				Cookie thisCookie = cookies[i];
				
				//쿠키명을 가져온다.
				String n = thisCookie.getName();
				
				if(n.equals("Shipping_cartId")){
					//getValue(): 쿠키에 들어있는 실제값을 가져온다.
					//decording: 바이트단위를 다시 문자열로 복원
					shipping_cartId = URLDecoder.decode(thisCookie.getValue(),"utf-8");
				}
				
				if(n.equals("Shipping_name")){
					shipping_name = URLDecoder.decode(thisCookie.getValue(),"utf-8");
				}
				
				if(n.equals("Shipping_shippingDate")){
					shipping_shippingDate = URLDecoder.decode(thisCookie.getValue(),"utf-8");
				}
				  
				if(n.equals("Shipping_zipCode")){
					shipping_zipcode = URLDecoder.decode(thisCookie.getValue(),"utf-8");
				}
				
				if(n.equals("Shipping_addressName")){
					shipping_addr1 = URLDecoder.decode(thisCookie.getValue(),"utf-8");
				}
				
				if(n.equals("Shipping_addressName2")){
					shipping_addr2 = URLDecoder.decode(thisCookie.getValue(),"utf-8");
				}
			}
		}
	%>
	
	

	

	<div class="orderConfirmDiv">
	<div class="container-fluid">
		<div class="p-5  ">
			<div class="container-fluid  ">
				<h1 class="text-center  fw-bold">주문 정보</h1>
			</div>
		</div>
		<div class="container-fluid   text-center col-9  ">
			<div class="text-center mb-3">
				<h3>영수증</h3>
			</div>
			<div class="text-center container-fluid"> 
				<div class=" " align=" ">
					<strong>배송주소</strong><br> 성명:<% out.println(shipping_name);%><br>
					우편번호:<% out.println(shipping_zipcode);%><br> 도로명주소:<% out.println(shipping_addr1);%><br>
					상세주소:<% out.println(shipping_addr2);%><br>
				</div>
				 
				<div class=" " align=" ">
					<p>
						<em>배송일:<% out.println(shipping_shippingDate);%></em>
				</div>
			</div>
			<div class=" ">
				<table class="table table-hover table-bordered table-striped">
					<tr> 
						<th class="text-center">품목</th>
						<th class="text-center">수량</th>
						<th class="text-center">정상가</th>
						<th class="text-center">할인가</th>
					</tr>
					<%
					
					int sum=0;
					
					/* 3/7 등급별 할인율 추가 */
					String sale="";
					int total=0;
				
				    /* session.getAttribute() ? : 생성된 세션정보를 가져온다.	 */	
					ArrayList<Product> cartList = (ArrayList<Product>)session.getAttribute("cartlist");
					
				    //장바구니에 한개도 없는 경우
					if(cartList == null){
						/* ArrayList 초기화 */
						cartList = new ArrayList<Product>();
					}
						
					for(int i=0;i<cartList.size();i++){
						
					    //ArrayList에 있는 정보를 가져온다. 
						Product product = cartList.get(i);
					    //소계계산
						total = product.getPd_saleprice() * product.getCart_qty();

					%>
				<tr>
					<td class="text-center"><em><%=product.getPd_name()%></em></td>
					<td class="text-center"><%=product.getCart_qty()%></td>
					<td class="text-center"><fmt:formatNumber value='<%=product.getPd_saleprice()%>' pattern="#,##0" />원</td>
					<td class="text-center"><fmt:formatNumber value='<%=total%>' pattern="#,##0"/>원</td>
				</tr> 
				
				
				<sql:query var="resultSet" dataSource="${conn}"> 
				   SELECT 	* 
				   FROM 	user 
				   WHERE 	user_id = ?
				<sql:param value="${sessionId}" />
				</sql:query>
							
				<c:forEach var="row" items="${resultSet.rows}">    
				<tr>
					<td></td>
					<td class="text-right">회원 등급 별<br> 할인율:</td> 
					<c:if test="${row.grade == 1}">  
						<%  sale = sum + "<br> - " + 0 + "(0%)"; %> 
					</c:if>
					<c:if test="${row.grade == 2}"> 
						<%  sale = total + "<br> - " + Math.ceil(total * 0.1) + " (10%)";
						total = (int) Math.ceil((total * 0.9)); %> 
					</c:if>
					<c:if test="${row.grade == 3}"> 
						<%  sale = total + "<br> - " + Math.ceil(total * 0.2) + " (20%)";
						total = (int) Math.ceil((total * 0.8)); %> 
					</c:if>
					<c:if test="${row.grade == 4}"> 
						<%  sale = total + "<br> - " + Math.ceil(total * 0.3) + " (30%)";
						total = (int) Math.ceil((total * 0.7)); %> 
					</c:if>
					<c:if test="${row.grade > 4}"> 
						<%  sale = total + "<br> - " + Math.ceil(total * 0.4) + " (40%)";
						total = (int) Math.ceil((total * 0.6)); %> 
					</c:if>
					<td class="text-center text-primary"><%=sale %></td>
					<td class="text-center text-primary"><strong><%=total%></strong></td>
				</tr>
				 
				</c:forEach>
				
				<%
		    		//총합계 계산
		    		sum += total;
					}	
				%>
				
				
				<tr>
					<td></td>
					<td></td>
					<td class="text-right"><strong>총액:</strong></td> 
					<td class="text-center text-danger"><strong><fmt:formatNumber value='<%=sum%>' pattern="#,##0"/>원</strong></td>   
				</tr>
	
				<%-- </c:forEach> --%>
			</table>
			

			<a href="thankCustomer.jsp?cartId=<%=cartId %>" class="btn btn-success" role="button">주문완료</a> 
			<a href="checkOutCancelled.jsp" class="btn btn-secondary"
				role="button">취소</a>
				<p></p>
			</div>
		</div>
	</div>
</div>



<%@ include file="/footer.jsp"%>
</body>
</html>