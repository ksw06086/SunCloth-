<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file = "setting.jsp" %>
<link type = "text/css" rel = "stylesheet" href = "${project}cssall/h_noticewrite.css"/>
<html>
<body>
<%@ include file = "topmenu.jsp" %>

<section>
<form action = "h_noticePro" method = "post" name = "h_noticeform" enctype="multipart/form-data">
	<input type = "hidden" name = "choose" value = "${choose}">
	<input type = "hidden" name = "num" value = "${num}">
	<input type = "hidden" name = "ref" value = "${ref}">
	<input type = "hidden" name = "ref_step" value = "${ref_step}">
	<input type = "hidden" name = "ref_level" value = "${ref_level}">
	<table id = "middle">
		<col style = "width:15%;">
		<col>
		<tr>
			<%@ include file = "h_boardLeft.jsp" %>
			<td id = "tabright">
				<div id = "righttop">
					<p><input type = "button" value = "게시글 리스트" id = "boardlist" onclick = "window.location = 'h_notice?choose=${choose}'"></p>
					<p><b>[공지] 게시글 등록</b></p>
					<p><input type = "submit" value = "저장" id = "save"></p>
				</div>
				
				<div id = "product">
					<table id = "faq">
						<col style = "width:20%">
						<col>
						<tr>
							<td>작성자</td>
							<td>
							관리자(${sessionScope.memId})
							</td>
						</tr>
						<tr>
							<td>제목</td>
							<td>
							<input type = "text" id = "question" name = "subject" 
							placeholder = "제목을 입력하세요!" maxlength = "400" style = "width:300px;" required>
							</td>
						</tr>
				     	
				     	<tr>
							<td>내용</td>
				     		<td>
				     		<textarea class = "Box" rows="30" cols="80" maxlength = "4000"
			    			style="resize: vertical; width:100%;" name = "content" 
			    			required word-break:break-all placeholder = "글내용을 입력하세요!"></textarea>
				     		</td>
				     	</tr>
				     	
						<tr>
			    			<td style = "border-right:1px solid #ccc;">첨부파일1</td>
			    			<td><input type = "file" id = "attachfile1" name = "file1"></td>
			    		</tr>
			    		<tr>
			    			<td style = "border-right:1px solid #ccc;">첨부파일2</td>
			    			<td><input type = "file" id = "attachfile2" name = "attachfileN2"></td>
			    		</tr>
			    		<tr>
			    			<td style = "border-right:1px solid #ccc;">첨부파일3</td>
			    			<td><input type = "file" id = "attachfile3" name = "attachfileN3"></td>
			    		</tr>
			    		<tr>
			    			<td style = "border-right:1px solid #ccc;">첨부파일4</td>
			    			<td><input type = "file" id = "attachfile4" name = "attachfileN4"></td>
			    		</tr>
			    		<tr>
			    			<td style = "border-right:1px solid #ccc;">첨부파일5</td>
			    			<td><input type = "file" id = "attachfile5" name = "attachfileN5"></td>
			    		</tr>
					</table>
		    	</div>
			</td>
		</tr>
	</table>
</form>
</section>
</body>
</html>