<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/header.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>My Order List</title>
<link rel="stylesheet" href="//code.jquery.com/ui/1.13.2/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
<script>
$(document).ready(function(){
		$("#firstDate, #lastDate").datepicker({
			changeMonth:true,
			changeYear:true,
			dateFormat:"yy-mm-dd",
			prevText:"이전 달",
			nextText:"다음 달",
			monthNames:['1월','2월','3월','4월',
						'5월','6월','7월','8월',
						'9월','10월','11월','12월'
				       ],
			monthNamesShort:['1월','2월','3월','4월',
							'5월','6월','7월','8월',
							'9월','10월','11월','12월'
					       ],
			dayNames:['일','월','화','수','목','금','토'],
			dayNamesShort:['일','월','화','수','목','금','토'],
			dayNamesMin:['일','월','화','수','목','금','토'],
			showMonthAfterYear:true,
			yearSuffix:'년'
		});
	});
</script>

 

<style type="text/css">
.myPageDiv {
	min-height: 700px;
} 
</style>
</head>
<body>
<%@ include file="/top.jsp" %> 
<div class="myPageDiv col-9 container-fluid p-5">
	<sql:query var="resultSet" dataSource="${conn}"> 
	   SELECT 	* 
	   FROM 	ordertb o, product p, codetb c
	   WHERE 	o.pd_no = p.pd_no
	   	AND		o.od_status = c.od_status
		AND		user_id = ?
	order by	o.od_createtime asc
	<sql:param value="${sessionId}" />
	</sql:query>
	
	
	<div class="bg-body-tertiary">
		<div class="container-fluid py-5">
			<h1 class=" fw-bold text-center">나의 주문내역</h1> 
		</div>
	</div>		
	
	<div class="container col-10 mb-3">
		<form action="userOrder_process.jsp" method="post">
			<span class="input-group-text col-sm-1" id="inputGroup-sizing-default" name="searchDate"  style="margin-left:10px; float:left;">조회 기간</span> 
			<input type="text" aria-label="First date" id="firstDate" name="firstDate"  class="form-control Date input-group-append col-sm-2" placeholder="시작일" style="float:left;" required>
			<input type="text" aria-label="Last date" id="lastDate" name="lastDate"  class="form-control Date col-sm-2" placeholder="종료일" style="float:left;" required> 
			<button class="btn btn-outline-info" type="submit">최신순 검색</button> 
		</form>
	</div>
		 
	<div class="container-fluid col-10 text-center">
		<table class="table table-hover table-bordered text-center" id="tbFile" >
			<thead class="thead-light">
			<tr>
				<th>주문번호</th>
				<th>품목번호</th>
				<th>품목정보</th>
				<th>수량</th>
				<th>배송상태</th>
				<th>주문일자</th>
				<th>자세히</th>
			</tr>
			<% 
			int pagePerRow = 5;
			%>
			</thead> 
			<c:forEach var="row" items="${resultSet.rows}">  
			<tr id="list-body" id="page-content twbsPagination">
				<td><c:out value='${row.od_id}'/></td>
				<td><c:out value='${row.pd_no}'/></td>
				<td><a href="/productView.jsp?pd_no=<c:out value='${row.pd_no}'/>" style="color:blue;"><c:out value='${row.pd_name}'/></a></td>
				<td><c:out value='${row.od_qty}'/></td>
				<td style="background-color: lightyellow;"><c:out value='${row.status}'/></td> 
				<td><c:out value='${row.od_createtime}'/></td>
				<td><a href="/user/userOrder_detail.jsp?od_id=<c:out value='${row.od_id}'/>" style="color:red;">운송장 정보</a></td>
			</tr>
			</c:forEach>
		</table> 
				<%

				int total_record = 100;
				int pageNum = 1;
				int pageSize = 5;
				int total_page = total_record / pagePerRow;
				int lastPage = total_record / pagePerRow; //마지막 페이지

				//총페이지 수 계산
				if (total_record % pagePerRow != 0) {
					lastPage++;
				}

				int startPage = ((pageNum - 1) / pageSize) * pageSize + 1;
				int endPage = startPage + pageSize - 1;

				if (endPage > lastPage) {
					endPage = lastPage;
				}
				%>
			
			<nav aria-label="..." class="Page navigation container-fluid ">
			  <ul class="pagination pagination-lg justify-content-center" id="twbsPagination pageScope"> 
						<%
						if (startPage > 1) {
						%>
			    <li class="page-item"><a class="page-link" href="/userOrder.jsp?pageNum=<%=startPage - pageSize%>">이전</a></li>
						<%
						} 
 						for (int i = startPage; i <= endPage; i++) {
						%> 
			    <li class="page-item" ><a class="page-link" href="/userOrder.jsp?pageNum=<%=i%>"><%=i%></a></li>
						<%
						}  
						//이후 페이지 처리 
						if (endPage != lastPage) {
						%> 
			    <li class="page-item" ><a class="page-link" href="/userOrder.jsp?pageNum=<%=startPage + pageSize%>">다음</a></li> 
						<%
						}
						%>
			  </ul>
			</nav>
	</div>
</div>
<%@ include file="/footer.jsp" %>
</body>
</html>