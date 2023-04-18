<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file = "setting.jsp" %>
<html>
<body>
	<!-- cnt를 가지고 mainSuccess로 이동 -->
	<%-- response.sendRedirect("mainSuccess?cnt=" + cnt); --%>
	<script type="text/javascript">
		alert("방문해주셔서 감사합니다!! 가시는길 위험하지 않길 바랍니다.");
		window.location = "main";
	</script>
</body>
</html>