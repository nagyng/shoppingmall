<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ include file="/header.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="//code.jquery.com/ui/1.13.2/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
<style type="text/css">
	.orderListDiv {
		min-height: 700px;
	}
</style>
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
</head>
<body>
<!-- 관리자 모드 -->

	<div class="top">
		<%@ include file="/top.jsp" %>
	</div>

	<%@ include file="/dbc_notsql.jsp" %>
	
	<div class="container-float mt-4 mb-4 p-5 text-black">
		<div class="container text-center">
			<h1>주문서 현황</h1>
		</div>
	</div>
	
		<% 
	
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	String sql = null;  
	String od_id2 = "null";
	
	String searchType = request.getParameter("searchType");
	String firstDate = request.getParameter("firstDate");
	String lastDate = request.getParameter("lastDate");

	if(request.getParameter("od_id") != null){
		od_id2 = request.getParameter("od_id");  
	}

	if(request.getParameter("firstDate") == null){
		firstDate = " ";
	}

	if(request.getParameter("lastDate") == null){
		lastDate = " ";
	}

	if(request.getParameter("searchType") == null){
		searchType = " ";
	}

	
	
	System.out.println("searchType: " + searchType);
	System.out.println("firstDate: " + firstDate);
	System.out.println("lastDate:  " + lastDate);  

	%>
	
	
	<div class="orderListDiv">
	<div class="container input-group text-center p-5">  
		<div class="input-group-prepend mb-3"> 
			<form action="orderListAjax.jsp" method="post">
			<span class="input-group-text col-sm-1" id="inputGroup-sizing-default" name="searchDate"  style="margin-left:10px; float:left;">조회 기간</span> 
			<input type="text" aria-label="First date" class="form-control Date input-group-append col-sm-2" value="<%=firstDate %>" readonly style="float:left;" required>
			 
			<input type="text" aria-label="Last date" class="form-control Date col-sm-2" value="<%=lastDate %>" readonly style="float:left;" required> 
			
			<div class="col-auto" style="float:left;">
			  <select class="custom-select col-sm-5" name="searchType" id="searchType" aria-label="Example select with button addon" style="margin-left:10px;" readonly>
			    <option selected value="all" readonly>단계: <%=searchType %></option>
			    <option value="0" >주문 완료</option>
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
			    <button class="btn btn-outline-info" type="submit">검색 초기화</button> 
			</div>
			  </form>
