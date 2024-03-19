<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%

	int pd_no = Integer.parseInt(request.getParameter("pd_no"));
	String pd_name = request.getParameter("pd_name");
	int pd_category = Integer.parseInt(request.getParameter("pd_category"));
	int pd_color = Integer.parseInt(request.getParameter("pd_color"));
	int pd_room = Integer.parseInt(request.getParameter("pd_room"));
	String pd_size = request.getParameter("pd_size");
	int pd_price = Integer.parseInt(request.getParameter("pd_price"));
	int pd_stock = Integer.parseInt(request.getParameter("pd_stock"));
	int pd_saleprice = Integer.parseInt(request.getParameter("pd_saleprice"));
	String pd_img = request.getParameter("pd_img");
	String pd_createtime = request.getParameter("pd_createtime");
	String pd_updatetime = request.getParameter("pd_updatetime");
	String pd_detail = request.getParameter("pd_detail");
%>

<%@ include file="/dbconnection.jsp" %>
 
<sql:update var="resultSet" dataSource="${conn}">
	update 	product
	set		pd_name=?,
			pd_category=?,
			pd_color=?,
			pd_room=?,
			pd_size=?,
			pd_price=?,
			pd_stock=?,
			pd_saleprice=?,
			pd_img=?,
			pd_updatetime=now(),
			pd_detail=?
	where	pd_no=?
	<sql:param value="<%=pd_name%>" />
	<sql:param value="<%=pd_category%>" />
	<sql:param value="<%=pd_color%>" />
	<sql:param value="<%=pd_room%>" />
	<sql:param value="<%=pd_size%>" />
	<sql:param value="<%=pd_price%>" />
	<sql:param value="<%=pd_stock%>" />
	<sql:param value="<%=pd_saleprice%>" />
	<sql:param value="<%=pd_img%>" />
	<sql:param value="<%=pd_detail%>" />
	<sql:param value="<%=pd_no%>" />
</sql:update>

<!-- update 문이 성공하면 resultSet 에 1 리턴, 1 리턴되면 강제 이동 -->
<c:if test="${resultSet>=1}">
	<c:redirect url="productListAjax.jsp" />
</c:if>