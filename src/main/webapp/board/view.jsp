<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="mvc.model.BoardDTO"%>
<%@ include file="/header.jsp" %>

<%
	BoardDTO notice = (BoardDTO) request.getAttribute("board");
	int num = ((Integer) request.getAttribute("num")).intValue();
	int nowpage = ((Integer) request.getAttribute("page")).intValue();
%>
<html>
<head> 
<title>Board</title>
</head>
<body>
	<%@ include file="/top.jsp" %> 
	<%@ include file="/dbconnection.jsp" %> 

	<div class="container-fluid col-10" style="min-height:700px;">
		
		<div class="p-5 mb-4 bg-body-tertiary rounded-3">
	      <div class="container-fluid py-5">
	        <h1 class="display-5 fw-bold">공지사항</h1> 
	      </div>
	    </div>
	
	
	
			<div class=" text-center">	 
			<form name="newUpdate" action="BoardUpdateAction.do?num=<%=notice.getNum()%>&pageNum=<%=nowpage%>"  method="post">
					<div class="mb-3 row">
					<label class="col-sm-2 control-label" >성명</label>
					<div class="col-sm-3">
						<input name="name" class="form-control"	value=" <%=notice.getName()%>"  >
					</div>
				</div>
					<div class="mb-3 row">
					<label class="col-sm-2 control-label" >제목</label>
					<div class="col-sm-5">
						<input name="subject" class="form-control"	value=" <%=notice.getSubject()%>" >
					</div>
				</div>
				<div class="mb-3 row">
					<label class="col-sm-2 control-label" >내용</label>
					<div class="col-sm-8" style="word-break: break-all;">
						<textarea name="content" class="form-control" cols="50" rows="5"> <%=notice.getContent()%></textarea>
					</div>
				</div>
					<div class="mb-3 row">
					<div class="col-sm-offset-2 col-sm-10 ">
						<c:set var="userId" value="<%=notice.getId()%>" />
						
						
		<sql:query var="resultSet" dataSource="${conn}"> 
		   SELECT * FROM user WHERE user_id = ?
		<sql:param value="${sessionId}" />
		</sql:query>
		<c:forEach var="row" items="${resultSet.rows}">
						
						<!-- 로그인한 사람이 관리자일 때, 수정 삭제 버튼 표시하기 -->
						<c:if test="${row.grade == 10}">
							<p>
								<a	href="./BoardDeleteAction.do?num=<%=notice.getNum()%>&pageNum=<%=nowpage%>"	class="btn btn-danger"> 삭제</a> 
								<input type="submit" class="btn btn-success" value="수정 ">
						</c:if>
						
						<a href="./BoardListAction.do?pageNum=<%=nowpage%>"		class="btn btn-primary"> 목록</a>
		</c:forEach>
					</div>
				</div>
			</form>
		</div> 
	</div>
<%@ include file="/footer.jsp"%>
</body>
</html>


