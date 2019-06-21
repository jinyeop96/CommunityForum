
$(document).ready(function(){
	$('#c_pwd').attr("readonly",true);//시작시 비밀번호 입력 인풋창은 입력불가
	$('#j_pwd').attr("readonly",true);//시작시 비밀번호 확인 인풋창은 입력불가
});



//다음 우편번호 검색 펑션
function zipSearch(){
    new daum.Postcode({
        oncomplete: function(data) {
            var fullRoadAddr = data.roadAddress; //도로명주소 변수
            var extraRoadAddr = ''; //도로명 조합형 주소 변수
            
            if(data.bname !==''&&/[동|로|가]$/g.test(data.bname)){
            	extraRoadAddr += data.bname;
            }
            
            if(data.buildingName !==''&&data.apartment =='Y'){
            	extraRoadAddr +=(extraRoadAddr !==''?','+data.buildingName : data.buildingName);
            }
            
            if(extraRoadAddr !==''){
            	extraRoadAddr = '('+ extraRoadAddr +')';
            }
            if(fullRoadAddr !==''){
            	fullRoadAddr += extraRoadAddr; 
            }
            document.getElementById('zip').value = (data.zonecode);
            document.getElementById('addr1').value = (data.zonecode)+(fullRoadAddr);
            document.getElementById('addr2').focus();
            
            
        }
    }).open();
    }
// 주소, 상세주소 합치는 펑션(히든값)
function addrsum(){
	var addr1 = $('#addr1').val();
	var addr2 = $('#addr2').val();
	$('#j_addr').val(addr1+'  ' +addr2);
}

//비밀번호 입력창 입력제한 및 알림 펑션
function PwdLength(event){
	$('#j_pwd').attr("readonly",true);
	$('#j_pwd').val('');
	$('#pwd_chk').html("");
     var pwd = $('#c_pwd').val();
 	 var chk = $('#j_pwd').val();
	 chk1 = /^[a-z\d]{8,12}$/i;  //a-z와 0-9이외의 문자가 있는지 확인
	 chk2 = /[a-z]/i;  //적어도 한개의 a-z 확인
	 chk3 = /\d/;  //적어도 한개의 0-9 확인
	 if(chk1.test(pwd) && chk2.test(pwd) && chk3.test(pwd)){
		 $('#pwd_leng').html("입력한 비밀번호는 사용가능합니다");
			$('#j_pwd').attr("readonly",false);
	 }else{
		 $('#pwd_leng').html("영,숫자 조합 8자리 이상 입력해주세요");
		
	 }
	 if(pwd.length<=0){
		 $('#pwd_leng').html("");
		 
	 }
		
	}

	 

//비밀번호 확인 펑션
function PwdChk(event){
	    var pwd = $('#j_pwd').val();
		var chk = $('#c_pwd').val();
	
		if(pwd.trim() != ''){
			if(pwd.trim() == chk.trim()){
				$('#pwd_chk').html("비밀번호가 일치합니다.");
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



//메일 도메인 주소 셀렉트 박스 선택시 자동으로 들어가는 펑션
function mail(){
	$('#email2').val(($('#email_select option:selected').val()));
	}
//메일 도메인주소와 메일 주소 합치는 펑션(히든값)
function mailplus(){
	var email1 = $('#email1').val();
	var email2 = $('#email2').val();
	$('#j_email').val(email1 + '@' + email2);
}

//가입폼내의 인풋박스에 입력값이 없으면 경고창을 띄우며 해당 인풋박스로 이동
function formchk(){
	
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
	
	if($('#j_pwd').val()  != $('#c_pwd').val()){
		alert("비밀번호가 달라요");
		$('#c_pwd').focus();
		return false;
	}
	
	if($('#j_name').val()  ==""){
		alert("이름입력해주세요");
		$('#j_name').focus();
		return false;j_nickname
	}
	
	if($('#j_nickname').val()  ==""){
		alert("닉네임 입력해주세요");
		$('#j_nickname').focus();
		return false;
	}
	if($('#email1').val() == "" ){
		alert("이메일 입력");
		$('#email1').focus();
		return false;
	}
	if($('#j_mobile').val() == "" ){
		alert("전화 번호 입력");
		$('#j_mobile').focus();
		return false;
	}
	
	if($('#j_addr').val() == "" ){
		alert("주소입력");
		return false;
	}
	return true;
}
