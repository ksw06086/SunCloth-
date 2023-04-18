<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file = "setting.jsp" %>
<link type = "text/css" rel = "stylesheet" href = "${project}cssall/h_QnAinputForm.css"/>
<html>
<body>
<%@ include file = "topmenu.jsp" %>

<section>
<form action = "h_QnAupdatePro" method = "post" name = "h_QnAform" enctype="multipart/form-data">
	<input type = "hidden" name = "choose" value = "${choose}">
	<input type = "hidden" name = "pageNum" value = "${pageNum}">
	<input type = "hidden" name = "num" value = "${vo.num}">
	<input type = "hidden" name = "ref" value = "${vo.ref}">
	<input type = "hidden" name = "ref_step" value = "${vo.ref_step}">
	<input type = "hidden" name = "ref_level" value = "${vo.ref_level}">
	<table id = "middle">
		<col style = "width:15%;">
		<col>
		<tr>
			<%@ include file = "h_boardLeft.jsp" %>
			<td id = "tabright">
				<div id = "righttop">
					<p><input type = "button" value = "게시글 리스트" id = "boardlist" onclick = "window.location = 'h_notice?choose=${choose}'"></p>
					<p><b>[FAQ] 게시글 수정</b></p>
					<p><input type = "button" value = "삭제" id = "save" onclick = "window.location = 'QnAdeletePro?onenum=${num}&choose=${choose}&pageNum=${pageNum}'">
					<input type = "submit" value = "저장" id = "save"></p>
				</div>
				<div id = "product">
					<table id = "persontop">
						<tr>
							<td>
							<b>·개인정보</b>
							</td>
						</tr>
					</table>
					
					<div id = "prddata" class = "oneandone">
				    	<table width = "100%">
				    	<col style = "width: 20%;">
				    	<col style = "width: 80%;">
				    		<tr>
				    			<td rowspan = "2" style = "text-align:center; padding: 10px 0px;"><img src = "../ascloimage/jang1.jpg" width = "100px" height = "100px" style = "vertical-align: middle;"></td>
				    			<td><img src = "../ascloimage/n.png" width = "10px" height = "10px" style = "vertical-align: middle;"><br>
				    			장원영의 이쁜 티셔츠(3color)<br>
				    			KRW 37,000</td>
				    		</tr>
				    		<tr>
				    			<td style = "padding: 0px 0px 15px;"><input type = "submit" id = "detailprd" name = "detailprdN" value = "상품 상세보기" style = "font-size: .9em;">
				    			</td>
				    		</tr>
				    	</table>
				    </div>
					
				     
				    <div id = "notice" class = "oneandone">
				    	<table width = "100%">
				    	<col style = "width: 15%;">
				    	<col style = "width: 85%;">
				    		<tr>
				    			<td>문의구분</td>
				    			<td>${basevo.state}</td>
				    		</tr>
				    		<tr>
				    			<td>제목</td>
				    			<td>${basevo.subject}</td>
				    		</tr>
				    		
				    		<tr>
				    			<td>작성자</td>
				    			<td><b>${basevo.writer}</b></td>
				    		</tr>
				    	</table>
				    </div>
					
					<table id = "qnatop">
						<tr>
							<td>
							<b>·관리자 답변</b>
							</td>
						</tr>
					</table>
					
					<input type = "hidden" name = "writestate" value = "답변완료">
					<table id = "qna">
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
							<input type = "text" id = "question" name = "Qtype" 
							value = "${vo.state}" style = "width:120px;" readonly>
							<input type = "text" id = "question" name = "subject" 
							value = "${vo.subject}" style = "width:300px;" readonly>
							</td>
						</tr>
				     	
				     	<tr>
							<td>내용</td>
				     		<td>
				     		<textarea class = "Box" rows="30" cols="80" name = "content"
			    			style="resize: vertical; width:100%;">
			    			${vo.content}&nbsp;
			    			<c:if test="${vo.file1 != null}">
								<img src="${project}fileready/${vo.file1}" width = "46%">
							</c:if>
			    			</textarea>
				     		</td>
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
			    		
			    		<c:if test="${vo.textType == 'close'}">
			    			<tr>
				    			<td style = "border-right:1px solid #ccc;">비밀번호</td>
				    			<td><input type = "password" id = "userpwd" name = "pwd" style = "width:200px;" readonly value = "${vo.pwd}"></td>
				    		</tr>
							<input type = "hidden" name = "textType" value = "close">
			    		</c:if>
			    		<c:if test="${vo.textType == 'open'}">
			    			<input type = "hidden" id = "userpwd" name = "pwd">
			    			<input type = "hidden" name = "textType" value = "open">
			    		</c:if>
					</table>
		    	</div>
			</td>
		</tr>
	</table>
</form>
</section>
</body>
</html>