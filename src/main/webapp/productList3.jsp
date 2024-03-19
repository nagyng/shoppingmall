<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ include file="header.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>품목 리스트</title>
<style type="text/css"> 
.pLCard:hover {
background-color: whitesmoke;
}
.productListDiv {
min-height:700px;
}
</style>
</head>
<body>
<!-- 인덱스 --> 

	<div class="top">
		<%@ include file="/top.jsp" %>
	</div>
	<div class="nav">
		<%@ include file="/nav.jsp" %>
	</div>
		
	<%@ include file="dbc_notsql.jsp" %>
	
	<div class="container col-12 productListDiv mb-5">
	
		<div class="container-fluid">
			<div class="row row-cols-1 row-cols-md-4">
			
			
	<%
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String sql = null;
			int pd_category=0, pd_room=0;
			int min=0, max=0;
			String all = request.getParameter("all");
			String pd_size = request.getParameter("pd_size");
			String pd_price_list = request.getParameter("pd_price_list"); 
			int limitStart = 0, limitEnd = 8;

			if(request.getParameter("pd_category") != null){
				pd_category = Integer.parseInt(request.getParameter("pd_category"));
				//System.out.println(pd_category);		//콘솔창에 값을 출력해 확인하기 
			}	
			
			if(request.getParameter("pd_room") != null){
				pd_room 	= Integer.parseInt(request.getParameter("pd_room"));
				//System.out.println(pd_room);
			}

			if(request.getParameter("min") != null){
				min 		= Integer.parseInt(request.getParameter("min"));
				System.out.println("최소: " + min);
			}
			
			if(request.getParameter("max") != null){
				max 		= Integer.parseInt(request.getParameter("max"));
				System.out.println("최대: " + max);
			}
			
			%>
			
			<% 
			
			try{
					if(pd_category != 0) {		//종류에 대한 칼럼값이 있을 때
						sql = "select * from product p, color cl, room rm, category ct" +
							  " where p.pd_color = cl.pd_color" +
							  " and p.pd_room = rm.pd_room" +
							  " and p.pd_category = ct.pd_category" +
							  " and p.pd_category=?" +
							  " order by pd_no" + 
							  " LIMIT	?, ?";
						pstmt = conn.prepareStatement(sql);
						pstmt.setInt(1, pd_category);
						pstmt.setInt(2, limitStart);
						pstmt.setInt(3, limitEnd); 	
					}
					
					else if(pd_room != 0) {		//공간에 대한 칼럼값이 있을 때
						sql = "select * from product p, color cl, room rm, category ct" +
							  " where p.pd_color = cl.pd_color" +
							  " and p.pd_room = rm.pd_room" +
							  " and p.pd_category = ct.pd_category" +
							  " and p.pd_room=?" +
							  " order by pd_no" + 
							  " LIMIT	?, ?";
						pstmt = conn.prepareStatement(sql);
						pstmt.setInt(1, pd_room);
						pstmt.setInt(2, limitStart);
						pstmt.setInt(3, limitEnd); 	
					}
					
					else if(pd_size != null) {	//크기에 대한 칼럼값이 있을 때
						sql = "select * from product p, color cl, room rm, category ct" +
							  " where p.pd_color = cl.pd_color" +
							  " and p.pd_room = rm.pd_room" +
							  " and p.pd_category = ct.pd_category" +
							  " and p.pd_size=?" +
							  " order by pd_no" + 
							  " LIMIT	?, ?";
						pstmt = conn.prepareStatement(sql);
						pstmt.setString(1, pd_size);
						pstmt.setInt(2, limitStart);
						pstmt.setInt(3, limitEnd); 	
					}
					
					else if(pd_price_list != null){
						
						if(pd_price_list.equals("high")) {
							sql = "select * from product p, color cl, room rm, category ct" +
								  " where p.pd_color = cl.pd_color" +
								  " and p.pd_room = rm.pd_room" +
								  " and p.pd_category = ct.pd_category" +
								  " order by pd_saleprice desc" + 
								  " LIMIT	?, ?";
								pstmt = conn.prepareStatement(sql);
								pstmt.setInt(1, limitStart);
								pstmt.setInt(2, limitEnd); 	
						} else if(pd_price_list.equals("low")) {
							sql = "select * from product p, color cl, room rm, category ct" +
								  " where p.pd_color = cl.pd_color" +
								  " and p.pd_room = rm.pd_room" +
								  " and p.pd_category = ct.pd_category" +
								  " order by pd_saleprice" + 
								  " LIMIT	?, ?";
								pstmt = conn.prepareStatement(sql);
								pstmt.setInt(1, limitStart);
								pstmt.setInt(2, limitEnd); 	
						}
					}

					else if(min != 0 && max != 0){
						sql = "select 	* " + 
							  " from 	product p, color cl, room rm, category ct" +
							  " where 	p.pd_color = cl.pd_color" +
							  " and 	p.pd_room = rm.pd_room" +
							  " and 	p.pd_category = ct.pd_category" +
							  " and 	p.pd_saleprice >= ?" +
							  " and 	p.pd_saleprice <= ?" +
							  " order by pd_saleprice" + 
							  " LIMIT	?, ?";
						pstmt = conn.prepareStatement(sql);
						pstmt.setInt(1, min);
						pstmt.setInt(2, max); 	
						pstmt.setInt(3, limitStart);
						pstmt.setInt(4, limitEnd); 
					}	
					else {
						sql = "select * from product p, color cl, room rm, category ct" +
							  " where p.pd_color = cl.pd_color" +
							  " and p.pd_room = rm.pd_room" +
							  " and p.pd_category = ct.pd_category" +
							  " order by pd_no" + 
							  " LIMIT	?, ?";
						pstmt = conn.prepareStatement(sql);
						pstmt.setInt(1, limitStart);
						pstmt.setInt(2, limitEnd); 	
					} 

					
			
				rs = pstmt.executeQuery();
				
				while(rs.next()){
					String pd_no = rs.getString("pd_no");
					String pd_name = rs.getString("pd_name");
					String category_name = rs.getString("category_name");
					String color_name = rs.getString("color_name");
					String room_name = rs.getString("room_name");
					String pd_price = rs.getString("pd_price");
					int pd_stock = rs.getInt("pd_stock");
					String pd_saleprice = rs.getString("pd_saleprice");
					String pd_img = rs.getString("pd_img");
					pd_size = rs.getString("pd_size");
					String pd_createtime = rs.getString("pd_createtime");
					String pd_updatetime = rs.getString("pd_updatetime");
					String pd_detail = rs.getString("pd_detail");
				%>
				
				<div class="col mb-3 sm-6">
				  <a href="productView.jsp?pd_no=<%=pd_no%>">
				    <div class="card border-light h-100 mt-5 mb-5 pLCard">
				      <img src="/fntimg/<%=pd_img%>" class="card-img-top mt-5" alt="<%=pd_img%>" style="width: 300px; height: 300px; margin:auto;">
				      <div class="card-body">
				        <h5 class="card-title pd-title"><%=pd_name%></h5>
				        <p class="card-text"><%=category_name%> | <%=room_name%> | <%=pd_size%></p>
						<span class="pdPrice" style="font-size: 20px; color:darkgrey; text-decoration-line: line-through;">
							<fmt:formatNumber value='<%=pd_price%>' pattern="#,##0"/>원 
						</span>
						<span class="pdSalePrice" style="font-size: 30px; font-weight:bold; color:gold;"> 
							<fmt:formatNumber value='<%=pd_saleprice%>' pattern="#,##0"/>원 
						</span>
						
						<% 
						if(pd_stock == 0){ 
						%>
						<span class="badge badge-danger" style="">  품절 </span>
						<%
						} 
						%>

						<%-- 새상품 뱃지 
						<% 
						if(pd_createtime ){ 
						%>
						<span class="badge" style="background-image: linear-gradient(to right, red, orange, yellow, green, blue, indigo, purple); "> New! </span>
						<%
						} 
						%> --%>
				      </div>
				    </div>
				  </a>
				 </div>

				<%	
				}	//while문 종료 
			%>
			
			<script src="http://code.jquery.com/jquery-latest.min.js"></script>
			<script type="text/javascript">   
				function limit(){
					<%
					limitStart = limitStart + 8;
					limitEnd = limitEnd + 8;
					%>
				} 
			</script>
			
			<button type="button" class="btn btn-primary m-5 p-5" onclick="limit();">더 보기</button>
			
			
			<%
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
			
			</div>
		</div>
	</div>
	
	
	
	
	
				   
	<div class="footer">
		<%@ include file="/footer.jsp"%>
	</div>

</body>
</html>