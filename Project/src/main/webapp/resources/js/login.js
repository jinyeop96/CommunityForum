$(document).ready(function(){
	$('#changeBTN').attr('disabled', true);
});




function loginformchk(){
	if($('#id').val()  ==""){
		alert("아이디 입력해주세요");
		$('#id').focus();
		return false;
	}
	
	if($('#pwd').val()  ==""){
		alert("비밀번호 입력해주세요");
		$('#pwd').focus();
		return false;
	}
}
	
//비밀번호 입력창 입력제한 및 알림 펑션
function PwdLength(event){
	 var pwd = $('#pwd').val();
 	 chk1 = /^[a-z\d]{8,12}$/i;  //a-z와 0-9이외의 문자가 있는지 확인
	 chk2 = /[a-z]/i;  //적어도 한개의 a-z 확인
	 chk3 = /\d/;  //적어도 한개의 0-9 확인
	 if(chk1.test(pwd) && chk2.test(pwd) && chk3.test(pwd)){
		 $('#pwd_leng').html("입력한 비밀번호는 사용가능합니다");
	 }else{
		 $('#pwd_leng').html("영,숫자 조합 8자리 이상 입력해주세요");
		 $('#changeBTN').attr('disabled', true);
	 }
	 if(pwd.length<=0){
		 $('#pwd_leng').html("");
		 
	 }
		
	}

function PwdChk(event){
    var pwd = $('#pwd').val();
	var chk = $('#c_pwd').val();
	if(pwd.trim() != ''){
		if(pwd.trim() == chk.trim()){
			 $('#pwd_leng').html("");
			$('#pwd_chk').html("");
			$('#changeBTN').attr('disabled', false);
		}else {
			$('#pwd_chk').html("비밀번호가 일치하지않습니다.");
			$('#changeBTN').attr('disabled', true);
		}
	}else{
		$('#pwd_chk').html("비밀번호를 입력해주세요");
	}
	if(chk.trim()==''){
		$('#pwd_chk').html("");
		
	}
}

