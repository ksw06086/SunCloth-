<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file = "setting.jsp" %>
<link type = "text/css" rel = "stylesheet" href = "${project}cssall/h_memberForm.css"/>
<html>
<body>
<%@ include file = "topmenu.jsp" %>

<section>
<form action = "h_memberPro" method = "post" name = "h_memberform">
	<input type = "hidden" name = "pageNum" value = "${pageNum}">
	<input type = "hidden" name = "id" value = "${vo.id}">
	<table id = "middle">
		<col style = "width:15%;">
		<col>
		<tr>
			<%@ include file = "h_memberLeft.jsp" %>
			<td id = "tabright">
				<div id = "righttop">
					<p><input type = "button" value = "회원리스트" id = "memberlist" onclick = "window.location = 'h_member?pageNum=${pageNum}'"></p>
					<p><b>회원관리</b></p>
					<p><input type = "submit" value = "저장" id = "save">
					<input type = "button" value = "탈퇴시키기" id = "memberout" onclick = "window.location = 'h_deletePro?id=${vo.id}&pageNum=${pageNum}'"></p>
				</div>
				
				<div id = "product">
					<table id = "basetop">
						<tr>
							<td>
							<b>·기본정보</b>
							</td>
						</tr>
					</table>
					
					<table id = "base">
						<col style = "width:20%">
						<col>
						<tr>
							<td>가입일</td>
							<td>
							${vo.reg_date}
							</td>
						</tr>
					</table>
					
					<table id = "persontop">
						<tr>
							<td>
							<b>·개인정보</b>
							</td>
						</tr>
					</table>
					
					<table id = "person">
						<col style = "width:20%">
						<col>
						<tr>
							<td>회원구분</td>
							<td>
							개인회원
							</td>
						</tr>
						
						<tr>
							<td>이름/아이디</td>
							<td>
							${vo.name}/${vo.id}
							</td>
						</tr>
				     	
				     	<tr>
							<td>생년월일</td>
				     		<td>
				     		${vo.birth}
				     		</td>
				     	</tr>
				     	
				     	<tr>
							<td>핸드폰번호</td>
				     		<td>
				     		${vo.hp}
				     		</td>
				     	</tr>
				     	
				     	<tr>
				    		<td>주소</td>
				    		<td style = "line-height: 35px;">
				    		<input type = "text" id = "useraddress" style = "width:70px" name = "userAddr" value = "${vo.address}" readonly><input type = "button" value = "우편번호" id = "address"><br>
				    		기본주소&emsp;<input type = "text" id = "baseaddress" style = "width:400px" name = "baseAddr" value = "${vo.address1}" readonly><br>
				    		나머지주소<input type = "text" id = "modaddress" style = "width:400px" name = "modAddr" value = "${vo.address2}" readonly>
				    		</td>
				    	</tr>
					</table>
					
					<table id = "btmtop">
						<tr>
							<td>
							<b>·활동정보</b>
							</td>
						</tr>
					</table>
					<table id = "bottom">
						<col style = "width:15%">
						<col>
						<col style = "width:15%">
						<col>
				     	
				     	<tr>
				     		<td>적립금</td>
				     		<td>${vo.plus}원
				     		</td>
							<td></td>
							<td></td>
				     	</tr>
				     	<tr>
							<td>구매횟수</td>
							<td>
							${orderCnt}회
							</td>
				     		<td>방문횟수</td>
				     		<td>${vo.visitcnt}회
				     		</td>
				     	</tr>
				     	<tr>
				     		<td>상품문의</td>
				     		<td>${qnaCnt}개
				     		</td>
				     		<td>상품후기</td>
				     		<td>${reviewCnt}개
				     		</td>
				     	</tr>
					</table>
					
					<table id = "processtop">
						<tr>
							<td>
							<b>·처리해야 할 주문</b>
							</td>
						</tr>
					</table>
					<table id = "process">	
						<col style = "width:20%;">
						<col>				
						<tr>
							<td>배송준비</td>
				     		<td>${dscnt}건
				     		</td>
				     	</tr>
				     	
				     	<tr>
							<td>배송중</td>
				     		<td>${dicnt}건
				     		</td>
				     	</tr>
				     	
				     	<tr>
							<td>배송완료</td>
				     		<td>${decnt}건
				     		</td>
				     	</tr>
				     	
				     	<tr>
							<td>환불접수</td>
				     		<td>${ricnt + recnt}건
				     		</td>
				     	</tr>
					</table>
					
					<table id = "subtop">
						<tr>
							<td>
							<b>·관리자 메모</b>
							</td>
						</tr>
					</table>
					
					<table id = "sub">
				    	<col style = "width: 15%;">
				    	<col>
			    		<tr>
			    			<td colspan = "2">
			    			<textarea class = "Box" rows="30" cols="80" name = "hostmemo"
			    			style="resize: vertical; width:100%; border:none;">${vo.hostmemo}</textarea></td>
			    		</tr>
			    	</table>
		    	</div>
			</td>
		</tr>
	</table>
</form>
</section>
</body>
</html>