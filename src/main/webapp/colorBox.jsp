<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
	.colorBoxList {
		margin: 30px;
		display: inline-block;
		width: 200px;
		height: 200px;
		border-radius: 30px;
		text-align: center;
		line-height: 200px;
	}
</style>
</head>
<body>

	
	<a href="/colorList.jsp?color_name=red"><div class="colorBoxList" style="background-color: #EB6464">레드</div></a>
	<a href="/colorList.jsp?color_name=orange"><div class="colorBoxList" style="background-color: #EA9A56">오렌지</div></a>
	<a href="/colorList.jsp?color_name=yellow"><div class="colorBoxList" style="background-color: #FFD700">노랑</div></a>
	<a href="/colorList.jsp?color_name=green"><div class="colorBoxList" style="background-color: #74D19D">그린</div></a>
	<a href="/colorList.jsp?color_name=blue"><div class="colorBoxList" style="background-color: #8CBDED">블루</div></a>
	<a href="/colorList.jsp?color_name=brown"><div class="colorBoxList" style="background-color: 	#D29953">브라운</div></a>
	<a href="/colorList.jsp?color_name=purple"><div class="colorBoxList" style="background-color: #A0A0FF">보라</div></a>
	<a href="/colorList.jsp?color_name=pink"><div class="colorBoxList" style="background-color: pink">핑크</div></a>
	<a href="/colorList.jsp?color_name=black"><div class="colorBoxList" style="background-color: black; color: white;">블랙</div></a>
	<a href="/colorList.jsp?color_name=gray"><div class="colorBoxList" style="background-color: gray; color: white;">그레이</div></a>
	<a href="/colorList.jsp?color_name=white"><div class="colorBoxList" style="background-color: white; border:1px solid lightgray;">화이트</div></a>

</body>
</html>