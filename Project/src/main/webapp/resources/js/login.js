
function loginformchk(){
	if($('#j_id').val()  ==""){
		alert("아이디 입력해주세요");
		$('#j_id').focus();
		return false;
	}
	
	if($('#j_pwd').val()  ==""){
		alert("비밀번호 입력해주세요");
		$('#c_pwd').focus();
		return false;
	}
}
	
