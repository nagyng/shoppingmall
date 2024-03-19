<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="mvc.model.QnaDTO"%>
<%@ include file="/header.jsp" %>

<%
	QnaDTO qna = (QnaDTO) request.getAttribute("qna");
	int qna_no = ((Integer) request.getAttribute("qna_no")).intValue();
	int nowpage = ((Integer) request.getAttribute("page")).intValue();
	System.out.println("qna_no" + qna_no);
	System.out.println("nowpage" + nowpage);
%>
<html>
<head> 
<title>QnA</title>
</head>
<body>
	<%@ include file="/top.jsp" %> 
	<%@ include file="/dbconnection.jsp" %> 

	<div class="container-fluid col-10">
		
		<div class="p-5 mb-4 bg-body-tertiary rounded-3">
	      <div class="container-fluid py-5">
	        <h1 class="display-5 fw-bold">Q n A</h1> 
	      </div>
	    </div>
	
	
		<sql:query var="resultSet" dataSource="${conn}"> 
		   SELECT * FROM user WHERE user_id = ?
		<sql:param value="${sessionId}" />
		</sql:query>
		<c:forEach var="row" items="${resultSet.rows}">
	
			<div class=" text-center">	 
			<form name="newUpdate" action="QnaUpdateAction.qdo?qna_no=<%=qna.getQna_no()%>&pageNum=<%=nowpage%>"  method="post">
					<div class="mb-3 row">
					<label class="col-sm-2 control-label" >아이디</label>
					<div class="col-sm-3">
						<input name="user_id" class="form-control"	value=" <%=qna.getUser_id()%>" readonly>
					</div>
				</div>
					<div class="mb-3 row">
					<label class="col-sm-2 control-label" >제목</label>
					<div class="col-sm-5">
						<input name="qna_title" class="form-control"	value=" <%=qna.getQna_title()%>" >
					</div>
				</div>
				<div class="mb-3 row">
					<label class="col-sm-2 control-label" >내용</label>
					<div class="col-sm-8" style="word-break: break-all;">
						<textarea name="qna_content" class="form-control" cols="50" rows="5"> <%=qna.getQna_content()%></textarea>
					</div>
				</div>
					<div class="mb-3 row">
					<div class="col-sm-offset-2 col-sm-10 ">
						<c:set var="userId" value="<%=qna.getUser_id()%>" /> 
						<!-- 로그인한 사람이 관리자일 때, 수정 삭제 버튼 표시하기 -->
						<c:if test="${row.grade == 10}">
							<p>
								<a	href="./BoardDeleteAction.do?num=<%=qna.getQna_no()%>&pageNum=<%=nowpage%>"	class="btn btn-danger"> 삭제</a> 
								<input type="submit" class="btn btn-success" value="수정 ">
						</c:if>
						
						<a href="./BoardListAction.do?pageNum=<%=nowpage%>"		class="btn btn-primary"> 목록</a>
					</div>
				</div>
			</form>
		</div> 
		</c:forEach>
		
		
		<!-- comment table 답변글 달기 -->
		
		
		
		
		
	</div>
<%@ include file="/footer.jsp"%>
</body>
</html>


