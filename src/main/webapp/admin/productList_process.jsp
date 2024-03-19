<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ include file="/header.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>품목 관리에서 검색</title>
<link rel="stylesheet" href="//code.jquery.com/ui/1.13.2/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
<style>/* 
form > * {
	float:left;
} */
</style>
</head>
<body>
<!-- 관리자 모드 -->
 
<%@ include file="/top.jsp" %> 

<%@ include file="/dbc_notsql.jsp" %>
	
	<div class="container-float mt-4 mb-4 p-5 text-black">
		<div class="container text-center">
			<h1>품목 상세</h1>
		</div>
	</div>
	
	<% 
	
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	String sql = null; 
	String pd_stock = "null";
	
	String searchType = request.getParameter("searchType");
	String firstDate = request.getParameter("firstDate");
	String lastDate = request.getParameter("lastDate"); 

	if(request.getParameter("firstDate") == null){
		firstDate = " ";
	}

	if(request.getParameter("lastDate") == null){
		lastDate = " ";
	}

	if(request.getParameter("searchType") == null){
		searchType = " ";
	}

	
	if(request.getParameter("pd_stock") != null){
		pd_stock = request.getParameter("pd_stock");  
	} 
	
	System.out.println("searchType: " + searchType);
	System.out.println("firstDate: " + firstDate);
	System.out.println("lastDate:  " + lastDate); 
	System.out.println("pd_stock:  " + pd_stock); 

	%>
	
	
