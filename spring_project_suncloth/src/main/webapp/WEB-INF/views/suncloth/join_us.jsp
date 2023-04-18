<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file = "setting.jsp" %>
<link type = "text/css" rel = "stylesheet" href = "${project}cssall/join_us.css"/>
<html>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script>
    function addressSearch(){ 
    	new daum.Postcode({
        	oncomplete: function(data) {
        		 // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var fullAddr = ''; // 최종 주소 변수
                var extraAddr = ''; // 조합형 주소 변수

                // 사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    fullAddr = data.roadAddress;

                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    fullAddr = data.jibunAddress;
                }

                // 사용자가 선택한 주소가 도로명 타입일때 조합한다.
                if(data.userSelectedType === 'R'){
                    //법정동명이 있을 경우 추가한다.
                    if(data.bname !== ''){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있을 경우 추가한다.
                    if(data.buildingName !== ''){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 조합형주소의 유무에 따라 양쪽에 괄호를 추가하여 최종 주소를 만든다.
                    fullAddr += (extraAddr !== '' ? ' ('+ extraAddr +')' : '');
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('useraddress').value = data.zonecode; //5자리 새우편번호 사용
                document.getElementById('baseaddress').value = fullAddr;

                // 커서를 상세주소 필드로 이동한다.
                document.getElementById('modaddress').focus();
        	}
		}).open();
	}
</script>
<body>
<%@ include file = "topmanu.jsp" %>

    <div id = "road">
		<p>home > join us</p>
	</div>
	
	<div id = "topname">
		<p><b>회원가입</b></p>
	</div>
    
    
    <form name = "inputForm" action = "inputPro" method = "post" id = "joinus"
    onsubmit = "return inputCheck();">    	
		<!-- hiddenId : 중복확인 버튼 클릭 여부 체크(0:클릭 안함, 1:클릭함) -->
		<input type = "hidden" name = "hiddenId" value = "0">
		<input type = "hidden" name = "memberNum" value = "0">
		
	    <p style = "float:left;">기본정보</p>
	    <p style = "float:right;"><img src = "./ascloimage/snorlax.png" width = "12px" height = "12px"> 필수입력사항</p>
	    <table>
	    	<tr>
	    		<td>아이디<img src = "./ascloimage/snorlax.png" width = "12px" height = "12px"></td>
	    		<td><input type = "text" id = "userid" name = "id">  <input type = "button" id = "overlabchk" name = "overlabchk" value = "중복확인" onclick = "confirmId();">(영문소문자/숫자, 4~16자)</td>
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
	    		<td><input type = "text" id = "username" name = "name"></td>
	    	</tr>
	    	<tr>
	    		<td>주소<img src = "./ascloimage/snorlax.png" width = "12px" height = "12px"></td>
	    		<td style = "line-height: 35px;">
	    		<input type = "text" id = "useraddress" style = "width:70px" name = "address"> <input type = "button" value = "우편번호" id = "addressbtn" name = "addrbtn" onclick = "addressSearch();"><br>
	    		<input type = "text" id = "baseaddress" style = "width:400px" name = "address1">기본주소<br>
	    		<input type = "text" id = "modaddress" style = "width:400px" name = "address2">나머지주소
	    		</td>
	    	</tr>
	    	<tr>
	    		<td>일반전화</td>
	    		<td>
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
	    		</td>
	    	</tr>
	    	<tr>
	    		<td>휴대폰번호<img src = "./ascloimage/snorlax.png" width = "12px" height = "12px"></td>
	    		<td>
	    			<select style = "width:100px;" name = "telphone1">
	   					<option value = "010">010</option>
	   					<option value = "011">011</option>
	   					<option value = "016">016</option>
	   					<option value = "017">017</option>
	   					<option value = "018">018</option>
	   					<option value = "019">019</option>
	   				</select>
	   				- <input type = "text" id = "telphonesecond" style = "width:70px;" name = "telphone2">
	   				- <input type = "text" id = "telphonethrid" style = "width:70px;" name = "telphone3">
	    		</td>
	    	</tr>
	    	<tr>
	    		<td>이메일<img src = "./ascloimage/snorlax.png" width = "12px" height = "12px"></td>
	    		<td>
	   				<input type = "text" id = "idname" name = "idName">
	   				@<input type = "text" id = "urlcode"  name = "urlcode">
	    			<select name = "email3" onchange = "selectEmailChk();">
	    				<option value = "0">직접입력</option>
	   					<option value = "naver.com">naver.com</option>
	   					<option value = "daum.com">daum.com</option>
	   					<option value = "nate.com">nate.com</option>
	   					<option value = "gmail.com">gmail.com</option>
	   					<option value = "korea.com">korea.com</option>
	   					<option value = "hanmail.com">hanmail.com</option>
	   				</select>
	   				<input type = "button" id = "formal" value = "인증" onclick = "formalChk();">
	   				<input type = "hidden" name = "hiddenemail" id = "hiddenemail1" value = "0">
	    		</td>
	    	</tr>
	    	<tr>
	    		<td>
	    		인증번호 입력<img src = "./ascloimage/snorlax.png" width = "12px" height = "12px">
	    		</td>
	    		<td>
	    		<input type = "text" id = "formalNum" name = "formalNum" maxlength = "6">
	    		<input type = "button" id = "Numcheck" value = "확인">
	    		<input type = "hidden" name = "numchk" id = "numchk1" value = "">
	    		</td>
	    	</tr>
	    </table>
	    
	    
	    <p>추가정보</p>
	    <table>
	    	<tr>
	    		<td>생년월일<img src = "./ascloimage/snorlax.png" width = "12px" height = "12px"></td>
	    		<td>
	    		<input type = "date" id = "datein" name = "birth" required>&nbsp;&nbsp;
	    		<input type = "radio" name = "birthtype" value = "양력" id = "yang" style = "vertical-align:middle;" checked><label for = "yang" style = "vertical-align:middle;">양력</label>
	    		<input type = "radio" name = "birthtype" value = "음력" id = "umm" style = "vertical-align:middle;"><label for = "umm" style = "vertical-align:middle;">음력</label>
	    		</td>
	    	</tr>
	    	<tr>
	    		<td rowspan = "3">환불계좌 정보<img src = "./ascloimage/snorlax.png" width = "12px" height = "12px"></td>
	    		<td>*예금주&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type = "text" id = "userbackhost" name = "acchost"></td>
	    	</tr>
	    	<tr>
	    		<td>*은행명&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<select id = "bankname" name = "bank">
	    			<option value = "">-은행선택-</option>
	    			<option value = "기업은행">기업은행</option>
	    			<option value = "국민은행">국민은행</option>
	    			<option value = "농협은행">농협은행</option>
	    			<option value = "우리은행">우리은행</option>
	    			<option value = "신한은행">신한은행</option>
	    			<option value = "삼성증권">삼성증권</option>
	    			<option value = "새마을금고">새마을금고</option>
	    			<option value = "카카오뱅크">카카오뱅크</option>
	    		</select></td>
	    	</tr>
	    	<tr>
	    		<td>*계좌번호&nbsp;&nbsp;&nbsp;&nbsp;<input type = "text" id = "acount" name = "acc">('-'와 숫자만 입력해주세요.)</td>
	    	</tr>
	    </table>
	    
	    <p>전체동의</p>
	    <p><input name = "allcheck" type = "checkbox" onchange="all_check();">&nbsp;이용약관 및 개인정보 수집 및 이용에 모두 동의합니다.
	    
	    <p style = "font-size: .8em; margin-top:30px;"><b>[필수] 이용약관 동의</b></p>
	    
	    <p><textarea name = "use_agree_chk" class = "Box" rows="5" cols="40" style="resize: none; width:100%;" onchange="allcheck_remove();">당신은 피카츄를 사랑하십니까?</textarea></p>
	    <p style = "font-size: .8em;">이용약관에 동의하십니까? <input type = "checkbox" id = "usechk"> 동의함</p>
	    
	    <p style = "font-size: .8em; margin-top:30px;"><b>[필수] 개인정보 수집 및 이용 동의</b></p>
	    
	    <p><textarea name = "data_agree_chk" class = "Box" rows="5" cols="40" style="resize: none; width:100%;" onchange="allcheck_remove();">당신은 잠만보를 사랑하십니까?</textarea></p>
	    <p style = "font-size: .8em;">개인정보 수집 및 이용에 동의하십니까? <input type = "checkbox" id = "guestdatachk"> 동의함</p>
	    
	    <div style = "text-align:center;" id = "joinbtn">
	    	<input type = "submit" value = "회원가입" id = "join">
	    	<input type = "button" value = "관리자회원가입" id = "host" onclick = "window.location = 'o_inputForm'">
	    </div>
    
    </form>
	
<%@ include file = "bottommenu.jsp" %>
</body>
</html>