/**
 * 
 */

var msg_id = "아이디를 입력해주세요!";
var msg_pwd = "비밀번호를 입력해주세요!";
var msg_repwd = "패스워드를 확인하세요!";
var msg_pwdChk = "패스워드가 일치하지 않습니다.!";
var msg_name = "이름을 입력해주세요!"	;
var msg_jumin1 = "주민번호 앞자리를 입력하세요!";
var msg_jumin2 = "주민번호 뒷자리를 입력하세요!";
var msg_email1 = "이메일을 입력해주세요!!";
var msg_emailChk = "이메일 형식에 일치하지 않습니다!";
var msg_confirmId = "중복확인을 해주세요.!!";

// ----------- I,U,D 에러 --------
var insertError = "회원가입에 실패했습니다.\n확인 후 다시 시도하세요!";
var updateError = "회원정보 수정에 실패하였습니다.\n확인 후 다시 시도하세요!";
var deleteError = "회원탈퇴에 실패했습니다.\n확인 후 다시 시도하세요!";
var passwdError = "입력하신 비밀번호가 일치하지 않습니다.\n확인 후 다시 시도하세요!";
var idError = "입력하신 아이디가 존재하지 않습니다.\n확인 후 다시 시도하세요!";

// 에러메시지
function errorAlert(errorMsg){
	alert(errorMsg);
	// 이전 페이지로 이동
	window.history.back();
}

// validation check document.폼이름.input태그이름.value // 값이 있는지 없는지
function inputCheck() {
	// 아이디 입력 확인
	if(!document.inputForm.id.value){
		alert("아이디를 입력하세요!!");
		document.inputForm.id.focus();
		return false; // 나를 호출한 곳으로 false를 리턴하면서 동작을 중지
	}
	
	// 패스워드 입력 확인
	if(!document.inputForm.pwd.value) {
		alert("패스워드를 입력하세요!!");
		document.inputForm.pwd.focus();
		return false;
	}
	
	// 패스워드 재입력 확인
	if(!document.inputForm.repwd.value){
		alert("패스워드 확인을 입력하세요!!");
		document.inputForm.repwd.focus();
		return false;
	} else if(document.inputForm.repwd.value != document.inputForm.pwd.value) {
		alert("패스워드갸 일치하지 않습니다. 다시 입력하세요!!");
		document.inputForm.repwd.value = null;
		document.inputForm.repwd.focus();
		return false;
	}
	
	// 이메일 입력 확인
	if(!document.inputForm.name.value){
		alert("이름을 입력하세요!!");
		document.inputForm.name.focus();
		return false;
	}
	
	if(!document.inputForm.address.value){
		alert("우편번호를 찾아주세요!!");
		document.inputForm.address.focus();
		return false;
	}
	
	if(!document.inputForm.address1.value){
		alert("주소를 입력해주세요!!");
		document.inputForm.address1.focus();
		return false;
	}
	
	if(!document.inputForm.telphone2.value){
		alert("휴대폰 번호를 입력하세요!!");
		document.inputForm.telphone2.focus();
		return false;
	}
	
	if(!document.inputForm.telphone3.value){
		alert("휴대폰 번호를 입력하세요!!");
		document.inputForm.telphone3.focus();
		return false;
	}
	
	if(!document.inputForm.idName.value){
		alert(msg_email1);
		document.inputForm.idName.focus();
		return false;
	}
	
	if(!document.inputForm.urlcode.value){
		alert(msg_emailChk);
		document.inputForm.urlcode.focus();
		return false;
	}
	
	if(document.inputForm.hiddenemail.value == 0){
		alert("인증 버튼을 클릭하세요.!!");
		document.inputForm.hiddenemail.focus();
		return false;
	}
	
	if(document.inputForm.formalNum.value != document.inputForm.numchk.value){
		alert("인증번호가 틀립니다 다시 입력하세요.!!");
		document.inputForm.formalNum.focus();
		return false;
	}
	
	if(!document.inputForm.acchost.value){
		alert("예금주를 입력하세요!!");
		document.inputForm.acchost.focus();
		return false;
	}
	
	if(!document.inputForm.bank.value){
		alert("은행명을 입력하세요!!");
		document.inputForm.bank.focus();
		return false;
	}
	
	if(!document.inputForm.acc.value){
		alert("계좌번호를 입력하세요!!");
		document.inputForm.acc.focus();
		return false;
	}
	
	if(!document.inputForm.usechk.checked){
		alert("이용약관을 체크하세요!!");
		document.inputForm.usechk.focus();
		return false;
	}
	
	if(!document.inputForm.guestdatachk.checked){
		alert("개인정보 수집약관을 체크하세요!!");
		document.inputForm.guestdatachk.focus();
		return false;
	}
	
	// 중복확인 버튼을 클릭하지 않은 경우
	// inputform.jsp
	// inputForm - hiddenId : 중복확인 버튼 클릭 여부 체크(0:클릭 안함, 1:클릭함)
	// <input type = "hidden" name = "hiddenId" value = "0">
	if(document.inputForm.hiddenId.value == 0){
		alert(msg_confirmId);
		document.inputForm.overlabchk.focus();
		return false;
	}
}

