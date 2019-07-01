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
	
	
	if($('#name').val()  ==""){
		alert("이름을 입력해주세요");
		$('#name').focus();
		return ;
	}
	
	if($('#email').val()  ==""){
		alert("이메일주소를 입력해주세요");
		$('#email').focus();
		return ;
	}
	
	var name =$('#name').val();
	var email = $('#email').val();
	var memdata = {'name' : name, 'email' : email};

	$.ajax({
		url : "searchIdOK.do",
		type : "post",
		data : memdata,
		dataType : "text",
		success:function(data){
			if(data !=""){
				alert("회원님의 아이디는"+data+"입니다.");	
			}else{
				alert("이름과 이메일을 확인해주세요.")
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
      
      <h1 class="masthead-heading text-uppercase mb-0">Find ID</h1>
      <div id="loginDiv" align="center">
      <form >
      	<table>
      		<tr>
      			<th>UserName</th>
      			<td><input class="input" name="name" id ="name"></td> 
      		</tr>
      		
      		<tr>
      			<th>EmailAdress</th>
      			<td><input class="input"  name="email" id="email"  ></td>
      		</tr>
      	</table>
      	<input id="loginBtn" type="button" value="IdFind" onclick="searchBtn()"><br>
      		<input  id="loginBtn" type="button" value="login_page" onclick="location.href='login.do'">	<input  id="loginBtn" type="button" value="find_pwd" onclick="location.href='pwd_search.do'">
      	</form>
      </div>
    </div>
  </header>
  
  
  <jsp:include page="/resources/include/footer.jsp" />
  <jsp:include page="/resources/include/copyright.jsp" />
  <jsp:include page="/resources/include/modals.jsp" />	<%-- modal.jsp 끝에 js 파일 있어서 반응형 웹이 됩니다~ 마지막에 꼭 넣으십쏘~ --%>

</html>