<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file = "setting.jsp" %>
<html>
<script type="text/javascript" src = "https://www.gstatic.com/charts/loader.js"></script>
<script>
	google.charts.load('current', {packages:['corechart']});
</script>
<body>
<c:set var="a" value = "300"/>
<c:set var="s" value = "500"/>
<c:set var="d" value = "400"/>
	<div style = "display: -webkit-box;">
	<div id = "firstChat"></div>
	<div id = "secondChat"></div>
	</div>
<script type="text/javascript">
	google.charts.setOnLoadCallback(drawChartFirst);
	google.charts.setOnLoadCallback(drawChartSecond);
	
	var firstChart_options = {
			title: '구매수량은 나의 것',
			width : 600,
			height : 400,
			bar : {
				groupWidth : '50%'
			},
			legend : {
				position : 'bottom'
			}
	}
	
	function drawChartFirst() {
		var data = google.visualization.arrayToDataTable([
			['Element', '도서별'],
			['사람', ${a}],
			['돼지', ${s}],
			['아하', ${d}],
		]);
		
		var firstChart = new google.visualization.ColumnChart(document.getElementById('firstChat'));
		firstChart.draw(data, firstChart_options);
	}
	
	var secondChart_options = {
		title : '구매비율',
		width : 600,
		height : 400,
		bar : {
			groupWidth : '100%'
		},
		series: {
			0: {color:'#ccc'},
			1: {color: '#c784de'}
		}
	}
	
	function drawChartSecond(){
		var data = google.visualization.arrayToDataTable([
			['Element', '성별'],
			['남자', 500],
			['여자', 300],
		]);
		
		var secondChart = new google.visualization.PieChart(document.getElementById('secondChat'));
		secondChart.draw(data, secondChart_options);
	}
</script>
</body>
</html>