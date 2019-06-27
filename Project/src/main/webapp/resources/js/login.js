
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
	
