<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ include file="/header.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- 페이징 처리 -->
<script src="https://code.jquery.com/jquery-latest.min.js"></script>
<script src="https://unpkg.com/axios/dist/axios.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/lodash@4.17.11/lodash.min.js"></script>
<link rel="stylesheet"	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.0/css/all.min.css"> 
<style> 

div.paging {
	width: 100%;
	display: inline-flex;
	align-items: center;
	margin-top: 20px;
	justify-content: center;
}

div.paging>i, div.paging>div.pages {
	margin: 0 10px;
}

div.paging>i, div.paging>div.pages>span {
	margin: 0 3px;
	cursor: pointer;
}

span.active {
	color: orangered;
	font-weight: bold;
}
.tbl2 > th {
	max-width: 100px;
} 
</style>
<%

String searchGrade = request.getParameter("searchGrade");
String firstDate = request.getParameter("firstDate");
String lastDate = request.getParameter("lastDate");
 
if (firstDate == null){
	firstDate = "";
}
if (lastDate == null){
	lastDate = "";
}

System.out.println("시작일: " + firstDate);
System.out.println("종료일: " + lastDate);
System.out.println("회원등급: " + searchGrade);

%>
<script>


let todoData = [];


var searchGrade = "<%=searchGrade%>";
var firstDate = "<%=firstDate%>";
var lastDate = "<%=lastDate%>";

let todosUrl = null;

const countPerPage = 10; // 페이지당 데이터 건수
const showPageCnt = 5; // 화면에 보일 페이지 번호 개수
 
