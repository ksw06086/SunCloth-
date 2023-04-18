<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file = "setting.jsp" %>
<link type = "text/css" rel = "stylesheet" href = "${project}cssall/h_productinput.css"/>
<html>
<script type="text/javascript">
function select_color(){
	// 서버로 요청해서 통신한 후 응답을 callback 함수로 받겠다.
	var color = document.productForm.color.value;
	var value = document.productForm.num.value;
	
	if(value != "") {
	  var params = "color=" + color + "&num="+ value;
		  
	  sendRequest(sub_color_callback, "h_subsize", "GET", params); // search_next.jsp -> 콜백함수로 리턴
	}
}

/*
 * 콜백함수
 	- 서버로부터 응답이 오면 동작할 함수(시스템이 자동으로 호출)
 	- 콜백함수 명은 sendRequest(콜백함수명)과 일치해야 한다.
 	- simple_callback() : 콜백함수
 	- result : 출력위치
 */
 
function sub_color_callback(){
	var result = document.getElementById("subsize");
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

function select_size(){
	// 서버로 요청해서 통신한 후 응답을 callback 함수로 받겠다.
	var size = document.productForm.size.value;
	var color = document.productForm.color.value;
	var value = document.productForm.num.value;
	
	if(value != "") {
	  var params = "size=" + size + "&color="+ color + "&num="+ value;
		  
	  sendRequest(sub_size_callback, "h_subcslist", "GET", params); // search_next.jsp -> 콜백함수로 리턴
	}
}

/*
 * 콜백함수
 	- 서버로부터 응답이 오면 동작할 함수(시스템이 자동으로 호출)
 	- 콜백함수 명은 sendRequest(콜백함수명)과 일치해야 한다.
 	- simple_callback() : 콜백함수
 	- result : 출력위치
 */
 
function sub_size_callback(){
	var result = document.getElementById("csupdate");
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
					<p><b>color/size 재고 상품 등록</b></p>
					<p>
					<input type = "submit" value = "등록" id = "prdinput" onclick = "javascript: productForm.action = 'h_csupdatePro'">
					</p>
				</div>
				
				<div id = "product">
					<table id = "basetop">
						<tr>
							<td>
							<b>·상품정보</b>
							</td>
						</tr>
					</table>
					
					<table id = "base">
						<col style = "width:20%">
						<col>
						<tr>
			    			<td style = "text-align:center; padding: 10px 0px;">
			    			<div id = "image" style = "background-color:#ccc; width: 100px; height: 100px; line-height:100px; margin:0px auto;">
			    			<img src = '${project}fileready/${vo.mainfile}' width = '100px' height = '100px'></div></td>
			    			<td>${vo.name}
			    			</td>
			    		</tr>
						
						<tr>
							<td>color/size*</td>
							<td>
							<select style = "width:100%; padding:3px 0px;"  name = "color" onchange = "select_color();">
		     					<option value = "">-[필수] 색상 선택-</option>
								<!-- 게시글이 있으면 -->
								<c:if test="${colorsrhCnt > 0}">
									<c:forEach var = "list" items = "${colorlist}">
										<option value = "${list.colorcode}">${list.colorname}</option>
									</c:forEach>
								</c:if>
								<!-- 게시글이 없으면 -->
								<c:if test="${colorsrhCnt <= 0}">
								</c:if>
							</select>
							<select style = "width:100%; padding:3px 0px;" name = "size" id = "subsize" onchange = "select_size();"> <!-- 일단 아우터것만 이거는 jQuery로 조건써서 갖다넣을려고함 -->
								
							</select>
							</td>
						</tr>
						
				     	<tr id = "csupdate">
				     	
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