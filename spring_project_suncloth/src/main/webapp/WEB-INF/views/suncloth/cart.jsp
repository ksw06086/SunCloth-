<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file = "setting.jsp" %>
<link type = "text/css" rel = "stylesheet" href = "${project}cssall/cart.css"/>
<html>
<body>
<%@ include file = "topmanu.jsp" %>

    <div id = "road">
		<p>home > cart</p>
	</div>
	
	<div id = "topname">
		<p><b>SHOPPING CART</b></p>
	</div>
     
     <table id = "service" style = "font-size: .7em; width:100%; border-bottom:1px solid #ccc; border-top:1px solid #ccc;">
     	<col style = "width:15%;">
     	<col>
     	<tr>
     		<th rowspan = "2">혜택정보</th>
     		<td style = "border-bottom: 1px solid #ccc;"><b>${sessionScope.memId}</b>님의 장바구니입니다.</td>
     	</tr>
     	<tr >
     		<td>가용적립금 : ${list[0].userplus}원</td>
     	</tr>
     	
     </table>
     
<c:set var="ncount" value = "0"/>
<c:set var="nprice" value = "0"/>
<c:set var="ndelipay" value = "0"/>
${srhCnt}
<form name = "cart" method = "post" style = "margin: 0px;">
    <table id = "cartlist" style = "border-bottom: 1px solid #ccc; border-top: 1px solid #ccc;">
    	<col style = "width:9%;">
    	<col>
    	<col style = "width:9%;">
    	<col style = "width:7%;">
    	<col style = "width:9%;">
    	<col style = "width:9%;">
    	<col style = "width:9%;">
    	<col style = "width:10%;">
    	<tr id = "title">
    		<td>이미지</td>
    		<td>상품정보</td>
    		<td>판매가</td>
    		<td>수량</td>
    		<td>적립금</td>
    		<td>배송비</td>
    		<td>합계</td>
    		<td>선택</td>
    	</tr>
    	<!-- 게시글이 있으면 -->
		<c:if test="${srhCnt > 0}">
			<c:forEach var = "list" items = "${list}">
				<tr class = "cartprd">
		    		<td>
					<c:if test="${list.mainfile != null}">
					<img src="${project}fileready/${list.mainfile}" width = "50px" height = "60px">
					</c:if>
					</td>
		    		<td style = "text-align:left;">
					<a href = "h_productForm?num=${list.num}&number=${number+1}&pageNum=${pageNum}">
					<b>${list.prdname}</b><br>
		    		<span style = "color: #282828;">[옵션: ${list.colorname}/${list.sizename}]</span>
		    		</a>
		    		</td>
		    		<td style = "border-left: 1px solid rgba(204, 204, 204,0.5);"><b>KRW ${list.price}</b></td>
		    		<td style = "border-left: 1px solid rgba(204, 204, 204,0.5);">${list.count}
		    		</td>
		    		<td style = "border-left: 1px solid rgba(204, 204, 204,0.5);">${list.pluspay}
		    		</td>
		    		<td style = "border-left: 1px solid rgba(204, 204, 204,0.5);">${list.delipay}</td>
		    		<td style = "border-left: 1px solid rgba(204, 204, 204,0.5);">${list.price * list.count}</td>
		    		<td style = "border-left: 1px solid rgba(204, 204, 204,0.5);">
		    		<input type = "button" value = "주문하기" id = "order" style = "width:80px;"
		    		onclick = "window.location = 'orderform?num=${list.prdnum}&colorcode=${list.colorcode}&sizecode=${list.sizecode}&count=${list.count}&swit=${list.num}&swh=1'"><br>
		    		<input type = "button" value = "관심상품등록" id = "likein" style = "width:80px;"
		    		onclick = "window.location = 'wishlistAdd?num=${list.prdnum}&colorcode=${list.colorcode}&sizecode=${list.sizecode}&count=${list.count}&swit=${list.num}&price=${list.price * list.count}'"><br>
		    		<input type = "button" value = "X 삭제" id = "del" style = "width:80px;"
		    		onclick = "window.location = 'cartdel?num=${list.num}'">
		    		<c:set var="ncount" value = "${ncount + list.price}"/>
		    		<c:set var="nprice" value = "${nprice + list.price + list.delipay}"/>
		    		<c:set var="ndelipay" value = "${ndelipay + list.delipay}"/>
		    		</td>
		    	</tr>
			</c:forEach>
		</c:if>
		<!-- 게시글이 없으면 -->
		<c:if test="${srhCnt <= 0}">
			<tr class = "cartprd">
				<td colspan = "8" align = "center">
					장바구니에 추가된 상품이 없을 때 나오는 글자입니다~!
				</td>
			</tr>
		</c:if>
		<tr>
			<th align = "center" colspan = "8">
				<!-- 게시글이 있으면 -->
				<c:if test="${cnt > 0}">
					<!-- 처음[◀◀] : ㅁ + 한자키 / 이전블록 [◀] -->
					<c:if test="${startPage > pageBlock}">
						<a href = "order">[◀◀]</a>
						<a href = "order?pageNum=${startPage - pageBlock}">[◀]</a>
					</c:if>
					
					<!-- 블럭내의 페이지 번호 -->
					<c:forEach var = "i" begin = "${startPage}" end = "${endPage}">
						<c:if test="${i == currentPage}">
							<span><b>[${i}]</b></span>				
						</c:if>
						<c:if test="${i != currentPage}">
							<span><a href = "order?pageNum=${i}">[${i}]</a></span>
						</c:if>
					</c:forEach>
					
					<!-- 다음블럭 [▶] / 끝[▶▶] -->
					<c:if test="${pageCount > endPage}">
						<a href = "order?pageNum=${startPage + pageBlock}">[▶]</a>
						<a href = "order?pageNum=${pageCount}">[▶▶]</a>
					</c:if>
				</c:if>
			</th>
		</tr>
    	<tr id = "subtotal">
    		<td colspan = "8">
    		<p style = "float: left; margin-left: 10px;">[기본배송]</p>
    		<p style = "float: right; margin-right: 10px;">상품구매금액 ${ncount} + 배송비 ${ndelipay} = 합계:   KRW ${nprice}</p>
    		</td>
    	</tr>
    	<tr>
    		<td colspan = "8">
    		<p style = "float: left;">할인 적용 금액은 주문서작성의 결제예정금액에서 확인 가능합니다.</p>
    		</td>
    	</tr>
    	<tr>
    		<td colspan = "8">
    		<p style = "float: right;"><input type = button value = "장바구니비우기" id = "alldel" onclick = "window.location = 'cartalldel'"></p>
    		</td>
    	</tr>
    </table>
     
 </form>  
    
    <table id = "total">
    	<col style = "width:20%;">
    	<col style = "width:20%;">
    	<col style = "width:60%;">
    	<tr id = "Ttitle">
    		<td>총 상품금액</td>
    		<td>총 배송비</td>
    		<td>결제예정금액</td>
    	</tr>
    	<tr id = "Tsmry">
    		<td>KRW ${ncount}</td>
    		<td style = "border-left: 1px solid rgba(204, 204, 204,0.5);">+ KRW ${ndelipay}</td>
    		<td style = "border-left: 1px solid rgba(204, 204, 204,0.5);">= KRW ${nprice}</td>
    	</tr>
    </table>
     
    <div style = "width:100%; text-align:center; position:relative; margin:20px 0px 100px;">
	    <input type = "button" value = "쇼핑계속하기" id = "goshopping" style = "position: absolute; right:0; top:0.5px;"
	    onclick = "window.location = 'main'">
    </div>
	
<%@ include file = "bottommenu.jsp" %>
</body>
</html>