<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file = "setting.jsp" %>
<link type = "text/css" rel = "stylesheet" href = "${project}cssall/h_productinput.css"/>
<html>
<script type="text/javascript">
function select_inputcategoryView(){
	// 서버로 요청해서 통신한 후 응답을 callback 함수로 받겠다.
	var value = document.productForm.opart.value;
	
	if(value != "") {
	  var params = "bigpart=" + value;
		  
	  sendRequest(sub_callback, "h_subcategory", "GET", params); // search_next.jsp -> 콜백함수로 리턴
	}
}

/*
 * 콜백함수
 	- 서버로부터 응답이 오면 동작할 함수(시스템이 자동으로 호출)
 	- 콜백함수 명은 sendRequest(콜백함수명)과 일치해야 한다.
 	- simple_callback() : 콜백함수
 	- result : 출력위치
 */
 
function sub_callback(){
	var result = document.getElementById("twopart");
	// 4 : completed => 전체데이터가 취득환료된 상태
	if(httpRequest.readyState == 4){ 
		if(httpRequest.status == 200) { // 200 : 정상종료
			//result.innerHTML = "정상종료";
			var data = httpRequest.responseText;
			
			result.innerHTML = data;
			//result.innerHTML = httpRequest.responseXML;
		} else {
			alert("에러발생");
		}
	} else {
		alert("상태 : " + httpRequest.readyState);
	}
}
</script>
<body onload = "start();">
<%@ include file = "topmenu.jsp" %>

<section>
	<table id = "middle">
		<col style = "width:15%;">
		<col>
		<tr>
			<%@ include file = "h_productLeft.jsp" %>
			<td id = "tabright">
			<form method="post" name = "productForm">
				<input type = "hidden" name = "pageNum" value = "${pageNum}">
				<input type = "hidden" name = "num" value = "${num}">
				<div id = "righttop">
					<p><input type = "button" value = "상품리스트" id = "prdlist"></p>
					<p><b>판매상품관리</b></p>
					<p><input type = "submit" value = "파일들수정폼" id = "prdinput" onclick = "javascript: productForm.action = 'h_productform2'">
					<input type = "submit" value = "텍스트등록" id = "prdinput" onclick = "javascript: productForm.action = 'h_productupdatePro1'">
					</p>
				</div>
				
				<div id = "product">
					<table id = "basetop">
						<tr>
							<td>
							<b>·상품기본정보</b>
							</td>
						</tr>
					</table>
					
					<table id = "base">
						<col style = "width:20%">
						<col>
						<tr>
							<td>상품 카테고리*</td>
							<td>
							<select id = "onepart" onchange = "select_inputcategoryView();" name = "opart">
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
								<!-- 게시글이 있으면 -->
								<c:if test="${mediumsrhCnt > 0}">
									<c:forEach var = "list" items = "${medilist}">
										<option value = "${list.mediumcode}">${list.mediumname}</option>
									</c:forEach>
								</c:if>
								<!-- 게시글이 없으면 -->
								<c:if test="${mediumsrhCnt <= 0}">
								</c:if>
							</select>*
							</td>
						</tr>
						
						<tr>
							<td>상품명 *</td>
				     		<td><input type = "text" id = "prdname" name = "name" value = "${vo.name}">
				     		</td>
				     	</tr>
	    				
	    				<tr>
							<td>과세/비과세</td>
							<td>
							<input type = "radio" name = "tex" id = "tax" value = "과세" checked>
	    					<label for = "tax">과세</label>&emsp;
	    					<input type = "radio" name = "tex" id = "nottax" value = "비과세">
	    					<label for = "nottax">비과세</label>
							</td>
						</tr>
						
						<tr>
							<td>브랜드</td>
							<td>
							<select id = "brand" name = "brands">
								<option value = "">브랜드 선택</option>
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
							<td>아이콘</td>
							<td>
	    					<input type = "radio" name = "icon" id = "hot" value = "hot">
	    					<label for = "hot">hot</label>&emsp;
	    					<input type = "radio" name = "icon" id = "minprice" value = "minprice">
	    					<label for = "minprice">최저가</label><br>
	    					<input type = "radio" name = "icon" id = "best" value = "best">
	    					<label for = "best">best</label>
							</td>
						</tr>
						
						<tr>
							<td>적립금</td>
							<td>
							<input type = "radio" name = "plus" id = "notplust" value = "notplus">
	    					<label for = "notplust">없음</label>&emsp;
	    					<input type = "radio" name = "plus" id = "plus" value = "plus">
	    					<label for = "plus">적립금</label>&emsp;
	    					<input type = "text" id = "maxcount" name = "pluspay" value = "${vo.plus}">원
							</td>
						</tr>
					</table>
					
					<table id = "btmtop">
						<tr>
							<td>
							<b>·상품 판매정보</b>
							</td>
						</tr>
					</table>
					<table id = "bottom">
						<col style = "width:15%">
						<col>
						<col style = "width:15%">
						<col>				
						<tr>
							<td>판매가격 *</td>
				     		<td><input type = "text" id = "saleprice" name = "saleprice" value = "${vo.saleprice}">원
				     		</td>
				     		<td>매입가격 *</td>
				     		<td><input type = "text" id = "buyprice" name = "buyprice" value = "${vo.buyprice}">원
				     		</td>
				     	</tr>
					</table>
					
					<table id = "delitop">
						<tr>
							<td>
							<b>·배송관련</b>
							</td>
						</tr>
					</table>
					<table id = "deli">	
						<col style = "width:20%;">
						<col>				
						<tr>
							<td>예상배송소요일 *</td>
				     		<td><input type = "text" id = "delidate" name = "delidate" value = "${vo.deliday}">일
				     		</td>
				     	</tr>
				     	
				     	<tr>
							<td>배송비 설정</td>
							<td>
							<input type = "radio" name = "delipay" id = "basepay" value = "basepay">
	    					<label for = "basepay">기본 배송비</label><br>
	    					<input type = "radio" name = "delipay" id = "free" value = "free">
	    					<label for = "free">무료</label><br>
	    					<input type = "radio" name = "delipay" id = "plusdelipay" value = "pluspay">
	    					<label for = "plusdelipay">유료</label>
	    					<input type = "text" id = "pluspay" name = "deliprice" value = "${vo.deliprice}">원
							</td>
				     	</tr>
					</table>
					
					<table id = "subtop">
						<tr>
							<td>
							<b>·상품 상세 설명</b>
							</td>
						</tr>
					</table>
					
					<table id = "sub">
				    	<col style = "width: 15%;">
				    	<col>
			    		<tr>
			    			<td colspan = "2">
			    			<textarea class = "Box" rows="30" cols="80" name = "content"
			    			style="resize: vertical; width:100%; border:none;">${vo.content}</textarea></td>
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