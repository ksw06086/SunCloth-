<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file = "setting.jsp" %>
<link type = "text/css" rel = "stylesheet" href = "${project}cssall/h_member.css"/>
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
	
	
	$("#noticeallcheck").change(function(){
		var is_check = $(this).is(":checked");
		
		// 전체선택시 개별을 일괄체크
		if(is_check){
			$(".noticecheck").prop("checked","true");
		} else {
			$(".noticecheck").prop("checked","");
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
			<%@ include file = "h_memberLeft.jsp" %>
			<td id = "tabright">
				<div id = "righttop">
					<p><b>회원관리</b></p>
				</div>
				<form action = "h_memberselect" method = "post" name = "searchForm">
				<table id = "searchifs">
					<col style = "width:15%;">
					<col>
					<tr>
						<td>가입일</td>
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
						<td>생일</td>
						<td>
						<select id = "birth">
							<option value = "0">전체</option>
							<option value = "01">1월</option>
							<option value = "02">2월</option>
							<option value = "03">3월</option>
							<option value = "04">4월</option>
							<option value = "05">5월</option>
							<option value = "06">6월</option>
							<option value = "07">7월</option>
							<option value = "08">8월</option>
							<option value = "09">9월</option>
							<option value = "10">10월</option>
							<option value = "11">11월</option>
							<option value = "12">12월</option>
						</select>
						</td>
					</tr>
					
					<tr>
						<td>적립금</td>
						<td>
						<input type = "text" id = "pluspay" name = "pluspay">원 이상
						</td>
					</tr>
    				
    				<tr>
						<td>검색어</td>
						<td>
						<select id = "type" name = "srhType" style = "padding:2px; vertical-align:middle;" onchange = "typeChange();">
							<option value = "0">전체</option>
							<option value = "1">이름</option>
							<option value = "2">아이디</option>
						</select>
						<input type = "hidden" name = "searchType" value = "0">
						<input type = "search" id = "srch" name = "srch" style = "vertical-align:middle;">
						</td>
					</tr>
				</table>
				
				<p id = "srhbtnp"><input type = "submit" value = "검색" id = "srhbtn"></p>
				</form>
				
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
				    	<col style = "width:8%;">
				    	<col>
				    	<col style = "width:10%;">
				    	<col style = "width:10%;">
				    	<col style = "width:10%;">
				    	<col style = "width:10%;">
				    	<col style = "width:10%;">
				    	<col style = "width:10%;">
				    	<tr id = "title">
				    		<td>번호</td>
				    		<td>회원구분</td>
				    		<td>이름</td>
				    		<td>아이디</td>
				    		<td>이메일</td>
				    		<td>휴대폰번호</td>
				    		<td>가입일</td>
				    		<td>적립금</td>
				    		<td>방문횟수</td>
				    	</tr>
				    	<!-- 게시글이 있으면 -->
						<c:if test="${srhCnt > 0}">
							<c:forEach var = "list" items = "${list}">
								<tr style = "text-align:center;" class = "orderprd">
									<td>${number}
									<c:set var = "number" value = "${number-1}"/>
									</td>
									<td>개인</td>
									<!-- 상세 페이지 -->
									<td align = "left">
									<a href = "h_memberForm?id=${list.id}&number=${number+1}&pageNum=${pageNum}">
									${list.name}
									</a></td>
									<td>${list.id}</td>
									<td>${list.email}</td>
									<td>${list.hp}</td>
									<td><fmt:formatDate type="both" pattern="yyyy-MM-dd HH:mm" value="${list.reg_date}"/></td>
									<td>
									${list.plus}
									</td>
									<td>${list.visitcnt}</td>
								</tr>
							</c:forEach>
						</c:if>
						<!-- 게시글이 없으면 -->
						<c:if test="${srhCnt <= 0}">
							<tr class = "orderprd">
								<td colspan = "9" align = "center">
									게시글이 없습니다. 글을 작성해주세요!!
								</td>
							</tr>
						</c:if>
				    </table>
				    
				    <table id = "buttons" style = "width:98%; padding: 10px 0px 0px; margin:0 auto;">
				    	<tr>
				    		<td style = "text-align:center; padding: 15px;"><!-- 페이지 컨트롤 -->
								<table style = "width:1000px;" align = "center">
									<tr>
										<th align = "center">
											<!-- 게시글이 있으면 -->
											<c:if test="${cnt > 0}">
												<!-- 처음[◀◀] : ㅁ + 한자키 / 이전블록 [◀] -->
												<c:if test="${startPage > pageBlock}">
													<a href = "h_member">[◀◀]</a>
													<a href = "h_member?pageNum=${startPage - pageBlock}">[◀]</a>
												</c:if>
												
												<!-- 블럭내의 페이지 번호 -->
												<c:forEach var = "i" begin = "${startPage}" end = "${endPage}">
													<c:if test="${i == currentPage}">
														<span><b>[${i}]</b></span>				
													</c:if>
													<c:if test="${i != currentPage}">
														<span><a href = "h_member?pageNum=${i}">[${i}]</a></span>
													</c:if>
												</c:forEach>
												
												<!-- 다음블럭 [▶] / 끝[▶▶] -->
												<c:if test="${pageCount > endPage}">
													<a href = "h_member?pageNum=${startPage + pageBlock}">[▶]</a>
													<a href = "h_member?pageNum=${pageCount}">[▶▶]</a>
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