function selectEmailChk() {
	if(document.inputForm.email3.value == 0){
		document.inputForm.urlcode.value = "";
		document.inputForm.urlcode.focus();
		return false;
	} else {
		document.inputForm.urlcode.value = document.inputForm.email3.value;
		return false;
	}
}

/* checkbox 한번에 체크 함수 */
function all_check() {
	if(document.inputForm.allcheck.checked){
		document.inputForm.use_agree_chk.checked = true;
		document.inputForm.data_agree_chk.checked = true;
	} else {
		document.inputForm.use_agree_chk.checked = false;
		document.inputForm.data_agree_chk.checked = false;
	}
}

/* checkbox 제거 시에 all체크 제거 함수 */
function allcheck_remove() {
	if(!document.inputForm.use_agree_chk.checked){
		document.inputForm.allcheck.checked = false;
	} else if(!document.inputForm.data_agree_chk.checked) {
		document.inputForm.allcheck.checked = false;
	} else {
		document.inputForm.allcheck.checked = true;
	}
}

//---- 중복확인 -----
//중복확인 버튼 클릭시 서브창 open
function confirmId() {
	// id값 미입력 후 중복확인 버튼 클릭 시
	if(document.inputForm.id.value == ""){
		alert(msg_id);
		document.inputForm.id.focus();
		return false;
	}
	
	/*
	 * window.open("파일명", "윈도우명", "창에 대한 속성")\
	 * url = "주소?속성 = " + 속성값;   -> get방식
	 */
	var url = "confirmId?id=" + document.inputForm.id.value + "&hiddenId=" + document.inputForm.hiddenId.value + "&member=" + document.inputForm.memberNum.value;
	window.open(url, "confirm", "menubar=no, width=500, height = 300");
	// -> confirmId 서블릿 지정
	
}

function confirmIdfocus(){
	document.confirmform.id.focus();
}

//중복확인창에서 id입력 여부
function confirmIdCheck(){
	if(document.confirmform.id.value == ""){
		alert(msg_id);
		document.confirmform.id.focus();
		return false;
	}
}
//opener : window 객체의 open() 메소드로 열린 새창(=중복확인창)에서, 열어준 부모창(=회원가입창)에 접근할 때 사용
//self.close() : 메시지 없이 현재 창을 닫을 때 사용
//hiddenId : 중복확인 버튼 클릭 여부 체크(0: 클릭안함, 1: 클릭함)
function setId(id){
	opener.document.inputForm.id.value = id;
	opener.document.inputForm.hiddenId.value = 1;
	self.close();
}

// loginView
function startVal() {
	document.loginForm.id.value = "";
}

// modifyView

