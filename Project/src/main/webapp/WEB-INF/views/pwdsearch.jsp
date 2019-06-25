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
	
	
	if($('#j_id').val()  ==""){
		alert("아이디을 입력해주세요");
		$('#j_id').focus();
		return ;
	}
	
	if($('#j_mobile').val()  ==""){
		alert("연락처를 입력해주세요");
		$('#j_mobile').focus();
		return ;
	}
	
	var id =$('#j_id').val();
	var number = $('#j_mobile').val();
	var memdata = {'j_id' : id, 'j_mobile' : number};
	alert (id);
	alert (number);
	
	$.ajax({
		url : "searchpwdOK.do",
		type : "post",
		data : memdata,
		dataType : "text",
		success:function(data){
			if(data !=""){
				alert("회원님의 비밀번호는"+data+"입니다.");	
			}else{
				alert("아이디와 연락처를 확인해주세요.")
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
      			<td><input class="input" name="j_id" id ="j_id"></td> 
      		</tr>
      		
      		<tr>
      			<th>MobileNumber</th>
      			<td><input class="input"  name="j_mobile" id="j_mobile" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');" ></td>
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