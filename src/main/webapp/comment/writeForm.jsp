<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="/header.jsp" %> 
<html>
<head> 
<title>QnA</title>
</head>
<script type="text/javascript"> 
		if (!document.newWrite.subject.value) {
			alert("제목을 입력하세요.");
			return false;
		}
		if (!document.newWrite.content.value) {
			alert("내용을 입력하세요.");
			return false;
		}		
	}
</script>
<body>
<%@ include file="/top.jsp" %> 
	<%@ include file="/dbconnection.jsp" %> 
	<div class="container-fluid col-10">
		
		 <div class="p-5 mb-4 bg-body-tertiary ">
	      <div class="container-fluid py-5">
	        <h1 class="display-5 fw-bold">문의하기</h1> 
	      </div>
	    </div>
	
		<div class=" text-center"> 
			<form name="newWrite" action="./QnaWriteAction.qdo"  method="post" onsubmit="return checkForm()">
				<input name="id" type="hidden" class="form-control" value="${sessionId}">
				<div class="col-10 mb-3 row">
					<label class="col-sm-2 control-label" >아이디</label>
					<div class="col-sm-3">
						<input name="user_id" type="text" class="form-control" value="${sessionId}" placeholder="name" readonly>
					</div>
				</div>
				<div class="col-10 mb-3 row">
					<label class="col-sm-2 control-label" >제목</label>
					<div class="col-sm-5">
	
						<input name="qna_title" type="text" class="form-control" placeholder="title" required>
					</div>
				</div>
			<div class="col-10 mb-3 row">
					<label class="col-sm-2 control-label" >내용</label>
					<div class="col-sm-8">
						<textarea name="qna_content" cols="50" rows="5" class="form-control" placeholder="content" required></textarea>
					</div>
				</div>
				<div class="col-10 mb-3 row">
					<div class="col-sm-offset-2 col-sm-10 ">
					 <input type="submit" class="btn btn-primary " value="등록 ">				
					<input type="reset" class="btn btn-primary " value="취소 ">
					</div>
				</div>
			</form>
		</div> 
	</div>
<%@ include file="/footer.jsp"%>
</body>
</html>