<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file = "setting.jsp" %>
<link type = "text/css" rel = "stylesheet" href = "${project}cssall/orderform.css"/>
<html>
<c:if test = "${gvo.homephone != null}">
	<c:set var = "homeP" value = "${fn:split(gvo.homephone, '-')}"/>
</c:if>
<c:set var = "emails" value = "${fn:split(gvo.email, '@')}"/>
<c:set var = "hps" value = "${fn:split(gvo.getHp(), '-')}"/>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script>
function start() {
	$("#deliname").val("${gvo.name}");
	$("#useraddress").val("${gvo.address}");
	$("#baseaddress").val("${gvo.address1}");
	$("#modaddress").val("${gvo.address2}");
	if(${vo.homephone != null}){
		$("#tel").val("${homeP[0]}");
		$("#telsecond").val("${homeP[1]}");
		$("#telthrid").val("${homeP[2]}");
	}
	$("#telphone").val("${hps[0]}");
	$("#telphonesecond").val("${hps[1]}");
	$("#telphonethrid").val("${hps[2]}");
	$("#idname").val("${emails[0]}");
	$("#urlcode").val("${emails[1]}");
	$("#emailchk").val("${emails[1]}");
}

$(function(){
	$("input[name = 'delinameN']").change(function(){
		if($("#mydeli").is(":checked")){
			$("#deliname").val("${gvo.name}");
			$("#useraddress").val("${gvo.address}");
			$("#baseaddress").val("${gvo.address1}");
			$("#modaddress").val("${gvo.address2}");
			if(${vo.homephone != null}){
				$("#tel").val("${homeP[0]}");
				$("#telsecond").val("${homeP[1]}");
				$("#telthrid").val("${homeP[2]}");
			}
			$("#telphone").val("${hps[0]}");
			$("#telphonesecond").val("${hps[1]}");
			$("#telphonethrid").val("${hps[2]}");
			$("#idname").val("${emails[0]}");
			$("#urlcode").val("${emails[1]}");
			$("#emailchk").val("${emails[1]}");
		} else if($("#newdeli").is(":checked")){
			$("#deliname").val("");
			$("#useraddress").val("");
			$("#baseaddress").val("");
			$("#modaddress").val("");
			$("#tel").val("");
			$("#telsecond").val("");
			$("#telthrid").val("");
			$("#telphone").val("");
			$("#telphonesecond").val("");
			$("#telphonethrid").val("");
			$("#idname").val("");
			$("#urlcode").val("");
			$("#emailchk").val("");
		}
	})
});
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
<script type="text/javascript">
function go(val){
	var ppl = 0;
	var memplus = 0;
	var totalprice = 0;
	if(val == "" || val == null){
		ppl = 0;
		memplus = ${gvo.plus};
		totalprice = ${(cvo.saleprice*count) + cvo.deliprice};
	} else {
		ppl = parseInt(val);
		memplus = ${gvo.plus} - parseInt(val);
		totalprice = ${(cvo.saleprice*count) + cvo.deliprice} - parseInt(val);
	}
	$(".ppl").html(ppl);
	$(".memplus").html(memplus);
	$(".total").html(totalprice);
	document.orderform.price.value = totalprice;
}
</script>
<body onload = "orderStart('${emails[1]}','${hps[0]}','${homeP[0]}');">
<c:if test="${scnt == 0}">
	<script type="text/javascript">
		errorAlert("로그인 해주세요!!!");
	</script>
</c:if>
<c:if test="${scnt != 0 and ucnt < 0}">
	<script type="text/javascript">
		errorAlert("재고보다 선택하신 수량이 많습니다.!!!");
	</script>
</c:if>
<c:if test="${scnt != 0 and ucnt >= 0}">
<%@ include file = "topmanu.jsp" %>

    <div id = "road">
		<p>home > sheet</p>
	</div>
	
	<div id = "topname">
		<p><b>ORDER FORM</b></p>
	</div>
     
     <table id = "service" style = "font-size: .7em; width:100%; border-bottom:1px solid #ccc; border-top:1px solid #ccc;">
     	<col style = "width: 10%;">
     	<col>
     	<tr>
     		<th rowspan = "2">혜택정보</th>
     		<td style = "border-bottom: 1px solid #ccc;"><b>${gvo.name}</b>님 저희 매장을 이용해주셔서 감사합니다.</td>
     	</tr>
     	<tr >
     		<td>가용적립금 : ${gvo.plus}원</td>
     	</tr>
     	
     </table>
