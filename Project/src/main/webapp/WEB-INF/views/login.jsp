<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.net.URLEncoder" %>
<%@ page import="java.security.SecureRandom" %>
<%@ page import="java.math.BigInteger" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
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
<script src="./resources/js/login.js" ></script>
<script src="//developers.kakao.com/sdk/js/kakao.min.js"></script>

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

   <%	//네이버 로그인
	    String clientId = "j8R_N6PAsO7uCvkZDq3n";//애플리케이션 클라이언트 아이디값";
	    String redirectURI = URLEncoder.encode("http://localhost:8054/controller/naver/callback.do", "UTF-8");
	    SecureRandom random = new SecureRandom();
	    String state = new BigInteger(130, random).toString();
	    String apiURL = "https://nid.naver.com/oauth2.0/authorize?response_type=code";
	    apiURL += "&client_id=" + clientId;
	    apiURL += "&redirect_uri=" + redirectURI;
	    apiURL += "&state=" + state;
	    session.setAttribute("state", state);
	%>
    	<a href="<%=apiURL%>"><img height="50" src="http://static.nid.naver.com/oauth/small_g_in.PNG"/></a>
    	
    	<!-- 카카오 로그인 -->
        <a id="kakaologinbtn" href="javascript:loginWithKakao()"><img src="./resources/img/kakao.png"></a>
        
        <script type='text/javascript'>
            Kakao.init('fa5422f3d426ecd7023329085641e7dc');
    		function loginWithKakao() {
  
      			Kakao.Auth.login({
			        success: function(authObj) {
			        	Kakao.API.request({
			        		url: '/v1/user/me',
			        	    success: function(res) {
			               		var kakaonick = res.properties.nickname;
			               		alert(res.properties.nickname);
			               		
			               		location.href="kakao.do?kakaonick="+kakaonick;
			        	    }
       	         		})
	        		},
	        		fail: function(err) {
	          			alert(JSON.stringify(err));
	        		}
	      		});
		    };
		</script>
		
		
		<!-- 페이스북 로그인 -->
		<div id="fb-root"></div>
		<script async defer crossorigin="anonymous" src="https://connect.facebook.net/ko_KR/sdk.js#xfbml=1&version=v3.3&appId=420903221845504&autoLogAppEvents=1"></script>
		<div class="fb-login-button" scope="public_profile,email" onlogin="checkLoginState();"
			 data-width="" data-size="large" data-button-type="login_with" data-auto-logout-link="false" data-use-continue-as="false"></div>
		
		<div id="status"></div>
		<script>
		  window.fbAsyncInit = function() {
		    FB.init({
		      appId      : '420903221845504',
		      cookie     : true,
		      xfbml      : true,
		      version    : 'v3.3'
		    });
		      
		    FB.AppEvents.logPageView();   
		    FB.getLoginStatus(function(response) {
			    console.log("FB.getLoginStatus");
			    console.log(response);
		    });
		      
		  };
		
		  (function(d, s, id){
		     var js, fjs = d.getElementsByTagName(s)[0];
		     if (d.getElementById(id)) {return;}
		     js = d.createElement(s); js.id = id;
		     js.src = "https://connect.facebook.net/en_US/sdk.js";
		     fjs.parentNode.insertBefore(js, fjs);
		   }(document, 'script', 'facebook-jssdk'));
		  
		  
		  function checkLoginState() {
		    FB.getLoginStatus(function(response) {
		      statusChangeCallback(response);
		    });
		  }
		  
		  function statusChangeCallback(response) {
			    console.log('statusChangeCallback');
			    console.log(response);
			    // The response object is returned with a status field that lets the
			    // app know the current login status of the person.
			    // Full docs on the response object can be found in the documentation
			    // for FB.getLoginStatus().
			    if (response.status === 'connected') {
			      // Logged into your app and Facebook.
			      FB.api('/me', {fields : "email, name"},  function(response) {
					  console.log(JSON.stringify(response));
					  location.href="facebookLogin.do?name="+response.name+"&email="+response.email;
				  });
			    } else {
			      // The person is not logged into your app or we are unable to tell.
			      document.getElementById('status').innerHTML = 'Please log ' +
			        'into this app.';
			    }
			  }
		  

		  
		</script>
		
    </div>
    
    
  </header>
  
  

  
  
  <jsp:include page="/resources/include/footer.jsp" />
  <jsp:include page="/resources/include/copyright.jsp" />
  <jsp:include page="/resources/include/modals.jsp" />	<%-- modal.jsp 끝에 js 파일 있어서 반응형 웹이 됩니다~ 마지막에 꼭 넣으십쏘~ --%>

</html>