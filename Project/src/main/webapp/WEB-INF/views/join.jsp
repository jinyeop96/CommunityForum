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
<script src="http://code.jquery.com/jquery-3.4.1.js"></script> <!-- JQuery사용을 위한 라이브러리 다운로드 -->
<script src="./resources/js/join.js" ></script>  <!-- Join.jsp에서 사용될 함수가 저장된 라이브러리로드 -->
<script >
$(function(){
	
	
	
	$("#idcheck").click(function(){
		var id = $("#id").val();
		if(id!=''){
			if(id.length < 5){
				$("#id_leng").html("아이디는 4자 이상 최대16자리까지만 가능합니다.");
				
			}else{
				$.ajax({
					url:"idcheck.do",
					type : "post",
					data : {
						id : id
					},
					dataType : "text",
					
					success:function(data){
						
						console.log(data);
						
						if(data == '1'){
							alert("중복된 아이디입니다.");
							$("#id_leng").html("");
							$('#c_pwd').attr("readonly",true);
						
							
						}else{
							alert("사용가능한 아이디입니다.");
							$("#id_leng").html("");
							$('#c_pwd').attr("readonly",false);
							
						}
					},
					error : function(data){
						alert("오류 "+data);
					}
				});
			}
		
		}else{
			alert("아이디를 입력해주세요");
		}
	});
	
	$("#nickname").keyup(function(){
		var nickname;
		nickname=$('#nickname').val();
		$.ajax({
			url :"nickcheck.do",
			type : "post",
			data : {
				nickname : nickname
			},
			dataType : "text",
			success:function(data){
				if(nickname !=''){
				
					if(data == '1'){
						$('#checknick').html("중복된 닉네임입니다.");
						$('#nickjoin').attr('disabled', true);
						
					}else{
						$('#checknick').html("");
						$('#nickjoin').attr('disabled', false);
						
					}
					
				}else{
					$('#checknick').html("닉네임 입력해주세요.");
				}
				
			},
			error : function(data){
				alert("통신오류 " + data);
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
      	<table style="width: 100%">
      
      	
      		<tr>
      			<td colspan="2"  align="center"><input class="input" name="id" id="id"  maxlength="16" placeholder="아이디입력(영,숫자조합)" onkeyup="this.value=this.value.replace(/[^a-z0-9]/gi,'');"  > <input type="button" id="idcheck" value="중복검사">
      			<br><span style='font-size: 12px; color: red;' id='id_leng'></span>

      			</td> 
      		</tr>
      		
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
      		
      		<tr>
      			
      			<td colspan="2"  align="center"><input class="input" style="margin-right: 85px"   name="name" id="name" placeholder="이름입력" ></td> 
      		</tr>
      		
      		<tr>
      			
      			<td colspan="2"  align="center"><input class="input" style="margin-right: 85px"   name="nickname" id="nickname" placeholder="닉네임입력" >
      			<br><span style="font-size: 12px; color: red;" id="checknick"></span>

      			
      			</td> 
      		</tr>
      		
      		<tr>
      			<td colspan="2"  align="center"><input class="input" name="email" id="email"  style="margin-right: 85px" placeholder="메일주소입력" >
      			</td> 
      			</table>
      	<input  type="submit" value="가입하기" disabled="disabled" id="nickjoin">&nbsp;&nbsp;
      	<input type="button" value="돌아가기" onclick="history.back();"> 
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