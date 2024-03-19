<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="mvc.model.ReviewDTO"%>
<%@ page import="java.sql.*"%>
<%@ include file="/header.jsp"%>

<%
List reviewList = (List) request.getAttribute("reviewlist");
int total_record = ((Integer) request.getAttribute("total_record")).intValue();
int pageNum = ((Integer) request.getAttribute("pageNum")).intValue();
int total_page = ((Integer) request.getAttribute("total_page")).intValue();
%>
<html>
<head>
<title>리뷰 보기</title> 
<script type="text/javascript">
function checkForm() {	 
	location.href = "/ReviewWriteForm.rdo?user_id=${sessionId}"
}
</script> 
</head>
<body> 

	<%@ include file="/top.jsp" %> 
	<%@ include file="/dbconnection.jsp" %> 
	
	<div class="container-fluid col-9" style="min-height:700px;">
		<div class="    bg-body-tertiary  ">
			<div class="container-fluid py-5">
				<h1 class=" fw-bold text-center">리뷰 게시판</h1> 
			</div>
		</div>
		<div class=" text-center">
			<form action="<c:url value="./ReviewListAction.rdo"/>" method="post">
				<div class="text-end">
					<span class="badge badge-pill badge-warning">전체 <%=total_record%>건
					</span>
				</div>
				<div style="padding-top: 20px">
					<table class="table table-hover table-bordered text-center">
  					<thead class="thead-light">
						<tr>
							<th>No.</th>
							<th>만족도</th> 
							<th>품목</th> 
							<th>제목</th>
							<th>작성일</th>
							<th>조회</th>
							<th>작성자</th>
						</tr>
					</thead>
				<%
					int pagePerRow = 5;

					PreparedStatement pstmt = null;
					ResultSet rs = null;

					for (int j = 0; j < reviewList.size(); j++) {
						ReviewDTO review = (ReviewDTO) reviewList.get(j);
						int rating = review.getRating();  
				%>
					<tr>
						<td><%=review.getRv_no()%></td>
						<td><%
							for(int r = 0; r < rating; r++ ) {
							%> 
							<svg style="color:gold;" xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-star-fill" viewBox="0 0 16 16">
							  <path d="M3.612 15.443c-.386.198-.824-.149-.746-.592l.83-4.73L.173 6.765c-.329-.314-.158-.888.283-.95l4.898-.696L7.538.792c.197-.39.73-.39.927 0l2.184 4.327 4.898.696c.441.062.612.636.282.95l-3.522 3.356.83 4.73c.078.443-.36.79-.746.592L8 13.187l-4.389 2.256z"/>
							</svg>
							 <%
								}
							%> 
						</td>
						<td><%=review.getPd_no()%></td> 
						<td><a
							href="./ReviewViewAction.rdo?rv_no=<%=review.getRv_no()%>&pageNum=<%=pageNum%>"><%=review.getRv_title()%></a></td>
						<td><%=review.getRv_createtime()%></td>
						<td><%=review.getHit()%></td>
						<td><%=review.getUser_id()%></td>
					</tr>
				<%
					}
				%>
					</table>
				</div>
				<%
				int lastPage = total_record / pagePerRow; //마지막 페이지

				//총페이지 수 계산
				if (total_record % pagePerRow != 0) {
					lastPage++;
				}

				int pageSize = 5;
				int startPage = ((pageNum - 1) / pageSize) * pageSize + 1;
				int endPage = startPage + pageSize - 1;

				if (endPage > lastPage) {
					endPage = lastPage;
				}
				%>
				<div class="pageScope">
					<ul class="pagination justify-content-center">
						<%
						if (startPage > 1) {
						%>
						<li class="page-item"><a class="page-link"
							href="/ReviewListAction.rdo?pageNum=<%=startPage - pageSize%>">이전</a>
						</li>
						<%
						}

 						for (int i = startPage; i <= endPage; i++) {
						%>

						<li class="page-item"><a class="page-link"
							href="/ReviewListAction.rdo?pageNum=<%=i%>"><%=i%></a></li>
						<%
						} 

						//이후 페이지 처리 
						if (endPage != lastPage) {
						%>

						<li class="page-item"><a class="page-link"
							href="/ReviewListAction.rdo?pageNum=<%=startPage + pageSize%>">다음</a>
						</li>
						<%
						}
						%>
					</ul>
				</div>
				
				<sql:query var="resultSet" dataSource="${conn}"> 
				   SELECT * FROM user WHERE user_id = ?
				<sql:param value="${sessionId}" />
				</sql:query>
				<c:forEach var="row" items="${resultSet.rows}">
					<c:if test="${sessionId != null}">
						<div class="py-3" align="right">
							<a href="#" onclick="checkForm(); return false;"
								class="btn btn-warning">&laquo;글쓰기</a>
						</div>
					</c:if>
				</c:forEach>
					
				<div class="mb-5">
					<select name="items" class="txt">
						<option value="rv_title">제목에서</option>
						<option value="rv_content">본문에서</option>
						<option value="user_id">글쓴이에서</option>
					</select> <input name="text" type="text" /> <input type="submit" id="btnAdd" class="btn btn-secondary " value="검색 " />
				</div>

			</form>
		</div>
	</div>
<%@ include file="/footer.jsp"%>
</body>
</html>