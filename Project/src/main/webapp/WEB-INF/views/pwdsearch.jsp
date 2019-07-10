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

function searchBtn(){
	
	
	if($('#id').val()  ==""){
		alert("아이디을 입력해주세요");
		$('#id').focus();
		return ;
	}
	
	if($('#email').val()  ==""){
		alert("연락처를 입력해주세요");
		$('#email').focus();
		return ;
	}
	
	var id =$('#id').val();
	var email = $('#email').val();
	var memdata = {'id' : id, 'email' : email};

	
	$.ajax({
		url : "searchpwdOK.do",
		type : "post",
		data : memdata,
		dataType : "text",
		success:function(data){
			if(data !=""){
				alert("임시 비밀번호  "+data+"  로 변경되었습니다");	
			}else{
				alert("아이디와 이메일주소를 확인해주세요.")
			}
			
			
		},
		error:function(data){
			alert(data);
		}
		
	});
	
	
	
	
	
	
}

</script>
	


	 <!--  section01 -->
	<header class="masthead bg-primary text-white text-center">
    <div class="container d-flex align-items-center flex-column">
      
      <h1 class="masthead-heading text-uppercase mb-0">Find PassWord</h1>
      <div id="loginDiv">
      <form >
      	<table>
      		<tr>
      			<th>UserID</th>
      			<td><input class="input" name="id" id ="id"></td> 
      		</tr>
      		
      		<tr>
      			<th>EmailAdress</th>
      			<td><input class="input"  name="email" id="email" ></td>
      		</tr>
      	</table>
      	<input id="loginBtn" type="button" value="PwdFind" onclick="searchBtn()"><br>
      	<input  id="loginBtn" type="button" value="Login_page" onclick="location.href='login.do'">
      	</form>
      </div>
    </div>
  </header>
  
  
  <jsp:include page="/resources/include/footer.jsp" />
  <jsp:include page="/resources/include/copyright.jsp" />
  <jsp:include page="/resources/include/modals.jsp" />	<%-- modal.jsp 끝에 js 파일 있어서 반응형 웹이 됩니다~ 마지막에 꼭 넣으십쏘~ --%>

</html>