<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ include file="/header.jsp"%>
<%@ include file="/dbconnection.jsp"%>
 

<sql:update var="resultSet" dataSource="${conn}">
   DELETE 
   FROM ordertb 
   WHERE od_id = ?
   <sql:param value="${param.od_id}" />
</sql:update>

 
<c:if test="${resultSet>=1}"> 
	<c:redirect url="orderListAjax.jsp" />
</c:if>

