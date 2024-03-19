<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="mvc.model.BoardDTO"%>
<%@ page import="java.sql.*"%>
<%@ include file="/header.jsp"%>

<%
List boardList = (List) request.getAttribute("boardlist");
int total_record = ((Integer) request.getAttribute("total_record")).intValue();
int pageNum = ((Integer) request.getAttribute("pageNum")).intValue();
int total_page = ((Integer) request.getAttribute("total_page")).intValue();
%>
<html>
<head>
<title>Board</title>
<style type="text/css">
.boardListDiv {
	min-height: 700px;
}
</style>
<script type="text/javascript">/* 
function checkForm() {	
	if (${sessionId==null}) {
		alert("로그인 해주세요.");
		return false;
	}

	location.href = "./BoardWriteForm.do?id=${sessionId}"
} */
</script>

</head>
<body> 

	<%@ include file="/top.jsp" %> 
	<%@ include file="/dbconnection.jsp" %> 
	
	
	
	
	<div class="container-fluid col-9 boardListDiv">
		<div class="    bg-body-tertiary  ">
			<div class="container-fluid py-5">
				<h1 class=" fw-bold text-center">공지사항</h1> 
			</div>
		</div>
		<div class=" text-center">
			<form action="<c:url value="./BoardListAction.do"/>" method="post">
				<div class="text-end">
					<span class="badge badge-pill badge-warning">전체 <%=total_record%>건
					</span>
				</div>
				<div style="padding-top: 20px">
					<table class="table table-hover table-bordered text-center">
					  <thead class="thead-light">
						<tr>
							<th>No.</th>
							<th>제목</th>
							<th>작성일</th>
							<th>조회</th>
							<th>글쓴이</th>
						</tr>
						</thead>
				<%
					int pagePerRow = 5;

					PreparedStatement pstmt = null;
					ResultSet rs = null;

					for (int j = 0; j < boardList.size(); j++) {
						BoardDTO notice = (BoardDTO) boardList.get(j);
				%>
					<tr>
						<td><%=notice.getNum()%></td>
						<td><a
							href="./BoardViewAction.do?num=<%=notice.getNum()%>&pageNum=<%=pageNum%>"><%=notice.getSubject()%></a></td>
						<td><%=notice.getRegdate()%></td>
						<td><%=notice.getHit()%></td>
						<td><%=notice.getName()%></td>
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
							href="/BoardListAction.do?pageNum=<%=startPage - pageSize%>">이전</a>
						</li>
						<%
						}

 						for (int i = startPage; i <= endPage; i++) {
						%>

						<li class="page-item"><a class="page-link"
							href="/BoardListAction.do?pageNum=<%=i%>"><%=i%></a></li>
						<%
						} 

						//이후 페이지 처리
	
						if (endPage != lastPage) {
						%>

						<li class="page-item"><a class="page-link"
							href="/BoardListAction.do?pageNum=<%=startPage + pageSize%>">다음</a>
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
					<c:if test="${row.grade == 10}">
						<div class="py-3" align="right">
							<a href="#" onclick="checkForm(); return false;"
								class="btn btn-warning">&laquo;글쓰기</a>
						</div>
					</c:if>
				</c:forEach>
					
				<div class="mb-5">
					<select name="items" class="txt">
						<option value="subject">제목에서</option>
						<option value="content">본문에서</option>
						<option value="name">글쓴이에서</option>
					</select> <input name="text" type="text" /> <input type="submit"
						id="btnAdd" class="btn btn-secondary " value="검색 " />
				</div>

			</form>
		</div>
	</div>
<%@ include file="/footer.jsp"%>
</body>
</html>