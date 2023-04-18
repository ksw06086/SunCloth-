<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file = "setting.jsp" %>
<link type = "text/css" rel = "stylesheet" href = "${project}cssall/bottom.css"/>
<html>
<body>
<%@ include file = "topmanu.jsp" %>

    <div id = "road">
		<p>home > search</p>
	</div>
	
	<div id = "topname">
		<p><b>제품 검색</b></p>
	</div>
	
	<form name = "search" method = "post">
	<div id = "searchpart">
		<table>
			<col style = "width:25%;">
			<col style = "width:60%;">
			<col style = "width:15%;">
			<tr>
				<td>
				<select id = "searchtype" name = "srhType" style = "width: 100%; height: 30px; border:none;">
					<option value = "0">상품명</option>
					<option value = "1">상품번호</option>
				</select>
				<input type = "hidden" name = "searchType" value = "0">
				</td>
				<td><input type = "search" id = "searchtext" name = "srch" value = "${searchtext}" style = "width: 100%; height: 40px; border:none;"></td>
				<td><a onclick = "javascript: search.action = 'searchlist'"><img src = "./ascloimage/search.png" width = "25px" height = "25px" style = "vertical-align:middle;"></a></td>
			</tr>
		</table>
	</div>
	</form>

	<div id = "prdlisttop" style = "width:100%; margin:0px;">
		<p id = "listtotal">총 <span style = "color:#000">${srhCnt}</span>개의 상품이 검색되었습니다.</p>
		<p id = "sortway"><input type = "button" id = "newprd" name = "new" value = "신상품">&nbsp;
		<input type = "button" id = "prdname" name = "new" value = "상품명">&nbsp;
		<input type = "button" id = "prdlow" name = "new" value = "낮은가격">&nbsp;
		<input type = "button" id = "prdhigh" name = "new" value = "높은가격">&nbsp;
		<input type = "button" id = "prdreview" name = "new" value = "사용후기"></p>
	</div>

	<c:if test="${srhCnt > 0}">
	<div class = "items">
		<table>
		<c:forEach var = "list" items = "${list}" varStatus="status">
		<c:if test="${status.index%4 == 0}">
			<tr>
				<td>
					<div>
						<li><a href = "productclick?num=${list.num}&name=${list.name}"><img src = "${project}fileready/${list.mainfile}" width = "320px" height = "350px"></a></li>
						<li><a href = "productclick?num=${list.num}&name=${list.name}">${list.name}</a></li>
						<li>KRW ${list.saleprice}</li>
					</div>
				</td>
				</c:if>
				<c:if test="${status.index%4 == 1}">
				<td>
					<div>
						<li><a href = "productclick?num=${list.num}&name=${list.name}"><img src = "${project}fileready/${list.mainfile}" width = "320px" height = "350px"></a></li>
						<li><a href = "productclick?num=${list.num}&name=${list.name}">${list.name}</a></li>
						<li>KRW ${list.saleprice}</li>
					</div>
				</td>
				</c:if>
				<c:if test="${status.index%4 == 2}">
				<td>
					<div>
						<li><a href = "productclick?num=${list.num}&name=${list.name}"><img src = "${project}fileready/${list.mainfile}" width = "320px" height = "350px"></a></li>
						<li><a href = "productclick?num=${list.num}&name=${list.name}">${list.name}</a></li>
						<li>KRW ${list.saleprice}</li>
					</div>
				</td>
				</c:if>
				<c:if test="${status.index%4 == 3}">
				<td>
					<div>
						<li><a href = "productclick?num=${list.num}&name=${list.name}"><img src = "${project}fileready/${list.mainfile}" width = "320px" height = "350px"></a></li>
						<li><a href = "productclick?num=${list.num}&name=${list.name}">${list.name}</a></li>
						<li>KRW ${list.saleprice}</li>
					</div>
				</td>
			</tr>		
		</c:if>
		</c:forEach>
		</table>
	</div>
	<div class = "listnum">
    	<table style = "width:1000px;" align = "center">
			<tr>
				<th align = "center">
					<!-- 게시글이 있으면 -->
					<c:if test="${cnt > 0}">
						<!-- 처음[◀◀] : ㅁ + 한자키 / 이전블록 [◀] -->
						<c:if test="${startPage > pageBlock}">
							<a href = "searchlist?srch=${searchtext}">[◀◀]</a>
							<a href = "searchlist?pageNum=${startPage - pageBlock}&srch=${searchtext}">[◀]</a>
						</c:if>
						
						<!-- 블럭내의 페이지 번호 -->
						<c:forEach var = "i" begin = "${startPage}" end = "${endPage}">
							<c:if test="${i == currentPage}">
								<span><b>[${i}]</b></span>				
							</c:if>
							<c:if test="${i != currentPage}">
								<span><a href = "searchlist?pageNum=${i}&srch=${searchtext}">[${i}]</a></span>
							</c:if>
						</c:forEach>
						
						<!-- 다음블럭 [▶] / 끝[▶▶] -->
						<c:if test="${pageCount > endPage}">
							<a href = "searchlist?pageNum=${startPage + pageBlock}&srch=${searchtext}">[▶]</a>
							<a href = "searchlist?pageNum=${pageCount}&srch=${searchtext}">[▶▶]</a>
						</c:if>
					</c:if>
				</th>
			</tr>
		</table>
    </div>
	</c:if>
	<c:if test="${srhCnt == 0}">
		<div id = "notfindprd">
			<p><b>검색결과가 없습니다.</b><br>
			<b>정확한 검색어인지 확인하시고 다시 검색해 주세요.</b><br>
			<br>
			검색어/제외검색어의 입력이 정확한지 확인해 보세요.<br>
			두 단어 이상의 검색어인 경우, 띄어쓰기를 확인해 보세요.<br>
			검색옵션을 다시 확인해 보세요.</p>
		</div>
	</c:if>
	
<%@ include file = "bottommenu.jsp" %>
</body>
</html>