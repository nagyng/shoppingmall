<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="dto.Product" %>    

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<% 
		int pd_no = Integer.parseInt(request.getParameter("pd_no"));
	
		/* 삭제하려는 정보가 없으면 조회화면으로 이동 */
		if(pd_no == 0){/* 
			response.sendRedirect("productList.jsp?all=all"); */
			return;
		}
		
		ArrayList<Product> cartList = (ArrayList<Product>)session.getAttribute("cartlist");
		
		Product goodsQnt = new Product();
		
		/* 반복문을 사용해서 세션 cartlist에 해당되는 정보가 있으면 삭제 */
		for(int i=0;i<cartList.size();i++){
			
			goodsQnt = cartList.get(i);
			
			if(goodsQnt.getPd_no() == pd_no){
				/* 세션정보에서 삭제 */
				cartList.remove(goodsQnt);
			}
		}
		
		/* 장바구니로 이동 */
		response.sendRedirect("cart.jsp");
	%>
</body>
</html>


