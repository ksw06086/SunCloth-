<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file = "setting.jsp" %>
<link type = "text/css" rel = "stylesheet" href = "${project}cssall/QnAForm2.css"/>
<html>
<body>
<c:if test="${cnt == 0}">
<script type = "text/javascript">
	errorAlert(passwdError);
</script>
</c:if>
<c:if test="${cnt != 0}">
<%@ include file = "topmanu.jsp" %>

    <div id = "road">
		<p>home > qna</p>
	</div>
	
	<div id = "topname">
		<p><b>Q&A</b></p>
	</div>
	
	<%--<div id = "prddata" class = "oneandone">
    	<table width = "100%">
    	<col style = "width: 20%;">
    	<col style = "width: 80%;">
    		<tr>
    			<td rowspan = "2" style = "text-align:center; padding: 10px 0px;"><img src = "./ascloimage/jang1.jpg" width = "100px" height = "100px" style = "vertical-align: middle;"></td>
    			<td><img src = "../ascloimage/n.png" width = "10px" height = "10px" style = "vertical-align: middle;"><br>
    			장원영의 이쁜 티셔츠(3color)<br>
    			KRW 37,000</td>
    		</tr>
    		<tr>
    			<td style = "padding: 0px 0px 15px;"><input type = "submit" id = "detailprd" name = "detailprdN" value = "상품 상세보기" style = "font-size: .9em;">
    			</td>
    		</tr>
    	</table>
    </div>--%>
	
     
    <div id = "notice" class = "oneandone">
    	<table width = "100%">
    	<col style = "width: 15%;">
    	<col style = "width: 85%;">
    		<tr>
    			<td>문의구분</td>
    			<td>${vo.state}</td>
    		</tr>
    		<tr>
    			<td>제목</td>
    			<td>${vo.subject}</td>
    		</tr>
    		
    		<tr>
    			<td>작성자</td>
    			<td><b>${vo.writer}</b></td>
    		</tr>
    	</table>
    </div>
    
    <div id = "content" name = "contents">
    	<p>${vo.content}</p>
    	
    	<c:if test="${vo.file1 != null}">
			<img src="${project}fileready/${vo.file1}" width = "46%">
		</c:if>
    </div>
    
    <div id = "golist" style = "margin: 10px 0px 50px; text-align: right;">
    	<c:if test="${sessionScope.memCnt == 1}">
    	<input type = "button" id = "list" name = "back" value = "뒤로가기"  style = "font-size: .7em;"
    	onclick = "window.history.back();">
    	</c:if>
    	<a href = "QnA?num=${num}&number=${number}&pageNum=${pageNum}&choose=${choose}">
    	<input type = "submit" id = "list" name = "listN" value = "목록"  style = "font-size: .7em;"></a>
    	<c:if test="${vo.writer == sessionScope.memId}">
    	<a href = "QnAupdate?num=${num}&number=${number}&pageNum=${pageNum}&choose=${choose}">
    	<input type = "submit" id = "list" name = "update" value = "수정"  style = "font-size: .7em;"></a>
    	<a href = "QnAdeletePro?onenum=${num}&number=${number}&pageNum=${pageNum}&choose=${choose}">
    	<input type = "submit" id = "list" name = "delete" value = "삭제"  style = "font-size: .7em;"></a>
    	</c:if>
    </div>
    
    <div id = "beforeNafter">
    	<table>
    		<col style = "width: 10%;">
    		<col style = "width: 90%;">
    		<c:if test="${vo.fwsubject != null}">
	    		<tr id = "before">
	    			<td><img src = "ascloimage/up.png" width = "12px" height = "12px">이전글</td>
	    			<td><a href = "QnAForm?num=${vo.fwnum}&number=${number-1}&pageNum=${pageNum}&choose=${choose}&textType=${vo.fwtextType}">${vo.fwsubject}</a></td>
	    		</tr>
    		</c:if>
    		<c:if test="${vo.nextsubject != null}">
	    		<tr id = "after">
	    			<td><img src = "ascloimage/down.png" width = "12px" height = "12px">다음글</td>
	    			<td><a href = "QnAForm?num=${vo.nextnum}&number=${number+1}&pageNum=${pageNum}&choose=${choose}&textType=${vo.nexttextType}">${vo.nextsubject}</a></td>
	    		</tr>
    		</c:if>
    	</table>
    </div>
	
<%@ include file = "bottommenu.jsp" %>
</c:if>
</body>
</html>