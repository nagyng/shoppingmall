<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%
	String user_id = request.getParameter("id");
	String user_pw = request.getParameter("password");
	String username = request.getParameter("name");
	String birthday = request.getParameter("birthday");
	String phone = request.getParameter("phone");
	String email1 = request.getParameter("email1");
	String email2 = request.getParameter("email2");
	String email = email1 + "@" + email2;
	String gender = request.getParameter("gender");
	String zipcode = request.getParameter("zipcode");
	String addr1 = request.getParameter("addr1");
	String addr2 = request.getParameter("addr2");
	int grade = Integer.parseInt(request.getParameter("grade"));
	String createtime = request.getParameter("createtime");
%>

<%@ include file="/dbconnection.jsp" %>
 
<sql:update var="resultSet" dataSource="${conn}">
	update 	user 
	set		user_id=?,
			user_pw=?,
			username=?,
			birthday=?,
			phone=?,
			email=?,
			gender=?,
			zipcode=?,
			addr1=?,
			addr2=?,
			grade=?,
			updatetime=now()
	where	user_id=?
	<sql:param value="<%=user_id%>" />
	<sql:param value="<%=user_pw%>" />
	<sql:param value="<%=username%>" />
	<sql:param value="<%=birthday%>" />
	<sql:param value="<%=phone%>" />
	<sql:param value="<%=email%>" />
	<sql:param value="<%=gender%>" />
	<sql:param value="<%=zipcode%>" />
	<sql:param value="<%=addr1%>" />
	<sql:param value="<%=addr2%>" />
	<sql:param value="<%=grade%>" />
	<sql:param value="<%=user_id%>" />
</sql:update>

<!-- update 문이 성공하면 resultSet 에 1 리턴, 1 리턴되면 강제 이동 -->
<c:if test="${resultSet>=1}">
	<c:redirect url="userListAjax.jsp" />
</c:if>
