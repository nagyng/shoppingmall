<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "com.oreilly.servlet.*" %>
<%@ page import = "com.oreilly.servlet.multipart.*" %>
<%@ page import = "java.util.*" %>
<%@ page import = "java.io.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
</head>
<body>
<%@ include file="/dbconnection.jsp" %>  


<%  
  
	MultipartRequest multi = new MultipartRequest(request, "D:\\jspStudy\\restart\\src\\main\\webapp\\review_upload_img", 5 * 1024 * 1024, "utf-8", new DefaultFileRenamePolicy());
	

	int rv_no = Integer.parseInt(multi.getParameter("rv_no"));
	String user_id = multi.getParameter("user_id"); 
	int pd_no = Integer.parseInt(multi.getParameter("pd_no"));
	String rv_title = multi.getParameter("rv_title");
	String rv_content = multi.getParameter("rv_content");
	String rv_createtime = multi.getParameter("rv_createtime");
	String ip = request.getRemoteAddr();    
	int rating = Integer.parseInt(multi.getParameter("rating")); 
	   
	// 입력된 name 값을 하나씩 가져와서 처리해주는 순환 인터페이스
 	Enumeration files=multi.getFileNames();
	
	while (files.hasMoreElements()){
		String name=(String) files.nextElement();			//요청 피라미터 이름
		String filename=multi.getFilesystemName(name);		//저장 파일 이름
		String original=multi.getOriginalFileName(name);	//실제 파일 이름
		String type=multi.getContentType(name);				//파일 콘텐츠 유형
		File file = multi.getFile(name); 
 
	
	System.out.println("요청 피라미터 이름: " + name + "<br>");
	System.out.println("실제 파일 이름: " + original + "<br>");
	System.out.println("저장 파일 이름: " + filename + "<br>");
	System.out.println("파일 콘텐츠 유형: " + type + "<br>");
	
	
	if(file!=null){
		System.out.println("파일 크기:" + file.length());
		System.out.println("<br>");
	}  //if 문 종료

	%>
	
	<!-- DB 의 review 테이블에 입력값 update 하기 -->
	<sql:update var="resultSet4" dataSource="${conn}">
		update 	review 
		set 	user_id=?,
				pd_no=?,
				rv_title=?,
				rv_content=?,
				rv_img=?,
				rv_updatetime=now() 
				rating=?,
		where	rv_no=?
		<sql:param value="<%=user_id%>"/> 
		<sql:param value="<%=pd_no%>"/> 
		<sql:param value="<%=rv_title%>"/> 
		<sql:param value="<%=rv_content%>"/> 
		<sql:param value="<%=filename%>"/>  
		<sql:param value="<%=rating%>"/> 
		
		<sql:param value="<%=rv_no%>"/>  
	</sql:update>   
	
	
	<% 

	 
	} //while 문 종료
	
	out.println("<script>");
	out.println("alert('리뷰가 수정되었습니다.');");
	out.println("location.href='/ReviewListAction.rdo?pageNum=1';");
	out.println("</script>");
	%> 

	
</body>
</html>