function modifyCheck() {
	// 패스워드 입력 확인
	if(!document.modifyView.pwd.value) {
		alert("패스워드를 입력하세요!!");
		document.modifyView.pwd.focus();
		return false;
	}
	
	// 패스워드 재입력 확인
	if(!document.modifyView.repwd.value){
		alert("패스워드 확인을 입력하세요!!");
		document.modifyView.repwd.focus();
		return false;
	} else if(document.modifyView.repwd.value != document.modifyView.pwd.value) {
		alert("패스워드갸 일치하지 않습니다. 다시 입력하세요!!");
		document.modifyView.repwd.value = null;
		document.modifyView.repwd.focus();
		return false;
	}
	
	// 이메일 입력 확인
	if(!document.modifyView.name.value){
		alert("이름을 입력하세요!!");
		document.modifyView.name.focus();
		return false;
	}
	
	if(!document.modifyView.address.value){
		alert("우편번호를 찾아주세요!!");
		document.modifyView.address.focus();
		return false;
	}
	
	if(!document.modifyView.address1.value){
		alert("주소를 입력해주세요!!");
		document.modifyView.address1.focus();
		return false;
	}
	
	if(!document.modifyView.telphone2.value){
		alert("휴대폰 번호를 입력하세요!!");
		document.inputForm.telphone2.focus();
		return false;
	}
	
	if(!document.modifyView.telphone3.value){
		alert("휴대폰 번호를 입력하세요!!");
		document.inputForm.telphone3.focus();
		return false;
	}
	
	if(!document.modifyView.idName.value){
		alert(msg_email1);
		document.modifyView.idName.focus();
		return false;
	}
	
	if(!document.modifyView.urlcode.value){
		alert(msg_emailChk);
		document.modifyView.urlcode.focus();
		return false;
	}
	
	if(!document.modifyView.pwd.value) {
		alert("패스워드를 입력하세요!!");
		document.modifyView.pwd.focus();
		return false;
	}
}

function MselectEmailChk() {
	if(document.modifyView.email3.value == ""){
		document.modifyView.urlcode.value = "";
		document.modifyView.urlcode.focus();
		return false;
	} else {
		document.modifyView.urlcode.value = document.modifyView.email3.value;
		return false;
	}
}

function modifyacc() {
	/*
	 * window.open("파일명", "윈도우명", "창에 대한 속성")\
	 * url = "주소?속성 = " + 속성값;   -> get방식
	 */
	var url = "modifyacc?bank=" + document.modifyView.bank.value + "&acc=" + document.modifyView.acc.value + "&acchost=" + document.modifyView.acchost.value;
	window.open(url, "refundAccList", "menubar=no, width=435px, height = 370px");
	// -> confirmId 서블릿 지정
}

function modifyStart(email,hp,homeP) {
	document.modifyView.email3.value = email;
	document.modifyView.telphone1.value = hp;
	if(homeP != ""){
		document.modifyView.tel1.value = homeP;
	}
}
	
function refundCheck() {
	if(!document.refundForm.acchost.value){
		alert("예금주를 입력하세요!!");
		document.refundForm.acchost.focus();
		return false;
	}
	
	if(!document.refundForm.bank.value){
		alert("은행명을 입력하세요!!");
		document.refundForm.bank.focus();
		return false;
	}
	
	if(!document.refundForm.acc.value){
		alert("계좌번호를 입력하세요!!");
		document.refundForm.acc.focus();
		return false;
	}
}

// refundForm
function refundStart(bankname) {
	document.refundForm.bank.value = bankname;
}

// deletePro
function deletePro(){
	var result = confirm("우리의 연은 여기까지였나요..?");
	if(result) {
		alert("그럼 조심히 가세요 좋은 추억이였습니다")
		window.location = "deletePro";
	} else {
		return false;
	}
}

// h_join_us
function numChk(){
	if(document.inputForm.formalNum1.value == ""){
		alert("고유번호를 적어주세요.!!");
		document.inputForm.formalNum1.focus();
		return false;
	}
	
	if(document.inputForm.formalNum1.value == 1234){
		alert("고유번호 확인되었습니다.");
		document.inputForm.numCheck.value = 1;
		return false;
	} else {
		alert("고유번호가 틀렸습니다.");
	}
}

