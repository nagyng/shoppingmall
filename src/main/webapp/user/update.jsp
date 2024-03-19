<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<%@ include file="/header.jsp" %>
<%@ include file="/dbconnection.jsp" %>
<title>회원 수정 (회원용)</title>
<style type="text/css">
	.joinBtn {
		text-align: center;
	}
	.input-group-text {
		min-width: 150px;
	}
</style>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script>
	$(document).ready(function(){
		
		checkValue = function(){
			
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
				<h1 class="display-5 fw-bold text-center">내 정보 수정</h1> 
			</div>
		</div>
		
		<sql:query var="resultSet" dataSource="${conn}"> 
		   SELECT * FROM user WHERE user_id = ?
		<sql:param value="${sessionId}" />
		</sql:query>
				
		<c:forEach var="row" items="${resultSet.rows}">
			<c:set var="email" value="${row.email}" />
			<c:set var="email1" value="${email.split('@')[0]}" />
			<c:set var="email2" value="${email.split('@')[1]}" />
			<c:set var="birthday" value="${row.birthday }" />
		<div class="container-fluid">
		
			<form name="joinForm" action="update_process.jsp" method="post" onsubmit="return joinForm()">	<!-- joinForm() -->
				<div class="input-group input-group-lg mb-3">
					<div class="input-group-prepend">
					  <label class="input-group-text " id="inputGroup-sizing-lg">아이디</label>
					</div>
					<input value="<c:out value='${row.user_id }'/>" name="id" id="id" type="text" class="form-control " aria-label="Sizing example input" aria-describedby="inputGroup-sizing-lg" placeholder="ID">
				</div>
				<div class="input-group input-group-lg mb-3">
					<div class="input-group-prepend">
					<label class="input-group-text" id="inputGroup-sizing-lg">비밀번호</label> 
					</div>
					<input value="<c:out value='${row.user_pw }'/>" name="password" id="password" type="text" class="form-control " aria-label="Sizing example input" aria-describedby="inputGroup-sizing-lg" placeholder="PW"> 
				</div>
				<div class="input-group input-group-lg mb-3">
					<div class="input-group-prepend">
					<label class="input-group-text" id="inputGroup-sizing-lg">성명</label>
					</div>
					<input value="<c:out value='${row.username }'/>" name="name" id="name" type="text" class="form-control" aria-label="Sizing example input" aria-describedby="inputGroup-sizing-lg" placeholder="name">
				</div>

				<div class="input-group input-group-lg mb-3">
					<div class="input-group-prepend">
						<label class="input-group-text" id="inputGroup-sizing-lg" >남
						</label>
					</div>
					<c:set var="gender" value="${row.gender }" />
					<input name="gender"  id="gender" type="radio" class="form-control col-1"  aria-label="Radio button for following text input" value="male"
						<c:if test="${gender.equals('남')}"> <c:out value="checked" /> </c:if> >
					
					<div class="input-group-prepend">
						<label class="input-group-text" id="inputGroup-sizing-lg">여
						</label>
					</div>
					<input name="gender"  id="gender" type="radio" class="form-control col-1"  aria-label="Radio button for following text input" value="female"
						<c:if test="${gender.equals('여')}"> <c:out value="checked" /> </c:if> >
				</div>

				
				<div class="input-group input-group-lg mb-3">
					<div class="input-group-prepend">
					  <label class="input-group-text " id="inputGroup-sizing-lg">생일</label>
					</div>
					<input value="<c:out value='${birthday }'/>" name="birthday" id="birthday" type="text" class="form-control " aria-label="Sizing example input" aria-describedby="inputGroup-sizing-lg" placeholder="birthday">
				</div>
				
				<div class="input-group input-group-lg mb-3">
					<div class="input-group-prepend">
					  <label class="input-group-text " id="inputGroup-sizing-lg">이메일</label>
					</div>
					<div class="col-sm-4">
						<input value="<c:out value='${email1 }'/>" name="email1" id="email1" type="text" class="form-control" aria-label="Sizing example input" aria-describedby="inputGroup-sizing-lg"  placeholder="email">
					</div>
					@
					<div class="col-sm-3">
						<select name="email2" id="email2" class="form-control form-select"  aria-label="Sizing example input" aria-describedby="inputGroup-sizing-lg" >
							<option>naver.com</option>
							<option>daum.net</option>
							<option>gmail.com</option>
							<option>nate.com</option>
						</select>
					</div>
				</div>
				<div class="input-group input-group-lg mb-3">
					<div class="input-group-prepend">
					  <label class="input-group-text " id="inputGroup-sizing-lg">연락처</label>
					</div>
					<input value="<c:out value='${row.phone}'/>" name="phone" id="phone" type="text" class="form-control " aria-label="Sizing example input" aria-describedby="inputGroup-sizing-lg" placeholder="phone">
				</div>
				<div class="input-group input-group-lg mb-3">
					<div class="input-group-prepend">
					  <label class="input-group-text " id="inputGroup-sizing-lg">우편번호</label>
					</div>
					<input value="<c:out value='${row.zipcode}'/>" name="zipcode" id="zipcode" type="text" class="form-control col-4" aria-label="Sizing example input" aria-describedby="inputGroup-sizing-lg" placeholder="zipcode" readonly>
					
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
					  <label class="input-group-text " id="inputGroup-sizing-lg">도로명주소</label>
					</div>
					<input value="<c:out value='${row.addr1}'/>" name="addr1" id="addr1"  type="text" class="form-control " aria-label="Sizing example input" aria-describedby="inputGroup-sizing-lg" placeholder="addr1"  readonly>
				</div>
				<div class="input-group input-group-lg mb-3">
					<div class="input-group-prepend">
					  <label class="input-group-text " id="inputGroup-sizing-lg">상세주소</label>
					</div>
					<input value="<c:out value='${row.addr2}'/>" name="addr2" id="addr2" type="text" class="form-control " aria-label="Sizing example input" aria-describedby="inputGroup-sizing-lg" placeholder="addr2" >
				</div>
				<div class="input-group input-group-lg mb-3">
					<div class="input-group-prepend">
					  <label class="input-group-text " id="inputGroup-sizing-lg">회원 등급</label>
					</div>
					<input value="<c:out value='${row.grade}'/>" name="grade" id="grade" type="text" class="form-control " aria-label="Sizing example input" aria-describedby="inputGroup-sizing-lg" readonly>
				</div>
				<div class="input-group input-group-lg mb-3">
					<div class="input-group-prepend">
					  <label class="input-group-text " id="inputGroup-sizing-lg">가입일자</label>
					</div>
					<input value="<c:out value='${row.createtime}'/>" name="grade" id="grade" type="text" class="form-control " aria-label="Sizing example input" aria-describedby="inputGroup-sizing-lg" readonly>
				</div>
				
				<div class="col-12 mb-3 joinBtn">
					<div class="container-fluid">
						<input type="submit" class="btn btn-primary " value="수정 " onclick="checkValue();">
						<input type="reset" class="btn btn-primary " value="취소 "> <!-- 
						<input type="button" class="btn btn-danger " value="탈퇴 " onclick="location.href='delete.jsp'"> -->
					</div>
				</div>
			</form>
		</div>
	</c:forEach>
	</div>



<%@ include file="/footer.jsp" %>
</body>

</html>