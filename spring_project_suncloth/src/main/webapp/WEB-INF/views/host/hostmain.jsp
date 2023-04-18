<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file = "setting.jsp" %>
<link type = "text/css" rel = "stylesheet" href = "${project}cssall/h_hostmain.css"/>
<html>
<body>
<%@ include file = "topmenu.jsp" %>
<section>
	<div id = "title">
		<table id = "titletop">
			<tr>
				<td>
				<b>오늘의 쇼핑몰</b>&emsp;<b><span style = "color:#282828;">${year[0]}년 ${month[0]}월 ${day[0]}일</span></b>
				</td>
				<td>
				(이번달 총 주문건수: <b>${monthorederCnttotal}</b>건/이번달 총 매출금액:<b>${monthorederrealpricetotal}</b>원)
				</td>
			<tr>
		</table>
		<table id = "titlebtm">
			<col style = "width:5%">
			<col style = "width:19%">
			<col style = "width:19%">
			<col style = "width:19%">
			<col style = "width:19%">
			<col style = "width:19%">
			<col>
			<tr>
				<td>
				</td>
				<td>
				오늘주문
				</td>
				<td>
				오늘매출
				</td>
				<td>
				상품문의
				</td>
				<td>
				신규회원
				</td>
				<td>
				오늘 방문자
				</td>
			</tr>
			<tr>
				<td>
				<b>주문완료</b>
				</td>
				<td>
				<span style = "color:green;"><b>${dayorederCnttotal}</b></span> 건
				</td>
				<td>
				</td>
				<td>
				</td>
				<td>
				</td>
			</tr>
			<tr>
				<td>
				<b>취소완료</b>
				</td>
				<td>
				<span style = "color:green;"><b>${daycancelCnttotal}</b></span> 건
				</td>
				<td>
				<span style = "color:skyblue;"><b>${todayorederrealprice}</b></span> 건
				</td>
				<td>
				<span style = "color:blue;"><b>${todayQnACnt}</b></span> 건
				</td>
				<td>
				<span style = "color:violet;"><b>${todaynewmemberCnt}</b></span> 명
				</td>
				<td>
				<span style = "color:red;"><b>${todayclicktotal}</b></span> 명
				</td>
			</tr>
		</table>
	</div>
	
	<div id = "sub">
		<table id = "subtop">
			<tr>
				<td>
				<b>이번주 운영 현황</b>
				</td>
				<td>
				<b>${year[1]}년 ${month[6]}월 ${day[6]}일 ~ ${year[0]}년 ${month[0]}월 ${day[0]}일</b>
				</td>
			</tr>
		</table>
		
		<table id = "subbtm">
			<col style = "width:15%;">
			<col style = "width:10%;">
			<col style = "width:10%;">
			<col style = "width:10%;">
			<col style = "width:10%;">
			<col style = "width:10%;">
			<col style = "width:10%;">
			<col style = "width:10%;">
			<col style = "width:15%;">
			<tr>
				<th>설정</th>
				<th>${month[0]}/${day[0]}</th>
				<th>${month[1]}/${day[1]}</th>
				<th>${month[2]}/${day[2]}</th>
				<th>${month[3]}/${day[3]}</th>
				<th>${month[4]}/${day[4]}</th>
				<th>${month[5]}/${day[5]}</th>
				<th>${month[6]}/${day[6]}</th>
				<th>이번주 합계</th>
			</tr>
			<tr>
				<td>매출액(단위:원)</td>
				<td>${orederpricetotal[0]}</td>
				<td>${orederpricetotal[1]}</td>
				<td>${orederpricetotal[2]}</td>
				<td>${orederpricetotal[3]}</td>
				<td>${orederpricetotal[4]}</td>
				<td>${orederpricetotal[5]}</td>
				<td>${orederpricetotal[6]}</td>
				<td><b>${orederpricetotal[7]}</b></td>
			</tr>
			<tr>
				<td>결제완료(단위:건)</td>
				<td>${payendCnt[0]}</td>
				<td>${payendCnt[1]}</td>
				<td>${payendCnt[2]}</td>
				<td>${payendCnt[3]}</td>
				<td>${payendCnt[4]}</td>
				<td>${payendCnt[5]}</td>
				<td>${payendCnt[6]}</td>
				<td><b>${payendCnt[7]}</b></td>
			</tr>
			<tr>
				<td>배송준비</td>
				<td>${delistartCnt[0]}</td>
				<td>${delistartCnt[1]}</td>
				<td>${delistartCnt[2]}</td>
				<td>${delistartCnt[3]}</td>
				<td>${delistartCnt[4]}</td>
				<td>${delistartCnt[5]}</td>
				<td>${delistartCnt[6]}</td>
				<td><b>${delistartCnt[7]}</b></td>
			</tr>
			<tr>
				<td>배송중</td>
				<td>${delingCnt[0]}</td>
				<td>${delingCnt[1]}</td>
				<td>${delingCnt[2]}</td>
				<td>${delingCnt[3]}</td>
				<td>${delingCnt[4]}</td>
				<td>${delingCnt[5]}</td>
				<td>${delingCnt[6]}</td>
				<td><b>${delingCnt[7]}</b></td>
			</tr>
			<tr>
				<td>배송완료</td>
				<td>${deliendCnt[0]}</td>
				<td>${deliendCnt[1]}</td>
				<td>${deliendCnt[2]}</td>
				<td>${deliendCnt[3]}</td>
				<td>${deliendCnt[4]}</td>
				<td>${deliendCnt[5]}</td>
				<td>${deliendCnt[6]}</td>
				<td><b>${deliendCnt[7]}</b></td>
			</tr>
			<tr>
				<td>취소,환불</td>
				<td>${cancelCnt[0]}</td>
				<td>${cancelCnt[1]}</td>
				<td>${cancelCnt[2]}</td>
				<td>${cancelCnt[3]}</td>
				<td>${cancelCnt[4]}</td>
				<td>${cancelCnt[5]}</td>
				<td>${cancelCnt[6]}</td>
				<td><b>${cancelCnt[7]}</b></td>
			</tr>
			<tr>
				<td>상품후기</td>
				<td>${reviewCnt[0]}</td>
				<td>${reviewCnt[1]}</td>
				<td>${reviewCnt[2]}</td>
				<td>${reviewCnt[3]}</td>
				<td>${reviewCnt[4]}</td>
				<td>${reviewCnt[5]}</td>
				<td>${reviewCnt[6]}</td>
				<td><b>${reviewCnt[7]}</b></td>
			</tr>
		</table>
	</div>
</section>
</body>
</html>