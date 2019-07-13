<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">



<title>Login</title>
<script src="http://code.jquery.com/jquery-3.4.1.js"></script> <!-- JQuery사용을 위한 라이브러리 다운로드 -->
<script src="./resources/js/join.js" ></script>  <!-- Join.jsp에서 사용될 함수가 저장된 라이브러리로드 -->
<script src="./resources/js/memberupdate.js" ></script>
<script type="text/javascript">

$(function(){
	//버튼 활성/비활성화를 위한 변수선언
	var nickresult = 0;
	var emailresult = 0;
	
	$("#nickname").keyup(function(){
		//닉네임입력란에 키입력값이 들어올때 이벹느발생
		var nickname;
		nickname=$('#nickname').val();
		//입력된 닉네임값을 변수에 저장
		$.ajax({
			url :"nickcheck.do",
			type : "post",
			data : {
				nickname : nickname
			},
			dataType : "text",
			//변수에 저장된값을 닉네임 nickcheck.do로 전송
			success:function(data){
				//정상적으로 DB와 연동되어 값을 가져올때
				if(nickname !=''){
				//닉네임 값이 중복되었을때
					if(data == '1'){
						$('#checknick').html("중복된 닉네임입니다.");
						$('#loginBtn').attr("disabled",true);
						nickresult = 0;
						//닉네임값 중복일때 반환값 1
						//span영역에 중복닉네임 안내
						//업데이트 버튼 비활성화
						//nickresult에 변수 0 주입
					}else{
						$('#checknick').html("");
						$('#loginBtn').attr("disabled",false);
						nickresult = 1;
						//닉네임이 중복되지않았을때 반환값 0
						//span영역 초기화
						//업데이트 버튼 관련 변수인 nickresult에 1 주입
						if(emailresult ==1 && nickresult ==1){
							$('#loginBtn').attr('disabled', false);	
							//만약 emailresult, nickresult값이 둘다 모두 1일때
							// 업데이트 버튼 활성화
						}else{
							$('#loginBtn').attr('disabled', true);
							//만약 emailresult, nickresult값이 둘다 모두 1이 아닐때
							// 업데이트 버튼 비활성화
						}
					}
				}else{
					$('#checknick').html("닉네임 입력해주세요.");
					$('#loginBtn').attr('disabled', true);
					//닉네임 입력 영역이 공백일때 span에 입력요청 문구
					//입력값이 없으므로 업데이트 버튼 비활성화
				}
			},
			error : function(data){
				alert("통신오류 " + data);
				//DB와 통신이 정상적으로 되지않았을때 경고창 
			}
		});
	});
	
	$("#email").keyup(function(){
		//이메일 영역에 키입력이 들어올때 이벤트 발생
		var email;
		email=$('#email').val();
		//이메일 영역의 입력값 변수에 저장
		$.ajax({
			url :"emailcheck.do",
			type : "post",
			data : {
				email : email
			},
			dataType : "text",
			//입력값이 저장된 변수를 emailcheck.do로 전송
			success:function(data){
				if(email !=''){
				//email영역에 값이있을때
					if(data == '1'){
						$('#checkemail').html("중복된 이메일입니다.");
						$('#loginBtn').attr("disabled",true);
						 emailresult = 0;
						 //DB와 통신이 정상적으로 이루어졌고 결과값이 1일때
						 //1은 중복일 경우에 넘어오는 값이므로 span영역에 중복 경고문구
						 //업데이트버튼 관련 변수에 0값 주입
					}else{
						$('#checkemail').html("");
						$('#loginBtn').attr("disabled",false);
						emailresult = 1;
						//DB와 통신이 정상적으로 이루어졌고 결과값이 0일때
						//0은 중복된 테이블이없을때 넘어오는 값이므로 span영역을 초기화
						//업데이트 버튼 관련 변수에 1주입
						if(emailresult ==1 && nickresult ==1){
							$('#loginBtn').attr('disabled', false);
							//만약 emailresult, nickresult값이 둘다 모두 1일때
							// 업데이트 버튼 활성화
						}else{
							$('#loginBtn').attr('disabled', true);
							//만약 emailresult, nickresult값이 둘다 모두 1이 아닐때
							// 업데이트 버튼 비활성화
						}
					}
				}else{
					$('#checkemail').html("이메일을 입력해주세요.");
					$('#loginBtn').attr('disabled', true);
					//이메일 입력영역이 비어있을때  span태그에 입력요청문구 
					//업데이트 버튼 비활성화
				}
			},
			error : function(data){
				alert("통신오류 " + data);
				//DB와 통신이 이루어지지 못했을때 경고창 발생
			}
		});
	});
	
});

</script>
<body>
		<jsp:include page="/resources/include/member_navigation.jsp" />

	 <!--  section01 -->
	<header class="masthead bg-primary text-white text-center">
    <div class="container d-flex align-items-center flex-column">
      <c:set var="dto" value="${dto }" ></c:set>
      <h3 class="masthead-heading text-uppercase mb-0">${dto.getName() }님의 정보 수정페이지</h3>
      
      <div id="loginDiv" align="center" style="width: 100%">
      <form method="post" onsubmit="return formcheck()" action="<%=request.getContextPath()%>/memberupdateOK.do">
      <input type="hidden" name="id" value="${dto.getId() }">
      <table>
          <tr>
      	  <th style="padding-right: 100px">Name</th>
      	   <td>${dto.getName() }</td>
      	  </tr>
      	  <tr>
      	  <th>I   D</th>
      	   <td>${dto.getId() }</td>
      	  </tr>
      	  <tr>
      	  <th>Nickname</th>
      	   <td><input name="nickname" id="nickname" style="width: 160px" value="${dto.getNickname() }">
      	   <br><span style="font-size: 12px; color: red;" id="checknick"></span> </td> 
      	  </tr>
      	  <tr>
      	  <th>Email</th>
      	   <td><input name="email" id="email" style="width: 160px"  value="${dto.getEmail() }" > 
      	   <br><span style="font-size: 12px; color: red;" id="checkemail"></span> </td>
      	  </tr>
      	</table>
        	<input type="submit" id="loginBtn" value="수정된정보로 등록" >
        	<input type="button" id="loginBtn" value="돌아가기"  onclick="history.back()">
      	</form>
      </div>
    </div>
  </header>
  </head>
  
  <jsp:include page="/resources/include/footer.jsp" />
  <jsp:include page="/resources/include/copyright.jsp" />
  <jsp:include page="/resources/include/modals.jsp" />
</body>
</html>