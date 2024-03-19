<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/header.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>My Order List</title> 
<style type="text/css">
.myPageDiv {
	min-height: 700px;
} 
</style>
</head>
<body>
<%@ include file="/top.jsp" %>
<%  
	String firstDate = request.getParameter("firstDate");
	String lastDate = request.getParameter("lastDate");
	   
	System.out.println("firstDate: " + firstDate);
	System.out.println("lastDate:  " + lastDate);   
%> 
<div class="myPageDiv col-9 container-fluid p-5">
	<sql:query var="resultSet" dataSource="${conn}"> 
	   SELECT 	* 
	   FROM 	ordertb o, product p, codetb c
	   WHERE 	o.pd_no = p.pd_no
	   AND		o.od_status = c.od_status
	   AND		o.od_createtime between '<%=firstDate %>'  and '<%=lastDate %>'
	   AND		user_id = '${sessionId}'  
	order by	o.od_createtime desc
	</sql:query>
	
	
	<div class="bg-body-tertiary">
		<div class="container-fluid py-5">
			<h1 class=" fw-bold text-center">나의 주문내역</h1> 
		</div>
	</div>		
	
	<div class="container col-10 mb-3">
		<form action="userOrderAjax.jsp" method="post">
			<span class="input-group-text col-sm-1" id="inputGroup-sizing-default" name="searchDate"  style="margin-left:10px; float:left;">조회 기간</span> 
			<input type="text" aria-label="First date" value="<%=firstDate %>"  class="form-control Date input-group-append col-sm-2" placeholder="시작일" style="float:left;" required readonly>
			<input type="text" aria-label="Last date"  value="<%=lastDate %>"  class="form-control Date col-sm-2" placeholder="종료일" style="float:left;" required readonly> 
			<button class="btn btn-outline-info" type="submit">다시 검색</button> 
		</form>
	</div>
		 
	<div class="container-fluid col-10 text-center">
		<table class="table table-hover table-bordered text-center">
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
			</thead>
			
			<c:forEach var="row" items="${resultSet.rows}">  
			<tr>
				<td><c:out value='${row.od_id}'/></td>
				<td><c:out value='${row.pd_no}'/></td>
				<td><a href="/productView.jsp?pd_no=<c:out value='${row.pd_no}'/>" style="color:blue;"><c:out value='${row.pd_name}'/></td>
				<td><c:out value='${row.od_qty}'/></td>
				<td style="background-color: lightyellow;"><c:out value='${row.status}'/></td> 
				<td><c:out value='${row.od_createtime}'/></td>
				<td><a href="/user/userOrder_detail.jsp?od_id=<c:out value='${row.od_id}'/>" style="color:red;">운송장 정보</a></td>
			</tr>
			</c:forEach>
		</table>
	</div>
</div>
<%@ include file="/footer.jsp" %>
</body>
</html>