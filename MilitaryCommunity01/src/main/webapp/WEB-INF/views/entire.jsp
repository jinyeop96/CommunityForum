<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>entire</title>
</head>
<body>
		<jsp:include page="/resources/include/navigation.jsp" />
	
		 <!--  section01 -->
		<header class="masthead bg-primary text-white text-center">
	    <div class="container d-flex align-items-center flex-column">
	      
	      <h3 class="masthead-heading text-uppercase mb-0">BOrad</h3>
	      
	      <div class="board" align="center"> 
	      	<table class="t1 table table-hover"> <%-- table : 선 긋기, table-hover : 마우스 올렸을 때 색변화 --%>
	      		<tr class="t2">
	      			<td class="t3">번호</td>
	      			<td class="t3">제목</td>
	      			<td class="t3">글쓴이</td>
	      			<td class="t3">작성일</td>
	      			<td class="t3">조회</td>
	      			<td class="t3">추천</td>
	      		</tr>
	      		
	      		<c:forEach items="${list }" var="dto">
		      		<tr class="t2">
		      		
		      			<td class="t3">${dto.getEntire_no() }</td>
		      			<td class="t3"><a href="content.do?no=${dto.getEntire_no() }" style="color: #000">
		      				${dto.getEntire_title() }
		      			</a></td>
		      			<td class="t3">${dto.getEntire_nickname() }</td>
		      			<td class="t3">${dto.getEntire_date().substring(0, 10) }</td>
		      			<td class="t3">${dto.getEntire_view() }</td>
		      			<td class="t3">${dto.getEntire_like() }</td>
		      		</tr>
	      		</c:forEach>
	      	
	      	
	      
		      	<tr>
	      			<td colspan="6">
	      				<c:if test="${ page > blocks }">
							<a href="entire.do?pageParam=1" class="blocks">[◀◀]</a>
							<a href="entire.do?pageParam=${blockStart - 1}" class="blocks">[◀]</a>
						</c:if>
	      				
	      				<%-----------------Left Arrows----------- --%>
	      				
			      		<c:forEach begin="${blockStart }" end="${blockEnd }" step="1" var="i">
			      			<c:if test="${page == i }">
			      				<b>${i }</b> 
			      			</c:if>
			      			
			      			<c:if test="${page != i }">
			      				<b><a href="entire.do?pageParam=${i }" class="blocks">${i }</a></b>
			      			</c:if>
			      		</c:forEach>
			      		
			      		<%--------------------Right Arrows----------------- --%>
			      		
			      		<c:if test="${blockEnd < totalPages }">
							<a href="entire.do?pageParam=${blockEnd + 1}" class="blocks">[▶]</a>
							<a href="entire.do?pageParam=${totalPages }" class="blocks">[▶▶] </a>
						</c:if>
		      		</td>
	      		</tr>
	      </table>
	      </div>
	     
	    </div>
	  </header>
	  
	  
	  <jsp:include page="/resources/include/footer.jsp" />
	  <jsp:include page="/resources/include/copyright.jsp" />
	  <jsp:include page="/resources/include/modals.jsp" />	<%-- modal.jsp 끝에 js 파일 있어서 반응형 웹이 됩니다~ 마지막에 꼭 넣으십쏘~ --%>

</body>
</html>