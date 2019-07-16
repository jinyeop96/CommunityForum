<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<title>오와열</title>

  
 

</head>
<body> 
	
	<%-- 
		resources 폴더에 css, image, js, jsp 등등 들어 있음. jsp 파일 불러오기는 아래와 같이 하시고~
	
		그 외 css, image, js 등은 
		 *중요! <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> jstl 사용 해주고
		 <c:url value="/resources/~~~/~~.css" />   	<= url에 요런 느낌으로 해주면 매핑 되어있어서 어디서든 쓸 수 있슴다
		 
		페이지 만들어 나가면서 <body></body> 는 include 하면 navigation.jsp 와 modals.jsp에 들어있으니까 빼도 되고
		modals.jsp도 마지막!!!에 꼭 넣어주셔요 js 파일들이 다 들어있는 곳이어서 넣어줘야 반응형 웹이 된답니다
	 --%>
	<jsp:include page="/resources/include/navigation.jsp" flush="false" />
	<jsp:include page="/resources/include/masthead.jsp" flush="false" />
	<jsp:include page="/resources/include/carousel.jsp" flush="false"/>
	<jsp:include page="/resources/include/section01.jsp" flush="false" />
	<jsp:include page="/resources/include/section02.jsp" flush="false" />
	<jsp:include page="/resources/include/section03.jsp" flush="false" />
	<jsp:include page="/resources/include/footer.jsp" flush="false" />
	<jsp:include page="/resources/include/copyright.jsp" flush="false" /> 
	<jsp:include page="/resources/include/bottomJs.jsp" flush="false" /> 
	<jsp:include page="/resources/include/banner.jsp" flush="false" /> 
  
	
</body>


</html>










