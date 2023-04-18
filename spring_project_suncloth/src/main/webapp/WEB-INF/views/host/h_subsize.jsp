<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<option value = "">-[필수] size 선택-</option>
<!-- 게시글이 있으면 -->
<c:if test="${sizesrhCnt > 0}">
	<c:forEach var = "list" items = "${sizelist}">
		<option value = "${list.sizecode}">${list.sizename}</option>
	</c:forEach>
</c:if>
<!-- 게시글이 없으면 -->
<c:if test="${sizesrhCnt <= 0}">
</c:if>