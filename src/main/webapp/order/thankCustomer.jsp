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
				int total=0;
				
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
					total = product.getPd_saleprice() * product.getCart_qty();
				    
				    int pd_no = product.getPd_no();
				    String pd_name = product.getPd_name();
				    int od_qty = product.getCart_qty();
				    int od_price = product.getPd_saleprice();
				    int od_status = 0;	
				    String od_createtime = product.getReleaseTime();
				    String od_updatetime = product.getUpdateTime();
				    
				    
				   
				    
				%>
				<sql:query var="resultSet4" dataSource="${conn}">
				   SELECT * FROM user WHERE user_id = ?
				<sql:param value="${sessionId}" />
				</sql:query>
				
				<c:forEach var="row4" items="${resultSet4.rows}">   
					<c:if test="${row4.grade == 2}"> 
						<% total = (int) Math.ceil((total * 0.9)); %> 
					</c:if>
					<c:if test="${row4.grade == 3}"> 
						<% total = (int) Math.ceil((total * 0.8)); %> 
					</c:if>
					<c:if test="${row4.grade == 4}"> 
						<% total = (int) Math.ceil((total * 0.7)); %> 
					</c:if>
					<c:if test="${row4.grade > 4}"> 
						<% total = (int) Math.ceil((total * 0.6)); %> 
					</c:if>	
				
				<% 
			    //총합계 계산
			    sum += total;
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
						
						<sql:update var="resultSet5" dataSource="${conn}">
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
						  
					
<!-- 카카오페이 연동 결제 -->		
<script type="text/javascript">
	//구매자 정보 
	//var buyer_email = ;
	//var buyer_tel = ;
	var buyer_addr = '<%=shipping_addr1%>';
	var buyer_postcode = <%=shipping_zipcode%>;
	
	// 결제창 함수 넣어주기 -> 값이 없는 에러 
	 /* 
	var today = new Date();
	var hours = today.getHours(); // 시
	var minutes = today.getMinutes();  // 분
	var seconds = today.getSeconds();  // 초
	var milliseconds = today.getMilliseconds();
	var makeMerchantUid = `${hours}` + `${minutes}` + `${seconds}` + `${milliseconds}`;
	 */
	
	var IMP = window.IMP;
	IMP.init('imp65458571');		//나의 아임포트 상점명 (발급키 부분)
	
	function kakaoPay(email, username) {
	IMP.request_pay({
	    pg: 'kakaopay.TC0ONETIME', // PG사 코드표에서 선택
	    pay_method: 'card', // 결제 방식
	    merchant_uid: "kakao_" + new Date().getTime(), // 결제 고유 번호  // + makeMerchantUid, <- 이렇게 하니까 값이 없어서 계속 같은 결제건으로 인식되는 에러  
	    name: '<%=pd_name%>', // 제품명
	    amount: <%=sum%>, // 가격
	    //구매자 정보 ↓
	    buyer_email: "<c:out value='${row4.email}'/>",
	    buyer_name: "<%=shipping_name%>",
	    buyer_tel : "<c:out value='${row4.phone}'/>",
	    //buyer_addr : buyer_addr,
	    //buyer_postcode : buyer_postcode
	}, async function (rsp) { // callback
	    if (rsp.success) { //결제 성공시
	        console.log(rsp); 
	        //결제 성공시 프로젝트 DB저장 요청 
	        
	
	        if (response.status == 200) { // DB저장 성공시
	            alert('결제 완료!')

				<%-- window.location.href = '/order/writeReview?pd_no=<%=pd_no%>'; --%>
	        
	            window.location.reload();
	        } else { // 결제완료 후 DB저장 실패시
	            alert(`error:[${response.status}]\n결제요청이 승인된 경우 관리자에게 문의바랍니다.`);
	            // DB저장 실패시 status에 따라 추가적인 작업 가능성
	        }
	    } else if (rsp.success == false) { // 결제 실패시
	        alert(rsp.error_msg)
	    }
	})
};

</script>


<!-- 이니시스 연동 결제 -->
<script>    
function requestPay() {
	var IMP = window.IMP; // 생략가능
	IMP.init('imp65458571');
	// 'iamport' 대신 부여받은 "가맹점 식별코드"를 사용 
	// i'mport 관리자 페이지 -> 내정보 -> 가맹점식별코드 
	IMP.request_pay({            
		pg: 'html5_inicis', //그냥 inicis 는 에러가 뜬다 
		// version 1.1.0부터 지원.
		/*                 
		'kakao':카카오페이, 
		'html5_inicis':이니시스(웹표준결제)    
		'nice':나이스페이                    
		'jtnet':제이티넷                    
		'uplus':LG유플러스                   
		'danal':다날                    
		'payco':페이코                    
		'syrup':시럽페이                    
		'paypal':페이팔                
		*/
		pay_method: 'card',            
		/*                 
		'samsung':삼성페이,
		'card':신용카드,                 
		'trans':실시간계좌이체,                
		'vbank':가상계좌,                
		'phone':휴대폰소액결제             
		*/ 
		merchant_uid: 'inicis_' + new Date().getTime(),
		/*                 
		merchant_uid에 경우 
		https://docs.iamport.kr/implementation/payment 
		위에 url에 따라가시면 넣을 수 있는 방법이 있습니다. 
		참고하세요.                 
		나중에 포스팅 해볼게요. 
		*/            
		name: '<%=pd_name%>',  		     //제품명
		amount: <%=sum%>,            	 //가격
		buyer_email: '<c:out value='${row4.email}'/>',
		buyer_name: '<%=shipping_name%>',            //결제창에서 보여질 이름    
		buyer_tel: '<c:out value='${row4.phone}'/>',            
		//buyer_addr: '서울특별시 강남구 삼성동',            
		//buyer_postcode: '123-456',            
		/* m_redirect_url: 'https://www.yourdomain.com/payments/complete' */
		/*                 
		모바일 결제시,                
		결제가 끝나고 랜딩되는 URL을 지정                 
		(카카오페이, 페이코, 다날의 경우는 필요없음. PC와 마찬가지로 callback함수로 결과가 떨어짐)
		*/        
		}, 
		function (rsp) {           
			console.log(rsp);
			
			if (rsp.success) {                
				var msg = '결제가 완료되었습니다.';
				msg += '고유ID : ' + rsp.imp_uid;
				msg += '상점 거래ID : ' + rsp.merchant_uid; 
				msg += '결제 금액 : ' + rsp.paid_amount;
				msg += '카드 승인번호 : ' + rsp.apply_num;
				
				<%-- window.location.href = '/order/writeReview?pd_no=<%=pd_no%>'; --%>
				
			} else {                
				var msg = '결제에 실패하였습니다.'; 
				msg += '에러내용 : ' + rsp.error_msg;
			}            
			alert(msg);        
		});    
	};

</script>

						<sql:update var="resultSet5" dataSource="${conn}">
							update 	product p, ordertb o 
							set		o.od_status = 1
							where	p.pd_no = o.pd_no
							and		o.od_id = ?;
						<sql:param value="${od_id2}"/> 
						</sql:update>


					</c:forEach>	<!-- ordertb 테이블 -->
				</c:forEach>		<!-- user 테이블 -->
				 
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
		<h3>결제 수단 선택</h3>
    	<button class="btn btn-warning" type="button" onclick="kakaoPay();" id="payment">카카오페이</button> 
    	<button class="btn btn-danger" type="button" onclick="requestPay();">이니시스</button>
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