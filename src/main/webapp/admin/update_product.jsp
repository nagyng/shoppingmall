<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<%@ include file="/header.jsp" %>
<%@ include file="/dbconnection.jsp" %>
<title>품목 수정 (관리자용)</title>
<style type="text/css">
.input-group-text {
	min-width: 130px;
}
</style>
</head>
<body>
<%@ include file="/top.jsp" %>

	<div class="container col-lg-6 col-md-12 col-sm-12">
		<div class="p-5">
			<div class="container-fluid">
				<h1 class="display-5 fw-bold text-center">품목 수정 (관리자용)</h1> 
			</div>
		</div>
		
		
		<sql:query var="resultSet" dataSource="${conn}"> 
		   SELECT * FROM product WHERE pd_no = ?
		<sql:param value="${param.pd_no}" />
		</sql:query>
		<c:forEach var="row" items="${resultSet.rows}">
		
		<div class="container-fluid">
			<form name="frm" action="update_product_process.jsp" method="post" onsubmit="return frm()">
				<div class="input-group input-group-lg mb-3">
					<div class="input-group-prepend">
					  <label class="input-group-text " id="inputGroup-sizing-lg">번호</label>
					</div>
					<input value="<c:out value='${row.pd_no }'/>"  name="pd_no" id="pd_no" type="text" class="form-control " aria-label="Sizing example input" aria-describedby="inputGroup-sizing-lg" readonly>
				</div>
				<div class="input-group input-group-lg mb-3">
					<div class="input-group-prepend">
					  <label class="input-group-text " id="inputGroup-sizing-lg">품목명</label>
					</div>
					<input value="<c:out value='${row.pd_name }'/>"  name="pd_name" id="pd_name" type="text" class="form-control " aria-label="Sizing example input" aria-describedby="inputGroup-sizing-lg" placeholder="품목명">
				</div>
				<div class="input-group input-group-lg mb-3">
					<div class="input-group-prepend">
					<label class="input-group-text" id="inputGroup-sizing-lg">종류</label> 
					</div>
					<input value="<c:out value='${row.pd_category }'/>"  name="pd_category" id="pd_category" type="text" class="form-control " aria-label="Sizing example input" aria-describedby="inputGroup-sizing-lg" placeholder="종류"> 
				</div>
				<div class="input-group input-group-lg mb-3">
					<div class="input-group-prepend">
					<label class="input-group-text" id="inputGroup-sizing-lg">색상</label>
					</div>
					<input value="<c:out value='${row.pd_color }'/>"  name="pd_color" id="pd_color" type="text" class="form-control " aria-label="Sizing example input" aria-describedby="inputGroup-sizing-lg" placeholder="색상">
				</div>
				<div class="input-group input-group-lg mb-3">
					<div class="input-group-prepend">
					<label class="input-group-text" id="inputGroup-sizing-lg">공간</label>
					</div>
					<input value="<c:out value='${row.pd_room }'/>"  name="pd_room" id="pd_room" type="text" class="form-control" aria-label="Sizing example input" aria-describedby="inputGroup-sizing-lg" placeholder="공간">
				</div>
				<div class="input-group input-group-lg mb-3">
					<div class="input-group-prepend">
					  <label class="input-group-text " id="inputGroup-sizing-lg">크기</label>
					</div>
					<input value="<c:out value='${row.pd_size }'/>"  name="pd_size" id="pd_size" type="text" class="form-control " aria-label="Sizing example input" aria-describedby="inputGroup-sizing-lg" placeholder="크기(large, medium, small)">
				</div>
				<div class="input-group input-group-lg mb-3">
					<div class="input-group-prepend">
					  <label class="input-group-text " id="inputGroup-sizing-lg">재고 수</label>
					</div>
					<input value="<c:out value='${row.pd_stock }'/>"  name="pd_stock" id="pd_stock" type="text" class="form-control " aria-label="Sizing example input" aria-describedby="inputGroup-sizing-lg" placeholder="재고 수">
				</div>
				<div class="input-group input-group-lg mb-3">
					<div class="input-group-prepend">
					  <label class="input-group-text " id="inputGroup-sizing-lg">기존가</label>
					</div>
					<input value="<c:out value='${row.pd_price }'/>"  name="pd_price" id="pd_price" type="text" class="form-control " aria-label="Sizing example input" aria-describedby="inputGroup-sizing-lg" placeholder="기존가">
				</div>
				<div class="input-group input-group-lg mb-3">
					<div class="input-group-prepend">
					  <label class="input-group-text " id="inputGroup-sizing-lg">할인가</label>
					</div>
					<input value="<c:out value='${row.pd_saleprice }'/>"  name="pd_saleprice" id="pd_saleprice" type="text" class="form-control " aria-label="Sizing example input" aria-describedby="inputGroup-sizing-lg" placeholder="할인가">
				</div>
				<div class="input-group input-group-lg mb-3">
					<div class="input-group-prepend">
					  <label class="input-group-text " id="inputGroup-sizing-lg">이미지</label>
					</div>
					<input value="<c:out value='${row.pd_img }'/>"  name="pd_img" id="pd_img" type="text" class="form-control " aria-label="Sizing example input" aria-describedby="inputGroup-sizing-lg" placeholder="사진 파일명.확장자">
				</div>
				<div class="input-group input-group-lg mb-3">
					<div class="input-group-prepend">
					  <label class="input-group-text " id="inputGroup-sizing-lg">상세 설명</label>
					</div>
					<input value="<c:out value='${row.pd_detail }'/>" style="height:200px;" name="pd_detail" id="pd_detail" type="text" class="form-control" aria-label="With textarea" aria-describedby="inputGroup-sizing-lg" placeholder="상세 설명">
				</div>
				
				<div class="col-12 mb-3 row joinBtn">
					<div class="col-sm-offset-2 col-sm-10 ">
						<input type="submit" class="btn btn-primary " value="등록 " onclick="checkValue();">
						<input type="reset" class="btn btn-primary " value="취소 ">
					</div>
				</div>
			</form>
		</div>
	</c:forEach>
	</div>



<%@ include file="/footer.jsp" %>

</body>
</html>