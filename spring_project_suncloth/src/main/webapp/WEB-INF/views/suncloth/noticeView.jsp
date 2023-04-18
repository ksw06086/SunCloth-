<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file = "setting.jsp" %>
<link type = "text/css" rel = "stylesheet" href = "${project}cssall/noticeView.css"/>
<html>
<body>
<%@ include file = "topmanu.jsp" %>

    <div id = "road">
		<p>home > notice</p>
	</div>
	
	<div id = "topname">
		<p><b>NOTICE</b></p>
	</div>
	
	<div id = "topnamesub">
		<p><b>애즈클로의 공지사항입니다.:)</b></p>
	</div>
     
    <div id = "notice" class = "oneandone">
    	<table width = "100%">
    	<col style = "width: 15%;">
    	<col style = "width: 85%;">
    		<tr>
    			<td>제목</td>
    			<td>${vo.subject}</td>
    		</tr>
    		
    		<tr>
    			<td>작성자</td>
    			<td><b>${vo.id}</b></td>
    		</tr>
    	</table>
    </div>
    
    <div id = "content" name = "contents">
    	<c:if test="${vo.file1 != null}">
			<img src="${project}fileready/${vo.file1}" width = "46%">
		</c:if>
    	
    	<p>${vo.content}</p>
    </div>
    
    
    <div id = "golist" style = "margin: 10px 0px 50px; text-align: right;">
    	<a href = "notice?num=${num}&number=${number}&pageNum=${pageNum}&choose=${choose}">
    	<input type = "submit" id = "list" name = "listN" value = "목록"  style = "font-size: .7em;"></a>
    </div>
    
    <div id = "beforeNafter">
    	<table>
    		<col style = "width: 10%;">
    		<col style = "width: 90%;">
    		<c:if test="${vo.fwsubject != null}">
	    		<tr id = "before">
	    			<td><img src = "ascloimage/up.png" width = "12px" height = "12px">이전글</td>
	    			<td><a href = "noticeForm?num=${vo.fwnum}&number=${number-1}&pageNum=${pageNum}&choose=${choose}">${vo.fwsubject}</a></td>
	    		</tr>
    		</c:if>
    		<c:if test="${vo.nextsubject != null}">
	    		<tr id = "after">
	    			<td><img src = "ascloimage/down.png" width = "12px" height = "12px">다음글</td>
	    			<td><a href = "noticeForm?num=${vo.nextnum}&number=${number+1}&pageNum=${pageNum}&choose=${choose}">${vo.nextsubject}</a></td>
	    		</tr>
    		</c:if>
    	</table>
    </div>
	
<%@ include file = "bottommenu.jsp" %>
</body>
</html>