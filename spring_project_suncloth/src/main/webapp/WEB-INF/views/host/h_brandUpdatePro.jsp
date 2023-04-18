<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="setting.jsp" %>
<html>
<body>
	<h2> 정상 수정 처리 되었습니다. </h2>
<c:if test="${cnt == 0}">
<script type = "text/javascript">
	errorAlert("응 수정 안됐어~~~");
</script>
</c:if>
<c:if test="${cnt != 0}">
<script type = "text/javascript">
	alert("수정이 정상 처리되었습니다.");
	window.location = "h_brand?pageNum=${pageNum}";
</script>
</c:if>
</body>
</html>