<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file = "setting.jsp" %>
<link type = "text/css" rel = "stylesheet" href = "${project}cssall/h_saletotal.css"/>
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
					<p><b>매출 통계</b></p>
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
				    		<td>총 매출건수</td>
				    		<td>총 매출금액</td>
				    		<td>실 매출액</td>
				    	</tr>
				    	<tr class = "click">
				    		<td>${octotal[12]}</td>
				    		<td>${orptotal[12] - ortotal[12]}</td>
				    		<td>${orptotal[12] - ortotal[12]}</td>
				    	</tr>
				    </table>
					<table id = "subtop">
						<tr>
							<td>
							<b>·월별 주문 현황</b>
							</td>
						</tr>
					</table>
					
					<div style = "display: -webkit-box;">
					<div id = "firstChat"></div>
					</div>
					
					<table id = "clicklist">
				    	<col style = "width:20%;">
				    	<col style = "width:15%;">
				    	<col style = "width:15%;">
				    	<col style = "width:15%;">
				    	<col style = "width:15%;">
				    	<col style = "width:20%;">
				    	<tr id = "title">
				    		<td rowspan = "2">월별</td>
				    		<td colspan = "3">결제금액</td>
				    		<td rowspan = "2">환불금액</td>
				    		<td rowspan = "2">매출액</td>
				    	</tr>
				    	<tr id = "title">
				    		<td>결제금액</td>
				    		<td>할인</td>
				    		<td>실결제금액</td>
				    	</tr>
				    	<tr class = "click">
				    		<td>01월</td>
				    		<td>${optotal[0]}</td>
				    		<td>0</td>
				    		<td>${orptotal[0]}</td>
				    		<td>${ortotal[0]}</td>
				    		<td>${optotal[0]}</td>
				    	</tr>
				    	<tr class = "click">
				    		<td>02월</td>
				    		<td>${optotal[1]}</td>
				    		<td>0</td>
				    		<td>${orptotal[1]}</td>
				    		<td>${ortotal[1]}</td>
				    		<td>${orptotal[1] - ortotal[1]}</td>
				    	</tr>
				    	<tr class = "click">
				    		<td>03월</td>
				    		<td>${optotal[2]}</td>
				    		<td>0</td>
				    		<td>${orptotal[2]}</td>
				    		<td>${ortotal[2]}</td>
				    		<td>${orptotal[2] - ortotal[2]}</td>
				    	</tr>
				    	<tr class = "click">
				    		<td>04월</td>
				    		<td>${optotal[3]}</td>
				    		<td>0</td>
				    		<td>${orptotal[3]}</td>
				    		<td>${ortotal[3]}</td>
				    		<td>${orptotal[3] - ortotal[3]}</td>
				    	</tr>
				    	<tr class = "click">
				    		<td>05월</td>
				    		<td>${optotal[4]}</td>
				    		<td>0</td>
				    		<td>${orptotal[4]}</td>
				    		<td>${ortotal[4]}</td>
				    		<td>${orptotal[4] - ortotal[4]}</td>
				    	</tr>
				    	<tr class = "click">
				    		<td>06월</td>
				    		<td>${optotal[5]}</td>
				    		<td>0</td>
				    		<td>${orptotal[5]}</td>
				    		<td>${ortotal[5]}</td>
				    		<td>${orptotal[5] - ortotal[5]}</td>
				    	</tr>
				    	<tr class = "click">
				    		<td>07월</td>
				    		<td>${optotal[6]}</td>
				    		<td>0</td>
				    		<td>${orptotal[6]}</td>
				    		<td>${ortotal[6]}</td>
				    		<td>${orptotal[6] - ortotal[6]}</td>
				    	</tr>
				    	<tr class = "click">
				    		<td>08월</td>
				    		<td>${optotal[7]}</td>
				    		<td>0</td>
				    		<td>${orptotal[7]}</td>
				    		<td>${ortotal[7]}</td>
				    		<td>${orptotal[7] - ortotal[7]}</td>
				    	</tr>
				    	<tr class = "click">
				    		<td>09월</td>
				    		<td>${optotal[8]}</td>
				    		<td>0</td>
				    		<td>${orptotal[8]}</td>
				    		<td>${ortotal[8]}</td>
				    		<td>${orptotal[8] - ortotal[8]}</td>
				    	</tr>
				    	<tr class = "click">
				    		<td>10월</td>
				    		<td>${optotal[9]}</td>
				    		<td>0</td>
				    		<td>${orptotal[9]}</td>
				    		<td>${ortotal[9]}</td>
				    		<td>${orptotal[9] - ortotal[9]}</td>
				    	</tr>
				    	<tr class = "click">
				    		<td>11월</td>
				    		<td>${optotal[10]}</td>
				    		<td>0</td>
				    		<td>${orptotal[10]}</td>
				    		<td>${ortotal[10]}</td>
				    		<td>${orptotal[10] - ortotal[10]}</td>
				    	</tr>
				    	<tr class = "click">
				    		<td>12월</td>
				    		<td>${optotal[11]}</td>
				    		<td>0</td>
				    		<td>${orptotal[11]}</td>
				    		<td>${ortotal[11]}</td>
				    		<td>${orptotal[11] - ortotal[11]}</td>
				    	</tr>
				    	<tr class = "click" id = "foot">
				    		<td>합계</td>
				    		<td>${optotal[12]}</td>
				    		<td>0</td>
				    		<td>${orptotal[12]}</td>
				    		<td>${ortotal[12]}</td>
				    		<td>${orptotal[12] - ortotal[12]}</td>
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
			['Element', '매출액'],
			['1월', parseInt(${orptotal[0] - ortotal[0]})],
			['2월', parseInt(${orptotal[1] - ortotal[1]})],
			['3월', parseInt(${orptotal[2] - ortotal[2]})],
			['4월', parseInt(${orptotal[3] - ortotal[3]})],
			['5월', parseInt(${orptotal[4] - ortotal[4]})],
			['6월', parseInt(${orptotal[5] - ortotal[5]})],
			['7월', parseInt(${orptotal[6] - ortotal[6]})],
			['8월', parseInt(${orptotal[7] - ortotal[7]})],
			['9월', parseInt(${orptotal[8] - ortotal[8]})],
			['10월', parseInt(${orptotal[9] - ortotal[9]})],
			['11월', parseInt(${orptotal[10] - ortotal[10]})],
			['12월', parseInt(${orptotal[11] - ortotal[11]})],
		]);
		
		var firstChart = new google.visualization.ColumnChart(document.getElementById('firstChat'));
		firstChart.draw(data, firstChart_options);
	}
</script>
</body>
</html>