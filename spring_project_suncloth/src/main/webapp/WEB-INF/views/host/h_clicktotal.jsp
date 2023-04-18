<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file = "setting.jsp" %>
<link type = "text/css" rel = "stylesheet" href = "${project}cssall/h_clicktotal.css"/>
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
					<p><b>방문자 분석</b></p>
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
					<table id = "subtop">
						<tr>
							<td>
							<b>·월별 접속자 현황</b>
							</td>
						</tr>
					</table>
					
				    <c:set var="click1" value = "${clicktotal[0]}"/>
				    <c:set var="click2" value = "${clicktotal[1]}"/>
				    <c:set var="click3" value = "${clicktotal[2]}"/>
				    <c:set var="click4" value = "${clicktotal[3]}"/>
				    <c:set var="click5" value = "${clicktotal[4]}"/>
				    <c:set var="click6" value = "${clicktotal[5]}"/>
				    <c:set var="click7" value = "${clicktotal[6]}"/>
				    <c:set var="click8" value = "${clicktotal[7]}"/>
				    <c:set var="click9" value = "${clicktotal[8]}"/>
				    <c:set var="click10" value = "${clicktotal[9]}"/>
				    <c:set var="click11" value = "${clicktotal[10]}"/>
				    <c:set var="click12" value = "${clicktotal[11]}"/>
					<div style = "display: -webkit-box;">
					<div id = "firstChat"></div>
					</div>
					
					<table id = "clicklist">
				    	<col style = "width:50%;">
				    	<col style = "width:50%;">
				    	<tr id = "title">
				    		<td>월별</td>
				    		<td>방문자수</td>
				    	</tr>
				    	<tr class = "click">
				    		<td>01월</td>
				    		<td>${clicktotal[0]}</td>
				    	</tr>
				    	<tr class = "click">
				    		<td>02월</td>
				    		<td>${clicktotal[1]}</td>
				    	</tr>
				    	<tr class = "click">
				    		<td>03월</td>
				    		<td>${clicktotal[2]}</td>
				    	</tr>
				    	<tr class = "click">
				    		<td>04월</td>
				    		<td>${clicktotal[3]}</td>
				    	</tr>
				    	<tr class = "click">
				    		<td>05월</td>
				    		<td>${clicktotal[4]}</td>
				    	</tr>
				    	<tr class = "click">
				    		<td>06월</td>
				    		<td>${clicktotal[5]}</td>
				    	</tr>
				    	<tr class = "click">
				    		<td>07월</td>
				    		<td>${clicktotal[6]}</td>
				    	</tr>
				    	<tr class = "click">
				    		<td>08월</td>
				    		<td>${clicktotal[7]}</td>
				    	</tr>
				    	<tr class = "click">
				    		<td>09월</td>
				    		<td>${clicktotal[8]}</td>
				    	</tr>
				    	<tr class = "click">
				    		<td>10월</td>
				    		<td>${clicktotal[9]}</td>
				    	</tr>
				    	<tr class = "click">
				    		<td>11월</td>
				    		<td>${clicktotal[10]}</td>
				    	</tr>
				    	<tr class = "click">
				    		<td>12월</td>
				    		<td>${clicktotal[11]}</td>
				    	</tr>
				    	<tr class = "click" id = "foot">
				    		<td>합계</td>
				    		<td>${clicktotal[0] + clicktotal[1] + clicktotal[2] + clicktotal[3] + clicktotal[4] + clicktotal[5]
				    		+ clicktotal[6] + clicktotal[7] + clicktotal[8] + clicktotal[9] + clicktotal[10] + clicktotal[11]}</td>
				    	</tr>
				    </table>
				</div>
			</td>
		</tr>
	</table>
</section>
<script type="text/javascript">
	google.charts.setOnLoadCallback(drawChartFirst);
	
	var firstChart_options = {
			title: '월별 방문자 분석',
			width : 1250,
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
		
		var firstChart = new google.visualization.ColumnChart(document.getElementById('firstChat'));
		firstChart.draw(data, firstChart_options);
	}
</script>
</body>
</html>