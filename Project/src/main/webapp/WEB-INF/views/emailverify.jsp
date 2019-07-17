<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>IdSearch</title>
</head>
	<jsp:include page="/resources/include/navigation.jsp" />
<script type="text/javascript">
$(function(){ 
	

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
					$('#emailcheck').html("");
					$('#loginBtn').attr('disabled', false);
				}else{
					$('#emailcheck').html("가입되지않은 이메일입니다");
					$('#loginBtn').attr('disabled', true);
				}
				
			}else{
				$('#emailcheck').html("이메일을 입력해주세요.");
				//email입력란이 비어있을 경우 span태그에 이메일입력안내문구 삽입
				$('#loginBtn').attr('disabled', true);
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
	


	 <!--  section01 -->
	<header class="masthead bg-primary text-white text-center">
    <div class="container d-flex align-items-center flex-column">
      
      <h1 class="masthead-heading text-uppercase mb-0">Find PassWord</h1>
      <div id="loginDiv">
      <form method="post" action="<%=request.getContextPath()%>/reverify.do">
      	<table>
      		<tr>
      			<th>EmailAdress</th>
      			<td><input class="input"  name="email" id="email" >
      			<br><span style="font-size: 12px; color: red;" id="emailcheck"></span>
      			</td>
      		</tr>
      	</table>
      	<input id="loginBtn" type="submit" value="Verify email Send" ><br>
      	<input  id="loginBtn" type="button" value="Login_page" onclick="location.href='login.do'">
      	</form>
      </div>
    </div>
  </header>
  
  
  <jsp:include page="/resources/include/footer.jsp" />
  <jsp:include page="/resources/include/copyright.jsp" />
  <jsp:include page="/resources/include/modals.jsp" />	<%-- modal.jsp 끝에 js 파일 있어서 반응형 웹이 됩니다~ 마지막에 꼭 넣으십쏘~ --%>

</html>