<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/dbc_notsql.jsp" %>
<!DOCTYPE html>
<html>
<head>
<title>구글 차트  </title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!-- 제이쿼리 -->
<script src="http://code.jquery.com/jquery-latest.min.js"></script>

<!-- 구글차트 관련 설정 -->
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
<script>
	google.charts.load('current', {packages:['corechart']});
</script> 

<script type="text/javascript">

	var queryObject = "";
	var queryObjectLen = "";
 
	$.ajax({
		type : 'post', /* 전송방식 */
		url : 'getData.jsp', /* 데이터를 가져올 위치 */
		dataType : 'json', /* 가져올 데이터 형태 */
		//성공시
		success : function(data) {
			/* 리턴된 json형태 데이터를 문자열로 변환 처리 */
			queryObject = eval('(' + JSON.stringify(data) + ')');
			queryObjectLen = queryObject.orderdetails.length;
		},
		//실패시
		error : function(xhr, type) {
			alert('server error occoured')
		}
	});

	
	
	google.charts.setOnLoadCallback(drawChart);

	//챠트 그리기 함수
	function drawChart() {
		
		var data = new google.visualization.DataTable();

		//전달된 속성값을 차트 컬럼으로 지정
		data.addColumn('string', 'pd_name'); 
		data.addColumn('number', 'od_qty'); 

		/* json 데이터를 가져온다. */
		for (var i=0;i<queryObjectLen;i++) {
			
			var pd_name = queryObject.orderdetails[i].pd_name; 
			var od_qty = queryObject.orderdetails[i].od_qty; 
			
			//JSON 형태의 데이터를 구글 차트에 추가
			data.addRows([[pd_name,od_qty]]);
		}

 
		//챠트 출력시 옵션 지정
		var options = {
			title : '판매 현황',
			colors: ['blue', 'red','#A5DF00', 'orange', 'blue', 'navy', 'purple'], // 항목 갯수에 맞게 컬러 설정
			fontSize: 20,
			/* is3D: true,//3d로 출력 */
			pieHole: 0.4,
			width : 700,
			height : 400,
			bar : { groupWidth : '50%' }, // 그래프 너비 %
			curveType: 'function',	// 부드러운 곡선
		    legend: { position: 'bottom' },//범례를 아래쪽에 표시
		    /* 가로범례 */
		    hAxis: {
				textStyle: {
					color: 'red',
					fontSize: 15,
					fontName: '맑은고딕',
					bold: true,
					italic: true
				},
			},
			vAxis: {
				textStyle: {
					color: 'black',
					fontSize: 15,
					bold: true
				}
			},
		};
		
		var options2 = {
				title : '판매 현황',
				colors: ['#5F04B4', 'red','#A5DF00', 'orange', 'blue', 'navy', 'purple'], // 항목 갯수에 맞게 컬러 설정
				fontSize: 20,
				is3D: true,//3d로 출력 */
				width : 700,
				height : 400,
				bar : { groupWidth : '50%' }, // 그래프 너비 %
				curveType: 'function',	// 부드러운 곡선
			    legend: { position: 'bottom' },//범례를 아래쪽에 표시
			    hAxis: {
					textStyle: {
						color: '#000000',
						fontSize: 15,
						fontName: '맑은고딕',
						bold: true,
						italic: true
					},
				},
				vAxis: {
					textStyle: {
						color: '#FE2E2E',
						fontSize: 15,
						bold: true
					}
				},
			};
	
		//챠트모양1
		var chart1 = new google.visualization.LineChart(document.getElementById('chart_div'));
		chart1.draw(data, options);
		
		//챠트모양2
		var chart2 = new google.visualization.ColumnChart(document.getElementById('chart_div2'));
		chart2.draw(data, options);
		
		//챠트모양3
		var chart3 = new google.visualization.PieChart(document.getElementById('chart_div3'));
		chart3.draw(data, options);
		
		//차트모양4
		var chart4 = new google.visualization.ScatterChart(document.getElementById('chart_div4'));
		chart4.draw(data, options);

		//차트모양5
		var chart5 = new google.visualization.PieChart(document.getElementById('chart_div5'));
		chart5.draw(data, options2);
		
		
		//차트모양6
		var chart6 = new google.visualization.BarChart(document.getElementById('chart_div6'));
		chart6.draw(data, options2);
		
		
	}
</script>

<style>
	.d1,.d2,.d3 {
		display: flex;
	}
</style>
</head>
<body>



	<!-- 챠트 모양을 출력할 영역 -->
	<div class="d1">
		<div id="chart_div" style="width: 600px; height: 600px;"></div>
		<div id="chart_div2" style="width: 600px; height: 600px;"></div>
	</div>
	<div class="d2">
		<div id="chart_div3" style="width: 600px; height: 600px;"></div>
		<div id="chart_div4" style="width: 600px; height: 600px;"></div>
	</div>
	<div class="d3">
		<div id="chart_div5" style="width: 600px; height: 600px;"></div>
		<div id="chart_div6" style="width: 600px; height: 600px;"></div>
	</div>
</body>
</html>