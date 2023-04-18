<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="setting.jsp" %>
<html>
<body>
	<h2> 삭제 처리 되었습니다. </h2>
<c:if test="${dcnt == 0}">
<script type = "text/javascript">
	errorAlert("후기가 정상삭제가 되지 못했습니다. 다시 시도해주세요.");
</script>
</c:if>
<c:if test="${dcnt != 0}">
<script type = "text/javascript">
	alert("삭제가 정상 처리되었습니다.");
	if(${sessionScope.memCnt} == 0){
		window.location = "review?choose=${choose}&pageNum=${pageNum}";
	} else if(${sessionScope.memCnt} == 1){
		window.location = "h_review?choose=${choose}&pageNum=${pageNum}";
	}
</script>
</c:if>
</body>
</html>