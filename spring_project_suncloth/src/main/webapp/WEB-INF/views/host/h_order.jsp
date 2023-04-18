<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file = "setting.jsp" %>
<link type = "text/css" rel = "stylesheet" href = "${project}cssall/h_order.css"/>
<html>
<body>
<%@ include file = "topmenu.jsp" %>
<script type="text/javascript">
function ordergo(num, gid, prdnum, state){
	var inin = confirm(state + "로 변경하시겠습니까?");
	
	if(inin){
		window.location = 'h_order?ordernum=' + num + '&orderstate=' + state + '&gid=' + gid + '&prdnum=' + prdnum;
	} else {
		window.location = 'h_order';
	}
}
</script>
<section>
	<table id = "middle">
		<col style = "width:15%;">
		<col>
		<tr>
			<%@ include file = "h_orderLeft.jsp" %>
			<td id = "tabright">
				<div id = "righttop">
					<p><b>주문관리</b></p>
				</div>
				<table id = "searchifs">
					<col style = "width:15%;">
					<col>
					<tr>
						<td>작성일</td>
			     		<td><span><select id = "orderstate" style = "padding: 3px; font-size: 1em; vertical-align:middle;">
				     			<option value = "allorder">등록일</option>
				     		</select></span>
			     			<span><input type = "date" id = "firstday" name = "firstday" style = "vertical-align:middle;">&nbsp;&nbsp;-&nbsp;&nbsp;
			     			<input type = "date" id = "lastday" name = "lastday" style = "vertical-align:middle;"></span>
			     			<span>
			 				<input type = "hidden" name = "dayNum" value = "0">
			     			<table id = "daytypeoption" style = "display: inline;">
			     				<tr>
			     					<td onclick = "today();"><input type = "radio" name = "daytype" id = "today" value = "today">
			     					<label for = "today">오늘</label></td>
			     					<td onclick = "week();"><input type = "radio" name = "daytype" id = "week" value = "week">
			     					<label for = "week">1주일</label></td>
			     					<td onclick = "month1();"><input type = "radio" name = "daytype" id = "month1" value = "month1">
			     					<label for = "month1">1개월</label></td>
			     					<td onclick = "month3();"><input type = "radio" name = "daytype" id = "month3" value = "month3">
			     					<label for = "month3">3개월</label></td>
			     					<td onclick = "month6();"><input type = "radio" name = "daytype" id = "month6" value = "month6">
			     					<label for = "month6">6개월</label></td>
			     				</tr>
			     			</table></span>
			     		</td>
			     	</tr>
			     	
			     	<tr>
						<td>주문상태</td>
						<td>
						<input type = "checkbox" name = "state" id = "deliready" value = "입금전">
    					<label for = "deliready">입금전</label>&emsp;
    					<input type = "checkbox" name = "state" id = "deliready" value = "배송준비중">
    					<label for = "deliready">배송준비중</label>&emsp;
    					<input type = "checkbox" name = "state" id = "deliing" value = "배송중">
    					<label for = "deliing">배송중</label>&emsp;
    					<input type = "checkbox" name = "state" id = "delifinish" value = "배송완료">
    					<label for = "delifinish">배송완료</label><br>
    					<input type = "checkbox" name = "state" id = "refundready" value = "환불신청">
    					<label for = "refundready">환불신청</label>&emsp;
    					<input type = "checkbox" name = "state" id = "refundfinish" value = "환불확인">
    					<label for = "refundfinish">환불확인</label>&emsp;
    					<input type = "checkbox" name = "state" id = "ordercancel" value = "주문취소">
    					<label for = "ordercancel">주문취소</label>
						</td>
					</tr>
					
					<tr>
						<td>결제수단</td>
						<td>
						<input type = "checkbox" name = "pay" id = "cardpay" value = "new">
    					<label for = "cardpay">신용카드</label>&emsp;
    					<input type = "checkbox" name = "pay" id = "accpay" value = "new">
    					<label for = "accpay">관리자 통장</label>
						</td>
					</tr>
    				
    				<tr>
						<td>검색어</td>
						<td>
						<select id = "type" style = "padding:2px; vertical-align:middle;">
							<option value = "">주문번호</option>
							<option value = "">주문자</option>
							<option value = "">입금자</option>
							<option value = "">아이디</option>
							<option value = "">상품명</option>
							<option value = "">상품번호</option>
						</select>
						<input type = "search" id = "srch" name = "srch" style = "vertical-align:middle;">
						</td>
					</tr>
				</table>
				
				<p id = "srhbtnp"><input type = "button" value = "검색" id = "srhbtn"></p>
				
				<div id = "result">
				<form method = "post" name = "completeForm">
					<input type = "hidden" name = "pageNum" value = "${pageNum}">
					<table id = "resulttop">
						<td>검색 
						<b><span style = "color:blue;">${srhCnt}</span></b>개
						/ 총 <b><span style = "color:#ccc;">${cnt}</span></b>개</td>
						<td>
						<select id = "count" style = "padding:3px;" name = "blocknum" onchange = "blockchange();">
							<option value = "10">10개씩 출력</option>
							<option value = "30">30개씩 출력</option>
							<option value = "50">50개씩 출력</option>
						</select>
						</td>
					</table>
					
					<table id = "orderlist">
				    	<col style = "width:8%;">
				    	<col style = "width:10%;">
				    	<col>
				    	<col style = "width:10%;">
				    	<col style = "width:10%;">
				    	<col style = "width:10%;">
				    	<col style = "width:10%;">
				    	<tr id = "title">
				    		<td>번호</td>
				    		<td>주문일시</td>
				    		<td>주문상품</td>
				    		<td>주문자</td>
				    		<td>결제수단</td>
				    		<td>결제금액</td>
				    		<td>상태</td>
				    	</tr>
				    	<!-- 게시글이 있으면 -->
						<c:if test="${srhCnt > 0}">
							<c:forEach var = "list" items = "${list}">
								<tr style = "text-align:center;" class = "orderprd">
									<td>${number}(${list.num})
									<c:set var = "number" value = "${number-1}"/>
									</td>
									<td><fmt:formatDate type="both" pattern="yyyy-MM-dd HH:mm" value="${list.reg_date}"/></td>
									<td align = "left">
									${list.prdname}
									</td>
									<td>${list.gid}</td>
									<!-- 상세 페이지 -->
									<td>${list.pay_option}</td>
									<td>${list.realprice}</td>
									<td>${list.state}&nbsp;
									<c:if test="${list.state != '주문취소' and list.state != '반품확인' and list.state != '배송완료'}">
									<select id = "orderstate" name = "state" style = "padding: 5px; font-size: .9em;" onchange = "ordergo('${list.num}', '${list.gid}', '${list.prdnum}', this.value);">
						     			<option value = "">=== 상태 선택 ===</option>
						     			<c:if test="${list.state == '입금전'}">
						     			<option value = "배송준비중">배송준비중</option>
						     			</c:if>
						     			<c:if test="${list.state == '입금전' or list.state == '배송준비중'}">
						     			<option value = "배송중">배송중</option>
						     			</c:if>
						     			<c:if test="${list.state == '배송준비중' or list.state == '배송중'}">
						     			<option value = "배송완료">배송완료</option>
						     			</c:if>
						     			<c:if test="${list.state == '환불신청'}">
						     			<option value = "환불확인">환불확인</option>
						     			</c:if>
						     		</select>
						     		</c:if></td>
								</tr>
							</c:forEach>
						</c:if>
						<!-- 게시글이 없으면 -->
						<c:if test="${srhCnt <= 0}">
							<tr class = "orderprd">
								<td colspan = "7" align = "center">
									게시글이 없습니다. 글을 작성해주세요!!
								</td>
							</tr>
						</c:if>
				    </table>
				    
				    <table id = "buttons" style = "width:98%; padding: 10px 0px 0px; margin:0 auto;">
						<tr>
							<th align = "center">
								<!-- 게시글이 있으면 -->
								<c:if test="${cnt > 0}">
									<!-- 처음[◀◀] : ㅁ + 한자키 / 이전블록 [◀] -->
									<c:if test="${startPage > pageBlock}">
										<a href = "h_order?choose=${choose}">[◀◀]</a>
										<a href = "h_order?pageNum=${startPage - pageBlock}&choose=${choose}">[◀]</a>
									</c:if>
									
									<!-- 블럭내의 페이지 번호 -->
									<c:forEach var = "i" begin = "${startPage}" end = "${endPage}">
										<c:if test="${i == currentPage}">
											<span><b>[${i}]</b></span>				
										</c:if>
										<c:if test="${i != currentPage}">
											<span><a href = "h_order?pageNum=${i}&choose=${choose}">[${i}]</a></span>
										</c:if>
									</c:forEach>
									
									<!-- 다음블럭 [▶] / 끝[▶▶] -->
									<c:if test="${pageCount > endPage}">
										<a href = "h_order?pageNum=${startPage + pageBlock}&choose=${choose}">[▶]</a>
										<a href = "h_order?pageNum=${pageCount}&choose=${choose}">[▶▶]</a>
									</c:if>
								</c:if>
							</th>
						</tr>
				    </table>
				    </form>
				</div>
			</td>
		</tr>
	</table>
</section>
</body>
</html>