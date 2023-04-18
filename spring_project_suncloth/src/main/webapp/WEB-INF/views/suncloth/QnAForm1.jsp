<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file = "setting.jsp" %>
<link type = "text/css" rel = "stylesheet" href = "${project}cssall/qnaForm.css"/>
<html>
<body>
<%@ include file = "topmanu.jsp" %>

    <div id = "road">
		<p>home > q&a</p>
	</div>
	
	<div id = "topname">
		<p><b>Q&A</b></p>
	</div>
    
    <div id = "detaillist">
    	<table>
    		<tr>
    			<td>상품문의&nbsp;&nbsp;&nbsp;|
    			&nbsp;&nbsp;&nbsp;배송문의&nbsp;&nbsp;&nbsp;|
    			&nbsp;&nbsp;&nbsp;입금확인문의&nbsp;&nbsp;&nbsp;|
    			&nbsp;&nbsp;&nbsp;주문/변경/취소/환불문의&nbsp;&nbsp;&nbsp;|
    			&nbsp;&nbsp;&nbsp;기타문의</td>
    		</tr>
    	</table>
    </div>
	
     <form name = "qnadoor" action = "QnAForm" method = "post"
     onsubmit = "return inputCheck();">
     	<input type = "hidden" name = "num" value = "${num}">
     	<input type = "hidden" name = "number" value = "${number}">
     	<input type = "hidden" name = "pageNum" value = "${pageNum}">
     	<input type = "hidden" name = "choose" value = "${choose}">
     	<fieldset id = "goqna" style = "margin-top: 10px;">
     		<table>
     			<col style = "width: 400px;">
     			<col style = "width: 600px;">
     			<tr>
     				<td style = "font-size:.7em; color: gray;" colspan = "2">
     				이 글은 비밀글입니다. <b>비밀번호를 입력하요 주세요.</b></td>
     			</tr>
     			<tr>
     				<td style = "font-size:.7em; color: gray;" colspan = "2">
     				관리자는 확인버튼만 누르시면 됩니다.</td>
     			</tr>
     			<tr>
     				<td colspan = "2"><br></td>
     			</tr>
     			<tr>
     				<td>
     				<b>비밀번호</b>
     				</td>
     				<td><input type = "password" id = "userpwd" name = "pwd" style = "width:98%;"></td>
     			</tr>
     			
     			<tr>
     				<td colspan = "2"><a href = "QnA?num=${num}&number=${number}&pageNum=${pageNum}&choose=${choose}">
    				<input type = "button" id = "list" name = "listN" value = "목록"  style = "font-size: .7em;"></a>
     				<input type = "submit" id = "ok" value = "확인"></td>
     			</tr>
     		</table>
     	</fieldset>
     </form>
	
<%@ include file = "bottommenu.jsp" %>
</body>
</html>