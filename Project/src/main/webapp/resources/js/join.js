
$(document).ready(function(){
	$('#c_pwd').attr("readonly",true);//시작시 비밀번호 입력 인풋창은 입력불가
	$('#pwd').attr("readonly",true);//시작시 비밀번호 확인 인풋창은 입력불가
	
});
//비밀번호 입력창 입력제한 및 알림 펑션
function PwdLength(event){
	$('#pwd').attr("readonly",true);
	$('#pwd').val('');
	$('#pwd_chk').html("");
     var pwd = $('#c_pwd').val();
 	 var chk = $('#pwd').val();
	 chk1 = /^[a-z\d]{8,12}$/i;  //a-z와 0-9이외의 문자가 있는지 확인
	 chk2 = /[a-z]/i;  //적어도 한개의 a-z 확인
	 chk3 = /\d/;  //적어도 한개의 0-9 확인
	 if(chk1.test(pwd) && chk2.test(pwd) && chk3.test(pwd)){
		 $('#pwd_leng').html("입력한 비밀번호는 사용가능합니다");
			$('#pwd').attr("readonly",false);
	 }else{
		 $('#pwd_leng').html("영,숫자 조합 8자리 이상 입력해주세요");
		
	 }
	 if(pwd.length<=0){
		 $('#pwd_leng').html("");
		 
	 }
		
	}

	 

//비밀번호 확인 펑션
function PwdChk(event){
    var pwd = $('#pwd').val();
	var chk = $('#c_pwd').val();
	if(pwd.trim() != ''){
		if(pwd.trim() == chk.trim()){
			 $('#pwd_leng').html("");
			$('#pwd_chk').html("");
		}else {
			$('#pwd_chk').html("비밀번호가 일치하지않습니다.");
		}
	}else{
		$('#pwd_chk').html("비밀번호를 입력해주세요");
	}
	if(chk.trim()==''){
		$('#pwd_chk').html("");
		
	}
}


function email_check(email){
	var regex=/([\w-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([\w-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$/;
    return (email != '' && email != 'undefined' && regex.test(email));
}

function email(){
	var emaill = $('#j_email').val();
	
	if(!email_check(email)){
		alert("이메일형식이 올바르지 않습니다.");
		return false;
	}else{
		return true;
	}
	
}



//가입폼내의 인풋박스에 입력값이 없으면 경고창을 띄우며 해당 인풋박스로 이동
function formchk(){
	
	var emailcheck = $('#email').val();
	var regExp = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
	
	if($('#id').val()  ==""){
		alert("아이디 입력해주세요");
		$('#id').focus();
		return false;
	}
	
	if($('#pwd').val()  ==""){
		alert("비밀번호 입력해주세요");
		$('#c_pwd').focus();
		return false;
	}
	
	if($('#pwd').val()  != $('#c_pwd').val()){
		alert("비밀번호가 달라요");
		$('#c_pwd').focus();
		return false;
	}
	
	if($('#name').val()  ==""){
		alert("이름입력해주세요");
		$('#name').focus();
		return false;j_nickname
	}
	
	if($('#nickname').val()  ==""){
		alert("닉네임 입력해주세요");
		$('#nickname').focus();
		return false;
	}
	if($('#email').val() == "" ){
		alert("이메일 입력");
		$('#email').focus();
		return false;
	}else if(emailcheck.match(regExp)!=null){
		return true;	
	}else{
		alert("이메일 형식이 맞지 않습니다."); 
		return false;
	}
	
	
	
}
