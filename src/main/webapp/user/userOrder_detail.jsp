<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.net.URLDecoder" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="dto.Product" %>    
<%@ page import="dao.ProductRepository" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>  
<%@ include file="/header.jsp" %>  
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
.OrderDetailDiv {
	min-height: 700px;
}
</style>
</head>
<body>
<%@ include file="/top.jsp" %>  
<%@ include file="/dbconnection.jsp" %>  
<% 
	int od_id = Integer.parseInt(request.getParameter("od_id"));
	System.out.println("od_id: " + od_id);
	
	String messege = "운송장 정보가 없습니다.";
%>

<div class="OrderDetailDiv">


	<sql:query var="resultSet2" dataSource="${conn}"> 
	   SELECT 	* 
	   FROM 	ordertb o, product p, codetb c
	   WHERE 	o.pd_no = p.pd_no
	   	AND		o.od_status = c.od_status
		AND		user_id = ?
		AND	 	o.od_id = ?
	<sql:param value="${sessionId}" />
	<sql:param value="${param.od_id}" />
	</sql:query>
	<c:forEach var="row2" items="${resultSet2.rows}">
	
	
	
		<sql:query var="resultSet" dataSource="${conn}"> 
		   SELECT 	* 
		   FROM	 	ordertb o, shipping s
		   WHERE	o.od_id = s.od_id
		   AND	 	o.od_id = ?
		<sql:param value="${param.od_id}" />
		</sql:query> 
		 
		<div class="container col-9">
			<div class="bg-body-tertiary">
				<div class="container-fluid py-5">
					<h1 class=" fw-bold text-center">운송장 정보</h1> 
				</div>
			</div>	 
			<div class="container-fluid col-10 text-center">
				<table class="table   table-bordered text-center">
					<thead class="thead-light">
					<tr>
						<th>주문번호</th>  
						<th>주문일자</th> 
						<th>배송 예정일자</th>
						<th>우편번호</th>
						<th>도로명주소</th>
						<th>상세주소</th>
					</tr>
					</thead> 
					<c:forEach var="row" items="${resultSet.rows}">  <%-- 
					<c:if test="${sessionId != row.user_id}">
						<c:out value="운송장 정보가 없습니다."></c:out>
						<c:redirect url="/user/userOrderAjax.jsp" />
					</c:if> --%>
					<tr>
						<td><c:out value='${row.od_id}'/></td> 
						<td><c:out value='${row.od_createtime}'/></td>
						<td><c:out value='${row.sh_date}'/></td>
						<td><c:out value='${row.sh_zipcode}'/></td>
						<td><c:out value='${row.sh_addr1}'/></td>
						<td><c:out value='${row.sh_addr2}'/></td>
					</tr>
					<c:if test="${null eq row.sh_date }">   
						<td colspan="6"><c:out value="<%=messege %>"></c:out></td>
					</c:if> 
					</c:forEach>
				</table>
			</div> 
		</div>
	 
	 
		<div class="container col-9"> 
			<div class="container-fluid col-10 text-center">
				<table class="table   table-bordered text-center"> 
					<thead class=" ">
					<tr>
						<th>품목</th>
						<th>품목정보</th> 
						<th>수량</th>
						<th>배송상태</th>
						<th>주문일자</th>
					</tr>
					</thead>  
					<tr>
						<td><img alt="<c:out value='${row2.pd_img}'/>" src="/fntimg/<c:out value='${row2.pd_img}'/>" style="max-width:250px; max-height:250px;"></td>
						<td><c:out value='${row2.pd_name}'/></td>
						<td><c:out value='${row2.od_qty}'/></td>
						<td style="color: red;"><c:out value='${row2.status}'/></td>
						<td><c:out value='${row2.od_createtime}'/></td>
					</tr> 
				</table>
				
				<a type="button" class="btn btn-light btn-lg" style="width:100%" href="/ReviewWriteForm.rdo?pd_no=<c:out value='${row2.pd_no}'/>">리뷰 쓰기</a>
			</div> 
		</div> 
	 
	</c:forEach>
</div>
<%@ include file="/footer.jsp" %>  
</body>
</html>