function hostCheck() {
	// 아이디 입력 확인
	if(!document.inputForm.id.value){
		alert("아이디를 입력하세요!!");
		document.inputForm.id.focus();
		return false; // 나를 호출한 곳으로 false를 리턴하면서 동작을 중지
	}
	
	// 패스워드 입력 확인
	if(!document.inputForm.pwd.value) {
		alert("패스워드를 입력하세요!!");
		document.inputForm.pwd.focus();
		return false;
	}
	
	// 패스워드 재입력 확인
	if(!document.inputForm.repwd.value){
		alert("패스워드 확인을 입력하세요!!");
		document.inputForm.repwd.focus();
		return false;
	} else if(document.inputForm.repwd.value != document.inputForm.pwd.value) {
		alert("패스워드갸 일치하지 않습니다. 다시 입력하세요!!");
		document.inputForm.repwd.value = null;
		document.inputForm.repwd.focus();
		return false;
	}
	
	// 이메일 입력 확인
	if(!document.inputForm.name.value){
		alert("이름을 입력하세요!!");
		document.inputForm.name.focus();
		return false;
	}
	
	if(!document.inputForm.telphone2.value){
		alert("휴대폰 번호를 입력하세요!!");
		document.inputForm.telphone2.focus();
		return false;
	}
	
	if(!document.inputForm.telphone3.value){
		alert("휴대폰 번호를 입력하세요!!");
		document.inputForm.telphone3.focus();
		return false;
	}
	
	if(!document.inputForm.idName.value){
		alert(msg_email1);
		document.inputForm.idName.focus();
		return false;
	}
	
	if(!document.inputForm.urlcode.value){
		alert(msg_emailChk);
		document.inputForm.urlcode.focus();
		return false;
	}
	
	if(document.inputForm.numCheck.value == 0){
		alert("관리자 고유번호를 확인하세요.!!");
		document.inputForm.numCheck.focus();
		return false;
	}
	
	// 중복확인 버튼을 클릭하지 않은 경우
	// inputform.jsp
	// inputForm - hiddenId : 중복확인 버튼 클릭 여부 체크(0:클릭 안함, 1:클릭함)
	// <input type = "hidden" name = "hiddenId" value = "0">
	if(document.inputForm.hiddenId.value == 0){
		alert(msg_confirmId);
		document.inputForm.overlabchk.focus();
		return false;
	}
}


// QnA
//QnA
function QnAwriteChk(choose, pageNum) {
	if(document.getElementById('memid').value != "") {
		window.location = 'QnAwrite?choose='+ choose +'&pageNum=' + pageNum;
	} else {
		alert("로그인을 해주세요!!");
		return false;
	}
}

// review
function reviewwriteChk(choose, pageNum) {
	if(document.getElementById('memid').value != "") {
		window.location = 'reviewwrite?choose='+ choose +'&pageNum=' + pageNum;
	} else {
		alert("로그인을 해주세요!!");
		return false;
	}
}

// product
function select_size(){
	var frm = document.productclick;
    frm.action = "productclick";
    frm.submit();
}

function orderStart(email,hp,homeP) {
	document.orderform.email3.value = email;
	document.orderform.telphone1.value = hp;
	if(homeP != ""){
		document.orderform.tel1.value = homeP;
	}
}

function OselectEmailChk() {
	if(document.orderform.email3.value == ""){
		document.orderform.urlcode.value = "";
		document.orderform.urlcode.focus();
		return false;
	} else {
		document.orderform.urlcode.value = document.orderform.email3.value;
		return false;
	}
}

function orderlistDel() {
	var frm = document.orderform;
    frm.action = "prdorderDel";
    frm.submit();
}

