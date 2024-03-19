<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="/header.jsp" %>
<%
	String name = (String) request.getAttribute("name");
%>
<html>
<head> 
<title>리뷰 작성</title>
<style type="text/css">
	#preview {
		max-width: 300px;
		max-height: 300px;
	}  
	
	.rating__input {
	display: none; /* 라디오버튼 hide */
	}
	
	.rating__label .star-icon {
		width: 24px;
		height: 24px;
		display: block;
		background-image: url("star.svg");
		background-repeat: no-repeat;
	}
	
	.rating__label {
		width: 12px; /* 원본 사이즈/2 */
		overflow: hidden;
		cursor: pointer;
	}
	.rating__label .star-icon {
		width: 12px; /* 원본 사이즈/2 */
		height: 24px;
		display: block;
		position: relative;
		left: 0;
		background-image: url("star.svg");
		background-repeat: no-repeat;
	}
	.rating__label--full .star-icon {
		background-position: right;
	}
	.rating__label--half .star-icon {
		background-position: left;
	}
	.reviewDiv > form > div > label {
		min-width:300px;
	}
	
</style>
</head>

<script type="text/javascript"> /* 별점 구현하기 */
	const rateWrap = document.querySelectorAll('.rating'),
	label = document.querySelectorAll('.rating .rating__label'),
	input = document.querySelectorAll('.rating .rating__input'),
	labelLength = label.length,
	opacityHover = '0.5';
	
	let stars = document.querySelectorAll('.rating .star-icon');
	
	checkedRate();

	
	rateWrap.forEach(wrap => {
	wrap.addEventListener('mouseenter', () => {
	    stars = wrap.querySelectorAll('.star-icon');
	
	    stars.forEach((starIcon, idx) => {
	        starIcon.addEventListener('mouseenter', () => {
	            if (wrap.classList.contains('readonly') == false) {
	                initStars(); // 기선택된 별점 무시하고 초기화
	                filledRate(idx, labelLength);  // hover target만큼 별점 active
	
	                // hover 시 active된 별점의 opacity 조정
	                for (let i = 0; i < stars.length; i++) {
	                    if (stars[i].classList.contains('filled')) {
	                        stars[i].style.opacity = opacityHover;
	                    }
	                }
	            }
	        });
	
	        starIcon.addEventListener('mouseleave', () => {
	            if (wrap.classList.contains('readonly') == false) {
	                starIcon.style.opacity = '1';
	                checkedRate(); // 체크된 라디오 버튼 만큼 별점 active
	            }
	        });
	
	        // rate wrap을 벗어날 때 active된 별점의 opacity = 1
	        wrap.addEventListener('mouseleave', () => {
	            if (wrap.classList.contains('readonly') == false) {
	                starIcon.style.opacity = '1';
	            }
	        });
	
	        // readonnly 일 때 비활성화
	        wrap.addEventListener('click', (e) => {
	            if (wrap.classList.contains('readonly')) {
	                e.preventDefault();
	            }
	        });
	    });
	});
	});
	
	//target보다 인덱스가 낮은 .star-icon에 .filled 추가 (별점 구현)
	function filledRate(index, length) {
	if (index <= length) {
	    for (let i = 0; i <= index; i++) {
	        stars[i].classList.add('filled');
	    }
	}
	}
	
	//선택된 라디오버튼 이하 인덱스는 별점 active
	function checkedRate() {
	let checkedRadio = document.querySelectorAll('.rating input[type="radio"]:checked');
	
	
	initStars();
	checkedRadio.forEach(radio => {
	    let previousSiblings = prevAll(radio);
	
	    for (let i = 0; i < previousSiblings.length; i++) {
	        previousSiblings[i].querySelector('.star-icon').classList.add('filled');
	    }
	
	    radio.nextElementSibling.classList.add('filled');
	
	    function prevAll() {
	        let radioSiblings = [],
	            prevSibling = radio.parentElement.previousElementSibling;
	
	        while (prevSibling) {
	            radioSiblings.push(prevSibling);
	            prevSibling = prevSibling.previousElementSibling;
	        }
	        return radioSiblings;
	    }
	});
	}
	
	//별점 초기화 (0)
	function initStars() {
	for (let i = 0; i < stars.length; i++) {
	    stars[i].classList.remove('filled');
	}
}
</script>
<!-- 유효성 검사 -->
<script type="text/javascript">
	function checkForm() {
		if (!document.newWrite.rv_title.value) {
			alert("제목을 입력하세요.");
			return false;
		}
		if (!document.newWrite.rv_content.value) {
			alert("내용을 입력하세요.");
			return false;
		}		
		if (!document.newWrite.pd_no.value) {
			alert("품목 번호를 입력하세요.");
			return false;
		}	
		newWrite.submit(); 
	}

	function readURL(input) {
		  if (input.files && input.files[0]) {
		    var reader = new FileReader();
		    reader.onload = function(e) {
		      document.getElementById('preview').src = e.target.result;
		    };
		    reader.readAsDataURL(input.files[0]);
		  } else {
		    document.getElementById('preview').src = "";
		  }
		}
	 
