<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file = "setting.jsp" %>
<link type = "text/css" rel = "stylesheet" href = "${project}cssall/join_us.css"/>
<html>
<body>
<%@ include file = "topmanu.jsp" %>

    <div id = "road">
		<p>home > join us</p>
	</div>
	
	<div id = "topname">
		<p><b>회원가입</b></p>
	</div>
    
    
    <form name = "inputForm" action = "inputPro" method = "post" id = "joinus"
    onsubmit = "return hostCheck();">
    	<%--  크로스사이드 스크립팅 공격방어를 위해 스프링시큐리티에서는 반드시 아래값을 전달해야 에러가 발생안함
			${_csrf.~} 사용
			name과 value는 반드시 아래 값을 사용해야한다. (규약)
		 --%>
		<!-- 필수 값 무조건 해야지만 암호화한다. -->
		<input type = "hidden" name = "${_csrf.parameterName}" value="${_csrf.token}">
		    	
		<!-- hiddenId : 중복확인 버튼 클릭 여부 체크(0:클릭 안함, 1:클릭함) -->
		<input type = "hidden" name = "hiddenId" value = "0">
		<input type = "hidden" name = "memberNum" value = "1">
		<input type = "hidden" name = "numCheck" value = "0">
		
	    <p style = "float:left;">기본정보</p>
	    <p style = "float:right;"><img src = "./ascloimage/snorlax.png" width = "12px" height = "12px"> 필수입력사항</p>
	    <table>
	    	<tr>
	    		<td>아이디<img src = "./ascloimage/snorlax.png" width = "12px" height = "12px"></td>
	    		<td><input type = "text" id = "userid" name = "id">  <input type = "button" id = "overlabchk" name = "overlabchk" value = "중복확인" onclick = "confirmId();">(영문소문자/숫자, 4~16자)</td>
	    	</tr>
	    	<tr>
	    		<td>비밀번호<img src = "./ascloimage/snorlax.png" width = "12px" height = "12px"></td>
	    		<td><input type = "password" id = "userpwd" name = "pwd">(영문 대소문자/숫자/특수문자 중 2가지 이상 조합, 8자~16자)</td>
	    	</tr>
	    	<tr>
	    		<td>비밀번호 확인<img src = "./ascloimage/snorlax.png" width = "12px" height = "12px"></td>
	    		<td><input type = "password" id = "userRpwd" name = "repwd"></td>
	    	</tr>
	    	<tr>
	    		<td>이름<img src = "./ascloimage/snorlax.png" width = "12px" height = "12px"></td>
	    		<td><input type = "text" id = "username" name = "name"></td>
	    	</tr>
	    	<tr>
	    		<td>휴대폰번호<img src = "./ascloimage/snorlax.png" width = "12px" height = "12px"></td>
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
	    	<tr>
	    		<td>이메일<img src = "./ascloimage/snorlax.png" width = "12px" height = "12px"></td>
	    		<td>
	   				<input type = "text" id = "idname" name = "idName">
	   				@<input type = "text" id = "urlcode"  name = "urlcode">
	    			<select name = "email3" onchange = "selectEmailChk();">
	    				<option value = "0">직접입력</option>
	   					<option value = "naver.com">naver.com</option>
	   					<option value = "daum.com">daum.com</option>
	   					<option value = "nate.com">nate.com</option>
	   					<option value = "gmail.com">gmail.com</option>
	   					<option value = "korea.com">korea.com</option>
	   					<option value = "hanmail.com">hanmail.com</option>
	   				</select>
	   				<input type = "button" id = "formal" value = "인증" onclick = "formalChk();">
	   				<input type = "hidden" name = "hiddenemail" id = "hiddenemail1" value = "0">
	    		</td>
	    	</tr>
	    	<tr>
	    		<td>
	    		인증번호 입력<img src = "./ascloimage/snorlax.png" width = "12px" height = "12px">
	    		</td>
	    		<td>
	    		<input type = "text" id = "formalNum" name = "formalNum" maxlength = "6">
	    		<input type = "button" id = "Numcheck" value = "확인">
	    		<input type = "hidden" name = "numchk" id = "numchk1" value = "">
	    		</td>
	    	</tr>
	    	<tr>
	    		<td>
	    		관리자 고유번호 입력<img src = "./ascloimage/snorlax.png" width = "12px" height = "12px">
	    		</td>
	    		<td>
	    		<input type = "text" id = "formalNum" name = "formalNum1" maxlength = "6">
	    		<input type = "button" id = "Numcheck" value = "확인" onclick = "numChk();">
	    		</td>
	    	</tr>
	    </table>
	    
	    <div style = "text-align:center;" id = "joinbtn">
	    	<input type = "submit" value = "회원가입" id = "join">
	    </div>
    
    </form>
	
<%@ include file = "bottommenu.jsp" %>
</body>
</html>