<div style="min-height: 700px;">
	<div class="container input-group text-center">
		<input type="button" class="btn btn-secondary mb-3" value="새로운 품목 추가" onclick="location.href='insert_product.jsp'">
		<div class="input-group-prepend mb-3"> 
			<form action="productListAjax.jsp" method="post">
			<span class="input-group-text col-sm-1" id="inputGroup-sizing-default" style="margin-left:10px; float:left;">조회 기간</span> 
			<input type="text" aria-label="First date" class="form-control Date input-group-append col-sm-2" value="<%=firstDate %>" readonly style="float:left;"> 
			<input type="text" aria-label="Last date" class="form-control Date col-sm-2" value="<%=lastDate %>" readonly style="float:left;"> 
			
			<div class="" style="float:right;">
			  <select class="custom-select col-sm-5" name="searchType" id="searchType" aria-label="Example select with button addon" style="margin-left:10px;">
			    <option selected value="all" readonly><%=searchType %></option>
			    <option value="1" >수납 정리</option>
			    <option value="2" >의자</option>
			    <option value="3" >침대</option>
			    <option value="4" >주방</option>
			    <option value="5" >욕실</option>
			    <option value="6" >식물</option>
			    <option value="7" >아웃도어</option> 
			  </select> 
			    <button class="btn btn-outline-info" type="submit">검색 초기화</button> 
			</div>
			  </form>

  		</div> 
 	</div>
		
		
		
	<div class="container col-9 input-group p-5">
		<table class="table table-hover table-sm table-bordered"> <!--  table-striped -->
			<thead class="table-active">
				<tr>
					<th class="text-center">등록번호</th>
					<th class="text-center">품목명</th>
					<th class="text-center">종류</th>
					<th class="text-center">색상</th>
					<th class="text-center">위치</th>
					<th class="text-center">크기</th>
					<th class="text-center">기존가</th>
					<th class="text-center">재고 수
						<a href="/admin/productList_process.jsp?pd_stock=desc">
						<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-caret-up-square" viewBox="0 0 16 16">
						  <path d="M14 1a1 1 0 0 1 1 1v12a1 1 0 0 1-1 1H2a1 1 0 0 1-1-1V2a1 1 0 0 1 1-1zM2 0a2 2 0 0 0-2 2v12a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V2a2 2 0 0 0-2-2z"/>
						  <path d="M3.544 10.705A.5.5 0 0 0 4 11h8a.5.5 0 0 0 .374-.832l-4-4.5a.5.5 0 0 0-.748 0l-4 4.5a.5.5 0 0 0-.082.537"/>
						</svg>
						</a>
						<a href="/admin/productList_process.jsp?pd_stock=asc">
						<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-caret-down-square" viewBox="0 0 16 16">
						  <path d="M3.626 6.832A.5.5 0 0 1 4 6h8a.5.5 0 0 1 .374.832l-4 4.5a.5.5 0 0 1-.748 0z"/>
						  <path d="M0 2a2 2 0 0 1 2-2h12a2 2 0 0 1 2 2v12a2 2 0 0 1-2 2H2a2 2 0 0 1-2-2zm15 0a1 1 0 0 0-1-1H2a1 1 0 0 0-1 1v12a1 1 0 0 0 1 1h12a1 1 0 0 0 1-1z"/>
						</svg></a>
					</th>
					<th class="text-center">할인가</th>
					<th class="text-center">이미지</th>
					<th class="text-center">등록일자</th>
					<th class="text-center">수정일자</th>
					<th class="text-center" colspan="2">편집</th>
				</tr>
			</thead>
			<%
			try{ 
					if(pd_stock.equals("null")){ 				//기간 
						if (searchType.equals("all")) {
							sql = "select 	* " +
									" from 		product p, color cl, room rm, category ct" +
									" where 	p.pd_color = cl.pd_color" +
									" and 		p.pd_room = rm.pd_room" +
									" and 		p.pd_category = ct.pd_category" + 
									" and		pd_createtime between ' " + firstDate + " ' and ' " + lastDate + " '"; 
						} else {									//종류
							sql = "select 	* " +
									" from 		product p, color cl, room rm, category ct" +
									" where 	p.pd_color = cl.pd_color" +
									" and 		p.pd_room = rm.pd_room" +
									" and 		p.pd_category = ct.pd_category" + 
									" and 		p.pd_category = ' " + searchType + " '" + 
									" and		pd_createtime between ' " + firstDate + " ' and ' " + lastDate + " '"; 
						}
					
					} 
					
					if(pd_stock.equals("asc")){
						sql = "select 	* " +
								" from 		product p, color cl, room rm, category ct" +
								" where 	p.pd_color = cl.pd_color" +
								" and 		p.pd_room = rm.pd_room" +
								" and 		p.pd_category = ct.pd_category" + 
								" order by	p.pd_stock asc";  
					} else if (pd_stock.equals("desc")) {
						sql = "select 	* " +
								" from 		product p, color cl, room rm, category ct" +
								" where 	p.pd_color = cl.pd_color" +
								" and 		p.pd_room = rm.pd_room" +
								" and 		p.pd_category = ct.pd_category" + 
								" order by	p.pd_stock desc"; 
					} 


				System.out.println("sql: " + sql); 
				
				pstmt = conn.prepareStatement(sql);
				rs = pstmt.executeQuery();
				
				while(rs.next()){

					String pd_no = rs.getString("pd_no");
					String pd_name = rs.getString("pd_name");
					String category_name = rs.getString("category_name");
					String color_name = rs.getString("color_name");
					String room_name = rs.getString("room_name");
					String pd_size = rs.getString("pd_size");
					int pd_price = rs.getInt("pd_price");
					int pd_stock2 = rs.getInt("pd_stock");
					int pd_saleprice = rs.getInt("pd_saleprice");
					String pd_img = rs.getString("pd_img");
					String pd_createtime = rs.getString("pd_createtime");
					String pd_updatetime = rs.getString("pd_updatetime");
					String pd_detail = rs.getString("pd_detail"); 
					

					if(pd_updatetime == null || pd_updatetime.equals("null")){
						pd_updatetime = " ";
					}

					
						
					 
				%>
					<tr>
						<td class="text-center"><%=pd_no%></td>
						<td class="text-center"><a href="/productView.jsp?pd_no=<%=pd_no%>" style="color:blue;"><%=pd_name%></a></td>
						<td class="text-center"><%=category_name%></td>
						<td class="text-center"><%=color_name%></td>
						<td class="text-center"><%=room_name%></td>
						<td class="text-center"><%=pd_size%></td>
						<td class="text-center"><%=pd_price%></td>
						<td class="text-center" style="background-color: lightyellow;"><%=pd_stock2%></td>
						<td class="text-center"><%=pd_saleprice%></td>
						<td class="text-center"> <img alt="<%=pd_img%>" src="/fntimg/<%=pd_img%>" style="width:50px; height:50px;"> </td>
						<td class="text-center"><%=pd_createtime%></td>
						<td class="text-center"><%=pd_updatetime%></td>
						<td class="text-center">
							<input type="button" class="btn btn-warning btn-sm" value="수정" onclick="location.href='update_product.jsp?pd_no=<%=pd_no%>'">
						</td>
						<td class="text-center">
							<input type="button" class="btn btn-outline-danger btn-sm" value="삭제" onclick="location.href='delete_product.jsp?pd_no=<%=pd_no%>'">
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
				    
				    
<%@ include file="/footer.jsp"%>
</body>
</html>