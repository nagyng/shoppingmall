<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="mvc.model.CommentDTO"%>
<%@ page import="java.sql.*"%>
<%@ include file="/header.jsp"%> 
<%
List commentList = (List) request.getAttribute("commentlist"); /* 
int qna_no = ((Integer) request.getAttribute("qna_no")).intValue(); */
int total_record = ((Integer) request.getAttribute("total_record")).intValue();
int pageNum = ((Integer) request.getAttribute("pageNum")).intValue();
int total_page = ((Integer) request.getAttribute("total_page")).intValue();
%>
<html>
<head>
<title>comment</title>  
</head>
<body> 
 
<%@ include file="/top.jsp"%> 
	<%@ include file="/dbconnection.jsp" %> 
	
	<div class="container-fluid col-10" style="min-height:600px;">
		<div class="bg-body-tertiary  ">
			<div class="container-fluid py-5">
				<h1 class=" fw-bold text-center">댓글</h1> 
			</div>
		</div>
		<div class=" text-center">
			<form action="<c:url value="./CommentListAction.cdo"/>" method="post">
				<div class="text-end"> 
				</div>
				<div style="padding-top: 20px">
					<table class="table table-hover table-bordered text-center">
						<tr>
							<th>No.</th>
							<th>내용</th>
							<th>작성자</th>
							<th>작성일</th> 
						</tr>
				<% 

					PreparedStatement pstmt = null;
					ResultSet rs = null;
					
					

					for (int j = 0; j < commentList.size(); j++) {
						CommentDTO comment = (CommentDTO) commentList.get(j);
				%>
					<tr>
						<td><%=comment.getCm_no()%></td>
						<td><a
							href="./CommentViewAction.cdo?cm_no=<%=comment.getCm_no()%>&pageNum=<%=pageNum%>"><%=comment.getCm_content()%></a></td>
						<td><%=comment.getUser_id()%></td>
						<td><%=comment.getCm_createtime()%></td> 
					</tr>
				<%
					}
				%>
					</table>
				</div>  
			</form>
		</div>
	</div>
<%@ include file="/footer.jsp"%>
</body>
</html>