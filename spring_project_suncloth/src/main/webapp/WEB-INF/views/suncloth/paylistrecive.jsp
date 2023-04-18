<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file = "setting.jsp" %>
<link type = "text/css" rel = "stylesheet" href = "${project}cssall/paylistrecive.css"/>
<html>
<body>
<header id = "header">
	<b>현금영수증 신청양식 작성</b>
</header>

    <form name = "myForm" action = "" method = "post" id = "accountChange">
	    
	    <table>
	    	<col style = "width:30%;">
	    	<col style = "width:70%;">
	    	
	    	<tr>
	    		<td>구분</td>
	    		<td>
	    		<input type = "radio" id = "one" value = "one" name = "member" checked> 개인
	    		<input type = "radio" id = "com" value = "company" name = "member"> 사업자
	    		</td>
	    	</tr>
	    	
	    	<tr>
	    		<td>핸드폰 번호</td>
	    		<td>
	    			<select style = "width:100px;">
	   					<option value = "010">010</option>
	   					<option value = "011">011</option>
	   					<option value = "016">016</option>
	   					<option value = "017">017</option>
	   					<option value = "018">018</option>
	   					<option value = "019">019</option>
	   				</select>
	   				- <input type = "text" id = "telphonesecond" style = "width:70px;" name = "telphoneSe">
	   				- <input type = "text" id = "telphonethrid" style = "width:70px;" name = "telphoneTh">
	    		</td>
	    	</tr>
	    	
	    	<tr style = "display: none;">
	    		<td>사업자명</td>
	    		<td><input type = "text" id = "comname" style = "width:70px;" name = "comnameN">
	    		</td>
	    	</tr>
	    </table>
	    
	    <div style = "text-align:center; margin: 30px 0px 100px 0px;" id = "changebtn">
	    	<input type = "submit" id = "recive" value = "현금영수증 신청">
	    </div>
    
    </form>
</body>
</html>