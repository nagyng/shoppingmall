<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/header.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title> 
<!-- 포트원 결제 -->
    <script src="https://cdn.iamport.kr/v1/iamport.js"></script>
    <!-- jQuery -->
    <script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js" ></script>
    <!-- iamport.payment.js -->
    <script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.2.0.js"></script>
<!-- 포트원 결제 -->

<!-- 카카오페이 결제 -->
<script type="text/javascript">
//구매자 정보

// 결제창 함수 넣어주기
 
var today = new Date();
var hours = today.getHours(); // 시
var minutes = today.getMinutes();  // 분
var seconds = today.getSeconds();  // 초
var milliseconds = today.getMilliseconds();
var makeMerchantUid = `${hours}` + `${minutes}` + `${seconds}` + `${milliseconds}`;


var IMP = window.IMP;
IMP.init('imp65458571');

function kakaoPay(email, username) {
IMP.request_pay({
    pg: 'kakaopay.TC0ONETIME', // PG사 코드표에서 선택
    pay_method: 'card', // 결제 방식
    merchant_uid: "kakao_" + makeMerchantUid, // 결제 고유 번호
    name: '상품명', // 제품명
    amount: 100, // 가격
    //구매자 정보 ↓
    buyer_email: "test@daum.net",
    buyer_name: "test",
    // buyer_tel : '010-1234-5678',
    // buyer_addr : '서울특별시 강남구 삼성동',
    // buyer_postcode : '123-456'
}, async function (rsp) { // callback
    if (rsp.success) { //결제 성공시
        console.log(rsp); 
        //결제 성공시 프로젝트 DB저장 요청 

        if (response.status == 200) { // DB저장 성공시
            alert('결제 완료!')
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

<!-- 이니시스 결제 -->
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
		html5_inicis':이니시스(웹표준결제)    
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
		merchant_uid: 'merchant_' + new Date().getTime(),
		/*                 
		merchant_uid에 경우 
		https://docs.iamport.kr/implementation/payment 
		위에 url에 따라가시면 넣을 수 있는 방법이 있습니다. 
		참고하세요.                 
		나중에 포스팅 해볼게요. 
		*/            
		name: '주문명:결제테스트',   //결제창에서 보여질 이름            
		amount: 1000,            	 //가격
		buyer_email: 'iamport@siot.do',
		buyer_name: '구매자이름',            
		buyer_tel: '010-1234-5678',            
		buyer_addr: '서울특별시 강남구 삼성동',            
		buyer_postcode: '123-456',            
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
			} else {                
				var msg = '결제에 실패하였습니다.'; 
				msg += '에러내용 : ' + rsp.error_msg;
			}            
			alert(msg);        
		});    
	};

</script>


</head> 
<body>
<%@ include file="/top.jsp"%> 
<div class="container" style="min-height: 700px;">

	<div class="text-center p-5">
    <button type="button" onclick="kakaoPay()">카카오페이</button>
    <button type="button" onclick="requestPay()">이니시스</button>
    </div>
    
</div>

<%@ include file="/footer.jsp"%>
</body>
</html>