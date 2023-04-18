<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file = "setting.jsp" %>
<link type = "text/css" rel = "stylesheet" href = "${project}cssall/login.css"/>
<html>
<body onload = "startVal();">
<%@ include file = "topmanu.jsp" %>

    <div id = "road">
		<p>home > login</p>
	</div>
	
     <form name = "loginForm" action = "loginPro" method = "post"
     onsubmit = "return inputCheck();">
     	<input type = "hidden" name = "member" value = "0">
     	<fieldset>
     		<table>
     			<tr>
     				<td>Registered Customers</td>
     			</tr>
     			<tr>
     				<td style = "font-size:.7em;">가입하신 아이디와 패스워드를 입력해주세요</td>
     			</tr>
     			<tr>
     				<td><br></td>
     			</tr>
     			<tr>
     				<td><input type = "text" id = "userid" name = "id" style = "width:98.5%;"></td>
     			</tr>
     			<tr>
     				<td><input type = "password" id = "userpwd" name = "pwd" style = "width:98.5%;"></td>
     			</tr>
     			
     			<tr>
     				<td id = "idsave"><input type = "checkbox" id = "useridsave" value = "아이디저장"><label for = "useridsave">아이디 저장</label></td>
     			</tr>
     			
     			<tr>
     				<td><input type = "submit" id = "loginbtn" value = "로그인"></td>
     			</tr>
     			
     			<tr>
     				<td><input type = "button" id = "go_join" value = "회원가입하기" onclick = "window.location = 'inputForm'"></td>
     			</tr>
     			
     			<tr>
     				<td class = "bottombtn1"><a href = "findid">아이디찾기</a> | <a href = "findpwd">비밀번호찾기</a></td>
     			</tr>
     		</table>
     	</fieldset>
     </form>
	
<%@ include file = "bottommenu.jsp" %>
</body>
</html>