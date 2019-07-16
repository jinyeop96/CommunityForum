var mailcheck;
var titlecheck;
var contcheck;

function mailformchk(){
	var regExp = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
	var emailcheck = $('#frommail').val();
/*	if($('#frommail').val()  ==""){
		alert("답변 받을 이메일주소를 입력해주세요");
		$('#frommail').focus();
		mailcheck = 0;
		return false;
		
	}else if(emailcheck.match(regExp)!=null){
		mailcheck = 1;
	}else{
		alert("이메일형식이 맞지 않습니다.");
		$('#frommail').focus();
		mailcheck = 0;
		return false;
		
	}*/
	
	if($('#mailtitle').val()  ==""){
		alert("제목을 입력해주세요");
		$('#mailtitle').focus();
		titlecheck = 0;
		return false;
	}else{
		titlecheck = 1;
	}
	
	if($('#mailcont').val()  ==""){
		alert("문의할 내용을 입력해주세요");
		$('#mailcont').focus();
		contcheck = 0;
		return false;
	}else{
		contcheck = 1;
	}
	
	if(/*mailcheck == 1 &&*/ titlecheck ==1 && mailcont ==1){
		return true;
	}
	
	
}
	
