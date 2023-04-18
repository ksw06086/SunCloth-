<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file = "setting.jsp" %>
<link type = "text/css" rel = "stylesheet" href = "${project}cssall/h_review.css"/>
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
	
	
	$("#reviewallcheck").change(function(){
		var is_check = $(this).is(":checked");
		
		// 전체선택시 개별을 일괄체크
		if(is_check){
			$(".viewcheck").prop("checked","true");
		} else {
			$(".viewcheck").prop("checked","");
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
			<%@ include file = "h_boardLeft.jsp" %>
			<td id = "tabright">
				<div id = "righttop">
					<p><b>[후기] 게시판 리스트</b></p>
				</div>
				<form action = "h_noticeselect" method = "post" name = "searchForm">
				<input type = "hidden" name = "choose" value = "1">
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
						<td>검색어</td>
						<td>
						<select id = "type" name = "srhType" style = "padding:2px; vertical-align:middle;" onchange = "typeChange();">
							<option value = "0">전체</option>
							<option value = "1">제목</option>
							<option value = "2">내용</option>
						</select>
						<input type = "hidden" name = "searchType" value = "0">
						<input type = "search" id = "srch" name = "srch" style = "vertical-align:middle;">
						</td>
					</tr>
				</table>
				
				<p id = "srhbtnp"><input type = "submit" value = "검색" id = "srhbtn"></p>
				</form>
				
				<div id = "result">
				<form action = "reviewdelete" method = "post" name = "completeForm">
					<input type = "hidden" name = "pageNum" value = "${pageNum}">
					<table id = "resulttop">
						<td>검색 
						<b><span style = "color:blue;">${srhCnt}</span></b>개
						/ 총 <b><span style = "color:#ccc;">${cnt}</span></b>개
						</td>
						<td>
						<select id = "count" style = "padding:3px;" name = "blocknum" onchange = "blockchange();">
							<option value = "10">10개씩 출력</option>
							<option value = "30">30개씩 출력</option>
							<option value = "50">50개씩 출력</option>
						</select>
						</td>
					</table>
					
					<input type = "hidden" name = "choose" value = "4">
					<table id = "faqlist">
				    	<col style = "width:1%;">
				    	<col style = "width:10%;">
				    	<col>
				    	<col style = "width:10%;">
				    	<col style = "width:10%;">
				    	<tr id = "title">
				    		<td><input type = "checkbox" name = "prdcheck" id = "reviewallcheck"  value = "전체선택"></td>
				    		<td>번호</td>
				    		<td>제목</td>
				    		<td>작성자</td>
				    		<td>작성일</td>
				    	</tr>
				    	<!-- 게시글이 있으면 -->
						<c:if test="${srhCnt > 0}">
							<c:forEach var = "list" items = "${list}">
								<tr style = "text-align:center;" class = "faq">
									<td><input type = "checkbox" name = "reviewchecks" class = "reviewcheck"  value = "${list.num}"></td>
									<td>${number}(${list.num})
									<c:set var = "number" value = "${number-1}"/>
									</td>
									<!-- 상세 페이지 -->
									<td align = "left">
									<a href = "reviewForm?num=${list.num}&number=${number+1}&pageNum=${pageNum}&choose=${choose}">
									${list.subject}
									</a>
									<c:set var="now" value="<%=new java.util.Date()%>" />
									<c:set var="sysYear"><fmt:formatDate value="${now}" pattern="yyyy-MM-dd" /></c:set>
									<c:set var="boardYear"><fmt:formatDate value="${list.reg_date}" pattern="yyyy-MM-dd" /></c:set> 
									<c:if test = "${boardYear == sysYear}">
									<img src = "${project}ascloimage/newicon.png" width = "20px" height = "15px" style = "vertical-align:middle;">
									</c:if>
									</td>
									<td>${list.writer}</td>
									<td>${list.reg_date}</td>
								</tr>
							</c:forEach>
						</c:if>
						<!-- 게시글이 없으면 -->
						<c:if test="${srhCnt <= 0}">
							<tr class = "qna">
								<td colspan = "5" align = "center">
									게시글이 없습니다. 글을 작성해주세요!!
								</td>
							</tr>
						</c:if>
				    </table>
				    
				    <table id = "buttons" style = "width:98%; padding: 10px 0px 0px; margin:0 auto;">
				    	<tr class = "prdbtn">
				    		<td>
				    		<input type = "submit" value = "선택삭제" id = "checkdel">
				    		</td>
				    	</tr>
				    	<tr>
				    		<th align = "center">
					<!-- 게시글이 있으면 -->
					<c:if test="${cnt > 0}">
						<!-- 처음[◀◀] : ㅁ + 한자키 / 이전블록 [◀] -->
						<c:if test="${startPage > pageBlock}">
							<a href = "h_review?choose=${choose}">[◀◀]</a>
							<a href = "h_review?pageNum=${startPage - pageBlock}&choose=${choose}">[◀]</a>
						</c:if>
						
						<!-- 블럭내의 페이지 번호 -->
						<c:forEach var = "i" begin = "${startPage}" end = "${endPage}">
							<c:if test="${i == currentPage}">
								<span><b>[${i}]</b></span>				
							</c:if>
							<c:if test="${i != currentPage}">
								<span><a href = "h_review?pageNum=${i}&choose=${choose}">[${i}]</a></span>
							</c:if>
						</c:forEach>
						
						<!-- 다음블럭 [▶] / 끝[▶▶] -->
						<c:if test="${pageCount > endPage}">
							<a href = "h_review?pageNum=${startPage + pageBlock}&choose=${choose}">[▶]</a>
							<a href = "h_review?pageNum=${pageCount}&choose=${choose}">[▶▶]</a>
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