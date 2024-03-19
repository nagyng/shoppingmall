<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.net.URLEncoder" %>    
<%@ page import="java.util.ArrayList" %>
<%@ page import="dto.Product" %>    
<%@ page import="dao.ProductRepository" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%@ include file="/dbconnection.jsp" %>
<%
	
		//URLEncoder.encode() : 문자열을 컴퓨터가 인식할 수 있도록 바이트단위로 변환
		//입력받은 데이터를 전부 쿠키를 생성한다.
		Cookie cartId = new Cookie("Shipping_cartId",URLEncoder.encode(request.getParameter("cartId"),"utf-8"));
		Cookie name = new Cookie("Shipping_name",URLEncoder.encode(request.getParameter("name"),"utf-8"));
		Cookie shippingDate = new Cookie("Shipping_shippingDate",URLEncoder.encode(request.getParameter("shippingDate"),"utf-8")); 
		Cookie zipCode = new Cookie("Shipping_zipCode",URLEncoder.encode(request.getParameter("zipCode"),"utf-8"));
		Cookie addressName = new Cookie("Shipping_addressName",URLEncoder.encode(request.getParameter("addressName"),"utf-8"));
		Cookie addressName2 = new Cookie("Shipping_addressName2",URLEncoder.encode(request.getParameter("addressName2"),"utf-8"));
		
		
		//쿠키의 유효시간 설정(24시간)
		cartId.setMaxAge(24 * 60 * 60);
		name.setMaxAge(24 * 60 * 60);
		zipCode.setMaxAge(24 * 60 * 60); 
		addressName.setMaxAge(24 * 60 * 60);
		addressName2.setMaxAge(24 * 60 * 60);
	
		//서버에서 생성한 쿠키정보를 클라이언트로 전송
		response.addCookie(cartId);
		response.addCookie(name);
		response.addCookie(shippingDate); 
		response.addCookie(zipCode);
		response.addCookie(addressName);
		response.addCookie(addressName2);
		
		
		response.sendRedirect("orderConfirmation.jsp");
		
		
	%>
</body>
</html>


