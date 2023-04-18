<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file = "setting.jsp" %>
<link type = "text/css" rel = "stylesheet" href = "${project}cssall/QnAwrite.css"/>
<html>
<script type="text/javascript">
$(function() {
	$("input[name = 'textType']").change(function(){
		if(document.QnAwriteForm.textType.value == "open"){
			$("input[type = 'password']").prop("disabled", true);
		} else {
			$("input[type = 'password']").prop("disabled", false);
		}
	})
});
</script>
<body>
<%@ include file = "topmanu.jsp" %>

<section>
<form action = "QnAPro" method = "post" name = "QnAwriteForm" enctype="multipart/form-data">
	<input type = "hidden" name = "choose" value = "${choose}">
	<input type = "hidden" name = "pageNum" value = "${pageNum}">
	<input type = "hidden" name = "num" value = "${num}">
	<input type = "hidden" name = "ref" value = "${ref}">
	<input type = "hidden" name = "ref_step" value = "${ref_step}">
	<input type = "hidden" name = "ref_level" value = "${ref_level}">
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
	
	<%--<div id = "prddata" class = "oneandone">
    	<table width = "100%">
    	<col style = "width: 10%;">
    	<col style = "width: 90%;">
    		<tr>
    			<td rowspan = "2" style = "text-align:center; padding: 10px 0px;"><div id = "image" 
    			style = "background-color:#ccc; width: 100px; height: 100px; line-height:100px; margin:0px auto;">
    			No image</div></td>
    			<td style = "padding: 0px 0px 15px;"><input type = "button" id = "detailprd" name = "detailprdN" value = "상품정보선택" style = "font-size: .9em;">
    			</td>
    		</tr>
    	</table>
    </div>--%>
	
     
    <div id = "review" class = "oneandone">
    	<table width = "100%">
    	<col style = "width: 15%;">
    	<col style = "width: 85%;">
    		<tr>
    			<td style = "border-right:1px solid #ccc;">제목</td>
    			<td>
    			<select id = "Qtype" name = "Qtype" style = "width: 100px; padding: 5px 0px; font-size:.9em; vertical-align: middle;">
    				<option value = "상품문의">상품문의</option>
    				<option value = "배송문의">배송문의</option>
    				<option value = "입금확인문의">입금확인문의</option>
    				<option value = "주문/변경/취소/환불문의">주문/변경/취소/환불문의</option>
    				<option value = "기타문의">기타문의</option>
    			</select>
    			<select id = "title" name = "subject" style = "width: 300px; padding: 5px 0px; font-size:.9em; vertical-align: middle;">
    				<option value = "Hello, asclo :)">Hello, asclo :)</option>
    			</select></td>
    		</tr>
    		<tr>
    			<td colspan = "2">
    			<textarea class = "Box" rows="30" cols="95" name = "content"
    			style="resize: vertical; width:100%; border:none;"></textarea></td>
    		</tr>
    		<tr>
    			<td style = "border-right:1px solid #ccc;">첨부파일1</td>
    			<td><input type = "file" id = "attachfile1" name = "file1"></td>
    		</tr>
    		<tr>
    			<td style = "border-right:1px solid #ccc;">비밀번호</td>
    			<td><input type = "password" id = "userpwd" name = "pwd" style = "width:200px;" disabled = "true"></td>
    		</tr>
    		<tr>
    			<td style = "border-right:1px solid #ccc;">비밀글설정</td>
    			<td><input type = "radio" id = "open" name = "textType" value = "open" checked>
    			<label for = "open">공개글</label>
    			<input type = "radio" id = "close" name = "textType" value = "close">
    			<label for = "close">비밀글</label>
    			</td>
    		</tr>
    	</table>
    </div>
    
    
    <div id = "golist" style = "margin: 10px 0px 50px; text-align: right;">
    	<input type = "button" id = "list" name = "listN" value = "목록"  style = "font-size: .7em;" 
    	onclick = "window.location = 'QnA?num=${num}&number=${number}&choose=${choose}'">
    	<input type = "button" id = "cancel" name = "cancelN" value = "취소"  style = "font-size: .7em;" 
    	onclick = "QnA?num=${num}&number=${number}&choose=${choose}">
    	<input type = "submit" id = "input" name = "inputN" value = "등록"  style = "font-size: .7em;">
    </div>
    
</form>
</section>

<%@ include file = "bottommenu.jsp" %>
</body>
</html>