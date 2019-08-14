<%@page import="java.math.BigInteger"%>
<%@page import="java.security.SecureRandom"%>
<%@page import="java.net.URLEncoder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>

<meta name = "google-signin-client_id" content="811363179923-l5jjuf3mjdrnrdmvl534rubl31frp24e.apps.googleusercontent.com">

<script src="<c:url value='/resources/jquery-3.4.1.js' /> "></script>
<script src="//developers.kakao.com/sdk/js/kakao.min.js"></script>
<script src="https://apis.google.com/js/platform.js" async defer></script>

<%	//네이버 로그인
	String getUrl = request.getRequestURL().toString();
	String[] currUrl = getUrl.split("/");
	String reUrl = currUrl[0] + "//" + currUrl[2] + "/" + currUrl[3] + "/naver/callback.do";
	System.out.println("reUrl = " + reUrl);

	String clientId = "j8R_N6PAsO7uCvkZDq3n";//애플리케이션 클라이언트 아이디값";
   	String redirectURI = URLEncoder.encode(reUrl, "UTF-8");
	SecureRandom random = new SecureRandom();
	String state = new BigInteger(130, random).toString();
	String apiURL = "https://nid.naver.com/oauth2.0/authorize?response_type=code";
	apiURL += "&client_id=" + clientId;
	apiURL += "&redirect_uri=" + redirectURI;
	apiURL += "&state=" + state;
	session.setAttribute("state", state);
%>

		<table>
	   		<tr>
				<td>	<!-- 네이버 -->
					<a href="<%=apiURL%>"><img width="235" height="50" src="<c:url value='/resources/img/login/naverLogin.PNG'/>"/></a>
				</td>
			</tr>
			
			<tr>
				<td>	<!-- 카카오 -->
				    <a href="javascript:loginWithKakao()"><img width="235" src="<c:url value='/resources/img/login/kakaoLogin.png'/>"></a>
				</td>
			</tr>
			
			<tr>
				<td colspan="2"> <!-- 구글 -->
				    <div align="center" class="g-signin2" data-width="235" data-height="43"  data-onsuccess="onSignIn" data-theme="dark"></div>
				</td>
			</tr>
			
			<tr> 
				<td>	<!-- 페이스북 -->
					<div id="fb-root"></div>	
					<script async defer crossorigin="anonymous" src="https://connect.facebook.net/ko_KR/sdk.js#xfbml=1&version=v3.3&appId=420903221845504&autoLogAppEvents=1"></script>
					<div class="fb-login-button" data-height="50" scope="public_profile,email" onlogin="checkLoginState();" 
						 data-width="" data-size="large" data-button-type="login_with" data-auto-logout-link="false" data-use-continue-as="false"></div>
				</td>
			</tr>	 
	   </table> 
	   
	   
	<script type="text/javascript">
		//카카오
		Kakao.init('fa5422f3d426ecd7023329085641e7dc');
		function loginWithKakao() {
		  Kakao.Auth.login({
		    success: function(authObj) {
		    	 Kakao.API.request({
		    	       url: '/v1/user/me',
		    	       success: function(res) {
		    	    	   	console.log(res);
		    	    	     var kakaonick = res.kaccount_email;
		    	             var kakaoemail = res.kaccount_email;
		    	             location.href="loginAPIOk.do?nickname="+kakaonick+"&email="+kakaoemail;
		    	           }
		    	         })
		
		    },
		    fail: function(err) {
		      alert(JSON.stringify(err));
		    }
		  });
		};
		
		//구글
		function onSignIn(googleUser) {
			  var profile = googleUser.getBasicProfile();
			  var gname = profile.getEmail();
			  var gemail = profile.getEmail();
			  var auth2 = gapi.auth2.getAuthInstance();
			  auth2.disconnect();
		        location.href="loginAPIOk.do?nickname="+gname+"&email="+gemail;
		}
	
		
		// 페이스북
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
					  location.href="loginAPIOk.do?nickname="+response.email+"&email="+response.email;
				  });
			    } else {
			      // The person is not logged into your app or we are unable to tell.
			      document.getElementById('status').innerHTML = 'Please log ' +
			        'into this app.';
			    }
		  }
		  
		</script>