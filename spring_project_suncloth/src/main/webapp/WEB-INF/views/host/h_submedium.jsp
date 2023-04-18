<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<option value = "">2차 카테고리</option>
<!-- 게시글이 있으면 -->
<c:if test="${medisrhCnt > 0}">
	<c:forEach var = "list" items = "${medilist}">
		<option value = "${list.mediumcode}">${list.mediumname}</option>
	</c:forEach>
</c:if>
<!-- 게시글이 없으면 -->
<c:if test="${medisrhCnt <= 0}">
</c:if>