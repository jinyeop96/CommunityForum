<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Content</title>
</head>
<body>
	<jsp:include page="/resources/include/navigation.jsp" />
	
		 <!--  section01 -->
		<header class="masthead bg-primary text-white text-center">
	    <div class="container d-flex align-items-center flex-column">
	      
	    	<h3 class="masthead-heading text-uppercase m	b-0">content</h3>
	      
	      	<div class="board" align="center"> 
	      		<form action="entireSearch.do" method="get">
	     			<input type="hidden" name="pageParam" value="1">
	      			 
	      			<table class="t1">
			      		<tr class="t2">
			      			<th class="t3">${dto.getEntire_title() }</th>
			      		</tr>
			      		
			      		<tr class="t2">
			      			<td class="t3">${dto.getEntire_nickname() } | </td>
			      			<td class="t3">${dto.getEntire_date() } |</td>
			      			<td class="t3">조회수  : ${dto.getEntire_view() } | </td> 
			      			<td class="t3">추천 : ${dto.getEntire_like() } | </td> 
			      			<td class="t3">비추천 : ${dto.getEntire_dislike() } | </td> 
			      			<td class="t3">답글 : ${dto.getEntire_reply() } | </td> 
			      		</tr>
			      		
			      		<tr>
			      			<td>${dto.getEntire_content() }</td>
			      		</tr>	
			      		
			        </table>
				</form>
	     	 </div>
	   	 </div>
	  </header>
	  
	  
	  <jsp:include page="/resources/include/footer.jsp" />
	  <jsp:include page="/resources/include/copyright.jsp" />
	  <jsp:include page="/resources/include/modals.jsp" />	<%-- modal.jsp 끝에 js 파일 있어서 반응형 웹이 됩니다~ 마지막에 꼭 넣으십쏘~ --%>
	
</body>
</html>