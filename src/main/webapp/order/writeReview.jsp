<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/header.jsp" %> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>리뷰 작성</title>
</head>
<body>
<%
int pd_no = Integer.parseInt(request.getParameter("pd_no"));
%>
<%@ include file="/top.jsp" %>
<%@ include file="/dbconnection.jsp" %>

<div style="min-height: 700px;">
	<div class="bg-body-tertiary">
		<div class="container-fluid py-5">
			<h1 class=" fw-bold text-center">리뷰 쓰기</h1> 
		</div>
	</div>
		
	<div class="col-9 text-center">
		<table class="table table-hover table-bordered text-center">
			<thead class="thead-light">
				<tr>
					<th>주문 완료 제품</th>
				</tr>
			</thead>
			
		</table>
	</div>
</div>

<%@ include file="/footer.jsp" %>
</body>
</html>