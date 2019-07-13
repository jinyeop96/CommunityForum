<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Login</title>
<script src="<c:url value='/resources/jquery-3.4.1.js' /> "></script>
<script type="text/javascript" src="https://static.nid.naver.com/js/naverLogin_implicit-1.0.3.js" charset="utf-8"></script>
<style type="text/css">
	.find{
		color: white;
	}
	.find:hover{
		font-style: italic;
	}
</style>
<script src="./resources/js/login.js" ></script>
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
      
      <div id="naver_id_login"></div>
      
    </div>
  </header>
  
   <script type="text/javascript">
	  	var naver_id_login = new naver_id_login("j8R_N6PAsO7uCvkZDq3n", "http://localhost:8054");
	  	var state = naver_id_login.getUniqState();
	  	naver_id_login.setButton("white", 2,40);
	  	naver_id_login.setDomain("http://127.0.0.1:8054");
	  	naver_id_login.setState(state);
	  	naver_id_login.setPopup();
	  	naver_id_login.init_naver_id_login();
  </script>

  
  
  <jsp:include page="/resources/include/footer.jsp" />
  <jsp:include page="/resources/include/copyright.jsp" />
  <jsp:include page="/resources/include/modals.jsp" />	<%-- modal.jsp 끝에 js 파일 있어서 반응형 웹이 됩니다~ 마지막에 꼭 넣으십쏘~ --%>

</html>