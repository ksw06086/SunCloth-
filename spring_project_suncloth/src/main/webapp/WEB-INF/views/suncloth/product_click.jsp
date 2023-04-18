<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file = "setting.jsp" %>
<link type = "text/css" rel = "stylesheet" href = "${project}cssall/productclick.css"/>
<html>
<script type="text/javascript">
function select_color(){
	// 서버로 요청해서 통신한 후 응답을 callback 함수로 받겠다.
	var color = document.productclick.color.value;
	var value = document.productclick.num.value;
	
	if(value != "") {
	  var params = "color=" + color + "&num="+ value;
		  
	  sendRequest(sub_callback, "subsize", "GET", params); // search_next.jsp -> 콜백함수로 리턴
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
	var result = document.getElementById("sizeid");
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
		
	}
}

function priceplus(val){
	var totalprice = 0;
	totalprice = ${vo.saleprice} * parseInt(val);
	$("#priceT").html(totalprice);
	document.productclick.price.value = totalprice;
};
</script>
<body>
<%@ include file = "topmanu.jsp" %>
<form name = "productclick" method = "post">
	<input type = "hidden" name = "num" value = "${num}">
    <div id = "middle">
	     <div id = "mainimg">
	     	<img src = "${project}fileready/${vo.mainfile}" width = "600px" height = "800px">
	     </div>
	     
	     <div id = "rightsummary">
		     <div id = "topsummary">
		     	<h4 id = "prdname">${vo.name}</h4>
		     	
		     	<table id = "checklist">
		     		<col style = "width:130px;">
		     		<col style = "width:340px;">
		     		<tr>
		     			<td><b>판매가</b></td>
		     			<td> KRW ${vo.saleprice} </td>
		     		</tr>
		     		
		     		<tr>
		     			<td>색상</td>
		     			<td>
		     				<select style = "width:100%; padding:3px 0px;" onchange = "select_color();" name = "color">
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
						</td>
		     		</tr>
		     		<tr>
		     			<td>사이즈</td>
		     			<td>
		     				<select style = "width:100%; padding:3px 0px;" name = "size" id = "sizeid" onchange = "select_size();"> <!-- 일단 아우터것만 이거는 jQuery로 조건써서 갖다넣을려고함 -->
		     					
							</select>
						</td>
		     		</tr>
		     		<c:if test="${svo != null}">
		     			<tr>
		     				<td colspan = "2"><hr></td>
		     			</tr>
			     		<tr>
			     			<td><b>color/size</b></td>
			     			<td>
							<input type = "hidden" name = "colorcode" value = "${svo.colorcode}">
							<input type = "hidden" name = "sizecode" value = "${svo.sizecode}">
			     			<b>${svo.colorname}</b>/<b>${svo.sizename}(${svo.count})</b>
			     			</td>
			     		</tr>
			     		<tr>
			     			<td><b>수량</b></td>
			     			<td>
			     			<input type = "number" name = "count" min = "1" max = "${svo.maxcount}" value = "1" oninput = "priceplus(this.value);">
							</td>
			     		</tr>
			     		<tr>
			     			<td><b>가격</b></td>
			     			<td>
			     			<input type = "hidden" id = "priceI" name = "price" value = "${vo.saleprice}">
			     			<label id = "priceT">${vo.saleprice}</label>
			     			</td>
			     		</tr>
		     		</c:if>
		     		<c:if test="${svo == null}">
		     		</c:if>
		     	</table>
		     </div>
		     
		     <form>
			     <div id = "btnlist">
			     	<table>
			     		<tr>
			     			<td colspan = "2"><input type = "submit" value = "BUY IT NOW" style = "width: 480px;" id = "buy" onclick = "javascript: productclick.action = 'orderform'"></td>
			     		</tr>
			     		<tr>
			     			<td><input type = "submit" value = "ADD TO CART" style = "width: 238px;" id = "cartadd" class = "btmbtn" onclick = "javascript: productclick.action = 'cartAdd'"></td>
			     			<td><input type = "submit" value = "WISH LIST" style = "width: 238px;" id = "wishlist" class = "btmbtn" onclick = "javascript: productclick.action = 'wishlistAdd'"></td>
			     		</tr>
			     	</table>
			     </div>
		     </form>
     
     		<div>
     			<pre> <img src = "./ascloimage/instagram.png" width = "10px" height = "10px">INSTRUCTION</pre>
     			<pre style = "font-size:.9em;">   INFO
   애즈클로 베스트셀러인 '1+1 퍼펙트 20수 싱글티셔츠'입니다.
   좀더 핏이 큰걸 우너하시는 분들이 많아 좀 더 넉넉한 사이즈로 준비해보았습니다:)
   반응이 좋아 1+1 이벤트로 진행합니다.!
   
   
   퍼펙트라인의 제품을 구매해보신분들이라면 아시리라 생각합니다.
   핏부터 원단감까지 가성비가 너무나도 훌륭한 티셔츠입니다.:)
   20수 원단으로 제작되었으며, 4계절내내 데일리로 활용하기 좋은 제품입니다.
		    	</pre>
		    </div>
	     </div>
     </div>
