<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file = "setting.jsp" %>
<html>
<body>
<h2> 회원가입 - 처리페이지 </h2>
<c:if test="${insertCnt == 0}">
<script type = "text/javascript">
	errorAlert(passwdError);
</script>
</c:if>
<c:if test="${insertCnt != 0}">
	<!-- cnt를 가지고 mainSuccess로 이동 -->
	<%-- response.sendRedirect("mainSuccess?cnt=" + cnt); --%>
	<script type="text/javascript">
		opener.document.modifyView.bank.value = "${bank}";
		opener.document.modifyView.acc.value = "${acc}";
		opener.document.modifyView.acchost.value = "${acchost}";
		opener.document.getElementById("refundlist").innerHTML = "[${bank}] ${acc} / 예금주: ${acchost} <input type = 'button' id = 'refundAccountChange' value = '환불계좌변경' name = 'refundAccountChange' onclick = 'modifyacc();''>";
		self.close();
	</script>
</c:if>
</body>
</html>