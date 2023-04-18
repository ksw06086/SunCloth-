<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file = "setting.jsp" %>
<link type = "text/css" rel = "stylesheet" href = "${project}cssall/reviewForm.css"/>
<html>
<body>
<%@ include file = "topmanu.jsp" %>

    <div id = "road">
		<p>home > review</p>
	</div>
	
	<div id = "topname">
		<p><b>REVIEW</b></p>
	</div>
	
	<%--<div id = "prddata" class = "oneandone">
    	<table width = "100%">
    	<col style = "width: 20%;">
    	<col style = "width: 80%;">
    		<tr>
    			<td rowspan = "2" style = "text-align:center; padding: 10px 0px;"><img src = "./ascloimage/jang1.jpg" width = "100px" height = "100px" style = "vertical-align: middle;"></td>
    			<td><img src = "../ascloimage/n.png" width = "10px" height = "10px" style = "vertical-align: middle;"><br>
    			장원영의 이쁜 티셔츠(3color)<br>
    			KRW 37,000</td>
    		</tr>
    		<tr>
    			<td style = "padding: 0px 0px 15px;"><input type = "submit" id = "detailprd" name = "detailprdN" value = "상품 상세보기" style = "font-size: .9em;">
    			</td>
    		</tr>
    	</table>
    </div>--%>
	
     
    <div id = "notice" class = "oneandone">
    	<table width = "100%">
    	<col style = "width: 15%;">
    	<col style = "width: 85%;">
    		<tr>
    			<td>제목</td>
    			<td>${vo.subject}</td>
    		</tr>
    		
    		<tr>
    			<td>작성자</td>
    			<td><b>${vo.writer}</b></td>
    		</tr>
    	</table>
    </div>
    
    <div id = "content" name = "contents">
    	<p>${vo.content}</p>
    	
    	<c:if test="${vo.file1 != null}">
			<img src="${project}fileready/${vo.file1}" width = "46%">
		</c:if>
    </div>
    
    <div id = "golist" style = "margin: 10px 0px 50px; text-align: right;">
    	<c:if test="${sessionScope.memCnt == 1}">
    	<input type = "button" id = "list" name = "back" value = "뒤로가기"  style = "font-size: .7em;"
    	onclick = "window.history.back();">
    	</c:if>
    	<a href = "review?num=${num}&number=${number}&pageNum=${pageNum}&choose=${choose}">
    	<input type = "submit" id = "list" name = "listN" value = "목록"  style = "font-size: .7em;"></a>
    	<c:if test="${vo.writer == sessionScope.memId}">
    	<a href = "reviewupdate?num=${num}&number=${number}&pageNum=${pageNum}&choose=${choose}">
    	<input type = "submit" id = "list" name = "update" value = "수정"  style = "font-size: .7em;"></a>
    	<a href = "reviewdelete?onenum=${num}&number=${number}&pageNum=${pageNum}&choose=${choose}">
    	<input type = "submit" id = "list" name = "delete" value = "삭제"  style = "font-size: .7em;"></a>
    	</c:if>
    </div>
    
    <form action="replyPro" method = "post" name = "replyForm">
    	<input type = "hidden" name = "num" value = "${num}">
    	<input type = "hidden" name = "number" value = "${number}">
    	<input type = "hidden" name = "pageNum" value = "${pageNum}">
    	<input type = "hidden" name = "choose" value = "${choose}">
	    <div id = "comment">
	    	<table width = "100%">
	    	<col style = "width: 7%;">
	    	<col>
	    	<col style = "width: 5%">
	    	<tr>
				<th align = "center" colspan = "3">
					<!-- 게시글이 있으면 -->
					<c:if test="${srhCnt > 0}">
						<!-- 처음[◀◀] : ㅁ + 한자키 / 이전블록 [◀] -->
						<c:if test="${startPage > pageBlock}">
							<a href = "reviewForm?num=${num}&number=${number}
							&pageNum=${pageNum}&choose=${choose}">[◀◀]</a>
							<a href = "reviewForm?num=${num}&number=${number}
							&pageNum=${pageNum}&r_pageNum=${startPage - pageBlock}&choose=${choose}">[◀]</a>
						</c:if>
						
						<!-- 블럭내의 페이지 번호 -->
						<c:forEach var = "i" begin = "${startPage}" end = "${endPage}">
							<c:if test="${i == currentPage}">
								<span><b>[${i}]</b></span>				
							</c:if>
							<c:if test="${i != currentPage}">
								<span><a href = "reviewForm?num=${num}&number=${number}
							&pageNum=${pageNum}&r_pageNum=${i}&choose=${choose}">[${i}]</a></span>				
							</c:if>
						</c:forEach>
						
						<!-- 다음블럭 [▶] / 끝[▶▶] -->
						<c:if test="${pageCount > endPage}">
							<a href = "reviewForm?num=${num}&number=${number}
							&pageNum=${pageNum}&r_pageNum=${startPage + pageBlock}&choose=${choose}">[▶]</a>
							<a href = "reviewForm?num=${num}&number=${number}
							&pageNum=${pageNum}&r_pageNum=${pageCount}&choose=${choose}">[▶▶]</a>
						</c:if>
					</c:if>
				</th>
			</tr>
	    	<!-- 게시글이 있으면 -->
			<c:if test="${srhCnt > 0}">
				<c:forEach var = "list" items = "${list}">
					<tr>
						<td colspan = "3">
						<c:set var="now" value="<%=new java.util.Date()%>" />
						<c:set var="sysYear"><fmt:formatDate value="${now}" pattern="yyyy-MM-dd" /></c:set>
						<c:set var="boardYear"><fmt:formatDate value="${list.reg_date}" pattern="yyyy-MM-dd" /></c:set> 
						<c:if test = "${boardYear == sysYear}">
						<img src = "./ascloimage/newicon.png" width = "20px" height = "15px" style = "vertical-align:middle;">
						</c:if>
						${list.num} ${list.writer}
						</td>
					</tr>
					<tr class = "qna">
						<!-- 상세 페이지 -->
						<td colspan = "2">
						${list.content}
						</td>
						<c:if test="${list.writer == sessionScope.memId}">
						<td style = "text-align: center;"><input type = "button" id = "ok" name = "okN" value = "삭제" 
						onclick = "window.location = 'replydelete?num=${num}&number=${number}&pageNum=${pageNum}&rpageNum=${rpageNum}&choose=${choose}&onenum=${list.num}'"></td></c:if>
						<c:if test="${list.writer != sessionScope.memId}">
						<td></td>
						</c:if>
					</tr>
					<tr>
						<td colspan = "3">
						${list.reg_date}
						</td>
					</tr>
				</c:forEach>
			</c:if>
			<!-- 게시글이 없으면 -->
			<c:if test="${srhCnt <= 0}">
				<tr class = "qna">
					<td colspan = "3" align = "center">
						댓글이 없습니다. 첫 댓글이 되어주세요!!
					</td>
				</tr>
			</c:if>
	    		<tr>
	    			<td><b>댓글달기</b></td>
	    			<td></td>
	    			<td></td>
	    		</tr>
	    		
	    		<tr>
	    			<td>비밀번호: </td>
	    			<td><input type = "password" id = "userpwd" name = "pwd"></td>
	    			<td></td>
	    		</tr>
	    		<tr>
	    			<td colspan = "2"><textarea class = "Box" rows="3" cols="80" name = "content" style="resize: none; width:100%;"></textarea></td>
	    			<td style = "text-align: center;"><input type = "submit" id = "ok" name = "okN" value = "확인"></td>
	    		</tr>
	    	</table>
	    </div>
    </form>
    
    <div id = "beforeNafter">
    	<table>
    		<col style = "width: 10%;">
    		<col style = "width: 90%;">
    		<c:if test="${vo.fwsubject != null}">
	    		<tr id = "before">
	    			<td><img src = "ascloimage/up.png" width = "12px" height = "12px">이전글</td>
	    			<td><a href = "reviewForm?num=${vo.fwnum}&number=${number-1}&pageNum=${pageNum}&choose=${choose}">${vo.fwsubject}</a></td>
	    		</tr>
    		</c:if>
    		<c:if test="${vo.nextsubject != null}">
	    		<tr id = "after">
	    			<td><img src = "ascloimage/down.png" width = "12px" height = "12px">다음글</td>
	    			<td><a href = "reviewForm?num=${vo.nextnum}&number=${number+1}&pageNum=${pageNum}&choose=${choose}">${vo.nextsubject}</a></td>
	    		</tr>
    		</c:if>
    	</table>
    </div>
	
<%@ include file = "bottommenu.jsp" %>
</body>
</html>