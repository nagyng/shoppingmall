<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<% 
	System.out.println("이동 성공");
	%>
	<jsp:useBean id="cart" class="dto.Cart" scope="session" />
	<% 
	HttpSession httpSession = request.getSession(true);
	
	int pd_no = Integer.parseInt(request.getParameter("pd_no"));
	System.out.println("pd_no: " + pd_no);
	int cart_qty = Integer.parseInt(request.getParameter("cart_qty"));
	System.out.println("cart_qty: " + cart_qty);
	
	cart.update(request,httpSession,pd_no,cart_qty);

	System.out.println("저장 성공");
	response.sendRedirect("/cart/cart.jsp");
	
	%>
</body>
</html>