<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file = "setting.jsp" %>
<link type = "text/css" rel = "stylesheet" href = "${project}cssall/h_ordertotal.css"/>
<html>
<script type="text/javascript" src = "https://www.gstatic.com/charts/loader.js"></script>
<script>
	google.charts.load('current', {packages:['corechart']});
</script>
<body>
<%@ include file = "topmenu.jsp" %>

<section>
	<table id = "middle">
		<col style = "width:15%;">
		<col>
		<tr>
			<%@ include file = "h_clicktotalLeft.jsp" %>
			<td id = "tabright">
				<div id = "righttop">
					<p><b>주문 통계</b></p>
				</div>
				<table id = "searchifs">
					<col style = "width:15%;">
					<col>
					<tr>
						<td>기간검색</td>
			     		<td>
			     		<select id = "year" name = "yearname" style = "padding:2px; vertical-align:middle;">
							<option value = "2025">2025년</option>
							<option value = "2024">2024년</option>
							<option value = "2023">2023년</option>
							<option value = "2022">2022년</option>
							<option value = "2021">2021년</option>
						</select>
			     		</td>
			     	</tr>
				</table>
				
				<p id = "srhbtnp"><input type = "button" value = "검색" id = "srhbtn"></p>
				
				<div id = "monthresult">
					<table id = "clicklist">
				    	<col style = "width:33%;">
				    	<col style = "width:33%;">
				    	<col style = "width:34%;">
				    	<tr id = "title">
				    		<td>총 구매자수</td>
				    		<td>총 구매건수</td>
				    		<td>총 판매금액</td>
				    	</tr>
				    	<tr class = "click">
				    		<td>${omtotal[12]}</td>
				    		<td>${octotal[12]}</td>
				    		<td>${optotal[12]}</td>
				    	</tr>
				    </table>
					<table id = "subtop">
						<tr>
							<td>
							<b>·월별 접속자 현황</b>
							</td>
						</tr>
					</table>
					
					<c:set var="click1" value = "${omtotal[0]}"/>
				    <c:set var="click2" value = "${omtotal[1]}"/>
				    <c:set var="click3" value = "${omtotal[2]}"/>
				    <c:set var="click4" value = "${omtotal[3]}"/>
				    <c:set var="click5" value = "${omtotal[4]}"/>
				    <c:set var="click6" value = "${omtotal[5]}"/>
				    <c:set var="click7" value = "${omtotal[6]}"/>
				    <c:set var="click8" value = "${omtotal[7]}"/>
				    <c:set var="click9" value = "${omtotal[8]}"/>
				    <c:set var="click10" value = "${omtotal[9]}"/>
				    <c:set var="click11" value = "${omtotal[10]}"/>
				    <c:set var="click12" value = "${omtotal[11]}"/>
					<div style = "display: -webkit-box;">
						<table style = "margin:0 auto;">
							<tr>
								<td id = "firstChat"></td>
								<td id = "secondChat"></td>
								<td id = "thirdChat"></td>
							</tr>
						</table>
					</div>
					
					
					<table id = "clicklist">
				    	<col style = "width:25%;">
				    	<col style = "width:25%;">
				    	<col style = "width:25%;">
				    	<col style = "width:25%;">
				    	<tr id = "title">
				    		<td>월별</td>
				    		<td>구매자수</td>
				    		<td>구매건수</td>
				    		<td>판매금액</td>
				    	</tr>
				    	<tr class = "click">
				    		<td>01월</td>
				    		<td>${omtotal[0]}</td>
				    		<td>${octotal[0]}</td>
				    		<td>${optotal[0]}</td>
				    	</tr>
				    	<tr class = "click">
				    		<td>02월</td>
				    		<td>${omtotal[1]}</td>
				    		<td>${octotal[1]}</td>
				    		<td>${optotal[1]}</td>
				    	</tr>
				    	<tr class = "click">
				    		<td>03월</td>
				    		<td>${omtotal[2]}</td>
				    		<td>${octotal[2]}</td>
				    		<td>${optotal[2]}</td>
				    	</tr>
				    	<tr class = "click">
				    		<td>04월</td>
				    		<td>${omtotal[3]}</td>
				    		<td>${octotal[3]}</td>
				    		<td>${optotal[3]}</td>
				    	</tr>
				    	<tr class = "click">
				    		<td>05월</td>
				    		<td>${omtotal[4]}</td>
				    		<td>${octotal[4]}</td>
				    		<td>${optotal[4]}</td>
				    	</tr>
				    	<tr class = "click">
				    		<td>06월</td>
				    		<td>${omtotal[5]}</td>
				    		<td>${octotal[5]}</td>
				    		<td>${optotal[5]}</td>
				    	</tr>
				    	<tr class = "click">
				    		<td>07월</td>
				    		<td>${omtotal[6]}</td>
				    		<td>${octotal[6]}</td>
				    		<td>${optotal[6]}</td>
				    	</tr>
				    	<tr class = "click">
				    		<td>08월</td>
				    		<td>${omtotal[7]}</td>
				    		<td>${octotal[7]}</td>
				    		<td>${optotal[7]}</td>
				    	</tr>
				    	<tr class = "click">
				    		<td>09월</td>
				    		<td>${omtotal[8]}</td>
				    		<td>${octotal[8]}</td>
				    		<td>${optotal[8]}</td>
				    	</tr>
				    	<tr class = "click">
				    		<td>10월</td>
				    		<td>${omtotal[9]}</td>
				    		<td>${octotal[9]}</td>
				    		<td>${optotal[9]}</td>
				    	</tr>
				    	<tr class = "click">
				    		<td>11월</td>
				    		<td>${omtotal[10]}</td>
				    		<td>${octotal[10]}</td>
				    		<td>${optotal[10]}</td>
				    	</tr>
				    	<tr class = "click">
				    		<td>12월</td>
				    		<td>${omtotal[11]}</td>
				    		<td>${octotal[11]}</td>
				    		<td>${optotal[11]}</td>
				    	</tr>
				    	<tr class = "click" id = "foot">
				    		<td>합계</td>
				    		<td>${omtotal[12]}</td>
				    		<td>${octotal[12]}</td>
				    		<td>${optotal[12]}</td>
				    	</tr>
				    </table>
				</div>
			</td>
		</tr>
	</table>
