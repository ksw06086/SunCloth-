<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file = "setting.jsp" %>
<link type = "text/css" rel = "stylesheet" href = "${project}cssall/h_board.css"/>
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
					<p><b>게시판 리스트</b></p>
				</div>
				<div id = "result">
					<table id = "boardlist">
				    	<col style = "width:5%;">
				    	<col style = "width:20%;">
				    	<col>
				    	<col style = "width:20%;">
				    	<tr id = "title">
				    		<td>번호</td>
				    		<td>게시판 아이디</td>
				    		<td>게시판 이름</td>
				    		<td>새글/총게시글</td>
				    	</tr>
				    	<tr class = "borad">
				    		<td>4</td>
				    		<td><a href = "h_notice?choose=1">notice</a></td>
				    		<td>공지</td>
				    		<td>0/0</td>
				    	</tr>
				    	<tr class = "borad">
				    		<td>3</td>
				    		<td><a href = "h_FAQ?choose=2">FAQ</a></td>
				    		<td>FAQ</td>
				    		<td>0/0</td>
				    	</tr>
				    	<tr class = "borad">
				    		<td>2</td>
				    		<td><a href = "h_QnA?choose=3">Q&A</a></td>
				    		<td>문의</td>
				    		<td>0/0</td>
				    	</tr>
				    	<tr class = "borad">
				    		<td>1</td>
				    		<td><a href = "h_review?choose=4">review</a></td>
				    		<td>후기</td>
				    		<td>0/0</td>
				    	</tr>
				    </table>
				    
				    <table id = "buttons" style = "width:98%; padding: 10px 0px 0px; margin:0 auto;">
				    	<tr>
				    		<td style = "text-align:center; padding: 15px;"> < &emsp;&emsp; 1 &emsp; &emsp;> </td>
				    	</tr>
				    </table>
				</div>
			</td>
		</tr>
	</table>
</section>
</body>
</html>