</form>
     
    <div class = "list">
		<table>
			<tr>
			<td style = "border-bottom:3px solid #cccccc;"><b>DETAIL</b></td>
			</tr>
		</table>
	</div>
	
	<div id = "summary">
		<ul align = "center">
			<c:if test = "${vo.file1 != null}">
			<li><img src = "${project}fileready/${vo.file1}" width = "600px"></li>
			</c:if>
			<c:if test = "${vo.content != null}">
			<li><p>${vo.content}</p></li>
			</c:if>
			<c:if test = "${vo.file2 != null}">
			<li><img src = "${project}fileready/${vo.file2}" width = "600px"></li>
			</c:if>
			<c:if test = "${vo.file3 != null}">
			<li><img src = "${project}fileready/${vo.file3}" width = "600px"></li>
			</c:if>
			<c:if test = "${vo.file4 != null}">
			<li><img src = "${project}fileready/${vo.file4}" width = "600px"></li>
			</c:if>
			<c:if test = "${vo.file5 != null}">
			<li><img src = "${project}fileready/${vo.file5}" width = "600px"></li>
			</c:if>
		</ul>
	</div>
     
    <!-- <div class = "list">
		<table>
			<tr>
			<td><a href = "#summary">DETAIL</a></td>
			<td style = "border-bottom:3px solid #cccccc;"><b>WITH ITEM</b></td>
			<td><a href = "#review">REVIEW</a></td>
			<td><a href = "#question">Q&A</a></td>
			</tr>
		</table>
	</div>
     
    <div id = "withitemtext">
    	<p align = "center", style = "line-height:20px;">
    		<span>WITH ITEM</span><br>
    		<span><font size = "2px">함께 코디된 관련상품 입니다.</font></span>
    	</p>
    </div>
    
    <div id = "withitemfull">
    	<ul>
    		<li><input type = "button" value = "" id = "leftbtn"></li>
    		<li id = "withitemlist">
    			<div id = "withitems">
    				<table>
    					<tr>
    						<td>
    							<div id = "withitem1">
    								<pre><img src = "../ascloimage/jang1.jpg" width = "250px" height="300px">
<input type = "checkbox" class = "withitem" value = "ASCLO_Black_Socks" id = "check1"><label>ASCLO Black Socks</label>
KRW 5,000
<input type = "number" value = "1" min = "1" max = "5" step = "1">
									</pre>
								</div>
							</td>
							<td>
								<div id = "withitem2">
    								<pre><img src = "../ascloimage/jang1.jpg" width = "250px" height="300px">
<input type = "checkbox" class = "withitem" value = "ASCLO_Black_Socks" id = "check1"><label>ASCLO Black Socks</label>
KRW 5,000
<select style="width: 100%;">
	<option value = "black">-[필수] 1+1 색상 선택-</option>
	<option value = "black">블랙</option>
	<option value = "black">화이트</option>
	<option value = "black">네이비</option>
	<option value = "black">그린</option>
	<option value = "black">블루</option>
	<option value = "black">챠콜</option>
	<option value = "black">베이지</option>
