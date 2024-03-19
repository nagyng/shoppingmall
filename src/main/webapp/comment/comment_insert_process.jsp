<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body> 
<%@ include file="/dbconnection.jsp" %>  

<% 
int qna_no = Integer.parseInt(request.getParameter("qna_no"));/* 
int qna_no2 =  ((Integer) request.getAttribute("qna_no")).intValue();    */
System.out.println("qna_no" + qna_no);/* 
System.out.println("qna_no2" + qna_no2); */
String user_id = request.getParameter("user_id"); 
String cm_content = request.getParameter("cm_content");
  
%>
  
	<sql:update var="resultSet4" dataSource="${conn}">
		insert into comment values(null,?,?,?,now(),now()) 
		<sql:param value="<%=qna_no%>"/> 
		<sql:param value="<%=user_id%>"/> 
		<sql:param value="<%=cm_content%>"/> 
	</sql:update>  
  <%-- 
<%
	System.out.println("댓글 등록 완료"); 
	response.sendRedirect("/QnaListAction.qdo?pageNum=1");
%> --%>

<script> 
	alert("댓글이 등록되었습니다.");
	history.back(); 
</script>

</body>
</html>