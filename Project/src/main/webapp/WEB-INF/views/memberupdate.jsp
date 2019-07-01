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
						$('#loginBtn').attr("disabled",true);
						
						
					}else{
						$('#checknick').html("");
						$('#loginBtn').attr("disabled",false);
						
						
					}
					
				}else{
					
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
      <c:set var="dto" value="${dto }" ></c:set>
      <h3 class="masthead-heading text-uppercase mb-0">${dto.getName() }님의 정보페이지</h3>
      
      <div id="loginDiv" align="center" style="width: 100%">
      <form method="post" onsubmit="return formcheck()" action="<%=request.getContextPath()%>/memberupdateOK.do">
      <input type="hidden" name="id" value="${dto.getId() }">
      <table>
<tr>
      	  <th>이름</th>
      	   <td>${dto.getName() }</td>
      	   
      	  </tr>
      	  <tr>
      	  <th>아이디</th>
      	   <td>${dto.getId() }</td>
      	  </tr>
      	  <tr>
      	  <th>닉네임</th>
      	   <td><input name="nickname" id="nickname" value="${dto.getNickname() }">
      	   <br><span id="checknick"></span> </td> 
      	  </tr>
      	  <tr>
      	  <th>이메일</th>
      	   <td><input name="email" id="email" value="${dto.getEmail() }">  </td>
      	  </tr>
      	</table>
        	<input type="submit" id="loginBtn" value="수정된정보로 등록" disabled="">
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