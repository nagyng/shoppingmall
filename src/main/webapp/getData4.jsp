<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="dbconn_ajax.jsp"%>
<%@ page import="java.sql.*" %>
<%@ page import="org.json.simple.*"%>

<%

	PreparedStatement pstmt = null;
	ResultSet rs = null;

	int pd_category=0, pd_room=0, min=0, max=0;
	String all = request.getParameter("all");
	String pd_size = request.getParameter("pd_size");
	String pd_price_list = request.getParameter("pd_price_list");
	String color_name = request.getParameter("color_name");
 
	if(request.getParameter("pd_category") != null){
		pd_category = Integer.parseInt(request.getParameter("pd_category")); 
	}	
	if(request.getParameter("pd_room") != null){
		pd_room 	= Integer.parseInt(request.getParameter("pd_room")); 
	}

	if(request.getParameter("min") != null){
		min 		= Integer.parseInt(request.getParameter("min")); 
	}
	if(request.getParameter("max") != null){
		max 		= Integer.parseInt(request.getParameter("max")); 
	}

	try {

		pstmt = conn.prepareStatement("select * from product p, color cl, room rm, category ct" +
				  " where p.pd_color = cl.pd_color" +
				  " and p.pd_room = rm.pd_room" +
				  " and p.pd_category = ct.pd_category" + 
				  " order by pd_no desc");

		if(pd_category != 0) {		//종류에 대한 칼럼값이 있을 때
			pstmt = conn.prepareStatement("select 		*" +
				  " from 		product p, color cl, room rm, category ct" +
				  " where 		p.pd_color = cl.pd_color" +
				  " and 		p.pd_room = rm.pd_room" +
				  " and 		p.pd_category = ct.pd_category" +
				  " and 		p.pd_category=?" +
				  " order by	pd_no desc"); 
			pstmt.setInt(1, pd_category);
		}
		
		else if(pd_room != 0) {		//공간에 대한 칼럼값이 있을 때
			pstmt = conn.prepareStatement("select * from product p, color cl, room rm, category ct" +
				  " where p.pd_color = cl.pd_color" +
				  " and p.pd_room = rm.pd_room" +
				  " and p.pd_category = ct.pd_category" +
				  " and p.pd_room=?" +
				  " order by pd_no desc");
			pstmt.setInt(1, pd_room);
		}
		
		else if(pd_size != null) {	//크기에 대한 칼럼값이 있을 때
			pstmt = conn.prepareStatement("select * from product p, color cl, room rm, category ct" +
				  " where p.pd_color = cl.pd_color" +
				  " and p.pd_room = rm.pd_room" +
				  " and p.pd_category = ct.pd_category" +
				  " and p.pd_size=?" +
				  " order by pd_no desc");
			pstmt.setString(1, pd_size);
		}
		
		else if(pd_price_list != null){
			
			if(pd_price_list.equals("high")) {	//가격 높은 순 
				pstmt = conn.prepareStatement("select * from product p, color cl, room rm, category ct" +
					  " where p.pd_color = cl.pd_color" +
					  " and p.pd_room = rm.pd_room" +
					  " and p.pd_category = ct.pd_category" +
					  " order by pd_saleprice desc");
			} else if(pd_price_list.equals("low")) {
				pstmt = conn.prepareStatement("select * from product p, color cl, room rm, category ct" +
					  " where p.pd_color = cl.pd_color" +
					  " and p.pd_room = rm.pd_room" +
					  " and p.pd_category = ct.pd_category" +
					  " order by pd_saleprice");
			}
		}

		else if(all != null){
			pstmt = conn.prepareStatement("select * from product p, color cl, room rm, category ct" +
				  " where p.pd_color = cl.pd_color" +
				  " and p.pd_room = rm.pd_room" +
				  " and p.pd_category = ct.pd_category" +
				  " order by pd_no desc");
		} 

		else if(min != 0 && max != 0){	//가격대 검색
			pstmt = conn.prepareStatement("select 	* " + 
				  " from 	product p, color cl, room rm, category ct" +
				  " where 	p.pd_color = cl.pd_color" +
				  " and 	p.pd_room = rm.pd_room" +
				  " and 	p.pd_category = ct.pd_category" +
				  " and 	p.pd_saleprice >= ?" +
				  " and 	p.pd_saleprice <= ?" +
				  " order by pd_saleprice");
			pstmt.setInt(1, min);
			pstmt.setInt(2, max); 	
		}	
  		 else if(color_name != null) {	//색상에 대한 칼럼값이 있을 때
  			pstmt = conn.prepareStatement("select *" + 
  		 		" from 		product p, color cl, room rm, category ct" +
				" where 	p.pd_color = cl.pd_color " +
				" and 		p.pd_room = rm.pd_room " +
				" and 		p.pd_category = ct.pd_category" +
				" and 		cl.color_name=?" +
				" order by 	pd_no desc");
			pstmt.setString(1, color_name);
  		 }
  		 
  		 
  		 
		rs = pstmt.executeQuery();
		
		String result = "";

		JSONArray sendArray = new JSONArray();
		while(rs.next()) {
			JSONObject json = new JSONObject(); //Map컬렉션
			int pd_no = rs.getInt("pd_no");
			String pd_name = rs.getString("pd_name");
			String category_name = rs.getString("category_name");
			color_name = rs.getString("color_name");
			String room_name = rs.getString("room_name");
			
			int pd_price = rs.getInt("pd_price");
			int pd_stock = rs.getInt("pd_stock");
			int pd_saleprice = rs.getInt("pd_saleprice");
			String pd_img = rs.getString("pd_img");
			pd_size = rs.getString("pd_size");
			
			String pd_createtime = rs.getString("pd_createtime");
			String pd_updatetime = rs.getString("pd_updatetime");
			String pd_detail = rs.getString("pd_detail");
	
			json.put("pd_no", pd_no);
			json.put("pd_name",pd_name);
			json.put("category_name", category_name);
			json.put("color_name", color_name);
			json.put("room_name", room_name);
			
			json.put("pd_price",pd_price);
			json.put("pd_stock", pd_stock);
			json.put("pd_saleprice",pd_saleprice);
			json.put("pd_img", pd_img);
			json.put("pd_size", pd_size);
			
			json.put("pd_createtime", pd_createtime);
			json.put("pd_updatetime",pd_updatetime); 
			json.put("pd_detail",pd_detail); 
		
			sendArray.add(json);
		} 
		
		out.println(sendArray); 
 
	}catch(SQLException e){
		out.println("SQLException:" + e.getMessage());
	}finally{
		if (conn != null) conn.close();
		if (pstmt != null) 	pstmt.close();
		if (rs != null) rs.close();
	}


%>


 



