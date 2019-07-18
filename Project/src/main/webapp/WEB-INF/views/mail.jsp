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
	div{
			  display: inline-block;
  vertical-align: middle;
  top:50%;
  left:50%;
		}

</style>
<script src="./resources/js/login.js" ></script>
<script src="//developers.kakao.com/sdk/js/kakao.min.js"></script>
<script src="./resources/js/mail.js" ></script>

</head>

	 <jsp:include page="/resources/include/banner.jsp"/>

	<jsp:include page="/resources/include/navigation.jsp" />


	 <!--  section01 -->
	<header class="masthead bg-primary text-white text-center">
    <div class="container d-flex align-items-center flex-column">
      
    <h1 class="masthead-heading text-uppercase mb-0">문의사항 이메일</h1> 
      <div id="loginDiv" align="center">


      <form onsubmit="return mailformchk()" method = "post" action="<%=request.getContextPath()%>/mailtest.do">
      	<input type="hidden" name = "tomail" value="owa101010@gmail.com" >
      	<c:if test="${!empty email }">
      	<input type="hidden" name = "frommail" value="${email }" >
      	</c:if>

    <table>
        <c:if test="${empty email }">
  		  <tr>
       		<td><input name = "frommail" style="width:262px;" placeholder="답변받을 메일주소" ></td>
        </tr>
      </c:if>
      	
        	<tr>
              	<td> <input name = "mailtitle" id ="mailtitle" style="width:262px;" placeholder="문의제목" "> </td>
            </tr>
            
            <tr>
               	<td> <textarea name = "mailcont" id ="mailcont" cols="30px" rows="10px" style="resize: none" placeholder="문의내용"></textarea> </td>
            </tr>  	

            
            <tr>
              <td colspan="2" align="center">
              <input type="submit" id="loginBtn" value="메일보내기"> <br>
              <input type="submit" id="loginBtn" value="돌아가기" onclick="history.back()">
              </td>
            </tr>
          </table>
       	</form>


      </div> 
    </div>
  </header>
  
  

  
  
  <jsp:include page="/resources/include/footer.jsp" />
  <jsp:include page="/resources/include/copyright.jsp" />
  <jsp:include page="/resources/include/modals.jsp" />	<%-- modal.jsp 끝에 js 파일 있어서 반응형 웹이 됩니다~ 마지막에 꼭 넣으십쏘~ --%>

</html>