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
<body>
		<jsp:include page="/resources/include/navigation.jsp" />

	 <!--  section01 -->
	<header class="masthead bg-primary text-white text-center">
    <div class="container d-flex align-items-center flex-column">
      <h3 class="masthead-heading text-uppercase mb-0"> ${dto.getNickname() }님의 정보페이지</h3>
      
      <div id="loginDiv" align="center" style="width: 100%">
      <form method="post" action="<%=request.getContextPath()%>/memberupdate.do">
      	<table style="width: 100%">
      	  
      	  <tr>
      	  <th>Name</th>
      	   <td>${dto.getName() }</td>
      	  </tr>
      	  <tr>
      	  <th>I   D</th>
      	   <td>${dto.getId() }</td>
      	  </tr>
      	  <tr>
      	  <th>NickName</th>
      	   <td>${dto.getNickname() }</td>
      	  </tr>
      	  <tr>
      	  <th>Email Adress</th>
      	   <td>${dto.getEmail() }</td>
      	  </tr>
      	</table>
      	<input type="submit" id="loginBtn" value="회원정보 수정">
      	<input type="button" id="loginBtn" value="회원 탈퇴" onclick="location.href='member_withraw.do'">
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