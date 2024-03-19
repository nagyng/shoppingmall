<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="java.util.*"%>
<%@page import="org.json.JSONObject"%>
<%
/* CREATE TABLE employee (
		  id int NOT NULL AUTO_INCREMENT,
		  name varchar(50) DEFAULT NULL,
		  saleqty int NOT NULL,
		  PRIMARY KEY (`id`)
		); 
 */
	
	Connection con = null; 
	 
	try {
		
		String url = "jdbc:mysql://localhost:3307/project?serverTimezone=Asia/Seoul";
		String userid = "project";
		String password = "project";
		
		Class.forName("com.mysql.cj.jdbc.Driver");
		
		con = DriverManager.getConnection(url,userid,password);
	
		ResultSet rs = null;
		
		List empdetails = new LinkedList();
		
		//객체를 Json객체로 바꿔주거나 Json객체를 새로 만드는 역할을 합니다
		//JSONObject는 JSON에서 key-value 쌍으로 데이터를 표현하는 객체입니다.
		JSONObject responseObj = new JSONObject();
	
		String query = "select DISTINCT p.pd_name as pd_name, o.od_qty as od_qty" + 
				" from 	product p, ordertb o, user u" +
				" where	p.pd_no = o.pd_no" + 
				" and	u.user_id = o.user_id";
		
		PreparedStatement pstm = con.prepareStatement(query);
	
		rs = pstm.executeQuery();
		
		JSONObject empObj = null;
	
		while (rs.next()) {
			
			String pd_name = rs.getString("pd_name");
			int od_qty = rs.getInt("od_qty");
			
			/* 테이블에서 가져온 데이터를 JSON 형태로 대입하기 위해 선언 */
			empObj = new JSONObject();
	
			empObj.put("pd_name", pd_name);
			empObj.put("od_qty", od_qty);
			
			//List구조에 JSON형태의 자료를 추가
			empdetails.add(empObj);
		}
		
		//json 속성 지정
		responseObj.put("empdetails", empdetails);
	
		//json 형태의 데이터를 화면에 출력
		out.print(responseObj.toString());
		
	} catch (Exception e) {
		e.printStackTrace();
	} finally {
		if (con != null) con.close();
	}
%>