<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<%@ include file="/header.jsp" %>
<%@ include file="/dbconnection.jsp" %>
<title>관리자 주문서 수정</title>
<style type="text/css">
	.joinBtn {
		text-align: center;
	}
	.orderLabel {
		min-width: 200px;
	}
</style>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script>
	$(document).ready(function(){
		
		checkValue = function(){
			/* 
			if(!$("#id").val()){
				alert("아이디를 입력하세요!");
				return false;
			}
			
			if(!$("#password").val()){
				alert("비밀번호를 입력하세요!");
				return false;
			}
			
			if(!$("#password").equals($("#password_confirm"))){
				alert("비밀번호가 일치하지 않습니다.");
				return false;
			}
			
			if(!$("#name").val()){
				alert("이름을 입력하세요!");
				return false;
			}
			
			if(!$("#phone").val()){
				alert("연락처를 입력하세요!");
				return false;
			}
			
			if(!$("input:radio[name='gender']").is(":checked")){
				alert("성별을 선택하세요!");
				return false;			
			}
			 */
			
			joinForm.submit();
		}		
		
	});
</script>
<!-- datepicker를 사용하기 위한 선언 -->
<link rel="stylesheet" href="//code.jquery.com/ui/1.13.2/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
<script>
/* 생일을 달력에서 찍기 */
$(document).ready(function(){
		$("#birthday").datepicker({
			changeMonth:true,
			changeYear:true,
			dateFormat:"yy-mm-dd",
			prevText:"이전 달",
			nextText:"다음 달",
			monthNames:['1월','2월','3월','4월',
						'5월','6월','7월','8월',
						'9월','10월','11월','12월'
				       ],
			monthNamesShort:['1월','2월','3월','4월',
							'5월','6월','7월','8월',
							'9월','10월','11월','12월'
					       ],
			dayNames:['일','월','화','수','목','금','토'],
			dayNamesShort:['일','월','화','수','목','금','토'],
			dayNamesMin:['일','월','화','수','목','금','토'],
			showMonthAfterYear:true,
			yearSuffix:'년'
		});
	});
</script>
<!-- 카카오 우편번호 API -->
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
    function postSearch() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var addr = ''; // 주소 변수
                var extraAddr = ''; // 참고항목 변수

                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    addr = data.roadAddress;
                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    addr = data.jibunAddress;
                }

                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
                if(data.userSelectedType === 'R'){
                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있고, 공동주택일 경우 추가한다.
                    if(data.buildingName !== '' && data.apartment === 'Y'){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                    if(extraAddr !== ''){
                        extraAddr = ' (' + extraAddr + ')';
                    }
                    // 조합된 참고항목을 해당 필드에 넣는다.
                    document.getElementById("addr2").value = extraAddr;
                
                } else {
                    document.getElementById("addr2").value = '';
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('zipcode').value = data.zonecode;
                document.getElementById("addr1").value = addr;
                // 커서를 상세주소 필드로 이동한다.
                document.getElementById("zipcode").focus();
            }
        }).open();
    }
</script>
</head>
<body>

