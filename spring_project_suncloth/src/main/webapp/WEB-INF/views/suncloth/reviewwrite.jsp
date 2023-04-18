<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file = "setting.jsp" %>
<link type = "text/css" rel = "stylesheet" href = "${project}cssall/reviewwrite.css"/>
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
<form action = "reviewPro" method = "post" name = "reviewwriteForm" enctype="multipart/form-data">
	<input type = "hidden" name = "choose" value = "${choose}">
	<input type = "hidden" name = "pageNum" value = "${pageNum}">
	<input type = "hidden" name = "num" value = "${num}">
	<input type = "hidden" name = "ref" value = "${ref}">
	<input type = "hidden" name = "ref_step" value = "${ref_step}">
	<input type = "hidden" name = "ref_level" value = "${ref_level}">
	<div id = "road">
		<p>home > review</p>
	</div>
	
	<div id = "topname">
		<p><b>REVIEW</b></p>
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
    			<input type = "text" id = "title" name = "subject" style = "width:300px;"></td>
    		</tr>
    		<tr>
    			<td colspan = "2">
    			<textarea class = "Box" rows="30" cols="95" name = "content"
    			style="resize: vertical; width:100%; border:none;">※리뷰작성 시 최대 적립금 2,000원 지급!(50자 이상 리뷰 작성시)
(일반리뷰 500원 / 상품포토리뷰 1000 / 상품착용포토리뷰(키,몸무게,구매사이즈(컬러) '작성필수') 2,000원)

키(cm):
몸무게(kg):
구매사이즈(컬러):
상품리뷰:</textarea></td>
    		</tr>
    		<tr>
    			<td style = "border-right:1px solid #ccc;">첨부파일1</td>
    			<td><input type = "file" id = "attachfile1" name = "file1"></td>
    		</tr>
    	</table>
    </div>
    
    
    <div id = "golist" style = "margin: 10px 0px 50px; text-align: right;">
    	<input type = "button" id = "list" name = "listN" value = "목록"  style = "font-size: .7em;" 
    	onclick = "window.location = 'review?num=${num}&number=${number}&choose=${choose}'">
    	<input type = "button" id = "cancel" name = "cancelN" value = "취소"  style = "font-size: .7em;" 
    	onclick = "window.location = 'review?num=${num}&number=${number}&choose=${choose}'">
    	<input type = "submit" id = "input" name = "inputN" value = "등록"  style = "font-size: .7em;">
    </div>
    
</form>
</section>

<%@ include file = "bottommenu.jsp" %>
</body>
</html>