</select>
<select style = "width: 100%;">
	<option value = "black">-[필수] 1+1 색상 선택-</option>
	<option value = "black">블랙</option>
	<option value = "black">화이트</option>
	<option value = "black">네이비</option>
	<option value = "black">그린</option>
	<option value = "black">블루</option>
	<option value = "black">챠콜</option>
	<option value = "black">베이지</option>
</select>
<input type = "number" value = "1" min = "1" max = "5" step = "1">
	    							</pre>
		    					</div>
			    			</td>
			    			<td>
								<div id = "withitem3">
	    							<pre><img src = "../ascloimage/jang1.jpg" width = "250px" height="250px">
<input type = "checkbox" class = "withitem" value = "ASCLO_Black_Socks" id = "check1"><label>ASCLO Black Socks</label>
KRW 5,000
<input type = "number" value = "1" min = "1" max = "5" step = "1">
	    							</pre>
		    					</div>
			    			</td>
			 				<td>
								<div id = "withitem4">
	    							<pre><img src = "../ascloimage/jang1.jpg" width = "250px" height="250px">
<input type = "checkbox" class = "withitem" value = "ASCLO_Black_Socks" id = "check1"><label>ASCLO Black Socks</label>
KRW 5,000
<input type = "number" value = "1" min = "1" max = "5" step = "1">
	    							</pre>
		    					</div>
			    			</td>
			    			<td>
								<div id = "withitem5">
	    							<pre><img src = "../ascloimage/image1.jpg" width = "250px" height="250px">
<input type = "checkbox" class = "withitem" value = "ASCLO_Black_Socks" id = "check1"><label>ASCLO Black Socks</label>
KRW 5,000
<input type = "number" value = "1" min = "1" max = "5" step = "1">
	    							</pre>
		    					</div>
			    			</td>
			    			<td>
								<div id = "withitem6">
	    							<pre><img src = "../ascloimage/image1.jpg" width = "250px" height="250px">
<input type = "checkbox" class = "withitem" value = "ASCLO_Black_Socks" id = "check1"><label>ASCLO Black Socks</label>
KRW 5,000
<input type = "number" value = "1" min = "1" max = "5" step = "1">
	    							</pre>
		    					</div>
			    			</td>
			    			<td>
								<div id = "withitem7">
	    							<pre><img src = "../ascloimage/image1.jpg" width = "250px" height="250px">
<input type = "checkbox" class = "withitem" value = "ASCLO_Black_Socks" id = "check1"><label>ASCLO Black Socks</label>
KRW 5,000
<input type = "number" value = "1" min = "1" max = "5" step = "1">
	    							</pre>
		    					</div>
			    			</td>
			    			<td>
								<div id = "withitem8">
	    							<pre><img src = "../ascloimage/image1.jpg" width = "250px" height="250px">
<input type = "checkbox" class = "withitem" value = "ASCLO_Black_Socks" id = "check1"><label>ASCLO Black Socks</label>
KRW 5,000
<input type = "number" value = "1" min = "1" max = "5" step = "1">
    								</pre>
    							</div>
    						</td>
    						<td>
								<div id = "withitem9">
    								<pre><img src = "../ascloimage/image1.jpg" width = "250px" height="250px">
