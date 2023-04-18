<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file = "setting.jsp" %>
<link type = "text/css" rel = "stylesheet" href = "${project}cssall/modify_profile.css"/>
<html>
<c:if test = "${vo.homephone != null}">
	<c:set var = "homeP" value = "${fn:split(vo.homephone, '-')}"/>
</c:if>
<c:set var = "emails" value = "${fn:split(vo.email, '@')}"/>
<c:set var = "hps" value = "${fn:split(vo.getHp(), '-')}"/>
<body onload = "modifyStart('${emails[1]}','${hps[0]}','${homeP[0]}');">
<%@ include file = "topmanu.jsp" %>

    <div id = "road">
		<p>home > membership</p>
	</div>
	
	<div id = "topname">
		<p><b>나의 프로필</b></p>
	</div>
	
    <div id = "toptext">
		<p><span style = "color:gray;">${vo.name}</span>님 저희 쇼핑몰을 이용해주셔서 감사합니다.</p>
	</div>
    
    <form name = "modifyView" action = "modifyPro" method = "post" id = "joinus"
    onsubmit = "return modifyCheck();">
	    <p style = "float:left;">기본정보</p>
	    <p style = "float:right;"><img src = "./ascloimage/snorlax.png" width = "12px" height = "12px"> 필수입력사항</p>
	    <table>
	    	<tr>
	    		<td>아이디</td>
	    		<td>${vo.id}</td> <!-- 입력받지 못하게 함 -->
	    	</tr>
	    	
	    	<tr>
	    		<td>비밀번호<img src = "./ascloimage/snorlax.png" width = "12px" height = "12px"></td>
	    		<td><input type = "password" id = "userpwd" name = "pwd">(영문 대소문자/숫자/특수문자 중 2가지 이상 조합, 8자~16자)</td>
	    	</tr>
	    	
	    	<tr>
	    		<td>비밀번호 확인<img src = "./ascloimage/snorlax.png" width = "12px" height = "12px"></td>
	    		<td><input type = "password" id = "userRpwd" name = "repwd"></td>
	    	</tr>
	    	
	    	<tr>
	    		<td>이름<img src = "./ascloimage/snorlax.png" width = "12px" height = "12px"></td>
	    		<td><input type = "text" id = "username" name = "name" value = "${vo.name}"></td>
	    	</tr>
	    	
	    	<tr>
	    		<td>주소<img src = "./ascloimage/snorlax.png" width = "12px" height = "12px"></td>
	    		<td style = "line-height: 35px;">
	    		<input type = "text" id = "useraddress" style = "width:70px" name = "address" value = "${vo.address}"><input type = "button" value = "우편번호" id = "addressbtn"><br>
	    		<input type = "text" id = "baseaddress" style = "width:400px" name = "address1" value = "${vo.address1}">기본주소<br>
	    		<input type = "text" id = "modaddress" style = "width:400px" name = "address2" value = "${vo.address2}">나머지주소
	    		</td>
	    	</tr>
	    	
	    	<tr>
	    		<td>일반전화</td>
	    		<td>
				<c:if test = "${vo.homephone != null}">
	    			<c:set var = "homeP" value = "${fn:split(vo.homephone, '-')}"/>
	    			<select style = "width:100px;" name = "tel1" id = "tel">
	   					<option value = "02">02</option>
	   					<option value = "031">031</option>
	   					<option value = "032">032</option>
	   					<option value = "033">033</option>
	   					<option value = "041">041</option>
	   					<option value = "042">042</option>
	   					<option value = "043">043</option>
	   					<option value = "044">044</option>
	   				</select>
	   				- <input type = "text" id = "telsecond" style = "width:70px;" name = "tel2" value = "${homeP[1]}">
	   				- <input type = "text" id = "telthrid" style = "width:70px;" name = "tel3" value = "${homeP[1]}">
				</c:if>
				<c:if test="${vo.homephone == null}">
					<select style = "width:100px;" name = "tel1">
	   					<option value = "02">02</option>
	   					<option value = "031">031</option>
	   					<option value = "032">032</option>
	   					<option value = "033">033</option>
	   					<option value = "041">041</option>
	   					<option value = "042">042</option>
	   					<option value = "043">043</option>
	   					<option value = "044">044</option>
	   				</select>
	   				- <input type = "text" id = "telsecond" style = "width:70px;" name = "tel2">
	   				- <input type = "text" id = "telthrid" style = "width:70px;" name = "tel3">
				</c:if>
				</td>
	    	</tr>
	    	
	    	<tr>
	    		<td>휴대폰번호<img src = "./ascloimage/snorlax.png" width = "12px" height = "12px"></td>
	    		<td>
	    			<select style = "width:100px;" name = "telphone1" id = "telphone">
	   					<option value = "010">010</option>
	   					<option value = "011">011</option>
	   					<option value = "016">016</option>
	   					<option value = "017">017</option>
	   					<option value = "018">018</option>
	   					<option value = "019">019</option>
	   				</select>
	   				- <input type = "text" id = "telphonesecond" style = "width:70px;" name = "telphone2" value = "${hps[1]}">
	   				- <input type = "text" id = "telphonethrid" style = "width:70px;" name = "telphone3" value = "${hps[2]}">
	    		</td>
	    	</tr>
	    	
	    	<tr>
	    		<td>이메일<img src = "./ascloimage/snorlax.png" width = "12px" height = "12px"></td>
	    		<td>
	   				<input type = "text" id = "idname" name = "idName" value = "${emails[0]}">
	   				@<input type = "text" id = "urlcode"  name = "urlcode" value = "${emails[1]}">
	    			<select name = "email3" onchange = "MselectEmailChk();" id = "emailchk">
	    				<option value = "">직접입력</option>
	   					<option value = "naver.com">naver.com</option>
	   					<option value = "daum.com">daum.com</option>
	   					<option value = "nate.com">nate.com</option>
	   					<option value = "gmail.com">gmail.com</option>
	   					<option value = "korea.com">korea.com</option>
	   					<option value = "hanmail.com">hanmail.com</option>
	   				</select>
	   				<input type = "button" id = "formal" value = "인증">
	    		</td>
	    	</tr>
	    	<tr>
	    		<td>가입일</td>
	    		<td>${vo.reg_date}</td>
	    	</tr>
	    </table>
	    
	    
    	<input type = "hidden" name = "bank" value = "${vo.bank}">
    	<input type = "hidden" name = "acc" value = "${vo.acc}">
    	<input type = "hidden" name = "acchost" value = "${vo.acchost}">
	    <p>추가정보</p>
	    <table>
	    	<tr>
	    		<td>생년월일<img src = "./ascloimage/snorlax.png" width = "12px" height = "12px"></td>
	    		<td>
	    		<input type = "date" id = "datein" name = "birth" required value = "${vo.birth}">&nbsp;&nbsp;
	    		<input type = "radio" name = "birthtype" id = "yang" style = "vertical-align:middle;" value = "양력" <c:if test="${vo.birthtype eq '양력'}">checked="checked"</c:if>>
	    		<label for = "yang" style = "vertical-align:middle;">양력</label>
	    		<input type = "radio" name = "birthtype" id = "umm" style = "vertical-align:middle;" value = "음력" <c:if test="${vo.birthtype eq '음력'}">checked="checked"</c:if>>
	    		<label for = "umm" style = "vertical-align:middle;">음력</label>
	    		</td>
	    	</tr>
	    	<tr>
	    		<td rowspan = "3">환불계좌 정보<img src = "./ascloimage/snorlax.png" width = "12px" height = "12px"></td>
	    		<td id = "refundlist">[${vo.bank}] ${vo.acc} / 예금주: ${vo.acchost} <input type = "button" id = "refundAccountChange" value = "환불계좌변경" name = "refundAccountChange" onclick = "modifyacc();"></td>
	    	</tr>
	    </table>
    	<div style = "text-align:center; margin: 30px 0px 100px 0px; position:relative;" id = "changebtn">
	    	<input type = "submit" id = "change" value = "회원정보수정">
	    	<input type = "button" id = "cancel" value = "취소" onclick = "window.history.back();">
	    	<input type = "button" value = "회원탈퇴" id = "memberOut" onclick = "deletePro();" style = "position: absolute; right:0; top:0.5px;">
	    </div>
    </form>
	
<%@ include file = "bottommenu.jsp" %>
</body>
</html>