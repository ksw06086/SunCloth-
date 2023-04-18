<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file = "setting.jsp" %>
<link type = "text/css" rel = "stylesheet" href = "${project}cssall/h_productinput.css"/>
<html>
<script type="text/javascript">
function select_inputcategory2(){
	// 서버로 요청해서 통신한 후 응답을 callback 함수로 받겠다.
	var value = document.productForm.subbigpart.value;
	
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
	var result = document.getElementById("twopart1");
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

function select_inputcategory(){
	// 서버로 요청해서 통신한 후 응답을 callback 함수로 받겠다.
	var value = document.productForm.opart.value;
	
	if(value != "") {
	  var params = "bigpart=" + value;
		  
	  sendRequest(sub_callback1, "h_subcategory", "GET", params); // search_next.jsp -> 콜백함수로 리턴
	}
}

/*
 * 콜백함수
 	- 서버로부터 응답이 오면 동작할 함수(시스템이 자동으로 호출)
 	- 콜백함수 명은 sendRequest(콜백함수명)과 일치해야 한다.
 	- simple_callback() : 콜백함수
 	- result : 출력위치
 */
 
function sub_callback1(){
	var result = document.getElementById("twopart2");
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
			<form method="post" name = "productForm" enctype="multipart/form-data">
				<div id = "righttop">
					<p><input type = "button" value = "상품리스트" id = "prdlist" onclick = "window.location.href = 'h_product'"></p>
					<p><b>판매상품관리</b></p>
					<p>
					<input type = "submit" value = "등록" id = "prdinput" onclick = "javascript: productForm.action = 'h_productPro'">
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
			    			<td style = "border-right:1px solid #ccc;">메인 이미지1</td>
			    			<td>
			    			<input type = "file" id = "attachfile1" name = "mainfile">
			    			</td>
			    		</tr>
						<tr>
							<td>1차 카테고리 추가</td>
							<td>
							<input type = "text" id = "prdname" name = "bigpart">
							<input type = "button" class = "Pro" name = "bigPro" value = "추가"
							onclick = "bigpartPro();">
							<select id = "onepart" name = "bigpartdel">
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
							<input type = "button" class = "Pro" name = "bigPro" value = "삭제"
							onclick = "bigpartdelPro();">
							</td>
						</tr>
						<tr>
							<td>2차 카테고리 추가</td>
							<td>
							<select id = "onepart1" name = "subbigpart" onchange = "select_inputcategory2();">
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
							<input type = "text" id = "prdname" name = "mediumpart">
							<input type = "button" class = "Pro" name = "mediumPro" value = "추가"
							onclick = "mediumpartPro();">
							<select id = "twopart1" name = "tpartdel"> <!-- 일단 아우터것만 이거는 jQuery로 조건써서 갖다넣을려고함 -->
								
							</select>
							<input type = "button" class = "Pro" name = "mediumdelPro" value = "삭제"
							onclick = "mediumpartdelPro();">
							</td>
						</tr>
						
						<tr>
							<td>상품 카테고리*</td>
							<td>
							<select id = "onepart2" onchange = "select_inputcategory();" name = "opart">
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
							<select id = "twopart2" name = "tpart"> <!-- 일단 아우터것만 이거는 jQuery로 조건써서 갖다넣을려고함 -->
								
							</select>*
							</td>
						</tr>
						
						<tr>
							<td>상품명 *</td>
				     		<td><input type = "text" id = "prdname" name = "name">
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
	    					<input type = "text" id = "maxcount" name = "pluspay">원
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
				     		<td><input type = "text" id = "saleprice" name = "saleprice">원
				     		</td>
				     		<td>매입가격 *</td>
				     		<td><input type = "text" id = "buyprice" name = "buyprice">원
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
				     		<td><input type = "text" id = "delidate" name = "delidate">일
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
	    					<input type = "text" id = "pluspay" name = "deliprice">원
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
			    			style="resize: vertical; width:100%; border:none;"></textarea></td>
			    		</tr>
			    		<tr>
			    			<td style = "border-right:1px solid #ccc;">첨부파일1</td>
			    			<td><input type = "file" id = "attachfile1" name = "file1"></td>
			    		</tr>
			    		<tr>
			    			<td style = "border-right:1px solid #ccc;">첨부파일2</td>
			    			<td><input type = "file" id = "attachfile2" name = "file2"></td>
			    		</tr>
			    		<tr>
			    			<td style = "border-right:1px solid #ccc;">첨부파일3</td>
			    			<td><input type = "file" id = "attachfile3" name = "file3"></td>
			    		</tr>
			    		<tr>
			    			<td style = "border-right:1px solid #ccc;">첨부파일4</td>
			    			<td><input type = "file" id = "attachfile4" name = "file4"></td>
			    		</tr>
			    		<tr>
			    			<td style = "border-right:1px solid #ccc;">첨부파일5</td>
			    			<td><input type = "file" id = "attachfile5" name = "file5"></td>
			    		</tr>
			    		<tr>
			    			<td style = "text-align:center; padding: 10px 0px;">
			    			<input type = "hidden" name = "withitem" value = "">
			    			<div id = "image" style = "background-color:#ccc; width: 100px; height: 100px; line-height:100px; margin:0px auto;">
			    			No image</div></td>
			    			<td><input type = "button" id = "detailprd"
			    			 onclick = "withproductChk();" name = "detailprdN" value = "상품정보선택" style = "vertical-align:middle; font-size: .9em;">
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