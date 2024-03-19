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
   <sql:param value="${sessionId}" />
</sql:update>

<!-- 정상적으로 삭제처리시 login.jsp로 이동 -->
<c:if test="${resultSet>=1}">
	<c:import var="url" url="/user/logout.jsp" />
	<c:redirect url="/user/login.jsp" />
</c:if>

