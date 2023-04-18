<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file = "setting.jsp" %>
<link type = "text/css" rel = "stylesheet" href = "${project}cssall/myboard.css"/>
<html>
<script type="text/javascript">
$(function() {
	$("#daytypeoption tr td").click(function() { /* 첫번째 링크를 클릭한 경우 */
		$("#daytypeoption tr td").css("background-color", "#fff");
		$("#daytypeoption tr td").css("font-weight", "normal");
		$(this).css("background-color", "#EAECEE");
		$(this).css("font-weight", "bold");
	});
	if("${schType}" != ""){
		document.searchForm.srhType.value = "${schType}";
		document.searchForm.searchType.value = "${schType}";
	}
});
</script>
<body>
<%@ include file = "topmanu.jsp" %>

    <div id = "road">
		<p>home > mypage > board</p>
	</div>
	
	<div id = "topname">
		<p><b>MY BOARD</b></p>
	</div>
    
    <div id = "listtype" style = " margin-bottom: 10px;">
    	<select id = "statetype" style = "width: 100px; font-size: .7em; padding: 5px 0px;">
    		<option value = "day">작성 일자별</option>
    		<option value = "category">분류별</option>
    	</select>
    </div>
    
    <form action = "" method = "post" name = "inputForm">
    <div id = "QnA" class = "oneandone">
    	검색 
		<b><span style = "color:blue;">${srhCnt}</span></b>개
		/ 총 <b><span style = "color:#ccc;">${cnt}</span></b>개
    	<table width = "100%">
    		<col style = "width: 6%;">
    		<col style = "width: 9%;">
    		<col style = "width: 9%;">
    		<col>
    		<col style = "width: 10%;">
    		<col style = "width: 8%;">
    		<col style = "width: 8%;">
    		<tr>
    			<th>NO</th>
    			<th>FILE</th>
    			<th>CATEGORY</th>
    			<th>SUBJECT</th>
    			<th>WRITER</th>
    			<th>DATE</th>
    			<th>HIT</th>
    		</tr>
    		
    		<!-- 게시글이 있으면 -->
			<c:if test="${srhCnt > 0}">
				<c:forEach var = "list" items = "${list}">
					<tr style = "text-align:center;" class = "qna">
						<td>${number}(${list.num})
						<c:set var = "number" value = "${number-1}"/>
						</td>
						<!-- 상세 페이지 -->
						<td>
						<c:if test="${list.file1 != null}">
						<img src="${project}fileready/${list.file1}" width = "50px" height = "60px">
						</c:if>
						</td>
						<td>${list.state}
						<c:set var="now" value="<%=new java.util.Date()%>" />
						<c:set var="sysYear"><fmt:formatDate value="${now}" pattern="yyyy-MM-dd" /></c:set>
						<c:set var="boardYear"><fmt:formatDate value="${list.reg_date}" pattern="yyyy-MM-dd" /></c:set>
						</td>
						<c:if test="${list.state == '문의글'}">
							<td align = "left">
							<a href = "QnAForm?num=${list.num}&number=${number+1}&pageNum=${pageNum}&choose=3&textType=${list.texttype}">
							${list.subject}(${list.writestate})
							</a>
							<c:if test="${list.texttype == 'close'}">
							<img src="./ascloimage/lock.png" width = "15px" height = "15px" style = "vertical-align:middle;">
							</c:if> 
							<c:if test = "${boardYear == sysYear}">
							<img src = "./ascloimage/newicon.png" width = "20px" height = "15px" style = "vertical-align:middle;">
							</c:if>
							</td>
						</c:if>
						<c:if test="${list.state == '후기글'}">
							<td align = "left">
							<a href = "reviewForm?num=${list.num}&number=${number+1}&pageNum=${pageNum}&choose=4">
							${list.subject}
							</a> 
							<c:if test = "${boardYear == sysYear}">
							<img src = "./ascloimage/newicon.png" width = "20px" height = "15px" style = "vertical-align:middle;">
							</c:if>
							</td>
						</c:if>
						<td>${list.writer}</td>
						<td>${boardYear}</td>
						<td>${list.readCnt}</td>
					</tr>
				</c:forEach>
			</c:if>
			<!-- 게시글이 없으면 -->
			<c:if test="${srhCnt <= 0}">
				<tr class = "qna">
					<td colspan = "7" align = "center">
						게시글이 없습니다. 글을 작성해주세요!!
					</td>
				</tr>
			</c:if>
    	</table>
    </div>
    
    <div id = "searchlist" style = "margin: 10px 0px; position: relative;">
    	<select id = "type" name = "srhType" style = "font-size: .8em; vertical-align: middle; padding: 6px 0px; width: 100px;" onchange = "typeChange();">
    		<option value = "0">제목</option>
    	</select>
    	<input type = "hidden" name = "searchType" value = "0">
		<input type = "search" id = "srch" name = "srch" style = "vertical-align:middle; padding: 5px 0px;">
    	<input type = "submit" id = "find" name = "findN" value = "찾기"  style = "font-size: .7em; vertical-align: middle; padding: 5px 0px;">
    	<input type = "hidden" value = "${sessionScope.memId}" id = "memid">
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
							<a href = "my_board">[◀◀]</a>
							<a href = "my_board?pageNum=${startPage - pageBlock}">[◀]</a>
						</c:if>
						
						<!-- 블럭내의 페이지 번호 -->
						<c:forEach var = "i" begin = "${startPage}" end = "${endPage}">
							<c:if test="${i == currentPage}">
								<span><b>[${i}]</b></span>				
							</c:if>
							<c:if test="${i != currentPage}">
								<span><a href = "my_board?pageNum=${i}">[${i}]</a></span>
							</c:if>
						</c:forEach>
						
						<!-- 다음블럭 [▶] / 끝[▶▶] -->
						<c:if test="${pageCount > endPage}">
							<a href = "my_board?pageNum=${startPage + pageBlock}">[▶]</a>
							<a href = "my_board?pageNum=${pageCount}">[▶▶]</a>
						</c:if>
					</c:if>
				</th>
			</tr>
		</table>
    </div>
	
<%@ include file = "bottommenu.jsp" %>
</body>
</html>