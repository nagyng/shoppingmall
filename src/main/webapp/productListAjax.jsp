<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ include file="header.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://code.jquery.com/jquery-latest.min.js"></script>
<script src="https://unpkg.com/axios/dist/axios.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/lodash@4.17.11/lodash.min.js"></script>
<link rel="stylesheet"	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.0/css/all.min.css">
<title>품목 리스트</title>
<style type="text/css"> 
a.a1 {
min-width: 400px;
max-width: 400px;
min-height: 600px;
max-height: 600px;
}
.pLCard {
margin: auto;
min-width: 400px;
min-height: 600px;
max-height: 600px;
float: left;
}
.pLCard:hover {
background-color: whitesmoke;
}
.productListDiv {
min-height:700px;
}

* {
	margin: 0;
	padding: 0;
}

div.app {
	width: 100%;
}
 
.page-link {
	color: black;
}
 
</style>
<% 

int pd_category=0, pd_room=0, min=0, max=0;
String all = request.getParameter("all");
String pd_size = request.getParameter("pd_size");
String pd_price_list = request.getParameter("pd_price_list");
String color_name = request.getParameter("color_name");

if(request.getParameter("pd_category") != null){
	pd_category = Integer.parseInt(request.getParameter("pd_category")); 
}	

if(request.getParameter("pd_room") != null){
	pd_room 	= Integer.parseInt(request.getParameter("pd_room")); 
}

if(request.getParameter("min") != null){
	min 		= Integer.parseInt(request.getParameter("min")); 
}

if(request.getParameter("max") != null){
	max 		= Integer.parseInt(request.getParameter("max")); 
}

System.out.println("카테고리: " + pd_category);
System.out.println("공간: " + pd_room);
System.out.println("최저금액: " + min);
System.out.println("최고금액: " + max);
System.out.println("all: " + all);
System.out.println("사이즈: " + pd_size);
System.out.println("가격대: " + pd_price_list);
System.out.println("색상: " + color_name);

 
 
%>
<script>
let todoData = [];

var pd_category = "<%=pd_category%>";
var pd_room = "<%=pd_room%>";
var min = "<%=min%>";
var max = "<%=max%>";
var all = "<%=all%>";
var pd_size = "<%=pd_size%>";
var pd_price_list = "<%=pd_price_list%>";
var color_name = "<%=color_name%>"; 

let todosUrl = null;
const countPerPage = 8; // 페이지당 데이터 건수
const showPageCnt = 5; // 화면에 보일 페이지 번호 개수

$(document).ready(function() {
	if(pd_price_list != "null") {
		todosUrl = 'getData4.jsp?pd_price_list=' + pd_price_list;
	} else if(color_name != "null") {
		todosUrl = 'getData4.jsp?color_name=' + color_name;
	} else if(min != "0" && max != "0") {
		todosUrl = 'getData4.jsp?min=' + min + '&max=' + max;
	} else if(all != "null") {
		todosUrl = 'getData4.jsp?all=' + all;
	} else {
		todosUrl = 'getData4.jsp?pd_category=' + pd_category + '&pd_room=' + pd_room + '&color_name=' + color_name + '&pd_size=' + pd_size;
	}
console.log(todosUrl); 


axios.get(todosUrl).then(res => {
   console.log(res.data);
   todoData = res.data;

   setTable(1);
   setPaging(1);
 }).catch(err => console.error(err))
 .then(() => {
   // finally
 });
 

$(document).on('click', 'div.pagingDiv>ul.pagination>li.count', function() { 
 if (!$(this).hasClass('active')) {
   $(this).parent().find('li.active').removeClass('active');
   $(this).addClass('active');

   setTable(Number($(this).text()));
 } 
});

$(document).on('click', 'div.pagingDiv>ul.paginationBtn>li', function() {
 const totalPage = Math.floor(todoData.length / countPerPage) + (todoData.length % countPerPage == 0 ? 0 : 1);
 const id = $(this).attr('id');
 console.log(id);

 if (id == 'first_page') {
   setTable(1);
   setPaging(1);
 } else if (id == 'prev_page') {
   let arrPages = [];
   $('div.pagingDiv>ul.pagination>li.count').each(function(idx, item) {
     arrPages.push(Number($(this).text()));
   });
   
   const prevPage = _.min(arrPages) - showPageCnt;
   setTable(prevPage);
   setPaging(prevPage);
 } else if (id == 'next_page') {
   let arrPages = [];
   $('div.pagingDiv>ul.pagination>li.count').each(function(idx, item) {
     arrPages.push(Number($(this).text()));
   });
   
   const nextPage = _.max(arrPages) + 1;
   setTable(nextPage);
   setPaging(nextPage);
 } else if (id == 'last_page') {
   const lastPage = Math.floor((totalPage - 1) / showPageCnt) * showPageCnt + 1;
   setTable(lastPage);
   setPaging(lastPage);
 }
});
});
</script>

