<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/header.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>My Order List</title>
<!-- ajax pagination -->
<script src="https://code.jquery.com/jquery-latest.min.js"></script>
<script src="https://unpkg.com/axios/dist/axios.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/lodash@4.17.11/lodash.min.js"></script>
<link rel="stylesheet"	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.0/css/all.min.css">
 
<script>


let todoData = [];

const countPerPage = 10; // 페이지당 데이터 건수
const showPageCnt = 5; // 화면에 보일 페이지 번호 개수

$(document).ready(function() {
const todosUrl = 'getData_userOrder.jsp'; 


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
		 sTbodyHtml += '  <td class="center">' + filteredData[i].od_id + '</td>';   
		 sTbodyHtml += '  <td class="center"> <img style="width: 100px; height: 100px;" src="/fntimg/' + filteredData[i].pd_img + '"> </td>'; 
		 sTbodyHtml += '  <td class="center">' + filteredData[i].pd_name + '</td>'; 
		 sTbodyHtml += '  <td>' + filteredData[i].od_qty + '</td>';
		 sTbodyHtml += '  <td>' + filteredData[i].od_price + '</td>';
		 sTbodyHtml += '  <td class="center" style="background-color: lightyellow;">' + filteredData[i].status + '</td>';
		 sTbodyHtml += '  <td>' + filteredData[i].od_createtime + '</td>';   
		 sTbodyHtml += '  <td>' + filteredData[i].sh_date + '</td>';   
		 sTbodyHtml += '  <td>' + filteredData[i].sh_zipcode + '<br>' + filteredData[i].sh_addr1 + '<br>' + filteredData[i].sh_addr2 + '</td>';
		 if(filteredData[i].od_status > 4){
		 	sTbodyHtml += '  <td class="text-center"> <a type="button" class="btn btn-info btn-sm" href="/ReviewWriteForm.rdo?pd_no=' + filteredData[i].pd_no + '">리뷰 쓰기</a> '; 
		 } else {
			sTbodyHtml += '  <td class="text-center">';
		 }
		 sTbodyHtml += ' <a type="button" class="btn btn-success btn-sm" href="/user/userOrder_detail.jsp?od_id=' + filteredData[i].od_id + '">운송장 조회</a> </td>';
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

</script>
<link rel="stylesheet" href="//code.jquery.com/ui/1.13.2/themes/base/jquery-ui.css"> <!-- ajax 보다 아래에 위치해야 함  -->
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
 
<style type="text/css">
.myPageDiv {
	min-height: 800px;
}  
</style> 
</head>
<body>
<%@ include file="/top.jsp" %> 
<div class="myPageDiv col-9 container-fluid p-5"> 
	
	
	<div class="bg-body-tertiary">
		<div class="container-fluid py-5">
			<h1 class=" fw-bold text-center">나의 주문내역</h1> 
		</div>
	</div>		
	
	
	<div class="container mb-3"> 
		<form action="userOrder_process.jsp" method="post" class="mb-3">
			<span class="input-group-text col-auto" id="inputGroup-sizing-default" name="searchDate"  style="float:left;">조회 기간</span> 
			<input type="text" aria-label="First date" id="firstDate" name="firstDate"  class="form-control Date input-group-append col-sm-2" placeholder="시작일" style="float:left;" required>
			<input type="text" aria-label="Last date" id="lastDate" name="lastDate"  class="form-control Date col-sm-2" placeholder="종료일" style="float:left;" required> 
			<button class="btn btn-outline-info" type="submit">최신순 검색</button> 
		</form>  
		<form action="/user/userOrder_detail.jsp"  method="post" class="mb-3" style="float:left;">
			<span class="input-group-text col-auto" id="inputGroup-sizing-default" style=" float:left;">운송장 정보 </span> 
			<input type="text" id="od_id" name="od_id" class="form-control Date input-group-append col-sm-6" placeholder="나의 주문번호 검색" style="float:left;" required>
			<button class="btn btn-outline-danger" type="submit" style="float:left;">자세히보기</button> 
		</form>
	</div>
	 
	<div class="container text-center app text-center">
		<table class="table table-hover table-sm table-bordered text-center" id="tblTodo"> 
			<thead class="thead-light">
			<tr>
				<th>주문번호</th>
				<th>품목</th> 
				<th>품목정보</th>
				<th>수량</th>
				<th>주문비</th>
				<th>배송상태</th>
				<th>주문일자</th> 
				<th>배송 예정일자</th>
				<th>운송장 정보</th>
				<th>비고</th>
			</tr> 
			</thead> 
			<tbody></tbody>
		</table>  
		



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

<%@ include file="/footer.jsp" %>
</body>
</html>