<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file = "setting.jsp" %>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h2> 회원정보 수정 </h2>
<c:if test = "${ucnt == 0}">
<script type = "text/javascript">
	errorAlert(updateError);
</script>
</c:if>
<c:if test="${ucnt != 0}">
<script type = "text/javascript">
	alert("수정이 정상 처리되었습니다.");
	window.location = "h_member?pageNum=${pageNum}";
</script>
</c:if>
</body>
</html>