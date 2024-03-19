<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/dbconn_ajax.jsp"%>
<%@ page import="java.sql.*" %>
<%@ page import="org.json.simple.*"%>
<%

String searchGrade = request.getParameter("searchGrade");
String firstDate = request.getParameter("firstDate");
String lastDate = request.getParameter("lastDate");

if(request.getParameter("firstDate") != null){
	firstDate = request.getParameter("firstDate");
}  
if(request.getParameter("lastDate") != null){
	lastDate = request.getParameter("lastDate");
}  
 
if (firstDate == null){
	firstDate = "";
}
if (lastDate == null){
	lastDate = "";
}

System.out.println("firstDate: " + firstDate); 
System.out.println("lastDate: " + lastDate); 

%>
<% 

PreparedStatement pstmt = null;
ResultSet rs = null; 
 
try { 
	System.out.println("회원등급 getdata try " + searchGrade);
	
	//날짜 조회 안 했을 때 
	if(firstDate.equals("") && lastDate.equals("")){
		pstmt = conn.prepareStatement("select * from user" +
			 						 " order by grade desc");
		System.out.println("getdata if 1");
	} else {
		if(searchGrade == "all" || searchGrade == null){
			pstmt = conn.prepareStatement(
					"select 	*" + 
					" from 		user" +
					" where 	createtime between '" + firstDate + " ' and '" + lastDate + " '");  
			System.out.println("getdata if 2");
		} else {
			pstmt = conn.prepareStatement(
					"select 	*" + 
					" from 		user" +
					" where 	createtime between '" + firstDate + " ' and '" + lastDate + " '" +
					" and 		grade = " + searchGrade);
			System.out.println("getdata if 3");
			System.out.println("getdata if 3 firstDate" + firstDate);
			System.out.println("getdata if 3 lastDate" + lastDate);
			System.out.println("getdata if 3 searchGrade" + searchGrade);
		}
	}
	
	rs = pstmt.executeQuery(); 
	String result = ""; 
	JSONArray sendArray = new JSONArray();

	while (rs.next()) {

		JSONObject json = new JSONObject(); //Map컬렉션
		String user_id = rs.getString("user_id");
		String user_pw = rs.getString("user_pw");
		String username = rs.getString("username");
		String birthday = rs.getString("birthday");
		String phone = rs.getString("phone");
		String email = rs.getString("email");
		String gender = rs.getString("gender");
		String zipcode = rs.getString("zipcode");
		String addr1 = rs.getString("addr1");
		String addr2 = rs.getString("addr2");
		int grade = rs.getInt("grade");
		String createtime = rs.getString("createtime");
		String updatetime = rs.getString("updatetime");
		 

		json.put("user_id", user_id);
		json.put("user_pw", user_pw); 
		json.put("username", username); 
		json.put("birthday", birthday);
		json.put("phone", phone);
		json.put("email", email);
		json.put("gender", gender);
		json.put("zipcode", zipcode);
		json.put("addr1", addr1);
		json.put("addr2", addr2);
		json.put("grade", grade);
		json.put("createtime", createtime);
		json.put("updatetime", updatetime); 

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