<form name = "orderform" method = "post" onsubmit = "">
	<input type = "hidden" name = "swh" value = "${swh}">
	<input type = "hidden" name = "swit" value = "${swit}">
	<input type = "hidden" name = "gname" value = "${gvo.id}">
	<input type = "hidden" name = "color" value = "${svo.colorcode}">
	<input type = "hidden" name = "size" value = "${svo.sizecode}">
	<input type = "hidden" name = "price" value = "${(cvo.saleprice*count) + cvo.deliprice}">
	<input type = "hidden" name = "count" value = "${count}">
	<input type = "hidden" name = "num" value = "${num}">
	<table style = "margin: 20px 0px 15px">
		<tr>
			<td><b>국내배송상품 주문내역</b></td>
			<td>
			</td>
		</tr>
	</table>
    <table id = "orderlist" style = "border-top: 1px solid #ccc;">
    	<col style = "width:1%;">
    	<col style = "width:9%;">
    	<col>
    	<col style = "width:7%;">
    	<col style = "width:5%;">
    	<col style = "width:7%;">
    	<col style = "width:7%;">
    	<col style = "width:7%;">
    	<col style = "width:7%;">
    	<tr id = "title">
    		<td><input type = "checkbox" name = "prdcheck" id = "allcheck"  value = "전체선택"></td>
    		<td>이미지</td>
    		<td>상품정보</td>
    		<td>판매가</td>
    		<td>수량</td>
    		<td>적립금</td>
    		<td>배송구분</td>
    		<td>배송비</td>
    		<td>합계</td>
    	</tr>
    	<tr class = "orderprd">
    		<td><input type = "checkbox" name = "prdcheck" id = "check1"  value = "prd1"></td>
    		<td><img src = "${project}fileready/${cvo.mainfile}" width = "70px" height = "100px"></td>
    		<td style = "text-align:left;"><b>${cvo.name}</b><br>
    		<span style = "color: #282828;">[옵션: ${svo.colorname}/${svo.sizename}]</span>
    		</td>
    		<td><b>KRW ${cvo.saleprice*count}</b></td>
    		<td>${count}
    		</td>
    		<td>
    		<img src = "./ascloimage/n.png" width = "10px" height = "10px" style = "vertical-align: middle;">
    		${cvo.plus}원
    		<input type = "hidden" name = "prdplus" value = "${cvo.plus}">
    		</td>
    		<td>기본배송</td>
    		<td>${cvo.deliprice}</td>
    		<td><b>KRW ${(cvo.saleprice*count) + cvo.deliprice}</b></td>
    	</tr>
    	<tr id = "subtotal">
    		<td colspan = "9">
    		<p style = "float: left; margin-left: 10px;">[기본배송]</p>
    		<p style = "float: right; margin-right: 10px;">상품구매금액 <b>KRW ${cvo.saleprice}</b> + 배송비 ${cvo.deliprice} = 합계:   <b>KRW ${(cvo.saleprice*count) + cvo.deliprice}</b></p>
    		</td>
    	</tr>
    	<tr class = "orderbtm">
    		<td colspan = "9" style = "text-align: left;">
    		상품의 옵션 및 수량 변경은 상품상세 또는 장바구니에서 가능합니다.
    		</td>
    	</tr>
    	<tr class = "orderbtm">
    		<td colspan = "5" style = "text-align: left;">
    		<b>선택상품을</b>  <input type = button value = "X 삭제하기" id = "checkdel" onclick = "orderlistDel();">
    		</td>
    		<td colspan = "4" style = "text-align: right;">
    		<input type = "button" value = "이전페이지" class = "before" onclick = "window.history.back();">
    		</td>
    	</tr>
    </table>
	
	<table style = "margin: 50px 0px 15px; width:100%;">
		<tr>
			<td><b>배송 정보</b></td>
    		<td style = "text-align: right;"><img src = "./ascloimage/snorlax.png" width = "12px" height = "12px"> 필수입력사항</td>
    	</tr>
    </table>
    <table id = "delilist">
    	<tr>
    		<td>배송지 선택</td>
    		<td>
    		<input type = "radio" id = "mydeli" name = "delinameN" value = "profil" checked>
    		회원 정보와 동일
    		<input type = "radio" id = "newdeli" name = "delinameN" value = "new">
    		새로운배송지
    		<!--&emsp;&emsp;최근 배송지:
    		 <input type = "radio" id = "base" value = "base" name = "delinameN" checked>
    		<img src = "./ascloimage/star.png" width = "10px" height = "10px">
    		ㅁㄴㅇㄹ
    		<input type = "radio" id = "base" value = "base2" name = "delinameN">
    		korea 
    		<input type = "button" id = "address" value = "주소록 보기">-->
    		</td>
    	</tr>
    	<tr>
    		<td>받으시는 분<img src = "./ascloimage/snorlax.png" width = "12px" height = "12px"></td>
    		<td>
    		<input type = "text" id = "deliname" name = "delinameN">
    		</td>
    	</tr>
    	<tr>
    		<td>주소<img src = "./ascloimage/snorlax.png" width = "12px" height = "12px"></td>
    		<td style = "line-height: 35px;">
    		<input type = "text" id = "useraddress" style = "width:70px" name = "userAddr">
    		<input type = "button" value = "우편번호" id = "address"  name = "addrbtn"  onclick = "addressSearch();"><br>
    		<input type = "text" id = "baseaddress" style = "width:400px" name = "baseAddr">기본주소<br>
    		<input type = "text" id = "modaddress" style = "width:400px" name = "modAddr">나머지주소
    		</td>
    	</tr>
    	<tr>
	    		<td>일반전화</td>
	    		<td>
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
	   				- <input type = "text" id = "telsecond" style = "width:70px;" name = "tel2">
	   				- <input type = "text" id = "telthrid" style = "width:70px;" name = "tel3">
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
	   				- <input type = "text" id = "telphonesecond" style = "width:70px;" name = "telphone2">
	   				- <input type = "text" id = "telphonethrid" style = "width:70px;" name = "telphone3">
	    		</td>
	    	</tr>
	    	
	    	<!-- <tr>
	    		<td>안심번호</td>
	    		<td><input type = "checkbox" id = "pinNum" value = "agree" name = "pinservice"> 안심번호 서비스 사용(무료)<br>
	    		- 안심번호 서비스는 개인정보 보호를 위하여 휴대폰번호 등 실제 연락처 대신에 1화성 임시번호를 제공하는 서비스입니다.</td>
	    	</tr> -->
	    	
	    	<tr>
	    		<td>이메일<img src = "./ascloimage/snorlax.png" width = "12px" height = "12px"></td>
	    		<td>
	   				<input type = "text" id = "idname" name = "idName">
	   				@<input type = "text" id = "urlcode"  name = "urlcode">
	    			<select name = "email3" onchange = "OselectEmailChk();" id = "emailchk">
	    				<option value = "">직접입력</option>
	   					<option value = "naver.com">naver.com</option>
	   					<option value = "daum.com">daum.com</option>
	   					<option value = "nate.com">nate.com</option>
	   					<option value = "gmail.com">gmail.com</option>
	   					<option value = "korea.com">korea.com</option>
	   					<option value = "hanmail.com">hanmail.com</option>
	   				</select>
   					주문처리과정을 이메일로 보내드립니다.
	    		</td>
	    	</tr>
    </table>
    
    <p><b>추가정보</b></p>
   	<table id = "message">
   		<tr>
   			<td>고객메세지</td>
   			<td><input type = "text" id = "baseaddress" style = "width:400px" name = "usermessege"></td>
   		</tr>
   	</table>
     
    <table id = "total">
    	<col style = "width:33.3%;">
    	<col style = "width:33.4%;">
    	<col style = "width:33.3%;">
    	<tr id = "Ttitle">
    		<td>총 주문 금액<input type = "button" id = "detail" value = "내역보기"></td>
    		<td>총 할인 + 부가결제 금액</td>
    		<td>총 결제예정 금액</td>
    	</tr>
    	<tr id = "Tsmry">
    		<td><b><font size = "3px">KRW</font> ${(cvo.saleprice*count) + cvo.deliprice}</b></td>
    		<td><b><font size = "3px">- KRW</font> <label class = "ppl">0</label></b></td>
    		<td><b><font size = "3px">= KRW</font> <label class = "total">${(cvo.saleprice*count) + cvo.deliprice}</label></b></td>
    	</tr>
    </table>
    
    <table id = "salepay">
    	<col style = "width:15%;">
    	<col>
    	<tr id = "saleplus">
    		<td>총 부가결제금액</td>
    		<td>KRW <label class = "ppl">0</label></td>
    	</tr>
    	<tr id = "plusmoney">
    		<td>적립금</td>
    		<td>
    		<input type = "text" id = "mileagepay" name = "pluspay" onkeyup="go(this.value);">
    		원 (총 사용가능 적립금 : <span style = "color:red;">${gvo.plus}</span>원)<br>
    		<br>
    		- 적립금은 최소 100 이상일 때 결제가 가능합니다.<br>
    		- 최대 사용금액은 제한이 없습니다.<br>
    		- 1회 구매시 적립금 최대 사용금액은 2,000입니다.<br>
    		- 적립금으로만 결제할 경우. 결제금액이 0으로 보여지는 것은 정상이며 [결제하기] 버튼을 누르면 주문이 완료됩니다.
    		</td>
    	</tr>
    </table>
    
    <table id = "paytop">
    	<tr>
    		<td><b>결제수단</b>
    		</td>
    	</tr>
    </table>
    
    <table id = "payway">
    	<col>
    	<col style = "width: 22%;">
    	<tr id = "paywaytop">
    		<td>
			<input type = "radio" name = "howpay" id = "notacc" value = "notacc" checked>
			 무통장 입금&emsp;
			<input type = "radio" name = "howpay" id = "cardbtn" value = "card">
			 카드 결제
			</td>
			<td rowspan = "2" id = "lastlist">
			<table>
				<col style = "width:40%;">
				<col>
				<tr id = "lasttop">
					<td colspan = "2">
					<b>무통장 입금</b> 최종결제 금액
					</td>
				</tr>
				<tr id = "lastpaychk">
					<td>
					KRW
					</td>
					<td>
					<label class = "total">${(cvo.saleprice*count) + cvo.deliprice}</label>
					</td>
				</tr>
				<tr id = "chkagree">
					<td colspan = "2">
					<input type = "checkbox" id = "agree" name = "agreeN" value = "ok">
					&nbsp;결제정보를 확인하였으며, 구매진행에 동의합니다.
					</td>
				</tr>
				<tr>
					<td colspan = "2" style = "padding:9px 6px;">
					<input type = "submit" id = "pay" name = "payN" value = "결제하기" onclick = "javascript: orderform.action = 'orderPro'">
					</td>
				</tr>
				<tr class = "lastbtm" id = "btm1">
					<td>
					<b>총 적립예정금액</b>
					</td>
					<td>
					${gvo.plus + cvo.plus}원
					</td>
				</tr>
				<tr class = "lastbtm" id = "btm2">
					<td>
					상품별 적립금
					</td>
					<td>
					${cvo.plus}원
					</td>
				</tr>
				<tr class = "lastbtm">
					<td>
					회원 적립금
					</td>
					<td>
					<label class = "memplus"></label>원
					</td>
				</tr>
			</table>
			</td>
    	</tr>
    	<tr id = "paywaybtm">
    		<td>
    			<table id = "mu">
    			<col style = "width:15%;">
    			<col>
			    	<tr>
			    		<td>입금자명</td>
			    		<td><input type = "text" name = "depositname" id = "payname" style = "padding:5px 0px;"></td>
			    	</tr>
			    	<tr>
			    		<td>입금은행</td>
			    		<td style = "line-height:27px;"><select id = "paybank" name = "bank" style = "padding:5px 0px; font-size:.9em;">
			    			<option value = "">:::선택해 주세요:::</option>
			    			<option value = "국민은행">상품 등록 담당 관리자 은행 계좌</option>
			    		</select>
			    		</td>
			    	</tr>
			    	<tr>
			    		<td></td>
			    		<td><img src = "./ascloimage/exclamation-mark.png" width = "10px" height = "10px">
			    		최소 결제 가능 금액은 결제금액에서 배송비를 제외한 금액입니다.
			    		</td>
			    	</tr>
    			</table>
    			
    			<table id = "card">
    			<col style = "width:20%;">
    			<col>
			    	<tr>
			    		<td></td>
			    		<td><img src = "./ascloimage/exclamation-mark.png" width = "10px" height = "10px">
			    		최소 결제 가능 금액은 결제금액에서 배송비를 제외한 금액입니다.<br>
			    		<img src = "./ascloimage/exclamation-mark.png" width = "10px" height = "10px">
			    		소액 결제의 경우 PG사 정책에 따라 결제금액 제한이 있을 수 있습니다.
			    		</td>
			    	</tr>
    			</table>
    		</td>
    	</tr>
    </table>
    
    <fieldset style = "border: 1px solid; margin: 80px 0px;">
    	<p style = "font-size:.9em;">무이자 할부 이용안내</p>
    	<hr>
    	<p style = "font-size:.8em;">&nbsp;&nbsp;&nbsp;<img src = "./ascloimage/one.png" width = "10px" height = "10px"> [쇼핑계속하기] 버튼을 누르시면 쇼핑을 계속하실 수 있습니다.<br>
    	&nbsp;&nbsp;&nbsp;<img src = "./ascloimage/two.png" width = "10px" height = "10px"> 장바구니와 관심상품을 이용하여 원하시는 상품만 주문하거나 관심상품으로 등록하실 수 있습니다.<br>
    	&nbsp;&nbsp;&nbsp;<img src = "./ascloimage/three.png" width = "10px" height = "10px"> 파일첨부 옵션은 동일상품을 장바구니에 추가할 경우 마지막에 업로드 한 파일로 교체됩니다.</p>
    </fieldset>
    
     
    <fieldset style = "border: 1px solid; margin: 80px 0px;">
    	<p style = "font-size:.9em;">이용안내</p>
    	<hr>
    	<p style = "font-size:.9em;">장바구니 이용안내</p>
    	<p style = "font-size:.8em;">&nbsp;&nbsp;&nbsp;<img src = "./ascloimage/one.png" width = "10px" height = "10px"> [쇼핑계속하기] 버튼을 누르시면 쇼핑을 계속하실 수 있습니다.<br>
    	&nbsp;&nbsp;&nbsp;<img src = "./ascloimage/two.png" width = "10px" height = "10px"> 장바구니와 관심상품을 이용하여 원하시는 상품만 주문하거나 관심상품으로 등록하실 수 있습니다.<br>
    	&nbsp;&nbsp;&nbsp;<img src = "./ascloimage/three.png" width = "10px" height = "10px"> 파일첨부 옵션은 동일상품을 장바구니에 추가할 경우 마지막에 업로드 한 파일로 교체됩니다.</p>
    	
    	<p style = "font-size:.9em;">무이자할부 이용안내</p>
    	<p style = "font-size:.8em;">&nbsp;&nbsp;&nbsp;<img src = "./ascloimage/one.png" width = "10px" height = "10px"> 상품별 무이자할부 혜택을 받으시려면 무이자할부 상품만 선택하여 [주문하기] 버튼을 눌러 주문/결제 하시면 됩니다.<br>
    	&nbsp;&nbsp;&nbsp;<img src = "./ascloimage/two.png" width = "10px" height = "10px"> [전체 상품 주문]버튼을 누르시면 장바구니의 구분없이 선택된 모든 상품에 대한 주문/결제가 이루어집니다.<br>
    	&nbsp;&nbsp;&nbsp;<img src = "./ascloimage/three.png" width = "10px" height = "10px"> 단, 전체 상품을 주문/결제하실 경우, 상품별 무이자할부 혜택을 받으실 수 없습니다.</p>
    </fieldset>
     
 </form>
	
<%@ include file = "bottommenu.jsp" %>
</c:if>
</body>
</html>