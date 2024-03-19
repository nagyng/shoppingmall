<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="header.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css"> 
.sLCard:hover {
background-color: whitesmoke;
}
</style>
</head>
<body>

	<div class="top">
		<%@ include file="/top.jsp" %>
	</div>
	<div class="nav">
		<%@ include file="/nav.jsp" %>
	</div>
	
	<div class="container col-12 productListDiv" style="min-height:500px;">
	
		<div class="container-fluid">
			<div class="row row-cols-1 row-cols-md-4">
			
			

<%@ include file="dbc_notsql.jsp" %>
<%
	String searchText = request.getParameter("searchText");
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	String sql = "select * from product p, color cl, room rm, category ct"
				+ " where p.pd_color = cl.pd_color"
				+ " and p.pd_room = rm.pd_room"
				+ " and p.pd_category = ct.pd_category"
				+ " and p.pd_name like ?";
	pstmt = conn.prepareStatement(sql);
	pstmt.setString(1, "%"+searchText+"%");
	rs = pstmt.executeQuery();
	
	if (!rs.next()) {
		out.println("해당하는 정보가 없습니다.");
		%>  검색창에 입력한 내용은 <%=searchText %>입니다. <%
	} else {/* 
	rs.previous();
	} */
	
	 
	
	while (rs.next()) {
	
		String pd_no = rs.getString("pd_no");
		String pd_name = rs.getString("pd_name");
		String category_name = rs.getString("category_name");
		String color_name = rs.getString("color_name");
		String room_name = rs.getString("room_name");
		String pd_size = rs.getString("pd_size");
		String pd_price = rs.getString("pd_price");
		int pd_stock = rs.getInt("pd_stock");
		String pd_saleprice = rs.getString("pd_saleprice");
		String pd_img = rs.getString("pd_img");
		String pd_createtime = rs.getString("pd_createtime");
		String pd_updatetime = rs.getString("pd_updatetime");
		String pd_detail = rs.getString("pd_detail");

%>
			 
				 
				<div class="col mb-3 sm-6">
				  <a href="productView.jsp?pd_no=<%=pd_no%>">
				    <div class="card border-light h-100 mt-5 mb-5 sLCard">
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

						<%-- 
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
	
	}		//while 문 종료
	
	if(rs != null)
		rs.close();
	if(pstmt != null)
		pstmt.close();
	if(conn != null)
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