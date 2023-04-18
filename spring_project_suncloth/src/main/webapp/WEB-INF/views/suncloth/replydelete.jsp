<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="setting.jsp" %>
<html>
<body>
	<h2> 삭제 처리 되었습니다. </h2>
<c:if test="${dcnt == 0}">
<script type = "text/javascript">
	errorAlert("댓글삭제가 처리되지 못했습니다 다시 클릭해주세요.");
</script>
</c:if>
<c:if test="${dcnt != 0}">
<script type = "text/javascript">
	alert("답글 삭제가 정상 처리되었습니다.");
	window.location = "reviewForm?choose=${choose}&pageNum=${pageNum}&rpageNum=${rpageNum}&number=${number}&num=${num}";
</script>
</c:if>
</body>
</html>