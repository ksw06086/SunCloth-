<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file = "setting.jsp" %>
<link type = "text/css" rel = "stylesheet" href = "${project}cssall/best.css"/>
<html>
<body>
<%@ include file = "topmanu.jsp" %>

    <div id = "road">
		<p>home > only asclo</p>
	</div>
	
	<div id = "topname">
		<p><b>ONLY ASCLO</b></p>
	</div>

	<div id = "prdlisttop" style = "width:100%; margin:20px 0px 800px;">
		<p id = "listtotal">Total : <span style = "color:#000">0</span> items</p>
		<p id = "sortway"><span>신상품</span> | <span>상품명</span> | <span>낮은가격</span> | <span>높은가격</span> | <span>사용후기</span></p>
	</div>
	
<%@ include file = "bottommenu.jsp" %>
</body>
</html>