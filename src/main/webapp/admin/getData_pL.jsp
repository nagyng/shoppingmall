<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/dbconn_ajax.jsp"%>
<%@ page import="java.sql.*" %>
<%@ page import="org.json.simple.*"%>
<% 

	PreparedStatement pstmt = null;
	ResultSet rs = null; 
	 
	try { 

			pstmt = conn.prepareStatement("select 	* " + 
				" from 		product p, color cl, room rm, category ct" +
			  	" where 	p.pd_color = cl.pd_color" +
				 " and 		p.pd_room = rm.pd_room" +
				 " and 		p.pd_category = ct.pd_category" +
				" order by 	p.pd_no, p.pd_stock asc");  

		rs = pstmt.executeQuery();
		
		String result = "";

		JSONArray sendArray = new JSONArray();
	
		while (rs.next()) {

			JSONObject json = new JSONObject(); //Map컬렉션
			String pd_no = rs.getString("pd_no");
			String pd_name = rs.getString("pd_name"); 
			String category_name = rs.getString("category_name");
			String color_name = rs.getString("color_name");
			String room_name = rs.getString("room_name");
			
			String pd_size = rs.getString("pd_size");
			int pd_price = rs.getInt("pd_price");
			int pd_stock = rs.getInt("pd_stock"); 
			int pd_saleprice = rs.getInt("pd_saleprice");
			String pd_img = rs.getString("pd_img");
			
			String pd_createtime = rs.getString("pd_createtime");
			String pd_updatetime = rs.getString("pd_updatetime");
			String pd_detail = rs.getString("pd_detail");
			 
	
			json.put("pd_no", pd_no);
			json.put("pd_name", pd_name); 
			json.put("category_name", category_name); 
			json.put("color_name", color_name);
			json.put("room_name", room_name);
			json.put("pd_size", pd_size);
			json.put("pd_price", pd_price);
			json.put("pd_stock", pd_stock);
			json.put("pd_saleprice", pd_saleprice);
			json.put("pd_img", pd_img);
			json.put("pd_createtime", pd_createtime);
			json.put("pd_updatetime", pd_updatetime);
			json.put("pd_detail", pd_detail); 

			sendArray.add(json);
		}
		
		//js
		out.println(sendArray);
	}catch(SQLException e){
		out.println("SQLException:" + e.getMessage());
	}finally{
		if (conn != null) conn.close();
		if (pstmt != null) 	pstmt.close();
		if (rs != null) rs.close();
	}
%>