<%@ include file="/top.jsp" %>

	<div class="container col-lg-6 col-md-12 col-sm-12">
		<div class="p-5">
			<div class="container-fluid">
				<h1 class="display-5 fw-bold text-center">주문 수정 (관리자용)</h1> 
			</div>
		</div>
		  
		<sql:query var="resultSet" dataSource="${conn}"> 
			SELECT 		o.od_id as 'od_id',
						max(o.user_id) as 'user_id',
						count(o.pd_no) as 'pd_no',
						sum(o.od_qty) as 'od_qty',
						sum(o.od_price) as 'od_price',
 						max(o.od_status) as 'od_status', 
						max(o.od_createtime) as 'od_createtime',
						max(o.od_updatetime) as 'od_updatetime',
						max(co.status) as status
			FROM 		ordertb o, codetb co
			WHERE 		od_id = ? 
            and			o.od_status = co.od_status
			group by	o.od_id
			order by 	o.od_id;
		<sql:param value="${param.od_id}" />
		</sql:query> 
				
		<div class="container-fluid">
			<form name="joinForm" action="update_order_process.jsp" method="post" onsubmit="return joinForm()"> 
		<c:forEach var="row" items="${resultSet.rows}"> 
				<div class="input-group input-group-lg mb-3">
					<div class="input-group-prepend">
					  <label class="input-group-text orderLabel" id="inputGroup-sizing-lg">주문번호</label>
					</div>
					<input readonly value="<c:out value='${row.od_id }'/>" name="od_id" id="od_id" type="text" class="form-control " aria-label="Sizing example input" aria-describedby="inputGroup-sizing-lg" placeholder="ID">
				</div> 
				<div class="input-group input-group-lg mb-3">
					<div class="input-group-prepend">
					  <label class="input-group-text  orderLabel" id="inputGroup-sizing-lg">고객 아이디</label>
					</div>
					<input readonly value="<c:out value='${row.user_id }'/>" name="user_id" id="user_id" type="text" class="form-control " aria-label="Sizing example input" aria-describedby="inputGroup-sizing-lg" placeholder="ID">
				</div> 
				<div class="input-group input-group-lg mb-3">
					<div class="input-group-prepend">
					  <label class="input-group-text  orderLabel" id="inputGroup-sizing-lg">종류별 총 개수</label>
					</div>
					<input value="<c:out value='${row.pd_no}'/>" name="pd_no" id="pd_no" type="text" class="form-control " aria-label="Sizing example input" aria-describedby="inputGroup-sizing-lg" placeholder="phone">
				</div>  
				<div class="input-group input-group-lg mb-3">
					<div class="input-group-prepend">
					  <label class="input-group-text  orderLabel" id="inputGroup-sizing-lg">총 수량</label>
					</div>
					<input value="<c:out value='${row.od_qty}'/>" name="od_qty" id="od_qty" type="text" class="form-control " aria-label="Sizing example input" aria-describedby="inputGroup-sizing-lg" placeholder="phone">
				</div>  
				<div class="input-group input-group-lg mb-3">
					<div class="input-group-prepend">
					  <label class="input-group-text  orderLabel" id="inputGroup-sizing-lg">총 결제 금액</label>
					</div>
					<input value="<c:out value='${row.od_price}'/>" name="od_price" id="od_price" type="text" class="form-control " aria-label="Sizing example input" aria-describedby="inputGroup-sizing-lg" placeholder="phone">
				</div>  
				<div class="input-group input-group-lg mb-3">
					<div class="input-group-prepend">
					  <label class="input-group-text  orderLabel" id="inputGroup-sizing-lg">배송 상태</label>
					</div>
					<select class="custom-select col-sm-5" name="od_status" id="od_status" aria-label="Example select with button addon" >
					    <option selected value="<c:out value='${row.od_status}'/>">현재 : <c:out value='${row.status}'/></option>
					     <hr>
					    <option value="1" >결제 완료</option>
					    <option value="2" >상품준비중</option>
					    <option value="3" >배송준비중</option>
					    <option value="4" >배송 중</option>
					    <option value="5" >배송 완료</option>
					    <option value="6" >취소 완료</option>
					    <option value="7" >반품 신청</option> 
					    <option value="8" >반품 완료</option>
					    <option value="9" >환불 신청</option>
					    <option value="10" >환불 완료</option> 
					  </select> 
				</div>  
				<div class="input-group input-group-lg mb-3">
					<div class="input-group-prepend">
					  <label class="input-group-text  orderLabel" id="inputGroup-sizing-lg">주문 일자</label>
					</div>
					<input value="<c:out value='${row.od_createtime}'/>" name="od_createtime" id="od_createtime" type="text" class="form-control " aria-label="Sizing example input" aria-describedby="inputGroup-sizing-lg" readonly>
				</div>
				
	</c:forEach>
				<div class="col-12 mb-3 row joinBtn">
					<div class="col-sm-offset-2 col-sm-10 ">
						<input type="submit" class="btn btn-primary " value="수정 " onclick="checkValue();">
						<input type="reset" class="btn btn-primary " value="취소 ">
					</div>
				</div>
			</form>
		</div>
	</div>



<%@ include file="/footer.jsp" %>
</body>
</html>