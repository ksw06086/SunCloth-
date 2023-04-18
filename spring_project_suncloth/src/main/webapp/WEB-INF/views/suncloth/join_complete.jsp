order<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file = "setting.jsp" %>
<link type = "text/css" rel = "stylesheet" href = "${project}cssall/join_complete.css"/>
<html>
<body>
<%@ include file = "topmanu.jsp" %>

    <div id = "road">
		<p>home > membership</p>
	</div>
	
	<div id = "topname">
		<p><b>JOIN COMPLETE</b></p>
	</div>
	
    <div id = "topnamesub">
		<p>회원가입이 완료 되었습니다.</p>
	</div> 
     
    <form name = "joincomplete" action = "main" method = "post">
    	<fieldset id = "joinfinish">
    		<input type = "hidden" name = "member" value = "${member}">
    		<table id = "headtext" style = "padding:5px 5px;">
    			<tr>
    				<td>
    				<img src = "../ascloimage/exclamation-mark.png" width = "10px" height = "10px">
    				<b>저희 쇼핑몰을 이용해 주셔서 감사합니다.</b> 
    				</td>
    			</tr>
    		</table>
    		<hr>
    		<table id = "summary" style = "padding:5px 5px;">
    			<tr>
    				<td>아이디</td>
    				<td>${id}</td>
    			</tr>
    			<tr>
    				<td>이름</td>
    				<td>${name}</td>
    			</tr>
    			<tr>
    				<td>이메일</td>
    				<td>${email}</td>
    			</tr>
    		</table>
    	</fieldset>
    	
    	<div style = "width:100%;">
    		<table id = "btn" style = "width: 100%;">
    			<tr>
    				<td><input type = "submit" id = "gomain" name = "gomainN" value = "메인으로 이동"></td>
    			</tr>
    		</table>
    	</div>
    </form>
	
<%@ include file = "bottommenu.jsp" %>
</body>
</html>