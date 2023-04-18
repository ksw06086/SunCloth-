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
	
     <form name = "loginForm" action = "z_login_check.do" method = "post"
     onsubmit = "return inputCheck();">
     	<%--  크로스사이드 스크립팅 공격방어를 위해 스프링시큐리티에서는 반드시 아래값을 전달해야 에러가 발생안함
			${_csrf.~} 사용
			name과 value는 반드시 아래 값을 사용해야한다. (규약)
		 --%>
		<!-- 필수 값 무조건 해야지만 암호화한다. -->
		<input type = "hidden" name = "${_csrf.parameterName}" value="${_csrf.token}">
		
     	<input type = "hidden" name = "member" value = "1">
     	<fieldset>
     		<table>
     			<tr>
     				<td>Registered Host</td>
     			</tr>
     			<tr>
     				<td style = "font-size:.7em;">아이디와 패스워드를 입력해주세요<br><span style = "color:red">${errMsg}</span></td>
     			</tr>
     			<tr>
     				<td></td>
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
     				<td><input type = "button" id = "go_join" value = "회원가입하기" onclick = "window.location = 'o_inputForm'"></td>
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