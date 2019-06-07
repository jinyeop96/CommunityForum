<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Login</title>
</head>
	<jsp:include page="/resources/include/navigation.jsp" />
	

	 <!--  section01 -->
	<header class="masthead bg-primary text-white text-center">
    <div class="container d-flex align-items-center flex-column">
      
      <h1 class="masthead-heading text-uppercase mb-0">testtesttetete</h1>
      <div id="loginDiv">
      	<table>
      		<tr>
      			<th>username</th>
      			<td><input class="input" name="username"></td> 
      		</tr>
      		
      		<tr>
      			<th>password</th>
      			<td><input class="input" type="password" name="pwd" ></td>
      		</tr>
      	</table>
      	<input id="loginBtn" type="submit" value="Login">
      </div>
    </div>
  </header>
  
  
  <jsp:include page="/resources/include/footer.jsp" />
  <jsp:include page="/resources/include/copyright.jsp" />
  <jsp:include page="/resources/include/modals.jsp" />

</html>