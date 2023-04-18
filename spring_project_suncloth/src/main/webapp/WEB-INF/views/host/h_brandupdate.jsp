<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file = "setting.jsp" %>
<link type = "text/css" rel = "stylesheet" href = "${project}cssall/h_brandupdate.css"/>
<html>
<c:set var = "hps" value = "${fn:split(vo.getHp(), '-')}"/>
<body onload = "brandupdateStart('${hps[0]}');">
<%@ include file = "topmenu.jsp" %>

<form action = "h_brandUpdatePro" method = "post" name = "h_brandform">
<input type = "hidden" name = "number" value = "${number}">
<input type = "hidden" name = "num" value = "${num}">
<input type = "hidden" name = "pageNum" value = "${pageNum}">
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
					<p><input type = "submit" value = "수정" id = "brandupdate"></p>
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
							${vo.num}
							</td>
						</tr>
						
						<tr>
							<td>브랜드 명</td>
							<td>
							<input type = "text" id = "brandname" name = "name" value = "${vo.name}">
							</td>
						</tr>
						
						<tr>
							<td>브랜드 전화번호</td>
				     		<td>
				    			<select style = "width:100px;" name = "telphone1" id = "telphone">
				   					<option value = "010">010</option>
				   					<option value = "011">011</option>
				   					<option value = "016">016</option>
				   					<option value = "017">017</option>
				   					<option value = "018">018</option>
				   					<option value = "019">019</option>
				   				</select>
				   				- <input type = "text" id = "telphonesecond" style = "width:70px;" name = "telphone2" value = "${hps[1]}">
				   				- <input type = "text" id = "telphonethrid" style = "width:70px;" name = "telphone3" value = "${hps[2]}">
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