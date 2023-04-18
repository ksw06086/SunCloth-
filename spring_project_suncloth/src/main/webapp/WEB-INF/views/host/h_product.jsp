<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file = "setting.jsp" %>
<link type = "text/css" rel = "stylesheet" href = "${project}cssall/h_product.css"/>
<html>
<body>
<%@ include file = "topmenu.jsp" %>
<script type="text/javascript">
$(function() {
	$("#daytypeoption tr td").click(function() { /* 첫번째 링크를 클릭한 경우 */
		$("#daytypeoption tr td").css("background-color", "#fff");
		$("#daytypeoption tr td").css("font-weight", "normal");
		$(this).css("background-color", "#EAECEE");
		$(this).css("font-weight", "bold");
	});
	
	
	$("#productallcheck").change(function(){
		var is_check = $(this).is(":checked");
		
		// 전체선택시 개별을 일괄체크
		if(is_check){
			$(".productcheck").prop("checked","true");
		} else {
			$(".productcheck").prop("checked","");
		}
	});
	
	document.getElementById('firstday').value = new Date().toISOString().substring(0, 10);
	document.getElementById('lastday').value = new Date().toISOString().substring(0, 10);
	if("${dayNum}" != ""){
		document.searchForm.dayNum.value = "${dayNum}";
		$("#daytypeoption tr td").eq(${dayNum}).click();
	}
	if("${schType}" != ""){
		document.searchForm.srhType.value = "${schType}";
		document.searchForm.searchType.value = "${schType}";
	}
});
</script>
<section>
	<table id = "middle">
		<col style = "width:15%;">
		<col>
		<tr>
			<%@ include file = "h_productLeft.jsp" %>
			<td id = "tabright">
				<form action = "h_productinput" method = "post" enctype="multipart/form-data">
				<div id = "righttop">
					<p><b>판매상품관리</b></p>
					<p><input type = "submit" value = "상품등록" id = "prdinput"></p>
				</div>
				</form>
				<form action = "h_productselect" method = "post" name = "searchForm">
				<table id = "searchifs">
					<col style = "width:15%;">
					<col>
					<tr>
						<td>카테고리</td>
						<td>
						<select id = "onepart" name = "opart" onchange = "select_category();">
							<option value = "">1차 카테고리</option>
							<!-- 게시글이 있으면 -->
							<c:if test="${bigsrhCnt > 0}">
								<c:forEach var = "list" items = "${biglist}">
									<option value = "${list.bigcode}">${list.bigname}</option>
								</c:forEach>
							</c:if>
							<!-- 게시글이 없으면 -->
							<c:if test="${bigsrhCnt <= 0}">
							</c:if>
						</select>
						<select id = "twopart" name = "tpart"> <!-- 일단 아우터것만 이거는 jQuery로 조건써서 갖다넣을려고함 -->
							<option value = "">2차 카테고리</option>
						</select>
						</td>
					</tr>
					
					<tr>
						<td>브랜드</td>
						<td>
						<select id = "brand">
							<option value = "">전체</option>
							<!-- 게시글이 있으면 -->
							<c:if test="${brandsrhCnt > 0}">
								<c:forEach var = "list" items = "${brandlist}">
									<option value = "${list.num}">${list.name}</option>
								</c:forEach>
							</c:if>
							<!-- 게시글이 없으면 -->
							<c:if test="${brandsrhCnt <= 0}">
							</c:if>
						</select>
						</td>
					</tr>
					
					<tr>
						<td>기간</td>
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
			     		<td>상품가격</td>
			     		<td><input type = "text" id = "minprice" name = "minprice">원
			     		~ <input type = "text" id = "maxprice" name = "maxprice">원</td>
			     	</tr>
			     	
			     	<tr>
			     		<td>판매상태</td>
			     		<td>
    					<input type = "checkbox" name = "state" id = "saleing" value = "saleing">
    					<label for = "saleing">판매중</label>&emsp;
    					<input type = "checkbox" name = "state" id = "notstock" value = "notstock">
    					<label for = "notstock">품절</label>&emsp;
    					<input type = "checkbox" name = "state" id = "saleready" value = "saleready">
    					<label for = "saleready">판매대기</label>&emsp;
    					<input type = "checkbox" name = "state" id = "salestop" value = "salestop">
    					<label for = "salestop">판매중지</label>&emsp;
    					<input type = "checkbox" name = "state" id = "all" value = "all">
    					<label for = "all">전체</label>
    					</td>
    				</tr>
    				
    				<tr>
						<td>검색어</td>
						<td>
						<select id = "type" name = "srhType" style = "padding:2px; vertical-align:middle;">
							<option value = "0">상품명</option>
							<option value = "1">상품번호</option>
						</select>
						<input type = "hidden" name = "searchType" value = "0">
						<input type = "search" id = "srch" name = "srch" style = "vertical-align:middle;">
						</td>
					</tr>
				</table>
				
				<p id = "srhbtnp"><input type = "submit" value = "검색" id = "srhbtn"></p>
				</form>
				
				<div id = "result">
				<form action = "h_productdeletePro" method = "post" name = "completeForm">
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
				    	<col style = "width:1%;">
				    	<col style = "width:9%;">
				    	<col style = "width:10%;">
				    	<col style = "width:10%;">
				    	<col>
				    	<col style = "width:10%;">
				    	<col style = "width:10%;">
				    	<col style = "width:10%;">
				    	<col style = "width:10%;">
				    	<col style = "width:10%;">
				    	<tr id = "title">
				    		<td><input type = "checkbox" name = "prdcheck" id = "productallcheck"  value = "전체선택"></td>
				    		<td>이미지</td>
				    		<td>번호</td>
				    		<td>카테고리</td>
				    		<td>상품명</td>
				    		<td>판매가</td>
				    		<td>배송비</td>
				    		<td>등록일</td>
				    		<td>판매상태</td>
				    	</tr>
				    	<!-- 게시글이 있으면 -->
						<c:if test="${srhCnt > 0}">
							<c:forEach var = "list" items = "${list}">
								<tr style = "text-align:center;" class = "orderprd">
									<td><input type = "checkbox" name = "productchecks" class = "productcheck"  value = "${list.num}"></td>
									<td>
									<c:if test="${list.mainfile != null}">
									<img src="${project}fileready/${list.mainfile}" width = "50px" height = "60px">
									</c:if>
									</td>
									<td>${number}(${list.num})
									<c:set var = "number" value = "${number-1}"/>
									</td>
									<!-- 상세 페이지 -->
									<td>
									${list.mediumpartname}
									</td>
									<td style = "text-align:left;">
									<a href = "h_productForm?num=${list.num}&number=${number+1}&pageNum=${pageNum}">
									${list.name}
									</a></td>
									<td><b>KRW ${list.saleprice}</b></td>
									<td>${list.deliprice}</td>
									<td><fmt:formatDate type="both" pattern="yyyy-MM-dd HH:mm" value="${list.reg_date}"/></td>
									<td><input type = "button" value = "color/size 추가" name = "csinput" 
									onclick = "window.location = 'h_csinput?num=${list.num}&pageNum=${pageNum}'"></td>
								</tr>
							</c:forEach>
						</c:if>
						<!-- 게시글이 없으면 -->
						<c:if test="${srhCnt <= 0}">
							<tr class = "orderprd">
								<td colspan = "10" align = "center">
									게시글이 없습니다. 글을 작성해주세요!!
								</td>
							</tr>
						</c:if>
				    </table>
				    
				    <table id = "buttons" style = "width:98%; padding: 10px 0px 0px; margin:0 auto;">
				    	<tr class = "prdbtn">
				    		<td>
				    		<input type = "submit" value = "삭제" id = "checkdel">
				    		</td>
				    	</tr>
				    	<tr>
				    		<td style = "text-align:center; padding: 15px;"><!-- 페이지 컨트롤 -->
								<table style = "width:1000px;" align = "center">
									<tr>
										<th align = "center">
											<!-- 게시글이 있으면 -->
											<c:if test="${cnt > 0}">
												<!-- 처음[◀◀] : ㅁ + 한자키 / 이전블록 [◀] -->
												<c:if test="${startPage > pageBlock}">
													<a href = "h_product">[◀◀]</a>
													<a href = "h_product?pageNum=${startPage - pageBlock}">[◀]</a>
												</c:if>
												
												<!-- 블럭내의 페이지 번호 -->
												<c:forEach var = "i" begin = "${startPage}" end = "${endPage}">
													<c:if test="${i == currentPage}">
														<span><b>[${i}]</b></span>				
													</c:if>
													<c:if test="${i != currentPage}">
														<span><a href = "h_product?pageNum=${i}">[${i}]</a></span>
													</c:if>
												</c:forEach>
												
												<!-- 다음블럭 [▶] / 끝[▶▶] -->
												<c:if test="${pageCount > endPage}">
													<a href = "h_product?pageNum=${startPage + pageBlock}">[▶]</a>
													<a href = "h_product?pageNum=${pageCount}">[▶▶]</a>
												</c:if>
											</c:if>
										</th>
									</tr>
								</table>
							</td>
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