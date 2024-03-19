<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="dto.Product" %>
<%@ page import="dao.ProductRepository" %>
<%@ page import="java.util.ArrayList" %>
<%@ include file="/dbc_notsql.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>장바구니</title>
</head>
<body>

<% 

int pd_no = 0;
if(request.getParameter("pd_no") != null){
	pd_no 	= Integer.parseInt(request.getParameter("pd_no"));
	System.out.println(pd_no);
}
if (pd_no == 0) { 
	System.out.println(pd_no);
	return;
}

ProductRepository dao = ProductRepository.getInstance();

Product product = dao.getProductByNo(pd_no);
if (product == null) {
	response.sendRedirect("/exception_error.jsp");
}

ArrayList<Product> goodsList = dao.getAllProducts();
Product goods = new Product();
for (int i = 0; i < goodsList.size(); i++) {
	goods = goodsList.get(i);
	if (goods.getPd_no() == pd_no){
		break;
	}
}

ArrayList<Product> list = (ArrayList<Product>) session.getAttribute("cartlist");		/* 세션 생성 */
if (list == null) {
	list = new ArrayList<Product>();
	session.setAttribute("cartlist", list);
}

int cnt=0;
Product goodsQnt = new Product();


for(int i = 0; i < list.size(); i++){						/* 정보 생성 */
	goodsQnt = list.get(i);
	if (goodsQnt.getPd_no() == pd_no ){						/* 수량 증가 */
		cnt++;
		int orderQuantity = goodsQnt.getCart_qty() + 1;		/* 수량에 1 더 증가 */
		goodsQnt.setCart_qty(orderQuantity);
	}
}


if(cnt == 0){
	goods.setCart_qty(1);
	list.add(goods);
}

response.sendRedirect("/cart/cart.jsp"); 


%>

</body>
</html>