<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name = "google-signin-client_id" content="811363179923-l5jjuf3mjdrnrdmvl534rubl31frp24e.apps.googleusercontent.com">
<title>Login</title>
<script src="<c:url value='/resources/jquery-3.4.1.js' /> "></script>
<style type="text/css">
	.find{
		color: white;
	}
	.find:hover{
		font-style: italic;
	}
</style>
<script src="<c:url value='/resources/js/login.js'/>" ></script>
<script src="//developers.kakao.com/sdk/js/kakao.min.js"></script>
<script src="https://apis.google.com/js/platform.js" async defer></script>
</head>
	<jsp:include page="/resources/include/navigation.jsp" />


	 <!--  section01 -->
	<header class="masthead bg-primary text-white text-center">
    <div class="container d-flex align-items-center flex-column">
      
      <h1 class="masthead-heading text-uppercase mb-0">로그인</h1>
      <div id="loginDiv" align="center">
      <!-- 일반 로그인 -->
      <form onsubmit="return loginformchk()" action="<%=request.getContextPath()%>/loginok.do" method="post">
      	<table>
      		<tr>
      			<td><input class="input" name="id" id ="id" placeholder="user ID"></td> 
      		</tr>
      		
      		<tr>
      			<td><input class="input" type="password" name="pwd" id="pwd" placeholder="password" ></td>
      		</tr>
      	</table>
      	
      	<input id="loginBtn" type="submit" value="Login"><br>
      	<a href="javascript:void(0)" class="find"  onclick="location.href='id_search.do'">find id</a>&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;  
      	<a href="javascript:void(0)" class="find" onclick="location.href='pwd_search.do'">find pwd</a> 
      	</form>
      </div> 
        
       <!-- 로그인 api 불러오기 -->
      	<table id="loginAPI"></table>
  
  		<script type="text/javascript">
  			$(function(){
  				$("#loginAPI").load("loginAPI.do");
  			})
  		</script>
        
        
        
  </div>
</header>
  
  
  <jsp:include page="/resources/include/footer.jsp" />
  <jsp:include page="/resources/include/copyright.jsp" />
  <jsp:include page="/resources/include/bottomJs.jsp" />	<%-- modal.jsp 끝에 js 파일 있어서 반응형 웹이 됩니다~ 마지막에 꼭 넣으십쏘~ --%>

</html>