function ordersubmit() {
	if(document.orderform.delinameN.value == ""){
		alert("받는 사람의 이름을 입력해주세요!");
		document.orderform.delinameN.focus();
		return false;
	}
	if(!document.orderform.userAddr.value()){
		alert("주소를 입력해주세요!");
		document.orderform.userAddr.focus();
		return false;
	}
	if(!document.orderform.baseAddr.value()){
		alert("주소를 입력해주세요!");
		document.orderform.baseAddr.focus();
		return false;
	}
	if(!document.orderform.baseAddr.value()){
		alert("주소를 입력해주세요!");
		document.orderform.baseAddr.focus();
		return false;
	}
	if(!document.orderform.telphone2.value){
		alert("휴대폰 번호를 입력하세요!!");
		document.orderform.telphone2.focus();
		return false;
	}
	
	if(!document.orderform.telphone3.value){
		alert("휴대폰 번호를 입력하세요!!");
		document.orderform.telphone3.focus();
		return false;
	}
	
	if(!document.orderform.idName.value){
		alert(msg_email1);
		document.orderform.idName.focus();
		return false;
	}
	
	if(!document.orderform.urlcode.value){
		alert(msg_emailChk);
		document.orderform.urlcode.focus();
		return false;
	}
	
	if(!document.orderform.agreeN.checked){
		alert("결제확인을 체크해주세요!");
		document.orderform.agreeN.focus();
		return false;
	}
	
	if(!document.orderform.howpay.value == "notacc"){
		if(!document.orderform.depositname.value){
			alert("입금자명을 작성해주세요!");
			document.orderform.depositname.focus();
			return false;
		}
		if(!document.orderform.bank.value){
			alert("입금계좌를 작성해주세요!");
			document.orderform.bank.focus();
			return false;
		}
	}
}

// 이메일 인증 이동 버튼
function formalChk() {
	// id값 미입력 후 중복확인 버튼 클릭 시
	if(!document.inputForm.idName.value){
		alert(msg_email1);
		document.inputForm.idName.focus();
		return false;
	}
	
	if(!document.inputForm.urlcode.value){
		alert(msg_emailChk);
		document.inputForm.urlcode.focus();
		return false;
	}
	
	/*
	 * window.open("파일명", "윈도우명", "창에 대한 속성")\
	 * url = "주소?속성 = " + 속성값;   -> get방식
	 */
	var url = "emailsend?idname=" + document.inputForm.idName.value + "&urlcode=" + document.inputForm.urlcode.value;
	window.open(url, "emailsend", "menubar=no");
	// -> confirmId 서블릿 지정
	
}

function findidpwdCheck() {
	if(!document.findform.idName.value){
		alert(msg_email1);
		document.findform.idName.focus();
		return false;
	}
	
	if(!document.findform.urlcode.value){
		alert(msg_emailChk);
		document.findform.urlcode.focus();
		return false;
	}
	
	if(document.findform.hiddenemail.value == 0){
		alert("인증 버튼을 클릭하세요.!!");
		document.findform.hiddenemail.focus();
		return false;
	}
	
	if(document.findform.formalNum.value != document.findform.numchk.value){
		alert("인증번호가 틀립니다 다시 입력하세요.!!");
		document.findform.formalNum.focus();
		return false;
	}
}

//울ㄴㅇ
function findformalChk() {
	// id값 미입력 후 중복확인 버튼 클릭 시
	if(!document.findform.idName.value){
		alert(msg_email1);
		document.findform.idName.focus();
		return false;
	}
	
	if(!document.findform.urlcode.value){
		alert(msg_emailChk);
		document.findform.urlcode.focus();
		return false;
	}
	
	/*
	 * window.open("파일명", "윈도우명", "창에 대한 속성")\
	 * url = "주소?속성 = " + 속성값;   -> get방식
	 */
	var url = "emailsend?idname=" + document.findform.idName.value + "&urlcode=" + document.findform.urlcode.value;
	window.open(url, "emailsend", "menubar=no");
	// -> confirmId 서블릿 지정
	
}

//opener : window 객체의 open() 메소드로 열린 새창(=중복확인창)에서, 열어준 부모창(=회원가입창)에 접근할 때 사용
//self.close() : 메시지 없이 현재 창을 닫을 때 사용
//hiddenId : 중복확인 버튼 클릭 여부 체크(0: 클릭안함, 1: 클릭함)
function setkey(key){
	window.opener.document.getElementById("numchk1").value = key;
	window.opener.document.getElementById("hiddenemail1").value = 1;
	alert(window.opener.document.getElementById("numchk1").value);
	self.close();
}