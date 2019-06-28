<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>plan</title>
<script src="<c:url value='/resources/jquery-3.4.1.js' /> "></script>
</head>
 <body>
	<jsp:include page="/resources/include/navigation.jsp" />
	
	<header class="masthead bg-primary text-white text-center">
    <div class="container d-flex align-items-center flex-column">
    
    <h1 class="masthead-heading text-uppercase mb-0">기획의도</h1>
    
    <br><br>
    <h4>군인 - 국민 대통합 프로젝트!!!</h4><br>
    <h4>나라를 지키며 고생하는 청춘들과 그 청춘들을 애타게 걱정하며 무사를 기원하는 모든 분들을 위해 오와열 프로젝트는 개발되었습니다.</h4><br>
    <h4>군대를 갔다온 전역자 입장으로써 전/현직 군인들이 공감할 수 있는 내용들과 모두가 공감대를 공유할 수 있는 소통의 장을 제공하여 
    	모두에게 기쁨을 줄 수 있도록 방향성을 잡고 오와열은 시작되었습니다.</h4><br>
    <h4>오와열 프로젝트를 통해 현역과 그의 주변인들에게는 연락의 연결망, 전역자들에게는 추억을 나눌 수 있는 오와열이 되었으면 합니다.
    </h4>
    
    </div>
   
    </header>
    </body>
    
  
  <jsp:include page="/resources/include/footer.jsp" />
  <jsp:include page="/resources/include/copyright.jsp" />
  <jsp:include page="/resources/include/modals.jsp" />	<%-- modal.jsp 끝에 js 파일 있어서 반응형 웹이 됩니다~ 마지막에 꼭 넣으십쏘~ --%>

</html>
