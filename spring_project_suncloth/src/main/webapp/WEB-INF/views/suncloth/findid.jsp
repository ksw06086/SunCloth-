order<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file = "setting.jsp" %>
<link type = "text/css" rel = "stylesheet" href = "${project}cssall/findid.css"/>
<html>
<body>
<%@ include file = "topmanu.jsp" %>

    <div id = "road">
		<p>home > membership</p>
	</div>
	
	<div id = "topname">
		<p><b>FIND ID</b></p>
	</div>
	
	<div id = "topnamesub">
		<p>아이디 찾기</p>
	</div>
	
    <form name = "findform" action="findidcomplete" method = "post"
    onsubmit = "return findidpwdCheck();">
    	<fieldset name = "typetbl">
    		<table id = "membertype" style = "margin: 40px auto 15px;">
    			<col style = "width: 35%;">
    			<col style = "width: 65%;">
    			<tr>
    				<td>회원유형</td>
    				<td>
    					<select id = "type" name = "typesel" style = "width:100%; padding: 7px 0px; font-size: .9em;">
    						<option value = "0">개인 회원</option>
    						<option value = "1">관리자</option>
    					</select>
    				</td>
    			</tr>
    		</table>
    			
    			
    		<table id = "summary" style = "margin: 0px auto 25px;">
	    		<col style = "width: 35%;">
	    		<col style = "width: 65%;">
    			<tr id = "GHfind1">
    				<td>이름</td>
    				<td>
    					<input type = "text" id = "Gname" name = "GNameN" style = "width:98.3%; padding: 5px 0px;" required>
    				</td>
    			</tr>
    			
    			<tr id = "findemail">
		    		<td>이메일로 찾기</td>
		    		<td>
		   				<input type = "text" id = "idname" name = "idName" style = "width: 35%; padding:5px 0px;">
		   				@ <input type = "text" id = "urlcode"  name = "urlcode" style = "width: 35%; padding:5px 0px;">
			    		<input type = "button" id = "formal" value = "인증" onclick = "findformalChk();">
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
    		</table>
    		
    		
    		<table id = "btn" style = "margin: 0px auto 40px;">	
    			<tr>
    				<td><input type = "submit" id = "findbtn" value = "확인" name = "findbtnN"></td>
    			</tr>
    		</table>
    	
    	</fieldset>
    </form>
	
<%@ include file = "bottommenu.jsp" %>
</body>
</html>