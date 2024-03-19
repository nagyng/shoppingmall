<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/dbconnection.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

	<%
		request.setCharacterEncoding("utf-8");
	
		String pd_name = request.getParameter("pd_name");
		int pd_category = Integer.parseInt(request.getParameter("pd_category"));
		int pd_color = Integer.parseInt(request.getParameter("pd_color"));
		int pd_room = Integer.parseInt(request.getParameter("pd_room"));
		String pd_size = request.getParameter("pd_size");
		int pd_price = Integer.parseInt(request.getParameter("pd_price"));
		int pd_stock = Integer.parseInt(request.getParameter("pd_stock"));
		int pd_saleprice = Integer.parseInt(request.getParameter("pd_saleprice"));
		String pd_img = request.getParameter("pd_img");
		String pd_detail = request.getParameter("pd_detail");

		 
	%>
	
	
	<sql:update var="resultSet" dataSource="${conn}">
		insert into product values(null,?,?,?,?,?,?,?,?,?,now(),now(),?)
		
		<sql:param value="<%=pd_name%>"/>		
		<sql:param value="<%=pd_category%>"/>
		<sql:param value="<%=pd_color%>"/>
		<sql:param value="<%=pd_room%>"/>
		<sql:param value="<%=pd_size%>"/>
		
		<sql:param value="<%=pd_price%>"/>
		<sql:param value="<%=pd_stock%>"/>
		<sql:param value="<%=pd_saleprice%>"/>
		<sql:param value="<%=pd_img%>"/>
		<sql:param value="<%=pd_detail%>"/>
	</sql:update>
	
	<%
	out.println("<script>");
	out.println("alert('새로운 품목이 등록되었습니다.');");
	out.println("location.href='/admin/productListAjax.jsp?firstDate=1920-01-01&lastDate=2099-01-01&searchType=all';");
	out.println("</script>");
	%>
	
</body>
</html>