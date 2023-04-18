<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file = "setting.jsp" %>
<link type = "text/css" rel = "stylesheet" href = "${project}cssall/mypage.css"/>
<html>
<c:set var="myuseplus" value="0" />
<c:set var="totalprice" value="0" />
<c:forEach var = "list" items = "${list}">
	<c:if test="${list.state != '주문취소' and list.state != '환불신청' and list.state != '환불완료'}">
		<c:set var="myuseplus" value="${myuseplus + list.useplus}"/>
	</c:if>
	<c:if test="${list.state != '주문취소' and list.state != '환불신청' and list.state != '환불완료'}">
		<c:set var="totalprice" value="${totalprice + list.price}"/>
	</c:if>
</c:forEach>

<body>
<%@ include file = "topmanu.jsp" %>

    <div id = "road">
		<p>home > mypage</p>
	</div>
	
	<div id = "topname">
		<p><b>MY PAGE</b></p>
	</div>
	
	<div id = "topsummary">
		<table style = "width:100%;">
			<tr>
				<td style = "padding: 8px 5px; border-bottom:1px solid #ccc;">저희 쇼핑몰을 이용해 주셔서 감사합니다. 
				<span style = "color:gray;">${sessionScope.memId}</span> 님은 <b>[FAMILY]</b>
				회원이십니다.</td>
			</tr>
			<tr>
				<td>
					<table id = "topsub">
						<tr>
							<td>주소를 복사하여 친구를 쇼핑몰에 초대해보세요.</td>
						</tr>
						<tr>
							<td>
							<input type = "text" id = "homepage" name = "homepageN" value = "//www.asclo.com/?reco_id=k12345"
							style = "width:400px; vertical-align:middle;" readonly>
							<input type = "button" id = "linkcopy" name = "linkcopyN" value = "주소복사" style = "font-size:.7em;">
							</td>
						</tr>
					</table>
				<td>
			</tr>
		</table>
	</div>
	
	<div id = "referencemenu">
		<table>
			<col style = "width: 16.5%">
			<col style = "width: 16.5%">
			<col style = "width: 16.5%">
			<col style = "width: 16.5%">
			<col style = "width: 17.5%">
			
			<tr>
				<td><a href = "order"><b>ORDER</b><br>주문내역 조회</a></td>
				<td><a href = "modifyView"><b>PROFLE</b><br>회원 정보</a></td>
				<td><a href = "wishlist"><b>WISH LIST</b><br>관심 상품</a></td>
				<td><a href = "mileage"><b>MILEAGE</b><br>적립금 관리</a></td>
				<td><a href = "my_board"><b>BOARD</b><br>내 게시물 관리</a></td>
			</tr>
		</table>
	</div>
	
	<div id = "paymenu">
		<table>
			<col style = "width:23%;">
			<col style = "width:23%;">
			<col style = "width:4%;">
			<col style = "width:23%;">
			<col style = "width:23%;">
			<col style = "width:4%;">
			<tr>
				<td>가용적립금</td>
				<td>${myplus}원</td>
				<td><a href = "mileage.html"><input type = "button" id = "availablepay" name = "availableN" value = "조회" class = "select"></a></td>
				<td>총적립금</td>
				<td>${myplus}원</td>
				<td></td>
			</tr>
			<tr>
				<td>사용적립금</td>
				<td>${myuseplus}원</td>
				<td></td>
				<td>총주문</td>
				<td>KRW+${totalprice}(${srhCnt}회)</td>
				<td></td>
			</tr>
		</table>
	</div>
	
    <div id = "mystate">
		<table>
			<tr>
				<td colspan = "5"><b>나의 주문 처리 현황</b></td>
			</tr>
		</table>
		<table style = "border-top:none;">
			<col style = "width:20%;">
			<col style = "width:20%;">
			<col style = "width:20%;">
			<col style = "width:20%;">
			<col style = "width:20%;">
			<tr>
				<td><b>입금전</b><br><span style = "font-size: 20px; font-weight:bold;">${becnt}</span></td>
				<td><b>배송준비중</b><br><span style = "font-size: 20px; font-weight:bold;">${dscnt}</span></td>
				<td><b>배송중</b><br><span style = "font-size: 20px; font-weight:bold;">${dicnt}</span></td>
				<td><b>배송완료</b><br><span style = "font-size: 20px; font-weight:bold;">${decnt}</span></td>
				<td style = "border-right:none;">취소 : ${ccnt}<br>
				환불 : ${rcnt}</td>
			</tr>
		</table>
	</div>
	
<%@ include file = "bottommenu.jsp" %>
</body>
</html>