<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%> 
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
</style>
<script>


let todoData = [];

const countPerPage = 10; // 페이지당 데이터 건수
const showPageCnt = 5; // 화면에 보일 페이지 번호 개수
 
$(document).ready(function() {
const todosUrl = 'getData_pL2.jsp'; 
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

$(document).on('click', 'div.paging>div.pages>span', function() {
 if (!$(this).hasClass('active')) {
   $(this).parent().find('span.active').removeClass('active');
   $(this).addClass('active');

   setTable(Number($(this).text()));
 }
});

$(document).on('click', 'div.paging>i', function() {
 const totalPage = Math.floor(todoData.length / countPerPage) + (todoData.length % countPerPage == 0 ? 0 : 1);
 const id = $(this).attr('id');
 console.log(id);

 if (id == 'first_page') {
   setTable(1);
   setPaging(1);
 } else if (id == 'prev_page') {
   let arrPages = [];
   $('div.paging>div.pages>span').each(function(idx, item) {
     arrPages.push(Number($(this).text()));
   });
   
   const prevPage = _.min(arrPages) - showPageCnt;
   setTable(prevPage);
   setPaging(prevPage);
 } else if (id == 'next_page') {
   let arrPages = [];
   $('div.paging>div.pages>span').each(function(idx, item) {
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
		 sTbodyHtml += '  <td class="center">' + filteredData[i].pd_no + '</td>';
		 sTbodyHtml += '  <td class="center">' + filteredData[i].pd_name + '</td>';
		 sTbodyHtml += '  <td class="center">' + filteredData[i].category_name + '</td>';
		 sTbodyHtml += '  <td class="center">' + filteredData[i].color_name + '</td>';
		 sTbodyHtml += '  <td class="center">' + filteredData[i].room_name + '</td>';
		  
		 sTbodyHtml += '  <td class="center">' + filteredData[i].pd_size + '</td>'; 
		 sTbodyHtml += '  <td class="center">' + filteredData[i].pd_price + '</td>';
		 sTbodyHtml += '  <td class="center" style="background-color: lightyellow;">' + filteredData[i].pd_stock + '</td>';
		 sTbodyHtml += '  <td class="center">' + filteredData[i].pd_saleprice + '</td>';
		 sTbodyHtml += '  <td class="center"> <img style="width: 100px; height: 100px;" src="/fntimg/' + filteredData[i].pd_img + '"> </td>';
		 
		 sTbodyHtml += '  <td class="text-center">' + filteredData[i].pd_createtime + '</td>'; 
		 sTbodyHtml += '  <td class="text-center">' + filteredData[i].pd_updatetime + '</td>'; 
		 sTbodyHtml += '  <td class="text-center"> <a type="button" class="btn btn-warning btn-sm" href=' + '"update_product.jsp?pd_no="' + filteredData[i].pd_no + '>수정</a> </td>';
		 sTbodyHtml += '  <td class="text-center"> <input type="button" class="btn btn-outline-danger btn-sm" value="삭제" onclick="location.href=' + 'delete_product.jsp?pd_no=' + filteredData[i].pd_no + '"> </td> ';  
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
	 sPagesHtml += '<span class="' + (start == currentPage ? 'active' : '') + '">' + start + '</span>';
	}
	
	$('div.paging>div.pages').html(sPagesHtml);
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
<!-- 관리자 모드 -->

	<div class="top">
		<%@ include file="/top.jsp" %>
	</div>
<%-- 
	<%@ include file="/dbc_notsql.jsp" %> --%>
	
	<div class="container-float mt-4 mb-4 p-5 text-black">
		<div class="container text-center">
			<h1>품목 상세</h1>
		</div>
	</div>
	
	
	<% 
	
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	String sql = null; 
	String pd_stock = "null";
	
	String searchType = request.getParameter("searchType");
	String firstDate = request.getParameter("firstDate");
	String lastDate = request.getParameter("lastDate");
	
	if(request.getParameter("pd_stock") != null){
		pd_stock = request.getParameter("pd_stock");  
	} 
	
	System.out.println("searchType: " + searchType);
	System.out.println("firstDate: " + firstDate);
	System.out.println("lastDate:  " + lastDate); 
	System.out.println("pd_stock:  " + pd_stock); 

	%>
	
	<div class="container input-group text-center">
		<input type="button" class="btn btn-secondary mb-3" value="새로운 품목 추가" onclick="location.href='insert_product.jsp'">
		<div class="input-group-prepend mb-3"> 
			<form action="productListAjax.jsp" method="post">
			<span class="input-group-text col-sm-1" id="inputGroup-sizing-default" style="margin-left:10px; float:left;">조회 기간</span> 
			<input type="text" aria-label="First date" class="form-control Date input-group-append col-sm-2" value="<%=firstDate %>" readonly style="float:left;">
			 
			<input type="text" aria-label="Last date" class="form-control Date col-sm-2" value="<%=lastDate %>" readonly style="float:left;"> 
			
			<div class="" style="float:right;">
			  <select class="custom-select col-sm-5" name="searchType" id="searchType" aria-label="Example select with button addon" style="margin-left:10px;">
			    <option selected value="all" readonly><%=searchType %></option>
			    <option value="1" >수납 정리</option>
			    <option value="2" >의자</option>
			    <option value="3" >침대</option>
			    <option value="4" >주방</option>
			    <option value="5" >욕실</option>
			    <option value="6" >식물</option>
			    <option value="7" >아웃도어</option> 
			  </select> 
			    <button class="btn btn-outline-info" type="submit">검색 초기화</button> 
			</div>
			  </form>

  		</div> 
 	</div>
 


<!-- ajax 페이징 처리 테이블 -->
<div class="container col-9 input-group p-5" style="min-height:700px;">
	<div class="app">
		<table id="tblTodo" class="table table-hover table-sm table-bordered"> 
			<thead class="table-active">
				<tr>
					<th class="text-center">등록번호</th>
					<th class="text-center">품목명</th>
					<th class="text-center">종류</th>
					<th class="text-center">색상</th>
					<th class="text-center">위치</th>
					
					<th class="text-center">크기</th>
					<th class="text-center">기존가</th>
					<th class="text-center">재고 수
						<a href="/admin/productListAjax_process.jsp?pd_stock=desc">
						<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-caret-up-square" viewBox="0 0 16 16">
						  <path d="M14 1a1 1 0 0 1 1 1v12a1 1 0 0 1-1 1H2a1 1 0 0 1-1-1V2a1 1 0 0 1 1-1zM2 0a2 2 0 0 0-2 2v12a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V2a2 2 0 0 0-2-2z"/>
						  <path d="M3.544 10.705A.5.5 0 0 0 4 11h8a.5.5 0 0 0 .374-.832l-4-4.5a.5.5 0 0 0-.748 0l-4 4.5a.5.5 0 0 0-.082.537"/>
						</svg>
						</a>
						<a href="/admin/productListAjax_process.jsp?pd_stock=asc">
						<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-caret-down-square" viewBox="0 0 16 16">
						  <path d="M3.626 6.832A.5.5 0 0 1 4 6h8a.5.5 0 0 1 .374.832l-4 4.5a.5.5 0 0 1-.748 0z"/>
						  <path d="M0 2a2 2 0 0 1 2-2h12a2 2 0 0 1 2 2v12a2 2 0 0 1-2 2H2a2 2 0 0 1-2-2zm15 0a1 1 0 0 0-1-1H2a1 1 0 0 0-1 1v12a1 1 0 0 0 1 1h12a1 1 0 0 0 1-1z"/>
						</svg></a></th>
					<th class="text-center">할인가</th>
					<th class="text-center">이미지</th>
					
					<th class="text-center">등록일자</th>
					<th class="text-center">수정일자</th>
					<th class="text-center" colspan="2">편집</th>
				</tr>
			</thead>
			<tbody></tbody>
		</table>
</div>
		<div class="paging p-5">
			<i class="fa-solid fa-angles-left" id="first_page"></i> 
			<i class="fa-solid fa-angle-left" id="prev_page"></i>
			<div class="pages" style="font-size: 30px;">
				<span class="active">1</span> <span>2</span> <span>3</span> <span>4</span>
				<span>5</span>
			</div>
			<i class="fa-solid fa-angle-right" id="next_page"></i> 
			<i class="fa-solid fa-angles-right" id="last_page"></i>
		</div>
	</div>
 
 
 
<%@ include file="/footer.jsp"%>
 
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
</body>
</html>