<script>
/*
  리턴받은 데이터를 테이블에 출력
*/
function setTable(pageNum) {

	$('#tblTodo>div').empty();

	const filteredData = _.slice(todoData, (pageNum - 1) * countPerPage, pageNum * countPerPage);
	console.log(filteredData); 
	
	var now = new Date();
	console.log(now); 
	
	let sTbodyHtml = '';
	
	for (let i = 0; i < filteredData.length; i++) {  
		 
		 sTbodyHtml += '<div class="d5 col mb-4 text-center">';
		 sTbodyHtml += ' <a class="a1" href="productView.jsp?pd_no=' + filteredData[i].pd_no + '">';
		 sTbodyHtml += '   <div class="card border-light h-100 mt-5 pLCard ">';
		 sTbodyHtml += '  	<img src="/fntimg/' + filteredData[i].pd_img + '" class="card-img-top mt-5" alt="' + filteredData[i].pd_img + '" style="width: 100%; height: 300px; margin:auto; object-fit: contain;">';
		 sTbodyHtml += '  	<div class="card-body">';
		 sTbodyHtml += '  		<h5 class="card-title pd-title">' + filteredData[i].pd_name + '</h5>'; 
		 sTbodyHtml += '  		<p class="card-text">' + filteredData[i].category_name + ' | ' + filteredData[i].room_name + ' | ' + filteredData[i].pd_size + '</p>';  
		 sTbodyHtml += '  		<span class="pdPrice" style="font-size: 20px; color:darkgrey; text-decoration-line: line-through;">' + filteredData[i].pd_price.toLocaleString() + '원</span>';
		 sTbodyHtml += '  		<span class="pdSalePrice" style="font-size: 30px; font-weight:bold; color:gold;">' + filteredData[i].pd_saleprice.toLocaleString() + '원</span>';   
		 if(filteredData[i].pd_stock == 0){ 
		 sTbodyHtml += '  		<span class="badge badge-danger" style="">  품절 </span>'; 
			} /* 		 
		 if( ((now.getTime() - filteredData[i].pd_createtime.getTime())/(24*60*60*1000)) <= 5){ 
		 sTbodyHtml += '  		<span class="badge badge-primary" style="">  new! </span>'; 
			}  */
		 sTbodyHtml += '  	</div>';
		 sTbodyHtml += '   </div>';
		 sTbodyHtml += ' </a>'; 
		 sTbodyHtml += '</div>'; 
	}
	$('#tblTodo>div').append(sTbodyHtml);
}

</script>

<script>
/**
 페이징 정보를 세팅합니다.
*/
function setPaging(pageNum) {
	const currentPage = pageNum;
	const totalPage = Math.floor(todoData.length / countPerPage) + (todoData.length % countPerPage == 0 ? 0 : 1);
	
	showAllIcon();
	
	if (currentPage <= showPageCnt) {
	 $('#first_page').hide();
	 $('#prev_page').hide();
	}
	
	if (totalPage <= showPageCnt ||  
		Math.floor((currentPage - 1) / showPageCnt) * showPageCnt + showPageCnt + 1 > totalPage) {
		 $('#next_page').hide();
		 $('#last_page').hide();
	}
	
	let start = Math.floor((currentPage - 1) / showPageCnt) * showPageCnt + 1;
	let sPagesHtml = '';
	
	for(const end = start + showPageCnt; start < end && start <= totalPage; start++) {
	 sPagesHtml += '<li class="' + (start == currentPage ? 'active page-link count' : 'page-link count') + '">' + start + '</li>';
	} 
 
	$('div.pagingDiv>ul.pagination').html(sPagesHtml);
} 

function showAllIcon() {
	$('#first_page').show();
	$('#prev_page').show();
	$('#next_page').show();
	$('#last_page').show();
}

</script>
</head>
<body>
<!-- 인덱스 --> 

	<div class="top">
		<%@ include file="/top.jsp" %>
	</div>
	<div class="nav">
		<%@ include file="/nav.jsp" %>
	</div> 
	
	<div class="container col-11 productListDiv mb-5"> 
		<div class="container-fluid app"> 
			<div id="tblTodo">
				<div class="d4 row row-cols-1 row-cols-md-4"> 
				 </div> 
			</div>  
			
			<div class="pagingDiv"> 
			  <ul class="paginationBtn pagination-lg">
			    <li class="page-item page-link fa-solid fa-angles-left" id="first_page"></li>
			    <li class="page-item page-link fa-solid fa-angle-left" id="prev_page"></li>
			  </ul>
			  <ul class="pagination pagination-lg"> 
				<li class="active page-link count">1</li>
				<li class="page-link count">2</li>
				<li class="page-link count">3</li> 
				<li class="page-link count">4</li>
				<li class="page-link count">5</li> 
			  </ul>
			  <ul class="paginationBtn pagination-lg">
			    <li class="page-item page-link fa-solid fa-angle-right" id="next_page"></li>
			    <li class="page-item page-link fa-solid fa-angles-right" id="last_page"></li>
			  </ul>
			</div>
			
		</div>
	</div>
	 
				   
	<div class="footer">
		<%@ include file="/footer.jsp"%>
	</div>

</body>
</html>