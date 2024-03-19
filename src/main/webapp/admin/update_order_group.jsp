<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<%@ include file="/header.jsp" %>
<%@ include file="/dbconnection.jsp" %>
<title>관리자 주문서 수정</title>
<style type="text/css">
	.joinBtn {
		text-align: center;
	}
	.orderLabel {
		min-width: 200px;
	}
</style> 
</head>
<body>

<%@ include file="/top.jsp" %>

	<div class="container col-lg-6 col-md-12 col-sm-12">
		<div class="p-5">
			<div class="container-fluid">
				<h1 class="display-5 fw-bold text-center">주문 수정 (관리자용)</h1> 
			</div>
		</div>
		
		<sql:query var="resultSet" dataSource="${conn}"> 
			SELECT 		min(o.od_id) as 'od_id',
						max(o.user_id) as 'user_id',
						count(o.pd_no) as 'pd_no',
						sum(o.od_qty) as 'od_qty',
						sum(o.od_price) as 'od_price',
 						max(o.od_status) as 'od_status', 
						o.od_createtime as 'od_createtime',
						max(o.od_updatetime) as 'od_updatetime',
						max(co.status) as status
			FROM 		ordertb o, codetb co
			WHERE 		min(o.od_id) = ? 
            and			o.od_status = co.od_status
			group by	o.od_createtime
			order by 	o.od_createtime;
		<sql:param value="${param.od_id}" />
		</sql:query>  
				
		<div class="container-fluid">
			<form name="joinForm" action="update_order_process.jsp" method="post" onsubmit="return joinForm()"> 
		<c:forEach var="row" items="${resultSet.rows}"> 
				<div class="input-group input-group-lg mb-3">
					<div class="input-group-prepend">
					  <label class="input-group-text orderLabel" id="inputGroup-sizing-lg">주문번호</label>
					</div>
					<input readonly value="<c:out value='${row.od_id }'/>" name="od_id" id="od_id" type="text" class="form-control " aria-label="Sizing example input" aria-describedby="inputGroup-sizing-lg" placeholder="ID">
				</div> 
				<div class="input-group input-group-lg mb-3">
					<div class="input-group-prepend">
					  <label class="input-group-text  orderLabel" id="inputGroup-sizing-lg">고객 아이디</label>
					</div>
					<input readonly value="<c:out value='${row.user_id }'/>" name="user_id" id="user_id" type="text" class="form-control " aria-label="Sizing example input" aria-describedby="inputGroup-sizing-lg" placeholder="ID">
				</div> 
				<div class="input-group input-group-lg mb-3">
					<div class="input-group-prepend">
					  <label class="input-group-text  orderLabel" id="inputGroup-sizing-lg">종류별 총 개수</label>
					</div>
					<input readonly value="<c:out value='${row.pd_no}'/>" name="pd_no" id="pd_no" type="text" class="form-control " aria-label="Sizing example input" aria-describedby="inputGroup-sizing-lg" placeholder="phone">
				</div>  
				<div class="input-group input-group-lg mb-3">
					<div class="input-group-prepend">
					  <label class="input-group-text  orderLabel" id="inputGroup-sizing-lg">총 수량</label>
					</div>
					<input readonly value="<c:out value='${row.od_qty}'/>" name="od_qty" id="od_qty" type="text" class="form-control " aria-label="Sizing example input" aria-describedby="inputGroup-sizing-lg" placeholder="phone">
				</div>  
				<div class="input-group input-group-lg mb-3">
					<div class="input-group-prepend">
					  <label class="input-group-text  orderLabel" id="inputGroup-sizing-lg">총 결제 금액</label>
					</div>
					<input readonly value="<c:out value='${row.od_price}'/>" name="od_price" id="od_price" type="text" class="form-control " aria-label="Sizing example input" aria-describedby="inputGroup-sizing-lg" placeholder="phone">
				</div>  
				<div class="input-group input-group-lg mb-3">
					<div class="input-group-prepend">
					  <label class="input-group-text  orderLabel" id="inputGroup-sizing-lg">배송 상태</label>
					</div>
					<select class="custom-select col-sm-5" name="od_status" id="od_status" aria-label="Example select with button addon" >
					    <option selected value="<c:out value='${row.od_status}'/>">현재 : <c:out value='${row.status}'/></option>
					     <hr>
					    <option value="1" >결제 완료</option>
					    <option value="2" >상품준비중</option>
					    <option value="3" >배송준비중</option>
					    <option value="4" >배송 중</option>
					    <option value="5" >배송 완료</option>
					    <option value="6" >취소 완료</option>
					    <option value="7" >반품 신청</option> 
					    <option value="8" >반품 완료</option>
					    <option value="9" >환불 신청</option>
					    <option value="10" >환불 완료</option> 
					  </select> 
				</div>  
				<div class="input-group input-group-lg mb-3">
					<div class="input-group-prepend">
					  <label class="input-group-text  orderLabel" id="inputGroup-sizing-lg">주문 일자</label>
					</div>
					<input value="<c:out value='${row.od_createtime}'/>" name="od_createtime" id="od_createtime" type="text" class="form-control " aria-label="Sizing example input" aria-describedby="inputGroup-sizing-lg" readonly>
				</div>
				
	</c:forEach>
				<div class="col-12 mb-3 row joinBtn">
					<div class="col-sm-offset-2 col-sm-10 ">
						<input type="submit" class="btn btn-primary " value="수정 " onclick="checkValue();">
						<input type="reset" class="btn btn-primary " value="취소 ">
					</div>
				</div>
			</form>
		</div>
	</div>



<%@ include file="/footer.jsp" %>
</body>
</html>
