<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file = "setting.jsp" %>
<link type = "text/css" rel = "stylesheet" href = "${project}cssall/paydetail.css"/>
<html>
<body>
<header id = "header">
	<b>총 주문금액 상세내역</b>
</header>

	<form name = "myForm" action = "" method = "post" id = "accountChange">
		<table>
			<tr style = "text-align:right;">
				<td colspan = "2" style = "border-bottom:1px solid #ccc;">
				<b>KRW 0</b>
				</td>
			</tr>
			<tr>
				<td>
				· 상품금액
				</td>
				<td>
				KRW 0
				</td>
			</tr>
			<tr>
				<td>
				· 배송비
				</td>
				<td>
				KRW 0
				</td>
			</tr>
			<tr>
				<td>
				· 지역별 배송비
				</td>
				<td>
				KRW 0
				</td>
			</tr>
		</table>
    
    </form>
</body>
</html>