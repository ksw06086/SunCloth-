<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file = "setting.jsp" %>
<html>
<body>
<c:if test="${icnt == 0}">
<script type = "text/javascript">
	errorAlert("추가 되지 못했습니다.!!");
</script>
</c:if>
<form name = "bigform" method = "post" enctype="multipart/form-data">
<c:if test="${icnt != 0}">
	<!-- cnt를 가지고 mainSuccess로 이동 -->
	<%-- response.sendRedirect("mainSuccess?cnt=" + cnt); --%>
	<script type="text/javascript">
		alert("추가 완료!");
	    window.location = "h_csinput?num=" + ${num};
	</script>
</c:if>
</form>
</body>
</html>