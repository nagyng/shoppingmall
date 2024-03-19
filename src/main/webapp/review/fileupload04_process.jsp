<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="org.apache.commons.fileupload.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>file upload 예제2</title>
</head>
<body>

	
	<%
		String path="D:\\jspStudy\\restart\\src\\main\\webapp\\review_upload_img";
	
		DiskFileUpload upload = new DiskFileUpload();		//서버 메모리에서 업로드를 처리해주는 클래스 
		
		upload.setSizeMax(5000000);
		upload.setSizeThreshold(4096);			//지정된 크기를 넘는 파일은 지정 폴더에 업로드 처리하고, 크기를 넘지 않으면 서버 메모리에서 처리.
		upload.setRepositoryPath(path);			//사이즈가 큰 파일을 업로드하면 임시폴더를 지정함.	
		
		List items = upload.parseRequest(request);			//입력화면의 입력값 매개변수를 전달받는 메서드 
		//List : 컬렉션의 list구조를 구현한 인터페이스 
		
		Iterator params = items.iterator();				//자료구조의 데이터를 하나씩 처리하는 인터페이스 
		
		while (params.hasNext()){
			FileItem item = (FileItem) params.next();	//
			
			if (item.isFormField()){					// 타입이 file로 선언 안 된 경우 처리 (이름, 제목)
				String name = item.getFieldName();			// name="" 의 이름명
				String value = item.getString("utf-8");
				out.println(name + " = " + value + "<br>");
			} else {										//타입 file을 처리 
				String fileFieldName = item.getFieldName();
				String fileName = item.getName();			//업로드한 파일 유형(MIME)을 가져옴 
				String contentType = item.getContentType();	
				
				fileName = fileName.substring(fileName.lastIndexOf("\\") + 1);
				long fileSize = item.getSize();
				
				File file = new File(path + "/" + fileName);
				item.write(file);
				
				out.println("--------------------------<br>");
				out.println("요청 피라미터 이름: " + fileFieldName + "<br>");
				out.println("저장 파일 이름:" + fileName + "<br>");
				out.println("파일 콘텐츠 유형: " + contentType + "<br>");
				out.println("파일 크기: " + fileSize + "<br>");
				
	%>
	
	<img alt="" src="/review_upload_img/<%=fileName%>" width="300" height="300">
	
	<%
			}
		}
	%>
	
</body>
</html>