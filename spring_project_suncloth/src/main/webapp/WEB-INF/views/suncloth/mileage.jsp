order<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file = "setting.jsp" %>
<link type = "text/css" rel = "stylesheet" href = "${project}cssall/mileage.css"/>
<html>
<c:if test="${srhCnt > 0}">
	<c:set var="myuseplus" value="0" />
	<c:forEach var = "list" items = "${list}">
		<c:set var="myuseplus" value="${myuseplus + list.useplus}"/>
	</c:forEach>
</c:if>
<body>
<%@ include file = "topmanu.jsp" %>

    <div id = "road">
		<p>home > mypage > mileage</p>
	</div>
	
	<div id = "topname">
		<p><b>MILEAGE</b></p>
	</div>
	
	<div id = "topnamesub">
		<p>고객님의 사용가능 적립금 금액 입니다.</p>
	</div>
	
	
	<div id = "paymenu">
		<table cellspacing = "0" id = "paylist">
			<col style = "width:25%;">
			<col style = "width:25%;">
			<col style = "width:25%;">
			<col style = "width:25%;">
			<tr>
				<td>총 적립금</td>
				<td>${myuseplus + myplus}원</td>
				<td>사용가능 적립금</td>
				<td>${myplus}원</td>
			</tr>
			<tr>
				<td>사용된 적립금</td>
				<td>${myuseplus}원</td>
				<td>환불예정 적립금</td>
				<td>${refundplus}원</td>
			</tr>
		</table>
		
		<table id = "btmmenu" cellspacing = "0">
			<col style = "width:33.3%;">
			<col style = "width:33.3%;">
			<col style = "width:33.3%;">
			<tr>
				<td>적립내역보기</td>
			</tr>
		</table>
		<c:set var="ncount" value = "0"/>
		${srhCnt}/${cnt}
	    <table id = "onemenu" class = "menu">
			<col style = "width:15%;">
			<col style = "width:15%;">
			<col>
			<col style = "width:15%;">
			<col style = "">
			<tr>
				<td>주문날짜</td>
				<td>적립금</td>
				<td>관련 주문</td>
				<td>사용가능 예정일</td>
				<td>내용</td>
			</tr>
	    	<!-- 게시글이 있으면 -->
			<c:if test="${srhCnt > 0}">
				<c:forEach var = "list" items = "${list}">
					<tr>
						<td><fmt:formatDate type="both" pattern="yyyy-MM-dd HH:mm" value="${list.reg_date}"/></td>
						<td>${list.prdplus}원</td>
			    		<td style = "text-align:left;">
						<b>${list.prdname}</b><br>
			    		<span style = "color: #282828;">[옵션: ${list.colorname}/${list.sizename}]</span>
			    		</td>
						<td><fmt:formatDate type="both" pattern="yyyy-MM-dd HH:mm" value="${list.reg_date}"/> ~
						<fmt:formatDate type="both" pattern="yyyy-MM-dd HH:mm" value="${list.reg_date}"/></td>
						<td>상품 주문 적립금</td>
					</tr>
				</c:forEach>
			</c:if>
			<!-- 게시글이 없으면 -->
			<c:if test="${srhCnt <= 0}">
				<tr class = "orderprd">
					<tr>
						<td colspan = "5" style = "padding: 50px 0px; text-align: center;">
						적립금 내역이 없습니다.</td>
					</tr>
				</tr>
			</c:if>
	    </table>
		
		<div class = "listnum">
	    	<table style = "width:1000px;" align = "center">
				<tr>
					<th align = "center">
						<!-- 게시글이 있으면 -->
						<c:if test="${cnt > 0}">
							<!-- 처음[◀◀] : ㅁ + 한자키 / 이전블록 [◀] -->
							<c:if test="${startPage > pageBlock}">
								<a href = "mileage">[◀◀]</a>
								<a href = "mileage?pageNum=${startPage - pageBlock}">[◀]</a>
							</c:if>
							
							<!-- 블럭내의 페이지 번호 -->
							<c:forEach var = "i" begin = "${startPage}" end = "${endPage}">
								<c:if test="${i == currentPage}">
									<span><b>[${i}]</b></span>				
								</c:if>
								<c:if test="${i != currentPage}">
									<span><a href = "mileage?pageNum=${i}">[${i}]</a></span>
								</c:if>
							</c:forEach>
							
							<!-- 다음블럭 [▶] / 끝[▶▶] -->
							<c:if test="${pageCount > endPage}">
								<a href = "mileage?pageNum=${startPage + pageBlock}">[▶]</a>
								<a href = "mileage?pageNum=${pageCount}">[▶▶]</a>
							</c:if>
						</c:if>
					</th>
				</tr>
			</table>
	    </div>
	    
	    <fieldset style = "border: 1px solid; margin: 80px 0px;">
	    	<p style = "font-size:.9em;">적립금 안내</p>
	    	<hr>
	    	<p style = "font-size:.8em;">&nbsp;&nbsp;&nbsp;<img src = "./ascloimage/one.png" width = "10px" height = "10px"> [쇼핑계속하기] 버튼을 누르시면 쇼핑을 계속하실 수 있습니다.<br>
	    	&nbsp;&nbsp;&nbsp;<img src = "./ascloimage/two.png" width = "10px" height = "10px"> 장바구니와 관심상품을 이용하여 원하시는 상품만 주문하거나 관심상품으로 등록하실 수 있습니다.<br>
	    	&nbsp;&nbsp;&nbsp;<img src = "./ascloimage/three.png" width = "10px" height = "10px"> 파일첨부 옵션은 동일상품을 장바구니에 추가할 경우 마지막에 업로드 한 파일로 교체됩니다.</p>
	    	
	    </fieldset>
	</div>
	
<%@ include file = "bottommenu.jsp" %>
</body>
</html>