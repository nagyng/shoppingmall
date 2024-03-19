<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/dbconn_ajax.jsp"%>
<%@ page import="java.sql.*" %>
<%@ page import="org.json.simple.*"%>
<%

String od_id = null; 
String searchType = request.getParameter("searchType");
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
if(request.getParameter("od_id") != null){
	od_id = request.getParameter("od_id");  
}  

System.out.println("od_id: " + od_id);
System.out.println("firstDate: " + firstDate); 
System.out.println("lastDate: " + lastDate); 
System.out.println("searchType: " + searchType); 

%>
<% 

PreparedStatement pstmt = null;
ResultSet rs = null; 
 
try { 
	
	//주문번호 정렬 버튼을 누르지 않았을 때 
	if (od_id == "null" || od_id == null){
		//날짜 조회 안 했을 때 
		if(firstDate.equals("") && lastDate.equals("")){
		pstmt = conn.prepareStatement("select 	o.od_id as 'od_id'," +
				" 			max(o.user_id) as 'user_id'," +
				" 			max(ct.category_name) as 'category_name'," +
				" 			max(p.pd_name) as 'pd_name'," +
				" 			max(o.pd_no) as 'pd_no'," +
				" 			sum(o.od_qty) as 'od_qty'," +
				" 			sum(o.od_price) as 'od_price'," +
				" 			max(o.od_status) as 'od_status'," +
				" 			max(co.status) as 'status'," +
				" 			max(DATE_FORMAT(o.od_createtime, '%Y-%m-%d')) as 'od_createtime'," + 
				" 			max(DATE_FORMAT(o.od_updatetime, '%Y-%m-%d')) as 'od_updatetime'" + 
				" from 		ordertb o, codetb co, category ct, product p" +
				" where		o.od_status = co.od_status" + 
				" and		o.pd_no = p.pd_no" +
				" and		ct.pd_category = p.pd_category" +
				" group by	o.od_id" +
				" order by 	o.od_id");
				System.out.println("전체보기 ");
		} else {
			if(searchType == "all" || searchType == null){
				pstmt = conn.prepareStatement(
						"select 	o.od_id as 'od_id'," +
						" 			max(o.user_id) as 'user_id'," +
						" 			max(ct.category_name) as 'category_name'," +
								" 			max(p.pd_name) as 'pd_name'," +
						" 			max(o.pd_no) as 'pd_no'," +
						" 			sum(o.od_qty) as 'od_qty'," +
						" 			sum(o.od_price) as 'od_price'," +
						" 			max(o.od_status) as 'od_status'," +
						" 			max(co.status) as 'status'," +
						" 			max(DATE_FORMAT(o.od_createtime, '%Y-%m-%d')) as 'od_createtime'," + 
						" 			max(DATE_FORMAT(o.od_updatetime, '%Y-%m-%d')) as 'od_updatetime'" + 
						" from 		ordertb o, codetb co, category ct, product p" +
						" where		o.od_status = co.od_status" + 
						" and		o.pd_no = p.pd_no" +
						" and		ct.pd_category = p.pd_category" +
						" and	 	o.od_createtime between '" + firstDate + " ' and '" + lastDate + " '" + 
						" group by	o.od_id" +
						" order by 	o.od_id");  
				System.out.println("날짜만 검색");
			} else {
				pstmt = conn.prepareStatement(
						"select 	o.od_id as 'od_id'," +
						" 			max(o.user_id) as 'user_id'," +
						" 			max(ct.category_name) as 'category_name'," +
								" 			max(p.pd_name) as 'pd_name'," +
						" 			max(o.pd_no) as 'pd_no'," +
						" 			sum(o.od_qty) as 'od_qty'," +
						" 			sum(o.od_price) as 'od_price'," +
						" 			max(o.od_status) as 'od_status'," +
						" 			max(co.status) as 'status'," +
						" 			max(DATE_FORMAT(o.od_createtime, '%Y-%m-%d')) as 'od_createtime'," + 
						" 			max(DATE_FORMAT(o.od_updatetime, '%Y-%m-%d')) as 'od_updatetime'" + 
						" from 		ordertb o, codetb co, category ct, product p" +
						" where		o.od_status = co.od_status" + 
						" and		o.pd_no = p.pd_no" +
						" and		ct.pd_category = p.pd_category" +
						" and	 	o.od_createtime between '" + firstDate + " ' and '" + lastDate + " '" +
						" and 		o.od_status = " + searchType + 
						" group by	o.od_id" +
						" order by 	o.od_id");
				System.out.println("날짜 + 배송단계 검색 ");
				System.out.println("getdata if 3 firstDate" + firstDate);
				System.out.println("getdata if 3 lastDate" + lastDate);
				System.out.println("getdata if 3 searchGrade" + searchType);
			}
		}
	} 
	
	//주문번호 정렬 버튼을 클릭했을 때 
	else if (od_id.equals("asc")){ 
		pstmt = conn.prepareStatement("select 	o.od_id as 'od_id'," +
						" 			max(o.user_id) as 'user_id'," +
						" 			max(ct.category_name) as 'category_name'," +
								" 			max(p.pd_name) as 'pd_name'," +
						" 			max(o.pd_no) as 'pd_no'," +
						" 			sum(o.od_qty) as 'od_qty'," +
						" 			sum(o.od_price) as 'od_price'," +
						" 			max(o.od_status) as 'od_status'," +
						" 			max(co.status) as 'status'," +
						" 			max(DATE_FORMAT(o.od_createtime, '%Y-%m-%d')) as 'od_createtime'," + 
						" 			max(DATE_FORMAT(o.od_updatetime, '%Y-%m-%d')) as 'od_updatetime'" + 
						" from 		ordertb o, codetb co, category ct, product p" +
						" where		o.od_status = co.od_status" + 
						" and		o.pd_no = p.pd_no" +
						" and		ct.pd_category = p.pd_category" +
						" group by	o.od_id" +
						" order by 	o.od_id asc"); 
		System.out.println("주문번호 오래된 순 정렬 ");
		
	} else if (od_id.equals("desc")) {
		pstmt = conn.prepareStatement("select 	o.od_id as 'od_id'," +
				" 			max(o.user_id) as 'user_id'," +
				" 			max(ct.category_name) as 'category_name'," +
						" 			max(p.pd_name) as 'pd_name'," +
				" 			max(o.pd_no) as 'pd_no'," +
				" 			sum(o.od_qty) as 'od_qty'," +
				" 			sum(o.od_price) as 'od_price'," +
				" 			max(o.od_status) as 'od_status'," +
				" 			max(co.status) as 'status'," +
				" 			max(DATE_FORMAT(o.od_createtime, '%Y-%m-%d')) as 'od_createtime'," + 
				" 			max(DATE_FORMAT(o.od_updatetime, '%Y-%m-%d')) as 'od_updatetime'" + 
				" from 		ordertb o, codetb co, category ct, product p" +
				" where		o.od_status = co.od_status" + 
				" and		o.pd_no = p.pd_no" +
				" and		ct.pd_category = p.pd_category" +
				" group by	o.od_id" +
				" order by 	o.od_id desc"); 
		System.out.println("주문번호 최신순 정렬");
	}  
	

	rs = pstmt.executeQuery(); 
	String result = ""; 
	JSONArray sendArray = new JSONArray();

	while (rs.next()) {

		JSONObject json = new JSONObject(); //Map컬렉션

		int od_id2 = rs.getInt("od_id");
		String user_id = rs.getString("user_id");
		String pd_name = rs.getString("pd_name");
		String category_name = rs.getString("category_name");
		int pd_no = rs.getInt("pd_no");
		int od_qty = rs.getInt("od_qty");
		int od_price = rs.getInt("od_price"); 
		String od_createtime = rs.getString("od_createtime");
		String od_updatetime = rs.getString("od_updatetime");
		int od_status = rs.getInt("od_status");
		String status = rs.getString("status");
		 

		json.put("od_id", od_id2);
		json.put("user_id", user_id); 
		json.put("pd_name", pd_name); 
		json.put("category_name", category_name); 
		json.put("pd_no", pd_no); 
		json.put("od_qty", od_qty);
		json.put("od_price", od_price);
		json.put("od_createtime", od_createtime);
		json.put("od_updatetime", od_updatetime);
		json.put("od_status", od_status);
		json.put("status", status); 

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