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
	
	if(!document.inputForm.formalNum.value){
		alert("인증번호를 입력하세요.!!");
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
	if(document.inputForm.formalNum.value == ""){
		alert("고유번호를 적어주세요.!!");
		document.inputForm.formalNum.focus();
		return false;
	}
	
	if(document.inputForm.formalNum.value == 1234){
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

// notice
function blockchange(){
	window.location = "h_notice?pageSize="+document.completeForm.blocknum.value + "&choose=" + document.completeForm.choose.value;
}

function BaseSize(size) {
	document.completeForm.blocknum.value = size;
}

// 날짜
/*var date = new Date();  현재 
var nowYear = date.getFullYear();
var nowMonth = date.getMonth()+1;
var nowDay = date.getDate();

// 어제날짜
var yesterDate = date.getTime() - (1*24*60*60*1000);
date.setTime(yesterDate); // 이걸로 date가 하루 전으로 초기화 되어서 가져오기만 하면됨
*/
function today(){
	document.getElementById('firstday').value = new Date().toISOString().substring(0, 10);
	document.getElementById('lastday').value = new Date().toISOString().substring(0, 10);
	document.searchForm.dayNum.value = 0;
}

function week(){
	var date = new Date(); /* 현재 */
	date.setDate(date.getDate() - 7);
	document.getElementById('firstday').value = date.toISOString().substring(0, 10);
	document.searchForm.dayNum.value = 1;
}

function month1(){
	var date = new Date(); /* 현재 */
	date.setDate(date.getDate() - 30);
	document.getElementById('firstday').value = date.toISOString().substring(0, 10);
	document.searchForm.dayNum.value = 2;
}

function month3(){
	var date = new Date(); /* 현재 */
	date.setDate(date.getDate() - 90);
	document.getElementById('firstday').value = date.toISOString().substring(0, 10);
	document.searchForm.dayNum.value = 3;
}

function month6(){
	var date = new Date(); /* 현재 */
	date.setDate(date.getDate() - 180);
	document.getElementById('firstday').value = date.toISOString().substring(0, 10);
	document.searchForm.dayNum.value = 4;
}

function typeChange(){
	document.searchForm.searchType.value = document.searchForm.srhType.value;
}

// FAQ
function FAQBaseSize(size) {
	document.completeForm.blocknum.value = size;
}

// brand
function brandupdateStart(hp) {
	if(hp != ""){
		document.h_brandform.telphone1.value = hp;
	}
}

// product
function select_category(){
	// 서버로 요청해서 통신한 후 응답을 callback 함수로 받겠다.
	var bigpart_name = document.getElementById("onepart");
	var value = bigpart_name.options[bigpart_name.selectedIndex].value;

	console.log("bigpart_value : " + value);
	if(value != "") {
		var params = "bigpart="+ value;

		sendRequest(sub_callback, "h_submedium", "GET", params); // search_next.jsp -> 콜백함수로 리턴
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
	var result = document.getElementById("twopart");
	// 4 : completed => 전체데이터가 취득환료된 상태
	if(httpRequest.readyState == 4){
		if(httpRequest.status == 200) { // 200 : 정상종료
			//result.innerHTML = "정상종료";
			var data = httpRequest.responseText;
			console.log(data);

			result.innerHTML = data;
			//result.innerHTML = httpRequest.responseXML;
		} else {
			alert("에러발생");
		}
	} else {

	}
}

function bigpartPro(){
	if(document.productForm.bigpart.value != "") {
		window.location = 'h_bigpartPro?name=' + document.productForm.bigpart.value;
	} else {
		alert("텍스트를 입력해주세요!!");
	}
}

function mediumpartPro(){
	if(document.productForm.mediumpart.value != "") {
		window.location = 'h_mediumpartPro?bcode=' + document.productForm.subbigpart.value + '&name=' + document.productForm.mediumpart.value;
	} else {
		alert("텍스트를 입력해주세요!!");
	}
}

function colorPro(){
	if(document.productForm.colorname.value != "") {
		window.location = 'h_colorPro?name=' + document.productForm.colorname.value + "&num=" + document.productForm.num.value;
	} else {
		alert("텍스트를 입력해주세요!!");
	}
}

function sizePro(){
	if(document.productForm.sizename.value != "") {
		window.location = 'h_sizePro?name=' + document.productForm.sizename.value + "&num=" + document.productForm.num.value;
	} else {
		alert("텍스트를 입력해주세요!!");
	}
}

function bigpartdelPro(){
	if(document.productForm.bigpartdel.value != "") {
		window.location = 'h_bigpartdelPro?name=' + document.productForm.bigpartdel.value;
	} else {
		alert("텍스트를 입력해주세요!!");
	}
}

function mediumpartdelPro(){
	if(document.productForm.tpartdel.value != "") {
		window.location = 'h_mediumpartdelPro?bcode=' + document.productForm.subbigpart.value + '&name=' + document.productForm.tpartdel.value;
	} else {
		alert("텍스트를 입력해주세요!!");
	}
}

function colordelPro(){
	if(document.productForm.colordelname.value != "") {
		window.location = 'h_colordelPro?name=' + document.productForm.colordelname.value + "&num=" + document.productForm.num.value;
	} else {
		alert("텍스트를 입력해주세요!!");
	}
}

function sizedelPro(){
	if(document.productForm.sizedelname.value != "") {
		window.location = 'h_sizedelPro?name=' + document.productForm.sizedelname.value + "&num=" + document.productForm.num.value;
	} else {
		alert("텍스트를 입력해주세요!!");
	}
}

//---- 중복확인 -----
//중복확인 버튼 클릭시 서브창 open
function withproductChk() {
	/*
	 * window.open("파일명", "윈도우명", "창에 대한 속성")\
	 * url = "주소?속성 = " + 속성값;   -> get방식
	 */
	var url = "withproductitems";
	window.open(url, "withitems", "menubar=no, width = 800px, height = 600px");
	
}

//opener : window 객체의 open() 메소드로 열린 새창(=중복확인창)에서, 열어준 부모창(=회원가입창)에 접근할 때 사용
//self.close() : 메시지 없이 현재 창을 닫을 때 사용
//hiddenId : 중복확인 버튼 클릭 여부 체크(0: 클릭안함, 1: 클릭함)
function setwithitems(num,image){
	opener.document.getElementById("image").innerHTML = "<img src = 'fileready/" + image + "' width = '100px' height = '100px'>";
	opener.document.productForm.withitem.value = num;
	self.close();
}

// color
function select_size(){
	var frm = document.productForm;
    frm.action = "h_csupdate";
    frm.submit();
}
