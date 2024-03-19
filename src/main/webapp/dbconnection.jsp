<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>database connection</title>
</head>
<body>

	<sql:setDataSource
	var="conn"
	url="jdbc:mysql://localhost:3307/project?serverTimezone=Asia/Seoul"
	user="project"
	password="project"
	driver = "com.mysql.cj.jdbc.Driver"
	/>

</body>
</html>