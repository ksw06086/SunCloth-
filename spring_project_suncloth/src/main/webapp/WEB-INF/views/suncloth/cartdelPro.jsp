<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="setting.jsp" %>
<html>
<body>
	<h2> 삭제 처리 되었습니다. </h2>
<c:if test="${dcnt == 0}">
<script type = "text/javascript">
	errorAlert(deleteError);
</script>
</c:if>
<c:if test="${dcnt != 0}">
<script type = "text/javascript">
	alert("삭제가 정상 처리되었습니다.");
	window.location = "cart";
</script>
</c:if>
</body>
</html>