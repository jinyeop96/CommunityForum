<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">

<style type="text/css">
::placeholder{
font-size: 12px;
}
</style>
<title>Login</title>
<script src="./resources/jquery-3.4.1.js"></script>
<script src="//developers.kakao.com/sdk/js/kakao.min.js"></script>
<script src="https://apis.google.com/js/platform.js" async defer></script>
<script src="./resources/js/join.js" ></script>  <!-- Join.jsp에서 사용될 함수가 저장된 라이브러리로드 -->

<script >
$(function(){
	//회원가입 버튼 활성/비활성을 할때 확인위한 변수 선언
	var nickresult = 0;
	var emailresult = 0;
	$("#idcheck").click(function(){
		//아이디 중복 체크 버튼을 눌렀을때
		var id = $("#id").val();
		//입력된 id값을 받아온다
		if(id!=''){
			//id 입력값이 있다면
			if(id.length < 5){
				//id에 저장된 문자열의 길이가 5보다 작다면
				$("#id_leng").html("아이디는 4자 이상 최대16자리까지만 가능합니다.");
				//아이디의 입력길이를 표시해준다
			}else{
				//아이디입력값이 있고 길이가 4자리이상이라면
				$.ajax({
					url:"idcheck.do",
					type : "post",
					data : {
						id : id
					},
					dataType : "text",
					//idcheck.do로 id값을 넘겨준다
					success:function(data){
						//DB와 정상적으로 연동되었을때
						console.log(data);
						
						if(data == '1'){
							alert("중복된 아이디입니다.");
							$("#id_leng").html("");
							$('#c_pwd').attr("readonly",true);
						//DB에 이미 ID가 있다면 1값이 반환된다
						//이미 값이 있으므로 경고창에 중복된 아이디 안내
						//id길이관련 텍스트가 들어가는 span의 값을 초기화
						//중복된 아이디일경우 pwd입력창은 입력 불가하게 readonly로 설정 해준다
						}else{
							alert("사용가능한 아이디입니다.");
							$("#id_leng").html("");
							$('#c_pwd').attr("readonly",false);
						//DB에 ID가 없다면 0이 반환된다
						//중복값이 없으므로 경고창으로 사용가능안내
						//id길이관련 텍스트가 들어가는 span의 값을 초기화
						//사용가능한 아이디이므로 다음 입력창인 pwd의 readonly해제
						}
					},
					error : function(data){
						alert("오류 "+data);
						//DB와 정상적으로 통신이되지않을시 경고창
					}
				});
			}
		}else{
			alert("아이디를 입력해주세요");
			//아이디 입력창이 비어있을때 경고창에 입력안내
		}
	});
	$("#nickname").keyup(function(){
		//닉네임 입력란의 입력이 들어올때 실행된다
		var nickname;
		nickname=$('#nickname').val();
		//닉네임 입력란에 들어온값을 변수에 저장
		$.ajax({
			url :"nickcheck.do",
			type : "post",
			data : {
				nickname : nickname
			},
			//변수에 저장된 값을 nickcheck.do로 넘겨준다
			dataType : "text",
			success:function(data){
				if(nickname !=''){
				     //nickname 입력란의 입력값이 있을때
					if(data == '1'){
						$('#checknick').html("중복된 닉네임입니다.");
						$('#joinbtn').attr('disabled', true);
						nickresult = 0;
						//DB와 연동하여 쿼리 확인시 중복됬을때 1의 값이 넘아온다
						//중복된 닉네임이라는 안내 및 회원가입 버튼 disable
						//회원가입버튼 enable을 위한 변수값 nickresult값에 0주입
					}else{
						$('#checknick').html("");
						nickresult = 1;
						}
				     //DB와 연동하여 쿼리 확인시 중복안됬을때 0의 값이 넘아온다
				     //중복경고span을 초기화
				     //회원가입버튼 enable을 위한 변수값 nickresult값에 1주입
					if(emailresult ==1 && nickresult ==1){
						$('#joinbtn').attr('disabled', false);
						//emailresult와 nickresult값이 1일때에 회원가입버튼 활성화
					}else{
						$('#joinbtn').attr('disabled', true);
						//emailresult와 nickresult값이 1아닐때에 회원가입버튼 비활성화
					}
				}else{
					$('#checknick').html("닉네임 입력해주세요.");
					//닉네임 입력창이 비어있을때 span경고 문구 출력
					$('#joinbtn').attr('disabled', true);
					//입력값이 없으므로 회원가입버튼 비활성화
				}
			},
			error : function(data){
				alert("통신오류 " + data);
				//DB연동이 안됬을때 경고창
			}
		});
	});
	
	$("#email").keyup(function(){
		//email입력창에 키입력이 들어왔을때 동작
		var email;
		email=$('#email').val();
		//email입력창의 값을 변수에 저장
		$.ajax({
			url :"emailcheck.do",
			type : "post",
			data : {
				email : email
			},
			dataType : "text",
			//저장된 값을 emailcheck.do로 전달
			success:function(data){
				if(email !=''){
				  //email입력창에 값이 있을때
					if(data == '1'){
						$('#emailcheck').html("중복된 이메일입니다.");
						$('#joinbtn').attr('disabled', true);
						 emailresult = 0;
						 //DB에 중복값이 있을경우 1이 반환된다.
						 //중복확인 span태그에 중복안내 문구 삽입
						 //회원가입버튼 비활성화
						 //회원가입버튼의 활성/비활성화를 위한 변수에 0입력
					}else{
						$('#emailcheck').html("");
						 emailresult = 1;
						 //DB에 중복값이 없을경우 0반환
						 //중복확인 span태그의 값을 초기화
						 //회원가입버튼의 활성/비활성화를 위한 변수에 1입력
						if(emailresult ==1 && nickresult ==1){
							$('#joinbtn').attr('disabled', false);	
							//emailresult와 nickresult값이 1일때에 회원가입버튼 활성화
						}else{
							$('#joinbtn').attr('disabled', true);
							//emailresult와 nickresult값이 1이 아닐때에 회원가입버튼 비활성화
						}
					}
					
				}else{
					$('#emailcheck').html("이메일을 입력해주세요.");
					//email입력란이 비어있을 경우 span태그에 이메일입력안내문구 삽입
					$('#joinbtn').attr('disabled', true);
					//email이 입력되어있지 않으므로 회원가입버튼 비활성화
				}
			},
			error : function(data){
				alert("통신오류 " + data);
				//DB와의 통신이 되지않을때 통신오류 경고창
			}
		});
	});
});
</script>
<body>
		<jsp:include page="/resources/include/navigation.jsp" />

	 <!--  section01 -->
	<header class="masthead bg-primary text-white text-center">
    <div class="container d-flex align-items-center flex-column">
      <h1 class="masthead-heading text-uppercase mb-0">회원 가입</h1>
      <div id="loginDiv" align="center" style="width: 100%">
      <form onsubmit="return formchk()" method="post" action="<%=request.getContextPath()%>/join_ok.do">
      <input type="hidden" name="verify" value="n">
      <!-- form안에 submit버튼 입력시 formchk()에서 체크후 return값이 true일 경우 form안에 있는 값들을 post형식으로 join_ok.do로 넘겨준다 -->
      	<table style="width: 100%">
      	<!-- 아이디 입력 공간
      	input :  name, id = id  /  한글입력 불가 정규식 적용
      	span tag : id = id_leng /  아이디 길이 경고문구 출력
      	-->
      		<tr>
      			<td colspan="2"  align="center"><input class="input" name="id" id="id"  maxlength="16" placeholder="아이디입력(영,숫자조합)" onkeyup="this.value=this.value.replace(/[^a-z0-9]/gi,'');"  > <input type="button" id="idcheck" value="중복검사">
      			<br><span style='font-size: 12px; color: red;' id='id_leng'></span>
      			</td> 
      		</tr>
      	<!-- 비밀번호 입력공간
      	input : 1. name, id = c_pwd  / 비밀번호입력란 
      	        2. name, id = pwd    / 비밀번호 중복확인 입력란
      	span tag : 1.id = pwd_leng   / 비밀번호의 형식 길이에 대한 경고문구 출력
      	           2.id = pwd_chk    /  input1,2를 비교하여 일치하지않을시 경고문구 출력        
      	 -->	
      		<tr>
      			<td colspan="2"  align="center"><input class="input" style="margin-right: 85px"   type="password" name="c_pwd" id="c_pwd" placeholder="비밀번호입력" onkeyup="PwdLength()">
      			<br><span style="font-size: 12px; color: red;" id="pwd_leng"></span>
      			</td>
      		</tr>
      		<tr>
      			<td colspan="2"  align="center"><input class="input" style="margin-right: 85px"   type="password" name="pwd" id="pwd" placeholder="비밀번호확인" onkeyup="PwdChk()" >
      			<br><span style="font-size: 12px; color: red;" id="pwd_chk"></span>
      			</td>
      		</tr>
      	<!-- 이름 입력공간
          input : name, id = name  /이름입력란
        -->
      		<tr>
      			<td colspan="2"  align="center"><input class="input" style="margin-right: 85px"   name="name" id="name" placeholder="이름입력" ></td> 
      		</tr>
      	<!-- 닉네임 입력공간
      	   input : name,id = nickname  / 닉네임입력란
      	    span : id = checknick      / 닉네임이 중복될경우 경고문구 출력
      	 -->	
      		<tr>
      			<td colspan="2"  align="center"><input class="input" style="margin-right: 85px"   name="nickname" id="nickname" placeholder="닉네임입력" >
      			<br><span style="font-size: 12px; color: red;" id="checknick"></span>
      			</td> 
      		</tr>
      	<!-- email 입력공간
      	     input : name,id = email   / 이메일입력란
      	     span : id = emailcheck    / 중복된 이메일시 경고문구 출력
      	 -->	
      		<tr>
      			<td colspan="2"  align="center"><input class="input" name="email" id="email"  style="margin-right: 85px" placeholder="메일주소입력" >
      			<br><span style="font-size: 12px; color: red;" id="emailcheck">가입시 인증메일이 발송됩니다.</span>
      			</td> 
      			</table>
       <!-- 버튼영역 
           input : 1.type submit id =joinbtn / 가입버튼 기본 비활성화
                   2.type button             / 이전화면으로 돌아가기
        -->    			
      	<input  type="submit" value="가입하기" disabled="disabled" id="joinbtn">&nbsp;&nbsp;
      	<input type="button" value="돌아가기" onclick="history.back();"> 
      	</form>
      	
      	<!-- 로그인 api 불러오기 -->
      	<table id="loginAPI"></table>
  
  		<script type="text/javascript">
  			$(function(){
  				$("#loginAPI").load("loginAPI.do");
  			})
  		</script>
      </div>
    </div>
  </header>
  </head>
  
  <jsp:include page="/resources/include/footer.jsp" />
  <jsp:include page="/resources/include/copyright.jsp" />
  <jsp:include page="/resources/include/modals.jsp" />
</body>
</html>