<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file = "setting.jsp" %>
<link type = "text/css" rel = "stylesheet" href = "${project}cssall/h_refund.css"/>
<html>
<body>
<%@ include file = "topmenu.jsp" %>

<section>
	<table id = "middle">
		<col style = "width:15%;">
		<col>
		<tr>
			<%@ include file = "h_orderLeft.jsp" %>
			<td id = "tabright">
				<div id = "righttop">
					<p><b>환불관리</b></p>
				</div>
				<table id = "searchifs">
					<col style = "width:15%;">
					<col>
					<tr>
						<td>환불신청일</td>
			     		<td><span><select id = "orderstate" style = "padding: 3px; font-size: 1em; vertical-align:middle;">
				     			<option value = "allorder">등록일</option>
				     			<option value = "paybefore">수정일</option>
				     		</select></span>
			     			<span><input type = "date" id = "firstday" value = "" style = "vertical-align:middle;">&nbsp;&nbsp;-&nbsp;&nbsp;
			     			<input type = "date" id = "lastday" value = "" style = "vertical-align:middle;"></span>
			     			<span><table id = "daytypeoption" style = "display: inline;">
			     				<tr>
			     					<td><input type = "radio" name = "daytype" id = "today" value = "today" checked>
			     					<label for = "today">오늘</label></td>
			     					<td><input type = "radio" name = "daytype" id = "week" value = "week">
			     					<label for = "week">1주일</label></td>
			     					<td><input type = "radio" name = "daytype" id = "month1" value = "month1">
			     					<label for = "month1">1개월</label></td>
			     					<td><input type = "radio" name = "daytype" id = "month3" value = "month3">
			     					<label for = "month3">3개월</label></td>
			     					<td><input type = "radio" name = "daytype" id = "month6" value = "month6">
			     					<label for = "month6">6개월</label></td>
			     				</tr>
			     			</table></span>
			     		</td>
			     	</tr>
			     	
			     	<tr>
						<td>상태</td>
						<td>
						<input type = "checkbox" name = "state" id = "refundready" value = "new">
    					<label for = "refundready">환불신청</label>&emsp;
    					<input type = "checkbox" name = "state" id = "refundready" value = "new">
    					<label for = "refundready">환불완료</label>
						</td>
					</tr>
					
					<tr>
						<td>결제수단</td>
						<td>
						<input type = "checkbox" name = "pay" id = "cardpay" value = "new">
    					<label for = "cardpay">신용카드</label>&emsp;
    					<input type = "checkbox" name = "pay" id = "accpay" value = "new">
    					<label for = "accpay">관리자 통장</label>
						</td>
					</tr>
    				
    				<tr>
						<td>검색어</td>
						<td>
						<select id = "type" style = "padding:2px; vertical-align:middle;">
							<option value = "">환불번호</option>
							<option value = "">주문번호</option>
							<option value = "">주문자</option>
							<option value = "">입금자</option>
							<option value = "">아이디</option>
							<option value = "">상품명</option>
							<option value = "">상품번호</option>
						</select>
						<input type = "search" id = "srch" name = "srch" style = "vertical-align:middle;">
						</td>
					</tr>
				</table>
				
				<p id = "srhbtnp"><input type = "button" value = "검색" id = "srhbtn"></p>
				
				<div id = "result">
					<table id = "resulttop">
						<td>검색 
						<b><span style = "color:blue;">0</span></b>개
						/ 총 <b><span style = "color:#ccc;">0</span></b>개</td>
						<td>
						<select id = "count" style = "padding:3px;">
							<option value = "">10개씩 출력</option>
							<option value = "">30개씩 출력</option>
							<option value = "">50개씩 출력</option>
						</select>
						</td>
					</table>
					
					<table id = "orderlist">
				    	<col style = "width:1%;">
				    	<col style = "width:8%;">
				    	<col style = "width:10%;">
				    	<col style = "width:8%;">
				    	<col>
				    	<col style = "width:10%;">
				    	<col style = "width:10%;">
				    	<col style = "width:10%;">
				    	<col style = "width:10%;">
				    	<col style = "width:10%;">
				    	<tr id = "title">
				    		<td>선택</td>
				    		<td>번호</td>
				    		<td>접수일시</td>
				    		<td>주문번호</td>
				    		<td>반품번호</td>
				    		<td>주문자</td>
				    		<td>결제수단</td>
				    		<td>주문수량</td>
				    		<td>수거완료일시</td>
				    		<td>상태</td>
				    	</tr>
				    	<tr class = "statemanu" id = "statemanu1">
				    		<td><input type = "checkbox" name = "prdcheck" id = "allcheck"  value = "전체선택"></td>
				    		<td>
							<input type = "button" value = "환불완료" name = "refundfinish" id = "refund">
							</td>
							<td colspan = "6"><b>환불신청</b>
							</td>
							<td colspan = "2"></td>
				    	</tr>
				    	<tr class = "statemanu" id = "statemanu2">
				    		<td><input type = "checkbox" name = "prdcheck" id = "allcheck"  value = "전체선택"></td>
				    		<td>
							<input type = "button" value = "삭제하기" name = "delete" id = "delete">
							</td>
							<td colspan = "6"><b>환불완료</b>
							</td>
							<td colspan = "2"></td>
				    	</tr>
				    	<tr class = "orderprd">
				    		<td><input type = "checkbox" name = "prdcheck" id = "check1"  value = "prd1"></td>
				    		<td>13</td>
				    		<td>2019/02/03 14:15:23</td>
				    		<td>20191102-000007
				    		</td>
				    		<td>12345789131</td>
				    		<td>김선우<br>(ksw1234/<br>
				    		일반회원)</td>
				    		<td>관리자 통장</td>
				    		<td>10ea</td>
				    		<td>
				    		[미정]
				    		</td>
				    		<td>환불신청</td>
				    	</tr>
				    </table>
				    
				    <table id = "buttons" style = "width:98%; padding: 10px 0px 0px; margin:0 auto;">
				    	<tr>
				    		<td style = "text-align:center; padding: 15px;"> < &emsp;&emsp; 1 &emsp; &emsp;> </td>
				    	</tr>
				    </table>
				</div>
			</td>
		</tr>
	</table>
</section>
</body>
</html>