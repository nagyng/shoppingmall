<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/dbconn_ajax.jsp"%>
<%@ page import="java.sql.*" %>
<%@ page import="org.json.simple.*"%>

<%

	String user_id = (String) session.getAttribute("sessionId");
	PreparedStatement pstmt = null;
	ResultSet rs = null;

	try {

		pstmt = conn.prepareStatement(" select * " +
				" FROM 		ordertb o, product p, codetb c, shipping s, category ct, color cl, room r" + 
				" WHERE 	o.pd_no = p.pd_no" + 
				" AND		o.od_status = c.od_status" +  
				" AND 		o.od_id = s.od_id" +
				" AND 		o.user_id = s.user_id" +
				" AND		p.pd_category = ct.pd_category" +
				" AND		p.pd_color = cl.pd_color" +
				" AND		p.pd_room = r.pd_room" +
				" AND		o.user_id = ?" + 
				" order by	o.od_createtime asc");   
		pstmt.setString(1, user_id);
		 

		rs = pstmt.executeQuery();
		
		String result = "";

		JSONArray sendArray = new JSONArray();
		while(rs.next()) {
			JSONObject json = new JSONObject(); //Map컬렉션
			int od_id = rs.getInt("od_id");
			int pd_no = rs.getInt("pd_no");
			String pd_name = rs.getString("pd_name");
			int od_qty = rs.getInt("od_qty");
			int od_price = rs.getInt("od_price");
			
			String status = rs.getString("status"); 
			String od_createtime = rs.getString("od_createtime"); 
			String pd_img = rs.getString("pd_img");
			String sh_date = rs.getString("sh_date");
			String sh_zipcode = rs.getString("sh_zipcode");
			
			String sh_addr1 = rs.getString("sh_addr1");
			String sh_addr2 = rs.getString("sh_addr2");
			
			String category_name = rs.getString("category_name");
			String color_name = rs.getString("color_name"); 
			String room_name = rs.getString("room_name");
	
			json.put("od_id", od_id);
			json.put("pd_no",pd_no);
			json.put("pd_name",pd_name);
			json.put("od_qty", od_qty);
			json.put("od_price", od_price);
			
			json.put("status", status); 
			json.put("od_createtime", od_createtime); 
			json.put("pd_img", pd_img);
			json.put("sh_date", sh_date);
			json.put("sh_zipcode", sh_zipcode);
			
			json.put("sh_addr1", sh_addr1);
			json.put("sh_addr2", sh_addr2);

			json.put("category_name", category_name);
			json.put("color_name", color_name);
			json.put("room_name", room_name);
		
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