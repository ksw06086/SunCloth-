<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file = "setting.jsp" %>
<link type = "text/css" rel = "stylesheet" href = "${project}cssall/h_category.css"/>
<html>
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
					<p><b>카테고리 상품 분석</b></p>
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
							<b>·월별 카테고리 인기순위 현황</b>
							</td>
						</tr>
					</table>
					
					<c:set var = "cntsum" value = "0"/>
					<c:set var = "pricesum" value = "0"/>
					<table id = "clicklist">
				    	<col style = "width:20%;">
				    	<col style = "width:16%;">
				    	<col style = "width:16%;">
				    	<col style = "width:16%;">
				    	<col style = "width:16%;">
				    	<col style = "width:16%;">
				    	<tr id = "title">
				    		<td rowspan = "2">순위</td> <!-- 5위까지만 -->
				    		<td colspan = "2">구분</td>
				    		<td colspan = "3">전체</td>
				    	</tr>
				    	<tr id = "title">
				    		<td>대분류</td>
				    		<td>중분류</td>
				    		<td>판매수량</td>
				    		<td>판매금액</td>
				    		<td>리뷰</td>
				    	</tr>
				    	<c:if test="${list != null}">
					    	<c:forEach var="list" items="${list}">
					    		<tr class = "click">
						    		<td>${number}
									<c:set var = "number" value = "${number+1}"/>
									<c:set var = "cntsum" value = "${cntsum+list.cnttotal}"/>
									<c:set var = "pricesum" value = "${pricesum+list.pricetotal}"/>
									</td>
						    		<td>${list.bigname}</td>
						    		<td>${list.mediname}</td>
						    		<td>${list.cnttotal}</td>
						    		<td>${list.pricetotal}</td>
						    		<td>15</td>
						    	</tr>
					    	</c:forEach>
				    	</c:if>
				    	<tr class = "click" id = "foot">
				    		<td>합계</td>
				    		<td></td>
				    		<td></td>
				    		<td>${cntsum}</td>
				    		<td>${pricesum}원</td>
				    		<td>27</td>
				    	</tr>
				    </table>
				</div>
			</td>
		</tr>
	</table>
</section>
</body>
</html>