<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file = "setting.jsp" %>
<link type = "text/css" rel = "stylesheet" href = "${project}cssall/refundChange.css"/>
<html>
<body onload = "refundStart('${bank}');">
<header id = "header">
	<b>환불계좌 변경</b>
</header>

    <form name = "refundForm" action = "refundPro" method = "post" id = "accountChange"
    onsubmit = "return refundCheck();">
	    
	    <table>
	    	<col style = "width:30%;">
	    	<col style = "width:70%;">
	    	<tr>
	    		<td>예금주</td>
	    		<td><input type = "text" id = "userbackhost" name = "acchost" value = "${acchost}"><br>
	    		예금주명은 주문자명과 동일해야 합니다.</td>
	    	</tr>
	    	
	    	<tr>
	    		<td>은행명</td>
	    		<td><select id = "bankname" name = "bank">
	    			<option value = "">-은행선택-</option>
	    			<option value = "기업은행">기업은행</option>
	    			<option value = "국민은행">국민은행</option>
	    			<option value = "농협은행">농협은행</option>
	    			<option value = "우리은행">우리은행</option>
	    			<option value = "신한은행">신한은행</option>
	    			<option value = "삼성증권">삼성증권</option>
	    			<option value = "새마을금고">새마을금고</option>
	    			<option value = "카카오뱅크">카카오뱅크</option>
	    		</select></td>
	    	</tr>
	    	
	    	<tr>
	    		<td>계좌번호</td>
	    		<td><input type = "text" id = "acount" name = "acc" value = "${acc}"><br>
	    		'-'와 숫자만 입력해주세요.</td>
	    	</tr>
	    	
	    	<tr>
	    		<td>비밀번호 확인<img src = "../ascloimage/snorlax.png" width = "12px" height = "12px"></td>
	    		<td><input type = "password" id = "userpwd" name = "pwd"><br>
	    		등록된 비밀번호를 확인합니다.</td>
	    	</tr>
	    </table>
	    
	    <div style = "text-align:center; margin: 30px 0px 10px 0px;" id = "changebtn">
	    	<input type = "submit" id = "change" value = "변경">
	    	<input type = "button" id = "cancel" value = "취소" onclick = "self.close();">
	    </div>
    
    </form>
</body>
</html>