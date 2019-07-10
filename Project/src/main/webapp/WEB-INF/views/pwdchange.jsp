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

<script type="text/javascript">

</script>
<script src="./resources/js/login.js" ></script>
<title>Login</title>
<script src="http://code.jquery.com/jquery-3.4.1.js"></script> <!-- JQuery사용을 위한 라이브러리 다운로드 -->
<body>
		<jsp:include page="/resources/include/member_navigation.jsp" />

	 <!--  section01 -->
	<header class="masthead bg-primary text-white text-center">
    <div class="container d-flex align-items-center flex-column">
      <c:set var="dto" value="${dto }" ></c:set>
      <h3 class="masthead-heading text-uppercase mb-0">${dto.getName() } Password Change</h3>
      
      <div id="loginDiv" align="center" style="width: 100%">
      <form method="post" action="<%=request.getContextPath()%>/pwdchangeOK.do">
      <input type="hidden" name="id" value="${dto.getId() }">
      <table>
      	  <tr>
      	   <td><input type="password" name="pwd" id="pwd" placeholder="변경할비밀번호입력" style="width: 160px" onkeyup="PwdLength()">
      	   <br><span style='font-size: 12px; color: red;' id="pwd_leng"  ></span> </td> 
      	  </tr>
      	  
      	  <tr>
      	   <td><input type="password" id="c_pwd" placeholder="비밀번호확인" style="width: 160px" onkeyup="PwdChk()">
      	   <br><span style='font-size: 12px; color: red;' id="pwd_chk"  ></span> </td> 
      	  </tr>
      	  
      	</table>
        	<input type="submit"  value="비밀번호 변경"  id="changeBTN" disabled="disabled" >
        	<input type="button"  value="돌아가기"  onclick="history.back()">
        	
        

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