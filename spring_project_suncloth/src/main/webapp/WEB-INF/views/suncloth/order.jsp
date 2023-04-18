<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file = "setting.jsp" %>
<link type = "text/css" rel = "stylesheet" href = "${project}cssall/order.css"/>
<html>
<script type = "text/javascript">
function start() {
	$("#typebtn tr td:nth-child(1)").css("border-top", "1px solid gray");
	$("#typebtn tr td:nth-child(1)").css("border-left", "1px solid gray");
	if(${ucnt} != null && ${ucnt} != 0){
		if(${scnt} == 1){
			alert("취소가 완료되었습니다.");
		} else if(${scnt} == 2){
			alert("환불신청이 정상 처리되었습니다.");
		}
	}
}
</script>
<body onload = "start();">
<%@ include file = "topmanu.jsp" %>

    <div id = "road">
		<p>home > mypage > order list</p>
	</div>
	
	<div id = "topname">
		<p><b>ORDER LIST</b></p>
	</div>
    <div id = "topbtn" style = "width: 100%;">
    	<table id = "typebtn" style = "width:100%; text-align:center;">
    		<col style = "width: 50%;">
    		<col style = "width: 50%;">
    		<tr>
    			<td style = "padding:10px;" onclick = "Otdclick();">주문내역조회(${srhCnt})</td>
    		</tr>
    	</table>
    </div>
     
     
     
     
     
     <table id = "service1" style = "font-size: .7em; width:100%; border:1px solid #ccc;" class = "service">
     	<tr>
     		<td><span><select id = "orderstate" name = "state" style = "padding: 5px; font-size: .9em;">
	     			<option value = "allorder">전체 주문처리상태</option>
	     			<option value = "paybefore">입금전</option>
	     			<option value = "delready">배송준비중</option>
	     			<option value = "deling">배송중</option>
	     			<option value = "delfinish">배송완료</option>
	     			<option value = "cancel">취소</option>
	     			<option value = "return">반품</option>
	     		</select></span><span>&nbsp;&nbsp; | &nbsp;&nbsp;</span>
     			<span><table id = "daytypeoption" style = "display: inline;">
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
     			<span><input type = "date" id = "firstday" name = "firstday" style = "vertical-align:middle;">&nbsp;&nbsp;-&nbsp;&nbsp;
				<input type = "date" id = "lastday" name = "lastday" style = "vertical-align:middle;">
     			<input type = "button" id = "lookup" value = "조회" name = "lookupN"></span>
     		</td>
     	</tr>
     </table>
     
     <div id = "basetext1" class = "basetext">
	     <p>·기본적으로 최근 3개월간의 자료가 조회되며, 기간 검색시 지난 주문내역을 조회하실 수 있습니다.<br>
	     ·주문번호를 클릭하시면 해당 주문에 대한 상세내역을 확인하실 수 있습니다.</p>
     </div>
     
    <div id = "secondtopname1" class = "secondtopname">
		<p><b>주문 상품 정보</b></p>
	</div>
     
     
     
     
     
<c:set var="ncount" value = "0"/>
${srhCnt}/${cnt}
<form name = "order" method = "post" id = "order1">
    <table id = "orderlist" style = "border-bottom: 1px solid #ccc; border-top: 1px solid #ccc;">
    	<col style = "width:9%;">
    	<col style = "width:9%;">
    	<col style = "width:50%;">
    	<col style = "width:5%;">
    	<col style = "width:9%;">
    	<col style = "width:9%;">
    	<col style = "width:9%;">
    	<tr id = "title">
    		<td>주문일자<br>[주문번호]</td>
    		<td>이미지</td>
    		<td>상품정보</td>
    		<td>수량</td>
    		<td>상품구매금액</td>
    		<td>주문처리상태</td>
    		<td>취소/교환/반품</td>
    	</tr>
    	<!-- 게시글이 있으면 -->
		<c:if test="${srhCnt > 0}">
			<c:forEach var = "list" items = "${list}">
				<tr class = "orderprd">
		    		<td><fmt:formatDate type="both" pattern="yyyy-MM-dd HH:mm" value="${list.reg_date}"/>
		    		<br>[${list.num}]</td>
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
		    		<td style = "border-left: 1px solid rgba(204, 204, 204,0.5);">${list.count}
		    		</td>
		    		<td style = "border-left: 1px solid rgba(204, 204, 204,0.5);"><b>KRW ${list.price}</b></td>
		    		<td style = "border-left: 1px solid rgba(204, 204, 204,0.5);">${list.state}</td>
		    		<td style = "border-left: 1px solid rgba(204, 204, 204,0.5);">
		    		<c:if test="${list.state != '입금전' and list.state != '주문취소' and list.state != '환불신청' and list.state != '환불완료'}">
		    		<input type = "button" value = "반품하기" id = "del" style = "width:80px;"
		    		onclick = "window.location = 'order?num=${list.num}&statenumber=2'">
		    		<c:set var="ncount" value = "${ncount + list.price}"/>
		    		</c:if>
		    		<c:if test="${list.state == '입금전'}">
		    		<input type = "button" value = "취소하기" id = "order" style = "width:80px;" 
		    		onclick = "window.location = 'order?num=${list.num}&statenumber=1&count=${list.count}'">
		    		</c:if>
		    		<c:if test="${list.state == '주문취소' or list.state == '환불신청' or list.state == '환불완료'}">
		    		-
		    		</c:if>
		    		</td>
		    	</tr>
			</c:forEach>
		</c:if>
		<!-- 게시글이 없으면 -->
		<c:if test="${srhCnt <= 0}">
			<tr class = "orderprd">
				<td colspan = "7" align = "center">
					주문한 상품이 없을 때 나오는 글자입니다~!
				</td>
			</tr>
		</c:if>
    	<tr id = "subtotal">
    		<td colspan = "7">
    		<p style = "float: right; margin-right: 10px;">합계:   KRW ${ncount}</p>
    		</td>
    	</tr>
    </table>
     
    <div style = "width:100%; text-align:right; margin:20px 0px;">
	    <input type = "button" value = "쇼핑계속하기" id = "goshopping" onclick = "window.location = 'main'">
    </div>
     
 </form>  
     
    <div class = "listnum">
    	<table style = "width:1000px;" align = "center">
			<tr>
				<th align = "center">
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
		</table>
    </div>
	
<%@ include file = "bottommenu.jsp" %>
</body>
</html>