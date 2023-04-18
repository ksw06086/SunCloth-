<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<link type = "text/css" rel = "stylesheet" href = "${project}cssall/h_boardLeft.css"/>
<html>
<body>
<td id = "tableft">
	<div id = "left">
		<table id = "menu">
			<tr>
				<td><b>·운영</b></td>
			</tr>
			<tr>
				<td>&emsp;<a href = "boardView">게시판 리스트</a></td>
			</tr>
			<tr>
				<td>&emsp;&emsp;<a href = "h_notice?choose=1">공지사항</a></td>
			</tr>
			<tr>
				<td>&emsp;&emsp;<a href = "h_FAQ?choose=2">FAQ</a></td>
			</tr>
			<tr>
				<td>&emsp;&emsp;<a href = "h_QnA?choose=3">Q&A</a></td>
			</tr>
			<tr>
				<td>&emsp;&emsp;<a href = "h_review?choose=4">후기</a></td>
			</tr>
			<tr>
				<td>&emsp;<a href = "h_notwritechar">금칙어관리</a></td>
			</tr>
		</table>
	</div>
</td>
</body>
</html>