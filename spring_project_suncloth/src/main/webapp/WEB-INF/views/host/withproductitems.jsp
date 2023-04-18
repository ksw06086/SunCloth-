<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<c:set var = "project" value = "/JSP_PJ/"/>
<link type = "text/css" rel = "stylesheet" href = "${project}cssall/h_withproduct.css"/>
<html>
<script type = "text/javascript" src = "${project}suncloth/js/jquery-3.4.1.min.js"></script>
<script type = "text/javascript" src = "${project}host/script.js"></script>
<script type="text/javascript">
$(function() {
	if("${schType}" != ""){
		document.searchForm.srhType.value = "${schType}";
		document.searchForm.searchType.value = "${schType}";
	}
});
</script>
<body>
<section>
	<table id = "middle">
		<tr>
			<td id = "tabright">
				<div id = "righttop">
					<p><b>판매상품관리</b></p>
				</div>
				<form action = "withproductitems" method = "post" name = "searchForm">
				<table id = "searchifs">
					<col style = "width:15%;">
					<col>
    				<tr>
						<td>검색어</td>
						<td>
						<select id = "type" name = "srhType" style = "padding:2px; vertical-align:middle;">
							<option value = "0">상품명</option>
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
					</table>
					
					<table id = "orderlist">
				    	<col style = "width:10%;">
				    	<col style = "width:10%;">
				    	<col>
				    	<col style = "width:10%;">
				    	<tr id = "title">
				    		<td>이미지</td>
				    		<td>카테고리</td>
				    		<td>상품명</td>
				    		<td>판매가</td>
				    	</tr>
				    	<!-- 게시글이 있으면 -->
						<c:if test="${srhCnt > 0}">
							<c:forEach var = "list" items = "${list}">
								<tr style = "text-align:center;" class = "orderprd">
									<td>
									<c:if test="${list.mainfile != null}">
									<img src="${project}fileready/${list.mainfile}" width = "50px" height = "60px">
									</c:if>
									</td>
									<!-- 상세 페이지 -->
									<td>
									${list.mediumpartname}
									</td>
									<td>
									<a onclick = "setwithitems('${list.num}', '${list.mainfile}');" style = "cursor:pointer;">
									${list.name}
									</a></td>
									<td><b>KRW ${list.saleprice}</b></td>
								</tr>
							</c:forEach>
						</c:if>
						<!-- 게시글이 없으면 -->
						<c:if test="${srhCnt <= 0}">
							<tr class = "orderprd">
								<td colspan = "10" align = "center">
									상품이 없습니다.
								</td>
							</tr>
						</c:if>
				    </table>
				    
				    <table id = "buttons" style = "width:98%; padding: 10px 0px 0px; margin:0 auto;">
				    	<tr>
				    		<td style = "text-align:center; padding: 15px;"><!-- 페이지 컨트롤 -->
								<table align = "center">
									<tr>
										<th align = "center">
											<!-- 게시글이 있으면 -->
											<c:if test="${cnt > 0}">
												<!-- 처음[◀◀] : ㅁ + 한자키 / 이전블록 [◀] -->
												<c:if test="${startPage > pageBlock}">
													<a href = "withproductitems">[◀◀]</a>
													<a href = "withproductitems?pageNum=${startPage - pageBlock}">[◀]</a>
												</c:if>
												
												<!-- 블럭내의 페이지 번호 -->
												<c:forEach var = "i" begin = "${startPage}" end = "${endPage}">
													<c:if test="${i == currentPage}">
														<span><b>[${i}]</b></span>				
													</c:if>
													<c:if test="${i != currentPage}">
														<span><a href = "withproductitems?pageNum=${i}">[${i}]</a></span>
													</c:if>
												</c:forEach>
												
												<!-- 다음블럭 [▶] / 끝[▶▶] -->
												<c:if test="${pageCount > endPage}">
													<a href = "withproductitems?pageNum=${startPage + pageBlock}">[▶]</a>
													<a href = "withproductitems?pageNum=${pageCount}">[▶▶]</a>
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