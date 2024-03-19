<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
	.colorListDiv {
		min-height: 700px;
	}
	.cLCard:hover {
	background-color: whitesmoke;
	}
</style>
</head>
<body>
<%@ include file="header.jsp" %>
<%@ include file="top.jsp" %>
<%@ include file="nav.jsp" %>


	<%@ include file="dbc_notsql.jsp" %>
	
	<div class="container col-12 colorListDiv">
	
		<div class="container-fluid">
			<div class="row row-cols-1 row-cols-md-4">
			
			
	<%
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String sql = null;
			
			String color_name = request.getParameter("color_name");
			
			try{
				
				if(color_name == null){
					sql = "select * from product p, color cl, room rm, category ct" +
						  " where p.pd_color = cl.pd_color " +
								  " and p.pd_room = rm.pd_room  " +
										  " and p.pd_category = ct.pd_category" +
						  " order by pd_no ";
				} else if(color_name != null) {
					sql = "select * from product p, color cl, room rm, category ct" +
						  " where p.pd_color = cl.pd_color " +
								  " and p.pd_room = rm.pd_room " +
										  " and p.pd_category = ct.pd_category" +
								  				" and cl.color_name=?" +
						  " order by pd_no ";
					pstmt = conn.prepareStatement(sql);
					pstmt.setString(1, color_name);
					pstmt.executeQuery();

				}
				
				
				rs = pstmt.executeQuery();
				
				while(rs.next()){

					String pd_no = rs.getString("pd_no");
					String pd_name = rs.getString("pd_name");
					String category_name = rs.getString("category_name");
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
 
 			 
				<div class="col mb-3 sm-6 ">
				  <a href="productView.jsp?pd_no=<%=pd_no%>">
				    <div class="card border-light h-100 mt-5 mb-5 cLCard">
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
			
			</div>
		</div>
	</div>
	
	
	
	


<%@ include file="footer.jsp" %>
</body>
</html>