<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ include file="/header.jsp"%>
<%@ include file="/dbconnection.jsp"%>
 

<sql:update var="resultSet" dataSource="${conn}">
   DELETE 
   FROM product 
   WHERE pd_no = ?
   <sql:param value="${param.pd_no}" />
</sql:update>


<!-- 정상적으로 삭제처리시 이동 -->
<c:if test="${resultSet>=1}">
	<c:redirect url="/admin/productListAjax.jsp?firstDate=1920-01-01&lastDate=2099-01-01&searchType=all" />
</c:if>

