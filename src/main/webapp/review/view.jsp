<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="org.apache.commons.fileupload.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="mvc.model.ReviewDTO"%>
<%@ include file="/header.jsp" %>

<%
	ReviewDTO review = (ReviewDTO) request.getAttribute("review");
	int rv_no = ((Integer) request.getAttribute("rv_no")).intValue();
	int nowpage = ((Integer) request.getAttribute("page")).intValue(); 
	System.out.println("rv_no" + rv_no);
	System.out.println("nowpage" + nowpage); 
	int rating = 10;
	if(request.getAttribute("rating") != null){
		rating = ((Integer) request.getAttribute("rating")).intValue(); 
	} 
	System.out.println("rating" + rating); 
%>
<html>
<head> 
<title>리뷰글 상세화면</title>
<style type="text/css">
	#preview {
		max-width: 300px;
		max-height: 300px;
	}  
	
	.control-label {
		min-width: 300px;
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
	
	
</style>
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
</head>
<body>
	<%@ include file="/top.jsp" %> 
	<%@ include file="/dbconnection.jsp" %> 

	<div class="container-fluid col-10" style="min-height:600px;">
		
		<div class="p-5 mb-4 bg-body-tertiary rounded-3">
	      <div class="container-fluid py-5">
	        <h1 class="display-5 fw-bold">리뷰</h1> 
	      </div>
	    </div>
	
			<div class=" text-center">	 
			<form name="newUpdate" action="ReviewUpdateAction.rdo?rv_no=<%=review.getRv_no()%>&pageNum=<%=nowpage%>"  method="post">
				<div class="mb-3 row">
					<label class="col-sm-2 control-label" >아이디</label>
					<div class="col-sm-3">
						<input name="user_id" class="form-control"	value=" <%=review.getUser_id()%>" readonly>
					</div>
				</div>
				<div class="mb-3 row">
					<label class="col-sm-2 control-label" >품목 번호</label>
					<div class="col-sm-3">
						<input name="pd_no" type="text" class="form-control" name="pd_no" value=" <%=review.getPd_no()%>" readonly>
					</div>
				</div>
				 
				<div class="mb-3 row rating"> 
					<label class="col-sm-2 control-label">별점</label>
					<div class="">
					<fieldset class="rate p-3"> 5 
						<input type="radio" id="rating5" name="rating" value="5" checked><label for="rating10" title="5점"></label>  
						<input type="radio" id="rating4" name="rating" value="4"><label for="rating8" title="4점"></label> 
						<input type="radio" id="rating3" name="rating" value="3"><label for="rating6" title="3점"></label> 
						<input type="radio" id="rating2" name="rating" value="2"><label for="rating4" title="2점"></label> 
						<input type="radio" id="rating1" name="rating" value="1"><label for="rating2" title="1점"></label> 1
					</fieldset> 
					</div>
				</div> 
				 
				<div class="mb-3 row">
					<label class="col-sm-2 control-label" >제목</label>
					<div class="col-sm-5">
						<input name="rv_title" class="form-control"	value=" <%=review.getRv_title()%>" >
					</div>
				</div>
				<div class="mb-3 row">
					<label class="col-sm-2 control-label" >내용</label>
					<div class="col-sm-8" style="word-break: break-all;">
						<textarea name="rv_content" class="form-control" cols="50" rows="5"> <%=review.getRv_content()%></textarea>
					</div>
				</div>
				    
				<div class="mb-3 row">
					<label class="col-sm-2 control-label" >사진</label>
					<div class="col-sm-2" style="word-break: break-all; "> 
					 <img alt="" src="/review_upload_img/<%=review.getRv_img()%>" width="300" height="300" 
					 		onerror="this.onerror=null; this.src='/fntimg/no-image.png';"> 
					</div>
				</div> 

	
		<sql:query var="resultSet" dataSource="${conn}"> 
		   SELECT * FROM user WHERE user_id = ?
		<sql:param value="${sessionId}" />
		</sql:query>
		<c:forEach var="row" items="${resultSet.rows}">
					 
				<div class="mb-3 container text-center">
					<div class="col-sm-offset-2 col-sm-10 container text-center mb-5">
						<c:set var="userId" value="<%=review.getUser_id()%>" /> 
						
						<!-- 로그인한 사람이 관리자일 때, 수정 삭제 버튼 표시하기 --> 
						<c:if test="${row.grade == 10 || userId == sessionId}"> 
							<p>
								<a	href="./ReviewDeleteAction.rdo?rv_no=<%=review.getRv_no()%>&pageNum=<%=nowpage%>"	class="btn btn-danger"> 삭제</a> 
								<input type="submit" class="btn btn-success" value="수정 "> 
						</c:if> 
						<a href="./ReviewListAction.rdo?pageNum=<%=nowpage%>" class="btn btn-primary"> 목록</a>
					</div>
				</div>
		</c:forEach>
			</form>
		</div> 
	</div>
	
<%
/* 
		}
	}
	 */
%>
<%@ include file="/footer.jsp"%>
</body>
</html>


