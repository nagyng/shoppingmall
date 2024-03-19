<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<%@ include file="/header.jsp" %>
<%@ include file="/dbconnection.jsp" %>
<title>회원가입</title>
<style type="text/css">
	.joinBtn {
		text-align: center;
	}
	.joinLabel {
		min-width: 150px;
	}
</style>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script>
	$(document).ready(function(){
		
		checkValue = function(){

            var ph = $("#phone").val();
            
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
            if (!hpReg.test(ph)){
                alert('연락처를 다시 입력하세요.');
                return false;
            }
			
			if(!$("input:radio[name='gender']").is(":checked")){
				alert("성별을 선택하세요!");
				return false;			
			}
			
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
<script>    
    //check.jsp 이동해서 아이디 중복 검사
	function submit2(frm) { //폼에서 액션 경로를 여러개 사용하기 위한 함수
		frm.action = '/user/check.jsp'; //두번째로 보낼 경로 아이디 중복 체크하는 부분
		frm.submit();
		return false;
	}
</script> 
</head>
<body>


	<div class="container col-lg-6 col-md-12 col-sm-12 mb-5">
		<div class="p-5">
			<div class="container-fluid">
				<h1 class="display-5 fw-bold text-center">회원가입</h1> 
			</div>
		</div>
		<div class="container-fluid">
			<form name="joinForm" action="join_process.jsp" method="post" onsubmit="return joinForm()">	<!-- joinForm() -->
				<div class="input-group input-group-lg mb-3">
					<div class="input-group-prepend">
					  <label class="input-group-text joinLabel" id="inputGroup-sizing-lg" >아이디</label>
					</div>
					<input name="id" id="id" type="text" class="form-control  col-4" aria-label="Sizing example input" aria-describedby="inputGroup-sizing-lg" placeholder="ID" required>
					<!-- <input type="button" value="아이디 중복 검사"  id="registerCheckFunction" onclick="registerCheckFunction();" ></button> -->
					
					<!-- 중복확인 버튼을 누르면 check.jsp로 이동하여 아이디 중복 검사 --> 
					<button type="button" class="btn btn-outline-success" onclick="return submit2(this.form);">중복확인</button>	
					
					<!-- 중복체크를 위한 알림메시지 모달 -->
					<div class="modal fade" id="checkModal" tabindex="-1" role="dialog" aria-hidden="true">
					    <div class="vertical-alignment-helper">
						<div class="modal-dialog vertical-align-center">
							<!--  패널 출력 성공 메시지냐 오류 메시지에 따라 -->
								<div class="modal-content panel-info">
									<div class="modal-header panel-heading">
										<button type="button" class="close" data-dismiss="modal">
											<span aria-hidden="true">&times;</span>
											<span class="sr-only">Close</span>
										</button>
										<h4 class="modal-title">
											확인 메시지
										</h4>
										<div class="modal-body" id="checkMessage">
										</div>
										<div class="modal-footer">
										<button type="button" class="btn btn-primary" data-dismiss="modal">확인</button>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
					
					
				</div> 
				<div class="input-group input-group-lg mb-3">
					<div class="input-group-prepend">
					<label class="input-group-text joinLabel" id="inputGroup-sizing-lg">비밀번호</label> 
					</div>
					<input name="password" id="password" type="text" class="form-control " aria-label="Sizing example input" aria-describedby="inputGroup-sizing-lg" placeholder="PW" required> 
				</div>
				<div class="input-group input-group-lg mb-3">
					<div class="input-group-prepend">
					<label class="input-group-text joinLabel" id="inputGroup-sizing-lg">비밀번호확인</label>
					</div>
					<input name="password_confirm" id="password_confirm" type="text" class="form-control " aria-label="Sizing example input" aria-describedby="inputGroup-sizing-lg" placeholder="PW confirm" required>
				</div>
				<div class="input-group input-group-lg mb-3">
					<div class="input-group-prepend">
					<label class="input-group-text joinLabel" id="inputGroup-sizing-lg">이름</label>
					</div>
					<input name="name" id="name" type="text" class="form-control" aria-label="Sizing example input" aria-describedby="inputGroup-sizing-lg" placeholder="name" required>
				</div>

				<div class="input-group input-group-lg mb-3">
					<div class="input-group-prepend">
						<label class="input-group-text joinLabel" id="inputGroup-sizing-lg" >남
						</label>
					</div>
					<input name="gender"  id="gender" type="radio" class="form-control col-1"  aria-label="Radio button for following text input" value="male">
					
					<div class="input-group-prepend" >
						<label class="input-group-text joinLabel" id="inputGroup-sizing-lg">여
						</label>
					</div>
					<input name="gender"  id="gender" type="radio" class="form-control col-1"  aria-label="Radio button for following text input" value="female">
				</div>

				
				<div class="input-group input-group-lg mb-3">
					<div class="input-group-prepend">
					  <label class="input-group-text  joinLabel" id="inputGroup-sizing-lg">생일</label>
					</div>
					<input name="birthday" id="birthday" type="text" class="form-control " aria-label="Sizing example input" aria-describedby="inputGroup-sizing-lg" placeholder="birthday" required>
				</div>
				
				<div class="input-group input-group-lg mb-3">
					<div class="input-group-prepend">
					  <label class="input-group-text  joinLabel" id="inputGroup-sizing-lg">이메일</label>
					</div>
						<input name="email1" id="email1" type="text" class="form-control" aria-label="Sizing example input" aria-describedby="inputGroup-sizing-lg"  placeholder="email" required>
					@
						<select name="email2" id="email2" class="form-control"  aria-label="Sizing example input" aria-describedby="inputGroup-sizing-lg"  required>
							<option>naver.com</option>
							<option>daum.net</option>
							<option>gmail.com</option>
							<option>nate.com</option>
						</select>
					
				</div>
				<div class="input-group input-group-lg mb-3">
					<div class="input-group-prepend">
					  <label class="input-group-text  joinLabel" id="inputGroup-sizing-lg">연락처</label>
					</div>
					<input name="phone" id="phone" type="text" class="form-control " aria-label="Sizing example input" aria-describedby="inputGroup-sizing-lg" placeholder="phone" required>
				</div>
				<div class="input-group input-group-lg mb-3">
					<div class="input-group-prepend">
					  <label class="input-group-text  joinLabel" id="inputGroup-sizing-lg">우편번호</label>
					</div>
					<input name="zipcode" id="zipcode" type="text" class="form-control col-4" aria-label="Sizing example input" aria-describedby="inputGroup-sizing-lg" placeholder="zipcode" readonly >
					
					<!-- 우편번호찾기 아이콘 표시 -->
					<div class="col-sm-4" onclick="postSearch();">
					    <i class="bi bi-search-heart"></i>
					    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-search-heart" viewBox="0 0 16 16">
						<path d="M6.5 4.482c1.664-1.673 5.825 1.254 0 5.018-5.825-3.764-1.664-6.69 0-5.018"/>
						<path d="M13 6.5a6.47 6.47 0 0 1-1.258 3.844q.06.044.115.098l3.85 3.85a1 1 0 0 1-1.414 1.415l-3.85-3.85a1 1 0 0 1-.1-.115h.002A6.5 6.5 0 1 1 13 6.5M6.5 12a5.5 5.5 0 1 0 0-11 5.5 5.5 0 0 0 0 11"/>
						</svg>
					</div>
				</div>
				<div class="input-group input-group-lg mb-3">
					<div class="input-group-prepend">
					  <label class="input-group-text  joinLabel" id="inputGroup-sizing-lg">도로명주소</label>
					</div>
					<input name="addr1" id="addr1"  type="text" class="form-control " aria-label="Sizing example input" aria-describedby="inputGroup-sizing-lg" placeholder="addr1"  readonly>
				</div>
				<div class="input-group input-group-lg mb-3">
					<div class="input-group-prepend">
					  <label class="input-group-text  joinLabel" id="inputGroup-sizing-lg">상세주소</label>
					</div>
					<input name="addr2" id="addr2" type="text" class="form-control " aria-label="Sizing example input" aria-describedby="inputGroup-sizing-lg" placeholder="addr2" >
				</div>
				
				<div class="m-5 joinBtn">
					<div class="col-sm-offset-2 container text-center ">
						<input type="submit" class="btn btn-primary " value="가입 " onclick="checkValue();">
						<input type="reset" class="btn btn-primary " value="취소 ">
					</div>
				</div>
			</form>
		</div>
	</div>



<%@ include file="/footer.jsp" %>
</body>
</html>