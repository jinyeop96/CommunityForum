<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>OwyMember</title>
<script src="<c:url value='/resources/jquery-3.4.1.js' /> "></script>
</head>
	<jsp:include page="/resources/include/navigation.jsp" />
	
	<header class="masthead bg-primary text-white text-center">
    <div class="container d-flex align-items-center flex-column">
    
    	<h1 class="masthead-heading text-uppercase mb-0">O.W.Y Member</h1>
    	
    	<br><br>
    	
    	<h4>Oh jinyeop[PM] - Birth : 1996 / Good skills : everything </h4>
    	<h4>Bang sangwon - Birth : 1993 / Good skills : nothing</h4>
    	<h4>Yoo chihyuk - Birth : 1989 / Good Skills : Javascript, C++, Sql</h4>
    	<h4>Kim dokyun - Birth : 1994 / Good Skills : Unity</h4>
    	
    
    </div>
    </header>
  
  <jsp:include page="/resources/include/footer.jsp" />
  <jsp:include page="/resources/include/copyright.jsp" />
  <jsp:include page="/resources/include/modals.jsp" />	<%-- modal.jsp 끝에 js 파일 있어서 반응형 웹이 됩니다~ 마지막에 꼭 넣으십쏘~ --%>

</html>
