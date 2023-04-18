<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file = "setting.jsp" %>
<html>
<body>
<!-- 아이디와 비밀번호가 일치 -->
<c:if test = "${scnt == 1}"> 
	<!-- 삭제 실패 -->
	<c:if test="${dcnt == 0}"> 
		<script type = "text/javascript">
			errorAlert(deleteError);
		</script>
	</c:if>
	<!-- 삭제 성공 -->
	<c:if test="${dcnt != 0}"> 
	
		<!-- 1초 후에 alert창 띄운 후에 main으로 이동 -->
		<script type = "text/javascript">
			alert("탈퇴처리되었습니다.");
			window.location = "main";
		</script>
	</c:if>
</c:if>

<c:if test="${scnt != 1}">
	<!-- 아이디와 비밀번호가 불일치 -->
	<script type = "text/javascript">
		errorAlert(idError);
	</script>
</c:if>
</body>
</html>