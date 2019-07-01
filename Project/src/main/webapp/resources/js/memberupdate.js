
	function formcheck(){
		var emailcheck = $('#email').val();
		var regExp = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
		
		if($('#nickname').val()==""){
			alert("변경할 닉네임을 입력해주세요.");
			return false;
		}
		
		if(emailcheck==""){
			alert("변경할 이메일을 입력해주세요.");
			return false;
		}else if(emailcheck.match(regExp)!=null){
			return true;
		}else{
			alert("이메일 형식이 맞지않습니다.");
			return false;
		}
		
	}