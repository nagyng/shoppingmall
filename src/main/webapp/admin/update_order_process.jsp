<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%> 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>  
<%@ include file="/dbconnection.jsp" %>
<%
	int od_id = Integer.parseInt(request.getParameter("od_id"));
	String user_id = request.getParameter("user_id");
	int pd_no = Integer.parseInt(request.getParameter("pd_no"));
	int od_qty = Integer.parseInt(request.getParameter("od_qty"));
	int od_price = Integer.parseInt(request.getParameter("od_price"));
	int od_status = Integer.parseInt(request.getParameter("od_status"));
	String od_createtime = request.getParameter("od_createtime"); 
	
	if(od_status == 6){	//주문취소 상태일 때
		%>  
		<sql:update var="resultSet5" dataSource="${conn}">
			update 	product p, ordertb o 
			set		pd_stock = pd_stock + od_qty
			where	p.pd_no = o.pd_no
			AND		p.pd_no = ?
		<sql:param value="${param.pd_no}" /> 
		</sql:update> 
		<% 
	}
%>

 

<sql:update var="resultSet" dataSource="${conn}">
	update 	ordertb 
	set		user_id=?,
			od_qty=?,
			od_price=?,
			od_status=?,
			od_updatetime=now()
	where	od_id=?
	and		pd_no=?
	<sql:param value="<%=user_id%>" />
	<sql:param value="<%=od_qty%>" />
	<sql:param value="<%=od_price%>" />
	<sql:param value="<%=od_status%>" /> 
	<sql:param value="<%=od_id%>" />
	<sql:param value="<%=pd_no%>" /> 
</sql:update>
<!-- update 문이 성공하면 resultSet 에 1 리턴, 1 리턴되면 강제 이동 -->
<c:if test="${resultSet>=1}">
	<c:redirect url="orderListAjax.jsp" />
</c:if>
