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
	
	String writer = ((String) request.getAttribute("user_id"));	//글쓴이
%>
<html>
<head> 
<title>QnA</title>
</head>
<body>
	<%@ include file="/top.jsp" %> 
	<%@ include file="/dbconnection.jsp" %> 

	<div class="container-fluid col-10" style="min-height:700px;">
		
		<div class="p-5 mb-4 bg-body-tertiary rounded-3">
	      <div class="container-fluid py-5">
	        <h1 class="display-5 fw-bold">Q n A</h1>  
				<span class="badge badge-pill badge-secondary" name="qna_no" id="qna_no" style="float:left;">No. <%=qna.getQna_no()%></span><%-- 
				<input name="qna_no" id="qna_no" style="float:left;" value="<%=qna.getQna_no()%>" size=1>  --%>
	      </div>
	    </div>
	
	
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
				
				
		<sql:query var="resultSet" dataSource="${conn}"> 
		   SELECT * FROM user WHERE user_id = ?
		<sql:param value="${sessionId}" />
		</sql:query>
		<c:forEach var="row" items="${resultSet.rows}">
	
				
				<div class="mb-3 row">
					<div class="col-sm-offset-2 col-sm-9 ">
						<c:set var="userId" value="<%=qna.getUser_id()%>" /> 
						<!-- 로그인한 사람이 관리자일 때, 수정 삭제 버튼 표시하기 -->
						<c:if test="${row.grade == 10}">
							<p></p>
								<a	href="./QnaDeleteAction.qdo?num=<%=qna.getQna_no()%>&pageNum=<%=nowpage%>"	class="btn btn-danger"> 삭제</a> 
								<input type="submit" class="btn btn-success" value="수정 "> <!-- 
								<a href="/comment/comment_insert.jsp">댓글 달기</a> -->
						</c:if>
						
						<a href="./QnaListAction.qdo?pageNum=<%=nowpage%>"	style="float:right;"	class="btn btn-dark"> 목록</a>
					</div>
				</div>
			</form> 
		</div>  
		 
		<div class="container input-group"> 
		 <form action="/comment/comment_insert_process.jsp" method="post"> 	<!-- 댓글 작성 form -->
			<table class="table table-sm table-bordered  "> 
				<tr>    
					<td><input type="text" class="input-group-text"  size=1 value="No" readonly></td>
					<td><input type="text" class="input-group-text"  id="qna_no" name="qna_no" size=5 value="<c:out value='<%=qna_no%>'/>" readonly></td>
					<td><input type="text" class="input-group-text"  id="user_id" name="user_id" size=5 value=" ${row.user_id }" readonly></td>
					<td><input type="text" class="input-group-text"  id="cm_content" name="cm_content" size=55 required></td> 
					<td>
						<input type="submit" class="btn btn-outline-secondary" value="등록" > 
						<input type="reset" class="btn btn-outline-secondary" value="취소">
					</td> 
				</tr> 
			</table>
		 </form>
		</c:forEach>
		</div>
		 
		<%-- 
		</c:if> 	 --%>
		
		
		
		<!-- comment table 답변글 보여주기 -->  
		<%@ include file="/comment/comment.jsp" %>
		
		
		
		
	</div>
<%@ include file="/footer.jsp"%>
</body>
</html>


