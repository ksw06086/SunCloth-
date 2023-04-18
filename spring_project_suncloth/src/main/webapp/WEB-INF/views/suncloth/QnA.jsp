<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file = "setting.jsp" %>
<link type = "text/css" rel = "stylesheet" href = "${project}cssall/QnA.css"/>
<html>
<script type="text/javascript">
$(function() {
	$("#daytypeoption tr td").click(function() { /* 첫번째 링크를 클릭한 경우 */
		$("#daytypeoption tr td").css("background-color", "#fff");
		$("#daytypeoption tr td").css("font-weight", "normal");
		$(this).css("background-color", "#EAECEE");
		$(this).css("font-weight", "bold");
	});
	/* if("${schType}" != ""){
		document.searchForm.srhType.value = "${schType}";
		document.searchForm.searchType.value = "${schType}";
	} */
});
</script>
<body>
<%@ include file = "topmanu.jsp" %>

    <div id = "road">
		<p>home > q&a</p>
	</div>
	
	<div id = "topname">
		<p><b>Q&A</b></p>
	</div>
     
    <div id = "likehtml">
    	<table>
    		<tr>
    			<td><a href = "notice?choose=1">
    				<img src = "${project}ascloimage/notice.png" width = "50px" height = "50px" style = "opacity:0.5;"><br>
    				공지사항
    				</a>
    			</td>
    			
    			<td><a href = "QnA?choose=2">
    				<img src = "${project}ascloimage/qna.png" width = "50px" height = "50px" style = "opacity:0.5;"><br>
    				상품문의
    				</a>
    			</td>
    			
    			<td><a href = "review?choose=4">
    				<img src = "${project}ascloimage/review.png" width = "50px" height = "50px" style = "opacity:0.5;"><br>
    				사용후기
    				</a>
    			</td>
    		</tr>
   		</table>
    </div>
     
    <div id = "detaillist">
    	<table>
    		<tr>
    			<td>상품문의&nbsp;&nbsp;&nbsp;|
    			&nbsp;&nbsp;&nbsp;배송문의&nbsp;&nbsp;&nbsp;|
    			&nbsp;&nbsp;&nbsp;입금확인문의&nbsp;&nbsp;&nbsp;|
    			&nbsp;&nbsp;&nbsp;주문/변경/취소/환불문의&nbsp;&nbsp;&nbsp;|
    			&nbsp;&nbsp;&nbsp;기타문의</td>
    		</tr>
    	</table>
    </div>
    
    <div id = "listtype" style = " margin-bottom: 10px;">
    	<select id = "statetype" style = "width: 100px; font-size: .7em; padding: 5px 0px;">
    		<option value = "all">전체글보기</option>
    		<option value = "before">답변 전 글보기</option>
    		<option value = "finish">답변 완료 글보기</option>
    	</select>
    </div>
    
    <form action = "" method = "post" name = "inputForm">
    <div id = "QnA" class = "oneandone">
    	검색 
		<b><span style = "color:blue;">${srhCnt}</span></b>개
		/ 총 <b><span style = "color:#ccc;">${cnt}</span></b>개
    	<table width = "100%">
    		<col style = "width: 6%;">
    		<col style = "width: 8%;">
    		<col style = "width: 9%;">
    		<col>
    		<col style = "width: 10%;">
    		<tr>
    			<th>NO</th>
    			<th>PRODUCT</th> <!-- 이미지 -->
    			<th>CATEGORY</th>
    			<th>CONTENTS</th>
    			<th>NAME</th>
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
						<td>${list.state}</td>
						<td align = "left">
						<a href = "QnAForm?num=${list.num}&number=${number+1}&pageNum=${pageNum}&choose=${choose}&textType=${list.textType}">
						<c:if test="${list.ref_level > 0}">
							&nbsp;<img src = "ascloimage/re.png" border = "0" width = "20" height = "15">
						</c:if>
						${list.subject}
						</a>
						<c:if test="${list.textType == 'close'}">
						<img src="./ascloimage/lock.png" width = "15px" height = "15px" style = "vertical-align:middle;">
						</c:if>
						<c:set var="now" value="<%=new java.util.Date()%>" />
						<c:set var="sysYear"><fmt:formatDate value="${now}" pattern="yyyy-MM-dd" /></c:set>
						<c:set var="boardYear"><fmt:formatDate value="${list.reg_date}" pattern="yyyy-MM-dd" /></c:set> 
						<c:if test = "${boardYear == sysYear}">
						<img src = "./ascloimage/newicon.png" width = "20px" height = "15px" style = "vertical-align:middle;">
						</c:if>
						</td>
						<td>${list.writer}</td>
					</tr>
				</c:forEach>
			</c:if>
			<!-- 게시글이 없으면 -->
			<c:if test="${srhCnt <= 0}">
				<tr class = "qna">
					<td colspan = "3" align = "center">
						게시글이 없습니다. 글을 작성해주세요!!
					</td>
				</tr>
			</c:if>
    	</table>
    </div>
    
    <div id = "searchlist" style = "margin: 10px 0px; position: relative;">
    	<select id = "daytype" style = "font-size: .8em; vertical-align: middle; padding: 6px 0px; width: 100px;">
    		<option value = "week">일주일</option>
    		<option value = "month1">한달</option>
    		<option value = "month3">세달</option>
    		<option value = "all">전체</option>
    	</select>
    	<select id = "texttype" style = "font-size: .8em; vertical-align: middle; padding: 6px 0px; width: 100px;">
    		<option value = "title">제목</option>
    		<option value = "summary">내용</option>
    		<option value = "writer">글쓴이</option>
    		<option value = "id">아이디</option>
    		<option value = "nickname">별명</option>
    	</select>
    	<input type = "text" id = "searchtext" name = "Stext"  style = "vertical-align: middle; padding: 5px 0px;">
    	<input type = "submit" id = "find" name = "findN" value = "찾기"  style = "font-size: .7em; vertical-align: middle; padding: 5px 0px;">
    	<input type = "hidden" value = "${sessionScope.memId}" id = "memid">
    	<input type = "button" id = "write" name = "writeN" value = "글쓰기"  style = "font-size: .7em;" onclick = "QnAwriteChk(${choose}, ${pageNum});">
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
							<a href = "QnA?choose=${choose}">[◀◀]</a>
							<a href = "QnA?pageNum=${startPage - pageBlock}&choose=${choose}">[◀]</a>
						</c:if>
						
						<!-- 블럭내의 페이지 번호 -->
						<c:forEach var = "i" begin = "${startPage}" end = "${endPage}">
							<c:if test="${i == currentPage}">
								<span><b>[${i}]</b></span>				
							</c:if>
							<c:if test="${i != currentPage}">
								<span><a href = "QnA?pageNum=${i}&choose=${choose}">[${i}]</a></span>
							</c:if>
						</c:forEach>
						
						<!-- 다음블럭 [▶] / 끝[▶▶] -->
						<c:if test="${pageCount > endPage}">
							<a href = "QnA?pageNum=${startPage + pageBlock}&choose=${choose}">[▶]</a>
							<a href = "QnA?pageNum=${pageCount}&choose=${choose}">[▶▶]</a>
						</c:if>
					</c:if>
				</th>
			</tr>
		</table>
    </div>
	
<%@ include file = "bottommenu.jsp" %>
</body>
</html>