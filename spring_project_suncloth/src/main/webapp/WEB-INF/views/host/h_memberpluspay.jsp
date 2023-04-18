<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file = "setting.jsp" %>
<link type = "text/css" rel = "stylesheet" href = "${project}cssall/h_memberpluspay.css"/>
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
					<p><b>회원적립금 분석</b></p>
				</div>
				<table id = "searchifs">
					<col style = "width:15%;">
					<col>
					<tr>
						<td>검색어</td>
						<td>
						<select id = "type" style = "padding:2px; vertical-align:middle;">
							<option value = "">전체</option>
							<option value = "name">이름</option>
							<option value = "id">아이디</option>
						</select>
						<input type = "search" id = "srch" name = "srch" style = "vertical-align:middle;">
						</td>
					</tr>
				</table>
				
				<p id = "srhbtnp"><input type = "button" value = "검색" id = "srhbtn"></p>
				
				<div id = "result">
					<table id = "subtop">
						<tr>
							<td>
							<b>·전체회원 적립금 분석결과</b>
							</td>
						</tr>
					</table>
					
					<c:set var = "cntsum" value = "0"/>
					<c:set var = "useplussum" value = "0"/>
					<c:set var = "myplussum" value = "0"/>
					<c:if test="${list != null}">
					    	<c:forEach var="list" items="${list}">
								<c:set var = "cntsum" value = "${cntsum+list.cnt}"/>
								<c:set var = "useplussum" value = "${useplussum+list.useplus}"/>
								<c:set var = "myplussum" value = "${myplussum+list.myplus}"/>
					    	</c:forEach>
				    	</c:if>
					<table id = "clicklist">
				    	<col style = "width:33.3%;">
				    	<col style = "width:33.3%;">
				    	<col>
				    	<tr id = "title">
				    		<td colspan = "2">총 사용 적립금</td>
				    		<td>총 잔여 적립금</td>
				    	</tr>
				    	<tr id = "title">
				    		<td>건수</td>
				    		<td>금액</td>
				    		<td>금액</td>
				    	</tr>
				    	<tr class = "click">
				    		<td>${cntsum}</td>
				    		<td>${useplussum}원</td>
				    		<td>${myplussum}원</td>
				    	</tr>
				    </table>
				</div>
				<div id = "result">
					<table id = "subtop">
						<tr>
							<td>
							<b>·회원 적립금 분석결과</b>
							</td>
						</tr>
					</table>
					
					<table id = "clicklist">
				    	<col style = "width:16%;">
				    	<col style = "width:16%;">
				    	<col style = "width:16%;">
				    	<col style = "width:16%;">
				    	<col style = "width:16%;">
				    	<col>
				    	<tr id = "title">
				    		<td rowspan = "2">순위</td> <!-- 10위 까지만 -->
				    		<td rowspan = "2">이름</td>
				    		<td rowspan = "2">아이디</td>
				    		<td colspan = "2">총 사용 적립금</td>
				    		<td>총 잔여 적립금</td>
				    	</tr>
				    	<tr id = "title">
				    		<td>건수</td>
				    		<td>금액</td>
				    		<td>금액</td>
				    	</tr>
				    	<c:if test="${list != null}">
					    	<c:forEach var="list" items="${list}">
					    		<tr class = "click">
						    		<td>${number}
									<c:set var = "number" value = "${number+1}"/></td>
						    		<td>${list.gname}</td>
						    		<td>${list.gid}</td>
						    		<td>${list.cnt}</td>
						    		<td>${list.useplus}</td>
						    		<td>${list.myplus}</td>
									<c:set var = "number" value = "${number+1}"/>
									<c:set var = "cntsum" value = "${cntsum+list.cnt}"/>
									<c:set var = "useplussum" value = "${useplussum+list.useplus}"/>
									<c:set var = "myplussum" value = "${myplussum+list.myplus}"/>
						    	</tr>
					    	</c:forEach>
				    	</c:if>
				    	<tr class = "click" id = "foot">
				    		<td>합계</td>
				    		<td></td>
				    		<td></td>
				    		<td>${cntsum}</td>
				    		<td>${useplussum}원</td>
				    		<td>${myplussum}원</td>
				    	</tr>
				    </table>
				</div>
			</td>
		</tr>
	</table>
</section>
</body>
</html>