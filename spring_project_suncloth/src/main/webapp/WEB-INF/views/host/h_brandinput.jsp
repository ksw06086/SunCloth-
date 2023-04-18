<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file = "setting.jsp" %>
<link type = "text/css" rel = "stylesheet" href = "${project}cssall/h_brandinput.css"/>
<html>
<body>
<%@ include file = "topmenu.jsp" %>

<form action = "h_brandPro" method = "post" name = "h_brandform">
<section>
	<table id = "middle">
		<col style = "width:15%;">
		<col>
		<tr>
			<%@ include file = "h_boardLeft.jsp" %>
			<td id = "tabright">
				<div id = "righttop">
					<p><input type = "button" value = "브랜드리스트" id = "brandlist" onclick = "window.location = 'h_brand'"></p>
					<p><b>브랜드관리</b></p>
					<p><input type = "submit" value = "등록" id = "brandinput"></p>
				</div>
				<div id = "brand">
					<table id = "summarytop">
						<tr>
							<td>
							<b>·브랜드정보</b>
							</td>
						</tr>
					</table>
					<table id = "summary">
						<tr>
							<td>·브랜드번호</td>
							<td>
							${num}
							</td>
						</tr>
						
						<tr>
							<td>브랜드 명</td>
							<td>
							<input type = "text" id = "brandname" name = "name">
							</td>
						</tr>
						
						<tr>
							<td>브랜드 전화번호</td>
				     		<td>
				    			<select style = "width:100px;" name = "telphone1">
				   					<option value = "010">010</option>
				   					<option value = "011">011</option>
				   					<option value = "016">016</option>
				   					<option value = "017">017</option>
				   					<option value = "018">018</option>
				   					<option value = "019">019</option>
				   				</select>
				   				- <input type = "text" id = "telphonesecond" style = "width:70px;" name = "telphone2">
				   				- <input type = "text" id = "telphonethrid" style = "width:70px;" name = "telphone3">
				    		</td>
				     	</tr>
				     </table>
			     </div>
			</td>
		</tr>
	</table>
</section>
</form>
</body>
</html>