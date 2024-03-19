<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.net.URLDecoder" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="dto.Product" %>    
<%@ page import="dao.ProductRepository" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>  
<%@ include file="/header.jsp" %>
<!DOCTYPE html>
<html>
<head>
<!-- 포트원 결제 -->
    <script src="https://cdn.iamport.kr/v1/iamport.js"></script>
    <!-- jQuery -->
    <script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js" ></script>
    <!-- iamport.payment.js -->
    <script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.2.0.js"></script>
<!-- 포트원 결제 -->
<meta charset="UTF-8">
<title>주문 완료</title>
<style type="text/css">
.thankDiv {
	min-height: 700px;
}
</style>
 
 

<body>
<%@ include file="/top.jsp" %>
<%@ include file="/dbconnection.jsp" %>
<%

String shipping_cartId = "";
String shipping_name = "";
String shipping_shippingDate = ""; 
String shipping_zipcode = "";
String shipping_addr1 = "";
String shipping_addr2 = "";


Cookie[] cookies = request.getCookies();

if (cookies != null) {
	for (int i=0; i < cookies.length; i++){
		Cookie thisCookie = cookies[i];
		String n = thisCookie.getName();
		if (n.equals("Shipping_cartId")){
			shipping_cartId = URLDecoder.decode((thisCookie.getValue()), "utf-8");
		}
		if (n.equals("Shipping_shippingDate")){
			shipping_shippingDate = URLDecoder.decode((thisCookie.getValue()), "utf-8");
		}
		if(n.equals("Shipping_name")){
			shipping_name = URLDecoder.decode(thisCookie.getValue(),"utf-8");
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



		 
				int sum=0;
				
			    /* 생성된 세션정보를 가져온다.	 */	
				ArrayList<Product> cartList = (ArrayList<Product>)session.getAttribute("cartlist");
				
			    //장바구니에 한개도 없는 경우 초기화
				if(cartList == null){
					cartList = new ArrayList<Product>();
				}
					
				for(int i=0;i<cartList.size();i++){
					
				    //ArrayList에 있는 정보를 가져온다. 
					Product product = cartList.get(i);
				    //소계계산
					int total = product.getPd_saleprice() * product.getCart_qty();
				    //총합계 계산
				    sum += total;
				    
				    int pd_no = product.getPd_no();
				    int od_qty = product.getCart_qty();
				    int od_price = product.getPd_saleprice();
				    int od_status = 1;	
				    String od_createtime = product.getReleaseTime();
				    String od_updatetime = product.getUpdateTime();
				    
				    
				   
				    
				%>
					
					<sql:query var="resultSet2" dataSource="${conn}">
						select 	ifnull(max(od_id),0) as od_id
						from 	ordertb
					</sql:query> 
					<c:forEach var="row2" items="${resultSet2.rows}"> 
					<c:set var="od_id2" value="${row2.od_id + 1}" />  
					 
						
						<sql:update var="resultSet3" dataSource="${conn}">
							insert into ordertb values(?,?,?,?,?,?,now(),now())
							
							<sql:param value="${od_id2}"/> 
							<sql:param value="${sessionId}"/>
							<sql:param value="<%=pd_no%>"/>
							<sql:param value="<%=od_qty%>"/>
							
							<sql:param value="<%=sum%>"/>
							<sql:param value="<%=od_status%>"/> 
						</sql:update>
						
						<sql:update var="resultSet4" dataSource="${conn}">
							update 	product p, ordertb o 
							set		pd_stock = pd_stock - od_qty
							where	p.pd_no = o.pd_no;
						</sql:update>
						
	
						<sql:update var="resultSet" dataSource="${conn}">
							insert into shipping values(?,?,?,?,?,?)
							
							<sql:param value="${od_id2}"/> 
							<sql:param value="${sessionId}"/>
							<sql:param value="<%=shipping_shippingDate%>"/>
							<sql:param value="<%=shipping_zipcode%>"/> 
							<sql:param value="<%=shipping_addr1%>"/>
							<sql:param value="<%=shipping_addr2%>"/> 
						</sql:update> 
						  
<script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
<script type="text/javascript" src="https://service.iamport.kr/js/iamport.payment-1.1.5.js"></script>
<!-- 출처: https://minaminaworld.tistory.com/78 [미나미 블로그:티스토리] -->
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>
<script>    
$(".btn_payment").click(function() {
	  //class가 btn_payment인 태그를 선택했을 때 작동한다.
		
	  	IMP.init('imp65458571');
	  	//결제시 전달되는 정보
		IMP.request_pay({
				    pg : 'inicis', 
				    pay_method : 'card',
				    merchant_uid : 'merchant_' + new Date().getTime(),
				    name : '주문명:결제테스트'/*상품명*/,
				    amount : 1000/*상품 가격*/, 
				    buyer_email : 'iamport@siot.do'/*구매자 이메일*/,
				    buyer_name : '구매자이름',
				    buyer_tel : '010-1234-5678'/*구매자 연락처*/,
				    buyer_addr : '서울특별시 강남구 삼성동'/*구매자 주소*/,
				    buyer_postcode : '123-456'/*구매자 우편번호*/
				}, function(rsp) {
					var result = '';
				    if ( rsp.success ) {
				        var msg = '결제가 완료되었습니다.';
				        msg += '고유ID : ' + rsp.imp_uid;
				        msg += '상점 거래ID : ' + rsp.merchant_uid;
				        msg += '결제 금액 : ' + rsp.paid_amount;
				        msg += '카드 승인번호 : ' + rsp.apply_num;
				        result ='0';
				    } else {
				        var msg = '결제에 실패하였습니다.';
				        msg += '에러내용 : ' + rsp.error_msg;
				        result ='1';
				    }
				    if(result=='0') {
				    	location.href= $.getContextPath()+"/Cart/Success";
				    }
				    alert(msg);
				});
			}
</script>
					</c:forEach>
				
				
				
				<%
				}	
				
				%> 
<%
%>
<div class="container py-4 thankDiv">

	<div class="container-fluid p-5  ">
		<div class="container-fluid  "> 
			<h1 class="container-fluid p-5 text-center">주문 완료</h1> 
			<svg xmlns="http://www.w3.org/2000/svg" width="200" height="200" fill="currentColor" class="container-fluid bi bi-check-circle-fill" viewBox="0 0 16 16" color="lightblue">
				<path d="M16 8A8 8 0 1 1 0 8a8 8 0 0 1 16 0m-3.97-3.03a.75.75 0 0 0-1.08.022L7.477 9.417 5.384 7.323a.75.75 0 0 0-1.06 1.06L6.97 11.03a.75.75 0 0 0 1.079-.02l3.992-4.99a.75.75 0 0 0-.01-1.05z"/>
			</svg> 
		</div>
	</div>
	
	<div class=" container-fluid text-center">
		<h2 class=" ">주문해주셔서 감사합니다.</h2> 
	<p> 주문은 <% out.println(shipping_shippingDate); %>에 배송될 예정입니다! 
	</div>
	
	<div class="container-fluid text-center">
		<p> <a href="/cart/cart.jsp" class="btn btn-secondary"> 돌아가기 </a>
    	<button class="btn btn-warning" type="button" id="check_module" class="btn_payment">KG이니시스 </button> 
	</div> 

</div>



<%


session.removeAttribute("cartlist");


for(int i = 0; i < cookies.length; i++) {
	
	Cookie thisCookie = cookies[i];
	
	String n = thisCookie.getName();
	
	//	쿠키명이 Shipping_으로 시작하는 것 처리 
	if(n.startsWith("Shipping_")){
		thisCookie.setMaxAge(0);
	}
 	
	response.addCookie(thisCookie);
}


%>


<%@ include file="/footer.jsp" %>
</body>
</html>