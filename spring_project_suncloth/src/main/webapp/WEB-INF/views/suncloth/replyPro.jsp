<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file = "setting.jsp" %>
<html>
<body>
<h2> 회원가입 - 처리페이지 </h2>
<c:choose>
<c:when test="${sessionScope.memId == null}">
<script type = "text/javascript">
	errorAlert("로그인 하시지 않았습니다. 로그인 하고 와주세요");
</script>
</c:when>
<c:when test="${pcnt == 0}">
<script type = "text/javascript">
	errorAlert("비밀번호가 맞지 않습니다.");
</script>
</c:when>
<c:when test="${icnt == 0}">
<script type = "text/javascript">
	errorAlert(insertError);
</script>
</c:when>
<c:when test="${icnt != 0}">
	<!-- cnt를 가지고 mainSuccess로 이동 -->
	<%-- response.sendRedirect("mainSuccess?cnt=" + cnt); --%>
	<script type="text/javascript">
		alert("글쓰기 완료!");
		window.location = "reviewForm?num=${num}&number=${number}&pageNum=${pageNum}&choose=${choose}";
	</script>
</c:when>
</c:choose>
</body>
</html>