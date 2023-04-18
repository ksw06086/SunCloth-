<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file = "setting.jsp" %>
<link type = "text/css" rel = "stylesheet" href = "${project}cssall/h_productinput.css"/>
<html>
<script type = "text/javascript">
function start() {
	$("#with").css("display","none");
	$("#main").css("display", "");
	$(".file").css("display", "none");
}

function changes(){
	$(function() {
		if($("select[name = 'typesel'] > option:selected").index() == 0){
			$("#main").css("display","");
			$(".file").css("display","none");
			$("#with").css("display","none");
			return false;
		}
		if($("select[name = 'typesel'] > option:selected").index() == 1){
			$("#main").css("display","none");
			$(".file").css("display","");
			$("#with").css("display","none");
			return false;
		}
		if($("select[name = 'typesel'] > option:selected").index() == 2){
			$("#main").css("display","none");
			$(".file").css("display","none");
			$("#with").css("display","");
			return false;
		}
	});
}
</script>
<body onload = "start();">
<%@ include file = "topmenu.jsp" %>
<section>
	<table id = "middle">
		<col style = "width:15%;">
		<col>
		<tr>
			<%@ include file = "h_productLeft.jsp" %>
			<td id = "tabright">
			<form method="post" name = "productupdateForm" enctype="multipart/form-data">
				<input type = "hidden" name = "choose" value = "${choose}">
				<input type = "hidden" name = "num" value = "${num}">
				<input type = "hidden" name = "pageNum" value = "${pageNum}">
				<div id = "righttop">
					<p><input type = "button" value = "상품리스트" id = "prdlist"></p>
					<p><b>판매상품관리</b></p>
				</div>
				
				<div id = "product">
					<table id = "basetop">
						<tr>
							<td>
							<b>·상품파일정보</b>
							</td>
						</tr>
					</table>
					
					<table id = "base">
						<col style = "width:20%">
						<col>
						<tr>
		    				<td>회원유형</td>
		    				<td>
		    					<select id = "type" name = "typesel" onchange = "changes();" style = "width:100%; padding: 7px 0px; font-size: .9em;">
		    						<option value = "guest">main images</option>
		    						<option value = "host">files</option>
		    						<option value = "with">with item</option>
		    					</select>
		    				</td>
		    			</tr>
						<tr id = "main">
			    			<td style = "border-right:1px solid #ccc;">메인 이미지1</td>
			    			<td>
			    			<input type = "file" id = "attachfile1" name = "mainfile">
			    			<input type = "submit" value = "수정" name = "mainupdate" onclick = "javascript: productupdateForm.action = 'h_productmainfileupdatePro'">
			    			</td>
			    		</tr>
						<tr class = "file">
			    			<td style = "border-right:1px solid #ccc;">첨부파일1</td>
			    			<td><input type = "file" id = "attachfile1" name = "file1"></td>
			    		</tr>
			    		<tr class = "file">
			    			<td style = "border-right:1px solid #ccc;">첨부파일2</td>
			    			<td><input type = "file" id = "attachfile2" name = "file2"></td>
			    		</tr>
			    		<tr class = "file">
			    			<td style = "border-right:1px solid #ccc;">첨부파일3</td>
			    			<td><input type = "file" id = "attachfile3" name = "file3"></td>
			    		</tr>
			    		<tr class = "file">
			    			<td style = "border-right:1px solid #ccc;">첨부파일4</td>
			    			<td><input type = "file" id = "attachfile4" name = "file4"></td>
			    		</tr>
			    		<tr class = "file">
			    			<td style = "border-right:1px solid #ccc;">첨부파일5</td>
			    			<td><input type = "file" id = "attachfile5" name = "file5"></td>
			    		</tr>
			    		<tr class = "file">
			    			<td colspan = "2"><input type = "submit" name = "fileupdate" value = "수정" onclick = "javascript: productupdateForm.action = 'h_productfilesupdatePro'"></td>
			    		</tr>
			    		<tr id = "with">
			    			<td style = "text-align:center; padding: 10px 0px;">
			    			<input type = "hidden" name = "withitem" value = "">
			    			<div id = "image" style = "background-color:#ccc; width: 100px; height: 100px; line-height:100px; margin:0px auto;">
			    			No image</div></td>
			    			<td><input type = "button" id = "detailprd"
			    			 onclick = "withproductChk();" name = "detailprdN" value = "상품정보선택" style = "vertical-align:middle; font-size: .9em;">
			    			<input type = "submit" name = "withitemupdate" value = "수정" onclick = "javascript: productupdateForm.action = 'h_productwithitemsupdatePro'">
			    			</td>
			    		</tr>
					</table>
		    	</div>
		    	</form>
			</td>
		</tr>
	</table>
</section>
</body>
</html>