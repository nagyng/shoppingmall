<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ include file="/header.jsp"%>
<%@ include file="/dbconnection.jsp"%>
 

<sql:update var="resultSet" dataSource="${conn}">
   DELETE 
   FROM user 
   WHERE user_id = ?
   <sql:param value="${param.user_id}" />
</sql:update>


<!-- 정상적으로 삭제처리시 이동 -->
<c:if test="${resultSet>=1}">
	<c:import var="url" url="logout_user.jsp" />
	<c:redirect url="userListAjax.jsp" />
</c:if>

