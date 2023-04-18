<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file = "setting.jsp" %>
<link type = "text/css" rel = "stylesheet" href = "${project}cssall/bottom.css"/>
<html>
<body>
<%@ include file = "topmanu.jsp" %>

    <div id = "road">
		<p>home > ${name}</p>
	</div>
	
	<div id = "topname">
		<p><b>${name}</b></p>
	</div>
	
	<div id = "prdlisttop" style = "width:100%; margin:0px;">
		<p id = "listtotal">Total : <span style = "color:#000">${srhCnt}</span> items</p>
		<p id = "sortway"><span>신상품</span> | <span>상품명</span> | <span>낮은가격</span> | <span>높은가격</span> | <span>사용후기</span></p>
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
	</c:if>

	<div class = "listnum">
    	<table style = "width:1000px;" align = "center">
			<tr>
				<th align = "center">
					<!-- 게시글이 있으면 -->
					<c:if test="${cnt > 0}">
						<!-- 처음[◀◀] : ㅁ + 한자키 / 이전블록 [◀] -->
						<c:if test="${startPage > pageBlock}">
							<a href = "menulist?name=${name}">[◀◀]</a>
							<a href = "menulist?name=${name}&pageNum=${startPage - pageBlock}">[◀]</a>
						</c:if>
						
						<!-- 블럭내의 페이지 번호 -->
						<c:forEach var = "i" begin = "${startPage}" end = "${endPage}">
							<c:if test="${i == currentPage}">
								<span><b>[${i}]</b></span>				
							</c:if>
							<c:if test="${i != currentPage}">
								<span><a href = "menulist?name=${name}&pageNum=${i}">[${i}]</a></span>
							</c:if>
						</c:forEach>
						
						<!-- 다음블럭 [▶] / 끝[▶▶] -->
						<c:if test="${pageCount > endPage}">
							<a href = "menulist?name=${name}&pageNum=${startPage + pageBlock}">[▶]</a>
							<a href = "menulist?name=${name}&pageNum=${pageCount}">[▶▶]</a>
						</c:if>
					</c:if>
				</th>
			</tr>
		</table>
    </div>
	
<%@ include file = "bottommenu.jsp" %>
</body>
</html>