</script>

<body>
<%@ include file="/top.jsp" %> 
	<%@ include file="/dbconnection.jsp" %> 
	<div class="container-fluid col-9">
		
		 <div class="p-5 mb-4 bg-body-tertiary ">
	      <div class="container-fluid py-5">
	        <h1 class="display-5 fw-bold">리뷰</h1> 
	      </div>
	    </div>
	
		<div class="reviewDiv text-center"> 
			<form name="newWrite" action="/ReviewWrite.rdo"  method="post" enctype="multipart/form-data">
				<input name="id" type="hidden" class="form-control" value="${sessionId}">
				<div class="col-10 mb-3 row">
					<label class="col-sm-2 control-label">아이디</label>
					<div class="col-sm-3">
						<input name="user_id" type="text" class="form-control" value="${sessionId}" placeholder="user id" readonly>
					</div>
				</div>
		<%   
		int pd_no2 = 0;
		if(request.getParameter("pd_no") != null) {
			pd_no2 = Integer.parseInt(request.getParameter("pd_no"));
			} 
		%>
	
				<div class="col-10 mb-3 row">
					<label class="col-sm-2 control-label" >품목 번호</label>
					<div class="col-sm-5">
						<input name="pd_no" type="text" class="form-control" id="pd_no" value="<%=pd_no2%>" placeholder="제품 번호는 필수 입력 사항입니다.">
					</div>
				</div>

				 
				<div class="col-10 mb-3 row rating"> 
					<label class="col-sm-2 control-label" >별점</label>
					<div class="">
					<fieldset class="ml-3"> 
						5점
						<input class="" type="radio" id="rating5" name="rating" value="5"><label for="rating10" title="5점"></label>  
						<input type="radio" id="rating4" name="rating" value="4"><label for="rating8" title="4점"></label> 
						<input type="radio" id="rating3" name="rating" value="3"><label for="rating6" title="3점"></label> 
						<input type="radio" id="rating2" name="rating" value="2"><label for="rating4" title="2점"></label> 
						<input type="radio" id="rating1" name="rating" value="1"><label for="rating2" title="1점"></label> 
						1점
					</fieldset> 
					</div>
				</div>  
				 
				<div class="col-10 mb-3 row">
					<label class="col-sm-2 control-label" >제목</label>
					<div class="col-sm-5"> 
						<input name="rv_title" type="text" class="form-control"	placeholder="제목을 입력해주세요." value="만족스러워요!">
					</div>
				</div>
				<div class="col-10 mb-3 row">
					<label class="col-sm-2 control-label" >내용</label>
					<div class="col-sm-8">
						<textarea name="rv_content" cols="50" rows="5" class="form-control"	placeholder="내용을 작성해주세요.">오래 쓸 것 같아요.</textarea>
					</div>
				</div>

				<div class="col-10 mb-3 row">
					<label class="col-sm-2 control-label" >첨부파일</label>
					<div class="col-sm-8">
						<p> <input type="file" name="filename" onchange="readURL(this);" accept=".png, .jpeg, .jpg"> 
							<img id="preview"/>  <!--  style="max-width:300; max-height:300;" -->
					</div>
				</div>

				<div class="col-10 mb-3 row">
					<div class="col-sm-offset-2 col-sm-10 ">
					 <input type="button" class="btn btn-primary " value="등록" onclick="checkForm();">				
					<input type="reset" class="btn btn-primary " value="취소 ">
					</div>
				</div>
			</form>
		</div> 
	</div>
<%@ include file="/footer.jsp"%>
</body>
</html>