$(document).ready(function() {
	if(firstDate != ""){ 
		todosUrl = 'getData_uL.jsp?firstDate=' + firstDate + '&lastDate=' + lastDate + '&searchGrade=' + searchGrade;  
	} else {
		todosUrl = 'getData_uL.jsp'; 
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

/*
  리턴받은 데이터를 테이블에 출력
*/
function setTable(pageNum) {

	$('#tblTodo>tbody').empty();

	const filteredData = _.slice(todoData, (pageNum - 1) * countPerPage, pageNum * countPerPage);
	console.log(filteredData); 
	
	let sTbodyHtml = '';
	
	for (let i = 0; i < filteredData.length; i++) {
		 sTbodyHtml += '<tr>';
		 sTbodyHtml += '  <td class="text-center">' + filteredData[i].user_id + '</td>'; 
		 sTbodyHtml += '  <td class="text-center">' + filteredData[i].username + '</td>';
		 sTbodyHtml += '  <td class="text-center">' + filteredData[i].birthday + '</td>';
		 sTbodyHtml += '  <td class="text-center">' + filteredData[i].phone + '</td>';
		  
		 sTbodyHtml += '  <td class="text-center">' + filteredData[i].email + '</td>'; 
		 sTbodyHtml += '  <td class="text-center">' + filteredData[i].gender + '</td>';
		 sTbodyHtml += '  <td class="text-center">' + filteredData[i].zipcode + '</td>';
		 sTbodyHtml += '  <td class="text-center">' + filteredData[i].addr1 + '</td>';
		 sTbodyHtml += '  <td class="text-center">' + filteredData[i].addr2 + '</td>';
		 
		 sTbodyHtml += '  <td class="text-center" style="background-color: lightyellow;">' + filteredData[i].grade + '</td>'; 
		 sTbodyHtml += '  <td class="text-center"> <a type="button" class="btn btn-warning btn-sm" href="update_user.jsp?user_id=' + filteredData[i].user_id + '">수정</a> </td>';
		 sTbodyHtml += '  <td class="text-center"> <a type="button" class="btn btn-outline-danger btn-sm" href="delete_user.jsp?user_id=' + filteredData[i].user_id + '">삭제</a> </td> ';   
		 sTbodyHtml += '</tr>';
	}
	$('#tblTodo>tbody').append(sTbodyHtml);
}

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



//지정 날짜로 정보를 조회
function searching(){
	var firstDate = document.getElementById("firstDate").value;
	var lastDate = document.getElementById("lastDate").value; 
	const selectElement = document.getElementById('searchGrade');
	const selectedIndex = selectElement.selectedIndex;
	const searchGrade = selectElement.options[selectedIndex].value;
	 
	//console.log(searchType); // 선택된 옵션의 값 출력
	
	location.href="userListAjax.jsp?firstDate=" + firstDate + "&lastDate=" + lastDate + "&searchGrade=" + searchGrade; 
}

</script>
<!-- 날짜 달력 -->
<link rel="stylesheet" href="//code.jquery.com/ui/1.13.2/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
<script>
$(document).ready(function(){
		$("#firstDate, #lastDate").datepicker({
			changeMonth:true,
			changeYear:true,
			dateFormat:"yy-mm-dd",
			prevText:"이전 달",
			nextText:"다음 달",
			monthNames:['1월','2월','3월','4월',
						'5월','6월','7월','8월',
						'9월','10월','11월','12월'
				       ],
			monthNamesShort:['1월','2월','3월','4월',
							'5월','6월','7월','8월',
							'9월','10월','11월','12월'
					       ],
			dayNames:['일','월','화','수','목','금','토'],
			dayNamesShort:['일','월','화','수','목','금','토'],
			dayNamesMin:['일','월','화','수','목','금','토'],
			showMonthAfterYear:true,
			yearSuffix:'년'
		});
	});
</script> 
</head>
<body>
<!-- 관리자 모드 -->
 
<%@ include file="/top.jsp" %>

<div style="min-height: 700px;">
	<div class="container-float mt-4 mb-4 p-5 text-black">
		<div class="container text-center">
			<h1>회원 목록</h1>
		</div>
	</div>
 
	<div class="container input-group text-center">
		<input type="button" class="btn btn-secondary mb-3" value="신규 회원 등록" onclick="location.href='insert_user.jsp'">
		<div class="input-group-prepend mb-3"> 
			<form action="#" method="post">
			<span class="input-group-text col-sm-1" id="inputGroup-sizing-default" name="searchDate"  style="margin-left:10px; float:left;">조회 기간</span> 
			<input type="text" aria-label="First date" id="firstDate" name="firstDate"  class="form-control Date input-group-append col-sm-2" placeholder="시작일" style="float:left;" required>
			<input type="text" aria-label="Last date" id="lastDate" name="lastDate"  class="form-control Date col-sm-2" placeholder="종료일" style="float:left;" required> 
			
			<div class="" style="float:right;">
			  <select class="custom-select col-sm-5" name="searchGrade" id="searchGrade" aria-label="Example select with button addon" style="margin-left:10px; ">
			    <option selected value="all">모든 등급: -------------</option>
			    <option value="1" >1</option>
			    <option value="2" >2</option>
			    <option value="3" >3</option>
			    <option value="4" >4</option>
			    <option value="5" >5</option>
			    <option value="6" >6</option>
			    <option value="7" >7</option>
			    <option value="8" >8</option>
			    <option value="9" >9</option>
			    <option value="10" >10</option>  
			  </select> 
			    <input class="btn btn-outline-secondary" type="button" onclick="searching();" value="검색">
			</div>
			  </form>
 
			  <div class="" style="float:left;" >
			    <button class="btn btn-outline-danger" type="button"  style="margin-left:10px;" onclick="location.href='userChart.jsp'">차트 조회</button>
			  </div>
  			</div> 
		 </div>
 


<!-- ajax 페이징 처리 테이블 -->
<div class="container col-9 input-group p-5 text-center">
	<div class="app container" style="min-height:1000px;">
		<table id="tblTodo" class="table table-hover table-sm table-bordered"> 
			<thead class="table-active">
				<tr class="tbl2">
					<th class="text-center">아이디</th><!-- 
					<th class="text-center">비밀번호</th> -->
					<th class="text-center">이름</th>
					<th class="text-center">생일</th>
					<th class="text-center">연락처</th>
					<th class="text-center">이메일</th>
					<th class="text-center">성별</th>
					<th class="text-center">우편번호</th>
					<th class="text-center">도로명주소</th>
					<th class="text-center">상세주소</th>
					<th class="text-center">회원 등급</th><!-- 
					<th class="text-center">등록일자</th>
					<th class="text-center">수정일자</th> -->
					<th class="text-center" colspan="2">편집</th>
				</tr>
			</thead>
			<tbody></tbody>
		</table>
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

			    
<%@ include file="/footer.jsp"%> 
</body>
</html>