</section>
<script type="text/javascript">
	google.charts.setOnLoadCallback(drawChartFirst);
	google.charts.setOnLoadCallback(drawChartSecond);
	google.charts.setOnLoadCallback(drawChartThird);
	
	var firstChart_options = {
			title: '월별 방문자 분석',
			width : 416,
			height : 400,
			bar : {
				groupWidth : '50%'
			},
			series: {
				0: {color:'#ccc'},
				1: {color: '#c784de'}
			}
	}
	
	function drawChartFirst() {
		var data = google.visualization.arrayToDataTable([
			['Element', '방문자 수'],
			['1월', ${click1}],
			['2월', ${click2}],
			['3월', ${click3}],
			['4월', ${click4}],
			['5월', ${click5}],
			['6월', ${click6}],
			['7월', ${click7}],
			['8월', ${click8}],
			['9월', ${click9}],
			['10월', ${click10}],
			['11월', ${click11}],
			['12월', ${click12}],
		]);
		
		var firstChart = new google.visualization.PieChart(document.getElementById('firstChat'));
		firstChart.draw(data, firstChart_options);
	}
	
	var secondChart_options = {
		title : '주문 건수',
		width : 416,
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
			['Element', '주문건수'],
			['1월', parseInt(${octotal[0]})],
			['2월', parseInt(${octotal[1]})],
			['3월', parseInt(${octotal[2]})],
			['4월', parseInt(${octotal[3]})],
			['5월', parseInt(${octotal[4]})],
			['6월', parseInt(${octotal[5]})],
			['7월', parseInt(${octotal[6]})],
			['8월', parseInt(${octotal[7]})],
			['9월', parseInt(${octotal[8]})],
			['10월', parseInt(${octotal[9]})],
			['11월', parseInt(${octotal[10]})],
			['12월', parseInt(${octotal[11]})],
		]);
		
		var secondChart = new google.visualization.PieChart(document.getElementById('secondChat'));
		secondChart.draw(data, secondChart_options);
	}
	
	var thirdChart_options = {
		title : '주문금액',
		width : 416,
		height : 400,
		bar : {
			groupWidth : '100%'
		},
		series: {
			0: {color:'#ccc'},
			1: {color: '#c784de'}
		}
	}
	
	function drawChartThird(){
		var data = google.visualization.arrayToDataTable([
			['Element', '주문금액'],
			['1월', parseInt(${optotal[0]})],
			['2월', parseInt(${optotal[1]})],
			['3월', parseInt(${optotal[2]})],
			['4월', parseInt(${optotal[3]})],
			['5월', parseInt(${optotal[4]})],
			['6월', parseInt(${optotal[5]})],
			['7월', parseInt(${optotal[6]})],
			['8월', parseInt(${optotal[7]})],
			['9월', parseInt(${optotal[8]})],
			['10월', parseInt(${optotal[9]})],
			['11월', parseInt(${optotal[10]})],
			['12월', parseInt(${optotal[11]})],
		]);
		
		var secondChart = new google.visualization.PieChart(document.getElementById('thirdChat'));
		secondChart.draw(data, thirdChart_options);
	}
</script>
</body>
</html>