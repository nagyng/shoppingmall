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
	
		String query = "select u.user_id as user_id, sum(o.od_price) as od_price" + 
				" from 		user u, ordertb o" +
				" where		u.user_id = o.user_id" + 
				" group by	u.user_id";
		
		PreparedStatement pstm = con.prepareStatement(query);
	
		rs = pstm.executeQuery();
		
		JSONObject empObj = null;
	
		while (rs.next()) {
			
			String user_id = rs.getString("user_id");
			int od_price = rs.getInt("od_price");
			
			/* 테이블에서 가져온 데이터를 JSON 형태로 대입하기 위해 선언 */
			empObj = new JSONObject();
	
			empObj.put("user_id", user_id);
			empObj.put("od_price", od_price);
			
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