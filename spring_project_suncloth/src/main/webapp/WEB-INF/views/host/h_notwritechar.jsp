<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file = "setting.jsp" %>
<link type = "text/css" rel = "stylesheet" href = "${project}cssall/h_notwritechar.css"/>
<html>
<body>
<%@ include file = "topmenu.jsp" %>

<section>
	<table id = "middle">
		<col style = "width:15%;">
		<col>
		<tr>
			<%@ include file = "h_boardLeft.jsp" %>
			<td id = "tabright">
				<div id = "righttop">
					<p><b>금칙어관리</b></p>
					<p><input type = "button" value = "저장" id = "save"></p>
				</div>
				
				<div id = "product">
					<table id = "persontop">
						<tr>
							<td>
							<b>·금칙어 관리</b>
							</td>
						</tr>
					</table>
					
					<table id = "person">
						<col style = "width:20%">
						<col>
						<tr>
							<td rowspan = "2">금칙어검색</td>
							<td>
							금칙어
							<input type = "text" id = "notwrite" name = "notwritechar">
							<input type = "button" id = "srch" name = "srch" value = "검색">
							<input type = "button" id = "srchdel" name = "srchdel" value = "삭제">
							</td>
						</tr>
						
						<tr>
							<td>
							<textarea class = "Box" rows="30" cols="80" 
			    			style="resize: vertical; width:100%;">꺼져, ㅅㅂ, 빈형, 편두염, 쓰레기</textarea>
							</td>
						</tr>
					</table>
		    	</div>
			</td>
		</tr>
	</table>
</section>
</body>
</html>