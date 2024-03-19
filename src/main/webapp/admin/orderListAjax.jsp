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
.tbl > th {
	min-width: 150px;
} 
</style>
<%

String searchType = request.getParameter("searchType");
String firstDate = request.getParameter("firstDate");
String lastDate = request.getParameter("lastDate");
String od_id = null; 
 
if (firstDate == null){
	firstDate = "";
}
if (lastDate == null){
	lastDate = "";
} 
if (searchType == null){
	searchType = "all";
}

if(request.getParameter("od_id") != null){
	od_id = request.getParameter("od_id");  
}  

System.out.println("주문번호 정렬 순서: " + od_id);
System.out.println("시작일: " + firstDate);
System.out.println("종료일: " + lastDate);
System.out.println("배송단계:  " + searchType);

%>
<script>


let todoData = [];

var od_id = "<%=od_id%>";
var searchType = "<%=searchType%>";
var firstDate = "<%=firstDate%>";
var lastDate = "<%=lastDate%>";

let todosUrl = null;

const countPerPage = 10; // 페이지당 데이터 건수
const showPageCnt = 5; // 화면에 보일 페이지 번호 개수
 
$(document).ready(function() {
	 if (od_id == "null" || od_id == null) {
		//날짜를 지정했을 때
		if(firstDate != ""){ 
			todosUrl = 'getData_oL.jsp?firstDate=' + firstDate + '&lastDate=' + lastDate + '&searchType=' + searchType;  
		} else {
			todosUrl = 'getData_oL.jsp'; 
		}  
	} else {
		todosUrl = 'getData_oL.jsp?od_id=' + od_id;
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
		 sTbodyHtml += '  <td class="text-center">' + filteredData[i].od_id + '</td>';
		 sTbodyHtml += '  <td class="text-center">' + filteredData[i].user_id + '</td>';
		 sTbodyHtml += '  <td class="text-center">' + filteredData[i].pd_name + '</td>';
		 sTbodyHtml += '  <td class="text-center">' + filteredData[i].od_qty + '</td>';
		 sTbodyHtml += '  <td class="text-center">' + filteredData[i].od_price + '</td>';
		    
		 sTbodyHtml += '  <td class="text-center" style="background-color: lightyellow;">' + filteredData[i].status + '</td>'; 
		 sTbodyHtml += '  <td class="text-center">' + filteredData[i].od_createtime + '</td>'; 
		 sTbodyHtml += '  <td class="text-center">' + filteredData[i].od_updatetime + '</td>';  
		 sTbodyHtml += '  <td class="text-center"> <a type="button" class="btn btn-warning btn-sm" href="update_order_detail.jsp?od_id=' + filteredData[i].od_id + '&pd_no=' + filteredData[i].pd_no + '">수정</a> </td>';
		 sTbodyHtml += '  <td class="text-center"> <a type="button" class="btn btn-outline-danger btn-sm" href="delete_order.jsp?od_id=' + filteredData[i].od_id + '&pd_no=' + filteredData[i].pd_no + '">삭제</a> </td> ';  
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
	const selectElement = document.getElementById('searchType');
	const selectedIndex = selectElement.selectedIndex;
	const searchType = selectElement.options[selectedIndex].value;
	 
	//console.log(searchType); // 선택된 옵션의 값 출력
	
	location.href="orderListAjax.jsp?firstDate=" + firstDate + "&lastDate=" + lastDate + "&searchType=" + searchType; 
}



</script>
<link rel="stylesheet" href="//code.jquery.com/ui/1.13.2/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
<style type="text/css">
	.orderListDiv {
		min-height: 700px;
		margin-bottom: 100px;
	}
</style>
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
<%@ include file="/top.jsp" %>

	<div class="container-float mt-4 mb-4 p-5 text-black">
		<div class="container text-center">
			<h1>주문서 현황</h1>
		</div>
	</div>
	

		<div class="container input-group text-center">  
		<div class="input-group-prepend mb-3"> 
			<form action="orderList_process.jsp" method="post">
			<span class="input-group-text col-sm-1" id="inputGroup-sizing-default" name="searchDate"  style="margin-left:10px; float:left;">조회 기간</span> 
			<input type="text" aria-label="First date" id="firstDate" name="firstDate"  class="form-control Date input-group-append col-sm-2" placeholder="시작일" style="float:left;" required> 
			<input type="text" aria-label="Last date" id="lastDate" name="lastDate"  class="form-control Date col-sm-2" placeholder="종료일" style="float:left;" required> 
			
			<div class="col-auto" style="float:left;">
			  <select class="custom-select col-sm-5" name="searchType" id="searchType" aria-label="shipping process level" style="margin-left:10px;">
			    <option selected value="all">배송 단계: -------------</option>
			    <option value="0" >주문 완료</option>
			    <option value="1" >결제 완료</option>
			    <option value="2" >상품준비중</option>
			    <option value="3" >배송준비중</option>
			    <option value="4" >배송 중</option>
			    <option value="5" >배송 완료</option>
			    <option value="6" >취소 완료</option>
			    <option value="7" >반품 신청</option> 
			    <option value="8" >반품 완료</option>
			    <option value="9" >환불 신청</option>
			    <option value="10" >환불 완료</option> 
			  </select> 
			    <input class="btn btn-outline-secondary" type="button" onclick="searching();" value="검색">
			</div>
			  </form> 
			  
			  <div class="col-auto" style="float:left;" >
			  	<!--
			    <button class="btn btn-outline-info" type="button"  style="margin-left:10px;" onclick="location.href='orderList_odIdGroup.jsp'">주문일자 별로 보기</button> 
			    <button class="btn btn-outline-info" type="button"  style="margin-left:10px;" onclick="location.href='orderList.jsp'">주문번호 별로 보기</button>
			    <button class="btn btn-outline-info" type="button"  style="margin-left:10px;" onclick="location.href='orderList_detail.jsp'">개별 주문보기</button> -->
			  </div> 
  		</div> 
 </div>

			 

<!-- ajax 페이징 처리 테이블 -->
<div class="container col-9 input-group p-5 text-center">
	<div class="app" style="min-height:600px;">
		<table id="tblTodo" class="table table-hover table-sm table-bordered"> 
			<thead class="table-active">
				<tr class="tbl">
					<th class="text-center">주문번호
						<a href="/admin/orderListAjax.jsp?od_id=desc">
						<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-caret-up-square" viewBox="0 0 16 16">
						  <path d="M14 1a1 1 0 0 1 1 1v12a1 1 0 0 1-1 1H2a1 1 0 0 1-1-1V2a1 1 0 0 1 1-1zM2 0a2 2 0 0 0-2 2v12a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V2a2 2 0 0 0-2-2z"/>
						  <path d="M3.544 10.705A.5.5 0 0 0 4 11h8a.5.5 0 0 0 .374-.832l-4-4.5a.5.5 0 0 0-.748 0l-4 4.5a.5.5 0 0 0-.082.537"/>
						</svg>
						</a>
						<a href="/admin/orderListAjax.jsp?od_id=asc">
						<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-caret-down-square" viewBox="0 0 16 16">
						  <path d="M3.626 6.832A.5.5 0 0 1 4 6h8a.5.5 0 0 1 .374.832l-4 4.5a.5.5 0 0 1-.748 0z"/>
						  <path d="M0 2a2 2 0 0 1 2-2h12a2 2 0 0 1 2 2v12a2 2 0 0 1-2 2H2a2 2 0 0 1-2-2zm15 0a1 1 0 0 0-1-1H2a1 1 0 0 0-1 1v12a1 1 0 0 0 1 1h12a1 1 0 0 0 1-1z"/>
						</svg></a> </th>  
					<th class="text-center">유저 아이디</th>
					<th class="text-center">품목</th>
					<th class="text-center">품목 개수</th>
					<th class="text-center">결제 금액</th>
					<th class="text-center">배송 상태</th>
					<th class="text-center">주문일자</th> 
					<th class="text-center">수정일자</th> 
					<th class="text-center" colspan="2">비고</th>
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



<%@ include file="/footer.jsp"%>
</body>
</html>