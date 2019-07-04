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
		<jsp:include page="/resources/include/member_navigation.jsp" />

	 <!--  section01 -->
	<header class="masthead bg-primary text-white text-center">
    <div class="container d-flex align-items-center flex-column">
      <h3 class="masthead-heading text-uppercase mb-0"> 회원탈퇴</h3>
      
      <div id="loginDiv" align="center" style="width: 100%">
      <form method="post" action="<%=request.getContextPath()%>/memberwithrawOK.do">
         <input type="hidden" name="id" value="${dto.getId() }">
      	<table style="width: 100%">
      	  
      	  <tr>
      	   <td colspan="2" align="center">${dto.getName() }님 정말로 탈퇴하시겠습니까?</td>
      	  </tr>
      	  <tr>
      	  <td colspan="2" align="center"><input type="password" name = "pwd" placeholder="비밀번호입력"> </td>
      	  </tr>
      	</table>
      	<input type="submit" id="loginBtn" value="회원 탈퇴">
      	<input type="button" id="loginBtn" value="취소" onclick="history.back()">
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