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
    	
        <a id="kakaologinbtn" href="javascript:loginWithKakao()"><img src="./resources/img/kakao.png"></a>
        <input type="button" value="문의메일쓰기" onclick="location.href='<%=request.getContextPath()%>/mailpage.do'">
        
        <script type='text/javascript'>
           Kakao.init('fa5422f3d426ecd7023329085641e7dc');
    function loginWithKakao() {
  
      Kakao.Auth.login({
        success: function(authObj) {
        	 Kakao.API.request({
        	       url: '/v1/user/me',
        	       success: function(res) {
        	             var kakaonick = res.properties.nickname;
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
        
    		    
      
      	<div id="fb-root"></div>
		<div class="fb-login-button"  data-width="" data-size="large" data-button-type="login_with" data-auto-logout-link="false" data-use-continue-as="false"></div>
    </div>
  </header>
 	<script async defer crossorigin="anonymous" src="https://connect.facebook.net/ko_KR/sdk.js#xfbml=1&version=v3.3&appId=420903221845504&autoLogAppEvents=1"></script>
  <script type="text/javascript">

  </script>
  
  

  
  
  <jsp:include page="/resources/include/footer.jsp" />
  <jsp:include page="/resources/include/copyright.jsp" />
  <jsp:include page="/resources/include/modals.jsp" />	<%-- modal.jsp 끝에 js 파일 있어서 반응형 웹이 됩니다~ 마지막에 꼭 넣으십쏘~ --%>

</html>