<input type = "checkbox" class = "withitem" value = "ASCLO_Black_Socks" id = "check1"><label>ASCLO Black Socks</label>
KRW 5,000
<input type = "number" value = "1" min = "1" max = "5" step = "1">
			    					</pre>
			    				</div>
    						</td>
    					</tr>
					</table>
				</div>
    		</li>
    		<li><input type = "button" value = "" id = "rightbtn"></li>
    	</ul>
    </div>
     
    <div id = "withbtn">
    	<table>
    		<tr>
    			<td><input type = "button" value = "함께 구매하기" id = "withbuybtn"></td>
    			<td><input type = "button" value = "함께 장바구니담기" id = "withcartbtn"></td>
    		</tr>
    	</table>
    </div> -->
    
    <!-- <div class = "list">
		<table>
			<tr>
			<td><a href = "#summary">DETAIL</a></td>
			<td><a href = "#withitemtext">WITH ITEM</a></td>
			<td style = "border-bottom:3px solid #cccccc;"><b>REVIEW</b></td>
			<td><a href = "#question">Q&A</a></td>
			</tr>
		</table>
	</div>
     
    <div id = "review" class = "oneandone">
    	<p>REVIEW</p>
    	<table width = "100%">
    		<tr>
    			<th>NO</th>
    			<th>SUBJECT</th>
    			<th>NAME</th>
    			<th>DATE</th>
    			<th>HIT</th>
    		</tr>
    		
    		<tr class = "firsttr">
    			<td>1</td>
    			<td>나의 히어로 아카데미아</td>
    			<td>미도리야</td>
    			<td>2011-01-12</td>
    			<td>1020</td>
    		</tr>
    		
    		<tr>
    			<td>2</td>
    			<td>명탐정 피카츄</td>
    			<td>피카츄</td>
    			<td>2000-12-31</td>
    			<td>1900</td>
    		</tr>
    		
    		<tr>
    			<td>1</td>
    			<td>가성비 좋아요</td>
    			<td>감나무</td>
    			<td>2011-12-13</td>
    			<td>1</td>
    		</tr>
    		
    		<tr>
    			<td>2</td>
    			<td>사람이 너무 좋아서</td>
    			<td>김선영</td>
    			<td>1234-12-31</td>
    			<td>50</td>
    		</tr>
    		
    		<tr>
    			<td>3</td>
    			<td>아주그냥 죽여줘요</td>
    			<td>데이터</td>
    			<td>1234-05-17</td>
    			<td>159</td>
    		</tr>
    	</table>
    </div>
    
    <div id = "rev" class = "notice">
    	<input type = "button" value = "상품후기쓰기" id = "prdR" class = "prd">
    	<input type = "button" value = "모두 보기" id = "allcheck1" class = "all">
    </div>
    
    <div class = "listnum">
    	<pre><<   <   1  2  3  >   >></pre>
    </div>
     
    <div class = "list">
		<table>
			<tr>
				<td><a href = "#summary">DETAIL</a></td>
				<td><a href = "#withitemtext">WITH ITEM</a></td>
				<td><a href = "#review">REVIEW</a></td>
				<td style = "border-bottom:3px solid #cccccc;"><b>Q&A</b></td>
			</tr>
		</table>
	</div>
     
    <div id = "question" class = "oneandone">
    	<p>Q&A</p>
    	<table width = "100%">
    		<tr>
    			<th>NO</th>
    			<th>SUBJECT</th>
    			<th>NAME</th>
    			<th>DATE</th>
    			<th>HIT</th>
    		</tr>
    		
    		<tr class = "firsttr">
    			<td>1</td>
    			<td>나의 히어로 아카데미아</td>
    			<td>미도리야</td>
    			<td>2011-01-12</td>
    			<td>1020</td>
    		</tr>
    		
    		<tr>
    			<td>2</td>
    			<td>명탐정 피카츄</td>
    			<td>피카츄</td>
    			<td>2000-12-31</td>
    			<td>1900</td>
    		</tr>
    		
    		<tr>
    			<td>1</td>
    			<td>가성비 좋아요</td>
    			<td>감나무</td>
    			<td>2011-12-13</td>
    			<td>1</td>
    		</tr>
    		
    		<tr>
    			<td>2</td>
    			<td>사람이 너무 좋아서</td>
    			<td>김선영</td>
    			<td>1234-12-31</td>
    			<td>50</td>
    		</tr>
    		
    		<tr>
    			<td>3</td>
    			<td>아주그냥 죽여줘요</td>
    			<td>데이터</td>
    			<td>1234-05-17</td>
    			<td>159</td>
    		</tr>
    	</table>
    </div>
    
    <div id = "Ques" class = "notice">
    	<input type = "button" value = "상품문의하기" id = "prdQ" class = "prd">
    	<input type = "button" value = "모두 보기" id = "allcheck2" class = "all">
    </div>
    
    <div class = "listnum">
    	<pre><<   <   1  2  3  >   >></pre>
    </div> -->
	
<%@ include file = "bottommenu.jsp" %>
</body>
</html>