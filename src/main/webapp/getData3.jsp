<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="dbconn_ajax.jsp"%>
<%@ page import="java.sql.*" %>
<%@ page import="org.json.simple.*"%>

<%

	PreparedStatement pstmt = null;
	ResultSet rs = null;

	try {

		pstmt = conn.prepareStatement("select * from ordertb");

		rs = pstmt.executeQuery();
		
		String result = "";

		JSONArray sendArray = new JSONArray();
		while(rs.next()) {
			JSONObject json = new JSONObject(); //Map컬렉션
			int od_id = rs.getInt("od_id");
			int pd_no = rs.getInt("pd_no");
			int od_qty = rs.getInt("od_qty");
			int od_price = rs.getInt("od_price");
			int od_status = rs.getInt("od_status");
			String user_id = rs.getString("user_id");
			String od_createtime = rs.getString("od_createtime");
			String od_updatetime = rs.getString("od_updatetime"); 
	
			json.put("od_id", od_id);
			json.put("pd_no",pd_no);
			json.put("od_qty", od_qty);
			json.put("od_price", od_price);
			json.put("od_status", od_status);
			json.put("user_id",user_id);
			json.put("od_createtime", od_createtime);
			json.put("od_updatetime", od_updatetime);
		
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