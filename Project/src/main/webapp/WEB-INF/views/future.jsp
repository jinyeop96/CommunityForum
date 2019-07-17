<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>future</title>
<script src="<c:url value='/resources/jquery-3.4.1.js' />"></script>

</head>

	  <jsp:include page="/resources/include/banner.jsp"/>
	
	<jsp:include page="/resources/include/navigation.jsp" />
	
	<header class="masthead bg-primary text-white text-center">
    <div class="container d-flex align-items-center flex-column">
    
    	<h1 class="masthead-heading text-uppercase mb-0">프로젝트의 미래</h1> 
    	
    	<br><br>
    	
    	<h4>현역 군인들을 위해 처음 개발을 목적으로 시작되었지만 점차 그 주변인들과 전역자들 모두가 이용할 수 있게 확장 되었습니다.</h4><br>
    	<h4>프로젝트가 확장되면 지금 제공되고 있는 기능들의 업데이트를 중심으로 더욱 더 다양한 기능을 제공할 예정입니다.</h4><br>
    	<h4>저희의 프로젝트로 인해 폐쇄적인 환경에서 활동하며 청춘을 나라를 위해 바치고 있는 젊은 청년들에게 조금이나마 도움이 되었으면 합니다.</h4>
    
    </div>
    </header>
  
  <a id="topBtn"><img src="resources/img/portfolio/up.png" width="10" height="10" alt="upButton" class="names">TOP</a>
  
  <jsp:include page="/resources/include/footer.jsp" />
  <jsp:include page="/resources/include/copyright.jsp" />
  <jsp:include page="/resources/include/modals.jsp" />	<%-- modal.jsp 끝에 js 파일 있어서 반응형 웹이 됩니다~ 마지막에 꼭 넣으십쏘~ --%>

</html>
