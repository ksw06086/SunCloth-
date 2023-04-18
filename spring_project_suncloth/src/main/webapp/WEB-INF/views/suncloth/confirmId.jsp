<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file = "setting.jsp" %>
<link type = "text/css" rel = "stylesheet" href = "${project}cssall/style.css">
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body onload="confirmIdfocus();">
	<h2> 중복확인 페이지 </h2>
<form action = "confirmId" method = "post" name = "confirmform" onsubmit = "return confirmIdCheck();">
<input type = "hidden" name = "member" value = "${member}">
<!--  중복일 때 : cnt 정보로 확인  -->
<c:if test="${selectCnt == 1}">
	<table>
		<tr>
			<th colspan = "2">
				<span>${id}</span>는 사용할 수 없습니다.
			</th>
		</tr>
		<tr>
			<th>아이디 :</th>
			<td><input type = "text" class = "input" name = "id" maxlength = "20"
			style = "width:150px;"></td>
		</tr>
		
		<tr>
			<th colspan = "2">
			<input class = "inputButton" type = "submit" value = "확인">
			<input class = "inputButton" type = "reset" value = "취소" onclick = "self.close();">
			</th>
		</tr>
	</table>
</c:if>
<!-- 중복이 아닐 때 -->
<c:if test="${selectCnt != 1}">
	<table>
		<tr>
			<td align = "center">
				<span>${id}</span>는 사용할 수 있습니다.
			</td>
		</tr>
		
		<tr>
			<th>
				<input class = "inputButton" type = "button" value = "확인" onclick = "setId('${id}');">
			</th>
		</tr>
	</table>
</c:if>
</form>
</body>
</html>