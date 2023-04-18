order<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file = "setting.jsp" %>
<link type = "text/css" rel = "stylesheet" href = "${project}cssall/findcompleteid.css"/>
<html>
<body>
<c:if test="${idCnt == 0}">
<script type = "text/javascript">
	errorAlert("비밀번호를 찾지 못했습니다.");
</script>
</c:if>
<%@ include file = "topmanu.jsp" %>

    <div id = "road">
		<p>home > membership</p>
	</div>
	
	<div id = "topname">
		<p><b>FIND PASSWORD</b></p>
	</div>
	
	<div id = "topnamesub">
		<p>비밀번호 찾기 완료</p>
	</div>
	
    <form name = "findId" action="login" method = "post">
    	<fieldset>
    		<table id = "headtext">
    			<tr>
    				<td><img src = "./ascloimage/exclamation-mark.png" width = "20px" height = "20px"></td>
    				<td>저희 쇼핑몰을 이용해주셔서 감사합니다.<br>
    				${id}님의 비밀번호를 찾았습니다.
    				</td>
    			</tr>
    		</table>
    			
    		<hr>
    		
    		<table id = "summary">
	    		<col style = "width: 20%;">
	    		<col style = "width: 20%;">
	    		<col style = "width: 60%;">
    			<tr id = "name">
    				<td>이메일</td>
    				<td>
    					&nbsp;${email}
    				</td>
    			</tr>
    			<tr id = "email">
    				<td>비밀번호</td>
    				<td>
    					&nbsp;${vo.pwd}
    				</td>
    			</tr>
    			
    			<tr id = "btmtext">
    				<td colspan = "3"> 고객님 즐거운 쇼핑 하세요!</td>
    			</tr>
    		</table>
    	</fieldset>
    	
    	<p id = "thankstext">고객님의 비밀번호 찾기가 성공적으로 이루어졌습니다. 항상 고객님의<br>
    	즐겁고 편리한 쇼핑을 위해 최선의 노력을 다하는 쇼핑몰이 되도록 하겠습니다.</p>
    	    	
   		<table id = "btn" style = "margin: 0px auto 40px;">	
   			<tr>
   				<td><input type = "submit" id = "findbtn" value = "로그인" name = "findbtnN"></td>
   			</tr>
   		</table>
    </form>
	
<%@ include file = "bottommenu.jsp" %>
</body>
</html>