<!-- 
			  <div class="col-auto" style="float:left;" >
			    <button class="btn btn-outline-info" type="button"  style="margin-left:10px;" onclick="location.href='orderList_odIdGroup.jsp'">주문일자 별로 보기</button>
			    <button class="btn btn-outline-info" type="button"  style="margin-left:10px;" onclick="location.href='orderList.jsp'">주문번호 별로 보기</button>
			  </div>  -->
  		</div> 
 </div>

			
 
		
		
	<div class="container col-9 input-group">
		
		<table class="table table-hover table-sm table-bordered"> <!--  table-striped -->
			<thead class="table-active">
				<tr> 
					<th class="text-center">주문번호
						<a href="/admin/orderList_process.jsp?od_id=desc">
						<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-caret-up-square" viewBox="0 0 16 16">
						  <path d="M14 1a1 1 0 0 1 1 1v12a1 1 0 0 1-1 1H2a1 1 0 0 1-1-1V2a1 1 0 0 1 1-1zM2 0a2 2 0 0 0-2 2v12a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V2a2 2 0 0 0-2-2z"/>
						  <path d="M3.544 10.705A.5.5 0 0 0 4 11h8a.5.5 0 0 0 .374-.832l-4-4.5a.5.5 0 0 0-.748 0l-4 4.5a.5.5 0 0 0-.082.537"/>
						</svg>
						</a>
						<a href="/admin/orderList_process.jsp?od_id=asc">
						<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-caret-down-square" viewBox="0 0 16 16">
						  <path d="M3.626 6.832A.5.5 0 0 1 4 6h8a.5.5 0 0 1 .374.832l-4 4.5a.5.5 0 0 1-.748 0z"/>
						  <path d="M0 2a2 2 0 0 1 2-2h12a2 2 0 0 1 2 2v12a2 2 0 0 1-2 2H2a2 2 0 0 1-2-2zm15 0a1 1 0 0 0-1-1H2a1 1 0 0 0-1 1v12a1 1 0 0 0 1 1h12a1 1 0 0 0 1-1z"/>
						</svg></a> </th>  
					<th class="text-center">유저 아이디</th>
					<th class="text-center">품목 번호</th>
					<th class="text-center">품목 개수</th>
					<th class="text-center">결제 금액</th> 
					<th class="text-center">배송 상태</th>
					<th class="text-center">주문일자</th> 
					<th class="text-center">수정일자</th> 
					<th class="text-center" colspan="2">편집</th>
				</tr>
			</thead>

			<% 
			
			try{ 
				
				if (od_id2.equals("null")){
					if (searchType.equals("all")) {
						sql = "select 	o.od_id as od_id," +
							" 			o.user_id as 'user_id'," +
							" 			o.pd_no as 'pd_no'," +
							" 			o.od_qty as 'od_qty'," +
							" 			o.od_price as 'od_price'," +
							" 			o.od_status as 'od_status'," +
							" 			co.status as 'status'," +
							" 			DATE_FORMAT(o.od_createtime, '%Y-%m-%d') as 'od_createtime'," + 
							" 			DATE_FORMAT(o.od_updatetime, '%Y-%m-%d') as 'od_updatetime'" + 
							" from 		ordertb o, codetb co" +
							" where		o.od_status = co.od_status" + 
							" and	 	o.od_createtime between '" + firstDate + " ' and '" + lastDate + " '" +
							" order by 	o.od_id";
					} else {
						sql = "select 	o.od_id as od_id," +
								" 			o.user_id as 'user_id'," +
								" 			o.pd_no as 'pd_no'," +
								" 			o.od_qty as 'od_qty'," +
								" 			o.od_price as 'od_price'," +
								" 			o.od_status as 'od_status'," +
								" 			co.status as 'status'," +
								" 			DATE_FORMAT(o.od_createtime, '%Y-%m-%d') as 'od_createtime'," + 
								" 			DATE_FORMAT(o.od_updatetime, '%Y-%m-%d') as 'od_updatetime'" + 
								" from 		ordertb o, codetb co" +
								" where		o.od_status = co.od_status" + 
								" and	 	o.od_createtime between '" + firstDate + " ' and '" + lastDate + " '" +
								" and		co.od_status = ' " + searchType + " '" + 
								" order by 	o.od_id";
					}
				} 
				
				if (od_id2.equals("asc")){
						sql = "select 	o.od_id as od_id," +
								" 			o.user_id as 'user_id'," +
								" 			o.pd_no as 'pd_no'," +
								" 			o.od_qty as 'od_qty'," +
								" 			o.od_price as 'od_price'," +
								" 			o.od_status as 'od_status'," +
								" 			co.status as 'status'," +
								" 			DATE_FORMAT(o.od_createtime, '%Y-%m-%d') as 'od_createtime'," + 
								" 			DATE_FORMAT(o.od_updatetime, '%Y-%m-%d') as 'od_updatetime'" + 
								" from 		ordertb o, codetb co" +
								" where		o.od_status = co.od_status" + 
								" order by	o.od_id asc";
					} else if (od_id2.equals("desc")) {
						sql = "select 	o.od_id as od_id," +
								" 			o.user_id as 'user_id'," +
								" 			o.pd_no as 'pd_no'," +
								" 			o.od_qty as 'od_qty'," +
								" 			o.od_price as 'od_price'," +
								" 			o.od_status as 'od_status'," +
								" 			co.status as 'status'," +
								" 			DATE_FORMAT(o.od_createtime, '%Y-%m-%d') as 'od_createtime'," + 
								" 			DATE_FORMAT(o.od_updatetime, '%Y-%m-%d') as 'od_updatetime'" + 
								" from 		ordertb o, codetb co" +
								" where		o.od_status = co.od_status" + 
								" order by	o.od_id desc";
					} 
				
				
				
				pstmt = conn.prepareStatement(sql);
				rs = pstmt.executeQuery();
				
				while(rs.next()){

					int od_id = rs.getInt("od_id");
					String user_id = rs.getString("user_id");
					int pd_no = rs.getInt("pd_no");
					int od_qty = rs.getInt("od_qty");
					int od_price = rs.getInt("od_price"); 
					String od_createtime = rs.getString("od_createtime");
					String od_updatetime = rs.getString("od_updatetime");
					int od_status = rs.getInt("od_status");
					String status = rs.getString("status");
				
				%>
					<tr>
						<td class="text-center"><%=od_id%></td>
						<td class="text-center"><%=user_id%></td>
						<td class="text-center"><%=pd_no%></td>
						<td class="text-center"><%=od_qty%></td>
						<td class="text-center"><%=od_price%></td> 
						<td class="text-center" style="background-color: lightyellow;"><%=status%></td>
						<td class="text-center"><%=od_createtime%></td> 
						<td class="text-center"><%=od_updatetime%></td> 
						<td class="text-center">
							<input type="button" class="btn btn-warning btn-sm" value="수정" onclick="location.href='update_order_detail.jsp?od_id=<%=od_id%>&pd_no=<%=pd_no%>'">
						</td>
						<td class="text-center">
							<input type="button" class="btn btn-outline-danger btn-sm" value="삭제" onclick="location.href='delete_order.jsp?od_id=<%=od_id%>&pd_no=<%=pd_no%>'">
						</td>
					</tr>
				<%	
					}
			
			}catch (SQLException e) {
				out.println("SQLException: " + e.getMessage());
			}finally{

				if (rs != null)
					rs.close();
				if (pstmt != null)
					pstmt.close();
				if (conn != null)
					conn.close();
			}
 
			%> 
		</table> 
	</div> 
	</div>

				   
	<div class="footer">
		<%@ include file="/footer.jsp"%>
	</div>
</body>
</html>