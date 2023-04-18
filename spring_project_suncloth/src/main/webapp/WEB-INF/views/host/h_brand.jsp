<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file = "setting.jsp" %>
<link type = "text/css" rel = "stylesheet" href = "${project}cssall/h_brand.css"/>
<html>
<body>
<%@ include file = "topmenu.jsp" %>
<script type="text/javascript">
$(function() {
	$("#brandallcheck").change(function(){
		var is_check = $(this).is(":checked");
		
		// 전체선택시 개별을 일괄체크
		if(is_check){
			$(".brandcheck").prop("checked","true");
		} else {
			$(".brandcheck").prop("checked","");
		}
	});
	
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
				<div id = "righttop">
					<p><b>브랜드관리</b></p>
					<p><a href = "h_brandinput"><input type = "button" value = "브랜드등록" id = "prdinput"></a></p>
				</div>
				
				<form action = "h_branddeletePro" method = "post" name = "completeForm">
				<input type = "hidden" name = "pageNum" value = "${pageNum}">
				<div id = "result">
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
					
					<table id = "brandlist" style = "border-bottom: 1px solid #ccc; border-top: 1px solid #ccc;">
				    	<col style = "width:1%;">
				    	<col>
				    	<col>
				    	<col>
				    	<col>
				    	<tr id = "title">
				    		<td><input type = "checkbox" name = "prdcheck" id = "brandallcheck"  value = "전체선택"></td>
				    		<td>번호</td>
				    		<td>브랜드 명</td>
				    		<td>전화번호</td>
				    		<td>등록일</td>
				    	</tr>
				    	<!-- 게시글이 있으면 -->
						<c:if test="${srhCnt > 0}">
							<c:forEach var = "list" items = "${list}">
								<tr style = "text-align:center;" class = "brands">
									<td><input type = "checkbox" name = "brandchecks" class = "brandcheck"  value = "${list.num}"></td>
									<td>${number}(${list.num})
									<c:set var = "number" value = "${number-1}"/>
									</td>
									<!-- 상세 페이지 -->
									<td align = "left">
									<a href = "h_brandForm?num=${list.num}&number=${number+1}&pageNum=${pageNum}&choose=${choose}">
									${list.name}
									</a></td>
									<td>${list.hp}</td>
									<td><fmt:formatDate type="both" pattern="yyyy-MM-dd HH:mm" value="${list.reg_date}"/></td>
								</tr>
							</c:forEach>
						</c:if>
						<!-- 게시글이 없으면 -->
						<c:if test="${srhCnt <= 0}">
							<tr class = "brands">
								<td colspan = "5" align = "center">
									게시글이 없습니다. 글을 작성해주세요!!
								</td>
							</tr>
						</c:if>
				    </table>
				    
				    <table id = "buttons">
				    	<tr class = "prdbtn">
				    		<td>
				    		<input type = "submit" value = "삭제" id = "checkdel">
				    		</td>
				    		<td>
				    		<input type = "hidden" name = "searchType" value = "0">
							<select id = "srhtype" name = "srhType" style = "vertical-align:middle;">
								<option value = "0">브랜드 명</option>
							</select>
							<input type = "search" id = "brandsrh" name = "srch">
							<input type = "button" value = "검색" id = "srhbtn" onclick = "srhClick();">
							</td>
				    	</tr>
				    	<tr>
				    		<td style = "text-align:center; padding: 15px;" colspan = "2"><!-- 페이지 컨트롤 -->
								<table align = "center">
									<tr>
										<th align = "center">
											<!-- 게시글이 있으면 -->
											<c:if test="${cnt > 0}">
												<!-- 처음[◀◀] : ㅁ + 한자키 / 이전블록 [◀] -->
												<c:if test="${startPage > pageBlock}">
													<a href = "h_brand">[◀◀]</a>
													<a href = "h_brand?pageNum=${startPage - pageBlock}">[◀]</a>
												</c:if>
												
												<!-- 블럭내의 페이지 번호 -->
												<c:forEach var = "i" begin = "${startPage}" end = "${endPage}">
													<c:if test="${i == currentPage}">
														<span><b>[${i}]</b></span>				
													</c:if>
													<c:if test="${i != currentPage}">
														<span><a href = "h_brand?pageNum=${i}">[${i}]</a></span>
													</c:if>
												</c:forEach>
												
												<!-- 다음블럭 [▶] / 끝[▶▶] -->
												<c:if test="${pageCount > endPage}">
													<a href = "h_brand?pageNum=${startPage + pageBlock}">[▶]</a>
													<a href = "h_brand?pageNum=${pageCount}">[▶▶]</a>
												</c:if>
											</c:if>
										</th>
									</tr>
								</table>
							</td>
				    	</tr>
				    </table>
				</div>
				</form>
			</td>
		</tr>
	</table>
</section>
</body>
</html>