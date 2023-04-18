<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file = "setting.jsp" %>
<link type = "text/css" rel = "stylesheet" href = "${project}cssall/h_noticewrite.css"/>
<html>
<body>
<%@ include file = "topmenu.jsp" %>

<section>
<form action = "h_noticeUpdatePro" method = "post" name = "h_noticeform">
	<input type = "hidden" name = "choose" value = "${choose}">
	<input type = "hidden" name = "num" value = "${num}">
	<input type = "hidden" name = "pageNum" value = "${pageNum}">
	<table id = "middle">
		<col style = "width:15%;">
		<col>
		<tr>
			<%@ include file = "h_boardLeft.jsp" %>
			<td id = "tabright">
				<div id = "righttop">
					<p><input type = "button" value = "게시글 리스트" id = "boardlist" onclick = "window.location = 'h_notice?pageNum=${pageNum}&choose=${choose}'"></p>
					<p><b>[공지] 게시글 수정</b></p>
					<p><input type = "button" value = "삭제" id = "save" onclick = "window.location = 'h_noticedeletePro?onenum=${num}&choose=${choose}&pageNum=${pageNum}'">
					<input type = "submit" value = "저장" id = "save"></p>
				</div>
				
				<div id = "product">
					<table id = "faq">
						<col style = "width:20%">
						<col>
						<tr>
							<td>글번호</td>
							<td>
							${number}
							</td>
						</tr>
						<tr>
							<td>작성자</td>
							<td>
							관리자(${vo.id})
							</td>
						</tr>
						<tr>
							<td>제목</td>
							<td>
							${vo.subject}
							</td>
						</tr>
				     	
				     	<tr>
							<td>내용</td>
				     		<td>
				     		<textarea class = "Box" rows="30" cols="80" maxlength = "4000"
			    			style="resize: vertical; width:100%;" name = "content" 
			    			required word-break:break-all placeholder = "글내용을 입력하세요!">${vo.content}
							</textarea>
							<c:if test="${vo.file1 != null}">
								<img src="${project}fileready/${vo.file1}" width = "5%">
							</c:if></td>
			    		</tr>
			    		<tr>
			    			<td style = "border-right:1px solid #ccc;">첨부파일1</td>
			    			<td>
			    			<c:if test="${vo.file1 != null}">
								<input type = "file" id = "attachfile1" name = "file1" value = "${vo.file1}">
							</c:if>
			    			<c:if test="${vo.file1 == null}">
								<input type = "file" id = "attachfile1" name = "file1">
							</c:if>
			    			</td>
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