<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<header id = "header">
	<div id = "langage">
	</div>
	<form method = "post" name = "search">
	<div id = "search">
		<input type = "search" id = "srch" name = "srch" id = "search_box" class = "searchall">
		<button id = "search_btn" class = "searchall" onclick = "javascript: search.action = 'searchlist'"></button>
	</div>
	</form>
	
	<div id = "mainname">
		<h2><a href = "main">suncloth</a></h2>
	</div>
	
	<div id = "bottomleft" class = "bottom">
		<table>
			<tr>
			<c:if test="${sessionScope.memId == null}"> <!-- 로그인 안함 -->
				<td><a href = "login?member=0">로그인</a></td>
				<td><a href = "inputForm">회원가입</a></td>
				<td><a href = "login?member=0">장바구니</a></td>
				<td><a href = "login?member=0">주문관리</a></td>
				<td><a href = "login?member=0">마이페이지</a></td>
			</c:if>
			<c:if test="${sessionScope.memId != null}"> <!-- 로그인 성공 -->
				<td><a href = "logout">로그아웃</a></td>
				<td><a href = "modifyView">회원수정</a></td>
				<td><a href = "cart">장바구니</a></td>
				<td><a href = "order">주문관리</a></td>
				<td><a href = "mypage">마이페이지</a></td>
			</c:if>
			</tr>
		</table>
	</div>
	<div id = "bottomright" class = "bottom">
		<table>
			<tr>
				<td><a href = "notice?choose=1">공지</a></td>
				<td><a href = "FAQ?choose=2">FAQ</a></td>
				<td><a href = "QnA?choose=3">Q&A</a></td>
				<td><a href = "review?choose=4">후기</a></td>
				<td><a href = "bookmark">bookmark</a></td>
				<td><a href = "https://www.doortodoor.co.kr/parcel/pa_004.jsp">delivery</a></td>
				<td><a href = "hostmain">host</a></td>
				<td><a href = "https://www.facebook.com/profile.php?id=100008360707255.html"><img src="${project}ascloimage/facebook-logo.png" width = "10px" height = "10px"></a></td>
				<td><a href = "https://www.instagram.com/seonu1109/?hl=ko"><img src="${project}ascloimage/instagram.png" width = "10px" height = "10px"></a></td>
			</tr>
		</table>
	</div>
</header>

<nav>
	<div class="lnb">
        <ul>
            <li><a href="menulist?name=only asclo" alt="">only asclo</a></li>
            <li><a href="menulist?name=best" alt="">best</a></li>
            <li><a href="menulist?name=outer" alt="">outer</a></li>
            <li><a href="menulist?name=suit" alt="">suit</a></li>
            <li><a href="menulist?name=top" alt="">top</a></li>
            <li><a href="menulist?name=shirt" alt="">shirt</a></li>
            <li><a href="menulist?name=knit" alt="">knit</a></li>
            <li><a href="menulist?name=bottom" alt="">bottom</a></li>
            <li><a href="menulist?name=shoes" alt="">shoes</a></li>
            <li><a href="menulist?name=acc" alt="">acc</a></li>
        </ul>
     </div>
    </nav>
</body>
</html>