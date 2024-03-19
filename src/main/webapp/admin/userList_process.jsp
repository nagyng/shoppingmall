<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ include file="/header.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 관리에서 검색</title>
<link rel="stylesheet" href="//code.jquery.com/ui/1.13.2/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
<style>/* 
form > * {
	float:left;
} */
</style>
</head>
<body>
<!-- 관리자 모드 -->
<div style="min-height: 700px;">

	<div class="top">
		<%@ include file="/top.jsp" %>
	</div>

	<%@ include file="/dbc_notsql.jsp" %>
	
	<div class="container-float mt-4 mb-4 p-5 text-black">
		<div class="container text-center">
			<h1>회원 목록</h1>
		</div>
	</div>
	
	<% 
	
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	String sql = null;  
	
	String searchGrade = request.getParameter("searchGrade");
	String firstDate = request.getParameter("firstDate");
	String lastDate = request.getParameter("lastDate");
	 
	
	System.out.println("searchGrade: " + searchGrade);
	System.out.println("firstDate: " + firstDate);
	System.out.println("lastDate:  " + lastDate);  

	%>
	
	<div class="container input-group text-center">
		<input type="button" class="btn btn-secondary mb-3" value="신규 회원 등록" onclick="location.href='insert_product.jsp'">
		<div class="input-group-prepend mb-3"> 
			<form action="userListAjax.jsp" method="post">
			<span class="input-group-text col-sm-1" id="inputGroup-sizing-default" style="margin-left:10px; float:left;">조회 기간</span> 
			<input type="text" aria-label="First date" class="form-control Date input-group-append col-sm-2" value="<%=firstDate %>" readonly style="float:left;">
			 
			<input type="text" aria-label="Last date" class="form-control Date col-sm-2" value="<%=lastDate %>" readonly style="float:left;"> 
			
			<div class="" style="float:right;">
			  <select class="custom-select col-sm-5 " name="searchType" id="searchType" aria-label="Example select with button addon" style="margin-left:10px;">
			    <option selected value="all" readonly><%=searchGrade %></option>
			    <option value="1" >1</option>
			    <option value="2" >2</option>
			    <option value="3" >3</option>
			    <option value="4" >4</option>
			    <option value="5" >5</option>
			    <option value="6" >6</option>
			    <option value="7" >7</option> 
			    <option value="8" >8</option>
			    <option value="9" >9</option>
			    <option value="10" >10</option> 
			  </select> 
			    <button class="btn btn-outline-info" type="submit">검색 초기화</button> 
			</div>
			  </form>

  		</div> 
 </div>
		
		
	
	<div class="container col-9 input-group userListDiv p-5" > 
 
		<table class="table table-hover table-sm table-bordered"> <!--  table-striped -->
			<thead class="table-active">
				<tr class="userListTh">
					<th class="text-center">아이디</th>
					<th class="text-center">비밀번호</th>
					<th class="text-center">이름</th>
					<th class="text-center">생일</th>
					<th class="text-center">연락처</th>
					<th class="text-center">이메일</th>
					<th class="text-center">성별</th>
					<th class="text-center">우편번호</th>
					<th class="text-center">도로명주소</th>
					<th class="text-center">상세주소</th>
					<th class="text-center">등급</th>
					<th class="text-center">등록일자</th>
					<th class="text-center">수정일자</th>
					<th class="text-center" colspan="2">편집</th>
				</tr>
			</thead>

			<%
			try{  			
						if (searchGrade.equals("all")) {				//회원등급 
							sql = "select 		*" +
									" from 		user u" +
									" where		u.createtime between ' " + firstDate + " ' and ' " + lastDate + " '";
						} else {								
							sql = "select 		*" +
									" from 		user u" +
									" where 	u.grade = ' " + searchGrade + " '" + 
									" and		u.createtime between ' " + firstDate + " ' and ' " + lastDate + " '"; 
						}
					 
				  
				System.out.println("sql: " + sql); 

				pstmt = conn.prepareStatement(sql);
				rs = pstmt.executeQuery();
				
				while(rs.next()){
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
				
				%>
					<tr>
						<td class="text-center"><%=user_id%></td>
						<td class="text-center"><%=user_pw%></td>
						<td class="text-center"><%=username%></td>
						<td class="text-center"><%=birthday%></td>
						<td class="text-center"><%=phone%></td>
						<td class="text-center"><%=email%></td>
						<td class="text-center"><%=gender%></td>
						<td class="text-center"><%=zipcode%></td>
						<td class="text-center"><%=addr1%></td>
						<td class="text-center"><%=addr2%></td>
						<td class="text-center" style="background-color: lightyellow;"><%=grade%></td>
						<td class="text-center"><%=createtime%></td>
						<td class="text-center"><%=updatetime%></td>
						<td class="text-center">
							<input type="button" class="btn btn-warning btn-sm" value="수정" onclick="location.href='update_user.jsp?user_id=<%=user_id%>'">
						</td>
						<td class="text-center">
							<input type="button" class="btn btn-outline-danger btn-sm" value="삭제" onclick="location.href='delete_user.jsp?user_id=<%=user_id%>'">
						</td>
					</tr>
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
		</table> 
	</div>

</div>
				   
	<div class="footer">
		<%@ include file="/footer.jsp"%>
	</div>
</body>
</html>