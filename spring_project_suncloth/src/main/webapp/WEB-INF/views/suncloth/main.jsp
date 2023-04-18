<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file = "setting.jsp" %>
<link type = "text/css" rel = "stylesheet" href = "${project}cssall/main.css"/>
<html>
<body>
<%@ include file = "topmanu.jsp" %>

<div class = "imgslide">
	<figure class = "imgblock">
	<c:if test="${srhCnt > 0}">
		<c:forEach var = "list" items = "${list}" varStatus="status" begin="0" end="5">
			<a href = "productclick?num=${list.num}&name=${list.name}"><img src = "${project}fileready/${list.mainfile}" width = "100%" height = "600px"></a>
		</c:forEach>
	</c:if>
	</figure>
</div>

<section>
     <div id = "threemenu">
		<ul style = "padding:0px;">
			<c:forEach var = "list" items = "${list}" varStatus="status" begin="0" end="1">
				<li style = "margin-right: 27px"><a href = "productclick?num=${list.num}&name=${list.name}"><img src = "${project}fileready/${list.mainfile}" width = "350px" height = "300px"></a></li>
			</c:forEach>
			<c:forEach var = "list" items = "${list}" varStatus="status" begin="2" end="2">
				<li style = "margin-right: 27px"><a href = "productclick?num=${list.num}&name=${list.name}"><img src = "${project}fileready/${list.mainfile}" width = "350px" height = "300px"></a></li>
			</c:forEach>
		</ul>
	</div>
	
	<div class = "weekly">
		<p class = "head1"><b>WEEKLY PRODUCT</b></p>
		
		<input id="tab1" type="radio" name="tabs" checked ><label for = "tab1">Outer</label>
		<input id="tab2" type="radio" name="tabs" ><label for = "tab2">Top</label>
		<input id="tab3" type="radio" name="tabs" ><label for = "tab3">Shirt</label>
		<input id="tab4" type="radio" name="tabs" ><label for = "tab4">Knit</label>
		<input id="tab5" type="radio" name="tabs" ><label for = "tab5">Bottom</label>
		<input id="tab6" type="radio" name="tabs" ><label for = "tab6">Suit</label>
		<input id="tab7" type="radio" name="tabs" ><label for = "tab7">ACC</label>
		<section id = "outermenu">
			<div class = oneblock>
				<ul>
				<c:forEach var = "list" items = "${outerlist}" varStatus="status" begin="0" end="0">
					<li><a href = "productclick?num=${list.num}&name=${list.name}"><img src = "${project}fileready/${list.mainfile}" width = "400px" height = "660px"></a></li>
				</c:forEach>
				</ul>
			</div>
			<div class = "oneblock">
				<div class = "one">
					<ul>
						<c:forEach var = "list" items = "${outerlist}" varStatus="status" begin="1" end="3">
							<li><a href = "productclick?num=${list.num}&name=${list.name}"><img src = "${project}fileready/${list.mainfile}" width = "250px" height = "320px"></a></li>
						</c:forEach>
					</ul>
				</div>
				<div class = "two">
					<ul>
						<c:forEach var = "list" items = "${outerlist}" varStatus="status" begin="4" end="6">
							<li><a href = "productclick?num=${list.num}&name=${list.name}"><img src = "${project}fileready/${list.mainfile}" width = "250px" height = "320px"></a></li>
						</c:forEach>
					</ul>
				</div>
			</div>
		</section>
		<section id = "topmenu">
			<div class = oneblock>
				<ul>
				<c:forEach var = "list" items = "${toplist}" varStatus="status" begin="0" end="0">
					<li><a href = "productclick?num=${list.num}&name=${list.name}"><img src = "${project}fileready/${list.mainfile}" width = "400px" height = "660px"></a></li>
				</c:forEach>
				</ul>
			</div>
			<div class = "oneblock">
				<div class = "one">
					<ul>
						<c:forEach var = "list" items = "${toplist}" varStatus="status" begin="1" end="3">
							<li><a href = "productclick?num=${list.num}&name=${list.name}"><img src = "${project}fileready/${list.mainfile}" width = "250px" height = "320px"></a></li>
						</c:forEach>
					</ul>
				</div>
				<div class = "two">
					<ul>
						<c:forEach var = "list" items = "${toplist}" varStatus="status" begin="4" end="6">
							<li><a href = "productclick?num=${list.num}&name=${list.name}"><img src = "${project}fileready/${list.mainfile}" width = "250px" height = "320px"></a></li>
						</c:forEach>
					</ul>
				</div>
			</div>
		</section>
		<section id = "Shirtmenu">
			<div class = oneblock>
				<ul>
				<c:forEach var = "list" items = "${shirtlist}" varStatus="status" begin="0" end="0">
					<li><a href = "productclick?num=${list.num}&name=${list.name}"><img src = "${project}fileready/${list.mainfile}" width = "400px" height = "660px"></a></li>
				</c:forEach>
				</ul>
			</div>
			<div class = "oneblock">
				<div class = "one">
					<ul>
						<c:forEach var = "list" items = "${shirtlist}" varStatus="status" begin="1" end="3">
							<li><a href = "productclick?num=${list.num}&name=${list.name}"><img src = "${project}fileready/${list.mainfile}" width = "250px" height = "320px"></a></li>
						</c:forEach>
					</ul>
				</div>
				<div class = "two">
					<ul>
						<c:forEach var = "list" items = "${shirtlist}" varStatus="status" begin="4" end="6">
							<li><a href = "productclick?num=${list.num}&name=${list.name}"><img src = "${project}fileready/${list.mainfile}" width = "250px" height = "320px"></a></li>
						</c:forEach>
					</ul>
				</div>
			</div>
		</section>
		<section id = "Knitmenu">
			<div class = oneblock>
				<ul>
				<c:forEach var = "list" items = "${knitlist}" varStatus="status" begin="0" end="0">
					<li><a href = "productclick?num=${list.num}&name=${list.name}"><img src = "${project}fileready/${list.mainfile}" width = "400px" height = "660px"></a></li>
				</c:forEach>
				</ul>
			</div>
			<div class = "oneblock">
				<div class = "one">
					<ul>
						<c:forEach var = "list" items = "${knitlist}" varStatus="status" begin="1" end="3">
							<li><a href = "productclick?num=${list.num}&name=${list.name}"><img src = "${project}fileready/${list.mainfile}" width = "250px" height = "320px"></a></li>
						</c:forEach>
					</ul>
				</div>
				<div class = "two">
					<ul>
						<c:forEach var = "list" items = "${knitlist}" varStatus="status" begin="4" end="6">
							<li><a href = "productclick?num=${list.num}&name=${list.name}"><img src = "${project}fileready/${list.mainfile}" width = "250px" height = "320px"></a></li>
						</c:forEach>
					</ul>
				</div>
			</div>
		</section>
		<section id = "Bottommenu">
			<div class = oneblock>
				<ul>
				<c:forEach var = "list" items = "${bottomlist}" varStatus="status" begin="0" end="0">
					<li><a href = "productclick?num=${list.num}&name=${list.name}"><img src = "${project}fileready/${list.mainfile}" width = "400px" height = "660px"></a></li>
				</c:forEach>
				</ul>
			</div>
			<div class = "oneblock">
				<div class = "one">
					<ul>
						<c:forEach var = "list" items = "${bottomlist}" varStatus="status" begin="1" end="3">
							<li><a href = "productclick?num=${list.num}&name=${list.name}"><img src = "${project}fileready/${list.mainfile}" width = "250px" height = "320px"></a></li>
						</c:forEach>
					</ul>
				</div>
				<div class = "two">
					<ul>
						<c:forEach var = "list" items = "${bottomlist}" varStatus="status" begin="4" end="6">
							<li><a href = "productclick?num=${list.num}&name=${list.name}"><img src = "${project}fileready/${list.mainfile}" width = "250px" height = "320px"></a></li>
						</c:forEach>
					</ul>
				</div>
			</div>
		</section>
		<section id = "Suitmenu">
			<div class = oneblock>
				<ul>
				<c:forEach var = "list" items = "${suitlist}" varStatus="status" begin="0" end="0">
					<li><a href = "productclick?num=${list.num}&name=${list.name}"><img src = "${project}fileready/${list.mainfile}" width = "400px" height = "660px"></a></li>
				</c:forEach>
				</ul>
			</div>
			<div class = "oneblock">
				<div class = "one">
					<ul>
						<c:forEach var = "list" items = "${suitlist}" varStatus="status" begin="1" end="3">
							<li><a href = "productclick?num=${list.num}&name=${list.name}"><img src = "${project}fileready/${list.mainfile}" width = "250px" height = "320px"></a></li>
						</c:forEach>
					</ul>
				</div>
				<div class = "two">
					<ul>
						<c:forEach var = "list" items = "${suitlist}" varStatus="status" begin="4" end="6">
							<li><a href = "productclick?num=${list.num}&name=${list.name}"><img src = "${project}fileready/${list.mainfile}" width = "250px" height = "320px"></a></li>
						</c:forEach>
					</ul>
				</div>
			</div>
		</section>
		<section id = "ACCmenu">
			<div class = oneblock>
				<ul>
				<c:forEach var = "list" items = "${acclist}" varStatus="status" begin="0" end="0">
					<li><a href = "productclick?num=${list.num}&name=${list.name}"><img src = "${project}fileready/${list.mainfile}" width = "400px" height = "660px"></a></li>
				</c:forEach>
				</ul>
			</div>
			<div class = "oneblock">
				<div class = "one">
					<ul>
						<c:forEach var = "list" items = "${acclist}" varStatus="status" begin="1" end="3">
							<li><a href = "productclick?num=${list.num}&name=${list.name}"><img src = "${project}fileready/${list.mainfile}" width = "250px" height = "320px"></a></li>
						</c:forEach>
					</ul>
				</div>
				<div class = "two">
					<ul>
						<c:forEach var = "list" items = "${acclist}" varStatus="status" begin="4" end="6">
							<li><a href = "productclick?num=${list.num}&name=${list.name}"><img src = "${project}fileready/${list.mainfile}" width = "250px" height = "320px"></a></li>
						</c:forEach>
					</ul>
				</div>
			</div>
		</section>
		</div>
	</section>
		
	<p> - NEW - </p>
	<div class = "divs">
		<c:if test="${srhCnt > 0}">
		<table>
		<c:forEach var = "list" items = "${list}" varStatus="status" begin="0" end="2">
		<c:if test="${status.index%3 == 0}">
			<tr>
				<td>
					<div>
						<li><a href = "productclick?num=${list.num}&name=${list.name}"><img src = "${project}fileready/${list.mainfile}" width = "320px" height = "350px"></a></li>
						<li><a href = "productclick?num=${list.num}&name=${list.name}">${list.name}</a></li>
						<li>KRW ${list.saleprice}</li>
					</div>
				</td>
				</c:if>
				<c:if test="${status.index%3 == 1}">
				<td>
					<div>
						<li><a href = "productclick?num=${list.num}&name=${list.name}"><img src = "${project}fileready/${list.mainfile}" width = "320px" height = "350px"></a></li>
						<li><a href = "productclick?num=${list.num}&name=${list.name}">${list.name}</a></li>
						<li>KRW ${list.saleprice}</li>
					</div>
				</td>
				</c:if>
				<c:if test="${status.index%3 == 2}">
				<td>
					<div>
						<li><a href = "productclick?num=${list.num}&name=${list.name}"><img src = "${project}fileready/${list.mainfile}" width = "320px" height = "350px"></a></li>
						<li><a href = "productclick?num=${list.num}&name=${list.name}">${list.name}</a></li>
						<li>KRW ${list.saleprice}</li>
					</div>
				</td>
			</tr>		
		</c:if>
		</c:forEach>
		</table>
	</c:if>
	</div>
	
	<p><b>MD RECOMMEND</b> PRODUCT</p>
	<div class = "divs">
	<c:if test="${srhCnt > 0}">
		<table>
		<c:forEach var = "list" items = "${list}" varStatus="status" begin="0" end="3">
		<c:if test="${status.index%4 == 0}">
			<tr>
				<td>
					<div>
						<li><a href = "productclick?num=${list.num}&name=${list.name}"><img src = "${project}fileready/${list.mainfile}" width = "320px" height = "350px"></a></li>
						<li><a href = "productclick?num=${list.num}&name=${list.name}">${list.name}</a></li>
						<li>KRW ${list.saleprice}</li>
					</div>
				</td>
				</c:if>
				<c:if test="${status.index%4 == 1}">
				<td>
					<div>
						<li><a href = "productclick?num=${list.num}&name=${list.name}"><img src = "${project}fileready/${list.mainfile}" width = "320px" height = "350px"></a></li>
						<li><a href = "productclick?num=${list.num}&name=${list.name}">${list.name}</a></li>
						<li>KRW ${list.saleprice}</li>
					</div>
				</td>
				</c:if>
				<c:if test="${status.index%4 == 2}">
				<td>
					<div>
						<li><a href = "productclick?num=${list.num}&name=${list.name}"><img src = "${project}fileready/${list.mainfile}" width = "320px" height = "350px"></a></li>
						<li><a href = "productclick?num=${list.num}&name=${list.name}">${list.name}</a></li>
						<li>KRW ${list.saleprice}</li>
					</div>
				</td>
				</c:if>
				<c:if test="${status.index%4 == 3}">
				<td>
					<div>
						<li><a href = "productclick?num=${list.num}&name=${list.name}"><img src = "${project}fileready/${list.mainfile}" width = "320px" height = "350px"></a></li>
						<li><a href = "productclick?num=${list.num}&name=${list.name}">${list.name}</a></li>
						<li>KRW ${list.saleprice}</li>
					</div>
				</td>
			</tr>		
		</c:if>
		</c:forEach>
		</table>
	</c:if>
	</div>
	
	<p> - BEST - </p>
	<div class = "divs">
	<c:if test="${srhCnt > 0}">
		<table>
		<c:forEach var = "list" items = "${list}" varStatus="status" begin="0" end="3">
		<c:if test="${status.index%4 == 0}">
			<tr>
				<td>
					<div>
						<li><a href = "productclick?num=${list.num}&name=${list.name}"><img src = "${project}fileready/${list.mainfile}" width = "320px" height = "350px"></a></li>
						<li><a href = "productclick?num=${list.num}&name=${list.name}">${list.name}</a></li>
						<li>KRW ${list.saleprice}</li>
					</div>
				</td>
				</c:if>
				<c:if test="${status.index%4 == 1}">
				<td>
					<div>
						<li><a href = "productclick?num=${list.num}&name=${list.name}"><img src = "${project}fileready/${list.mainfile}" width = "320px" height = "350px"></a></li>
						<li><a href = "productclick?num=${list.num}&name=${list.name}">${list.name}</a></li>
						<li>KRW ${list.saleprice}</li>
					</div>
				</td>
				</c:if>
				<c:if test="${status.index%4 == 2}">
				<td>
					<div>
						<li><a href = "productclick?num=${list.num}&name=${list.name}"><img src = "${project}fileready/${list.mainfile}" width = "320px" height = "350px"></a></li>
						<li><a href = "productclick?num=${list.num}&name=${list.name}">${list.name}</a></li>
						<li>KRW ${list.saleprice}</li>
					</div>
				</td>
				</c:if>
				<c:if test="${status.index%4 == 3}">
				<td>
					<div>
						<li><a href = "productclick?num=${list.num}&name=${list.name}"><img src = "${project}fileready/${list.mainfile}" width = "320px" height = "350px"></a></li>
						<li><a href = "productclick?num=${list.num}&name=${list.name}">${list.name}</a></li>
						<li>KRW ${list.saleprice}</li>
					</div>
				</td>
			</tr>		
		</c:if>
		</c:forEach>
		</table>
	</c:if>
	</div>
	
	<div id = "image12">
		<a href = "https://www.instagram.com/seonu1109/?hl=ko"><img src = "${project}ascloimage/image12.jpg"></a>
	</div>
	
	<p> WITH ITEM </p>
	<div class = "divs">
	<c:if test="${srhCnt > 0}">
		<table>
		<c:forEach var = "list" items = "${list}" varStatus="status" begin="0" end="3">
		<c:if test="${status.index%4 == 0}">
			<tr>
				<td>
					<div>
						<li><a href = "productclick?num=${list.num}&name=${list.name}"><img src = "${project}fileready/${list.mainfile}" width = "320px" height = "350px"></a></li>
						<li><a href = "productclick?num=${list.num}&name=${list.name}">${list.name}</a></li>
						<li>KRW ${list.saleprice}</li>
					</div>
				</td>
				</c:if>
				<c:if test="${status.index%4 == 1}">
				<td>
					<div>
						<li><a href = "productclick?num=${list.num}&name=${list.name}"><img src = "${project}fileready/${list.mainfile}" width = "320px" height = "350px"></a></li>
						<li><a href = "productclick?num=${list.num}&name=${list.name}">${list.name}</a></li>
						<li>KRW ${list.saleprice}</li>
					</div>
				</td>
				</c:if>
				<c:if test="${status.index%4 == 2}">
				<td>
					<div>
						<li><a href = "productclick?num=${list.num}&name=${list.name}"><img src = "${project}fileready/${list.mainfile}" width = "320px" height = "350px"></a></li>
						<li><a href = "productclick?num=${list.num}&name=${list.name}">${list.name}</a></li>
						<li>KRW ${list.saleprice}</li>
					</div>
				</td>
				</c:if>
				<c:if test="${status.index%4 == 3}">
				<td>
					<div>
						<li><a href = "productclick?num=${list.num}&name=${list.name}"><img src = "${project}fileready/${list.mainfile}" width = "320px" height = "350px"></a></li>
						<li><a href = "productclick?num=${list.num}&name=${list.name}">${list.name}</a></li>
						<li>KRW ${list.saleprice}</li>
					</div>
				</td>
			</tr>		
		</c:if>
		</c:forEach>
		</table>
	</c:if>
	</div>
	
	<p align = "center"> ACC </p>
	<div class = "divs">
	<c:if test="${srhCnt > 0}">
		<table>
		<c:forEach var = "list" items = "${list}" varStatus="status" begin="0" end="3">
		<c:if test="${status.index%4 == 0}">
			<tr>
				<td>
					<div>
						<li><a href = "productclick?num=${list.num}&name=${list.name}"><img src = "${project}fileready/${list.mainfile}" width = "320px" height = "350px"></a></li>
						<li><a href = "productclick?num=${list.num}&name=${list.name}">${list.name}</a></li>
						<li>KRW ${list.saleprice}</li>
					</div>
				</td>
				</c:if>
				<c:if test="${status.index%4 == 1}">
				<td>
					<div>
						<li><a href = "productclick?num=${list.num}&name=${list.name}"><img src = "${project}fileready/${list.mainfile}" width = "320px" height = "350px"></a></li>
						<li><a href = "productclick?num=${list.num}&name=${list.name}">${list.name}</a></li>
						<li>KRW ${list.saleprice}</li>
					</div>
				</td>
				</c:if>
				<c:if test="${status.index%4 == 2}">
				<td>
					<div>
						<li><a href = "productclick?num=${list.num}&name=${list.name}"><img src = "${project}fileready/${list.mainfile}" width = "320px" height = "350px"></a></li>
						<li><a href = "productclick?num=${list.num}&name=${list.name}">${list.name}</a></li>
						<li>KRW ${list.saleprice}</li>
					</div>
				</td>
				</c:if>
				<c:if test="${status.index%4 == 3}">
				<td>
					<div>
						<li><a href = "productclick?num=${list.num}&name=${list.name}"><img src = "${project}fileready/${list.mainfile}" width = "320px" height = "350px"></a></li>
						<li><a href = "productclick?num=${list.num}&name=${list.name}">${list.name}</a></li>
						<li>KRW ${list.saleprice}</li>
					</div>
				</td>
			</tr>		
		</c:if>
		</c:forEach>
		</table>
	</c:if>
	</div>
	
</section>
	
<%@ include file = "bottommenu.jsp" %>
</body>
</html>