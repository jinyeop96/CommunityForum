<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
      			<table class="board">
		      		<tr class="t2">
		      			<th class="content-title	">${dto.getEntire_title() }</th>
		      		</tr>
		      		
		      		<tr class="t2">
		      			<td class="t3">${dto.getEntire_nickname() }</td>
		      		</tr>
		      		
		      		<tr>
		      			<td class="t3">${dto.getEntire_date() } </td>
		      		</tr>
		      		
		      		<tr>
		      			<td class="t3">조회수  : ${dto.getEntire_view() }</td> 
		      		</tr>
		      		
		      		<tr>
		      			<td class="t3">추천 : ${dto.getEntire_like() }</td> 
		      		</tr>
		      				      		
		      		<tr>
		      			<td class="t3">비추천 : ${dto.getEntire_dislike() }</td> 
		      		</tr>
		      				      		
		      		<tr>
		      			<td class="t3">답글 : ${dto.getEntire_reply() }</td> 
		      		</tr>
		      		
		      		<tr>
		      			<td><hr></td>
		      		</tr>
		      		
		      		<tr>
		      			<td>${dto.getEntire_content() }</td>
		      		</tr>	
		      		
		      		<tr>
		      			<td><hr></td>
		      		</tr>
		      		
		        </table>
				
				<table class="board"> <%-- table : 선 긋기, table-hover : 마우스 올렸을 때 색변화 --%>
		      		<%------------------가져온 전체 게시물 있다면-------------- --%>
		      		<c:if test="${!empty list }">
		      			<%-- 가져온 게시물 뿌려주기 --%>
			      		<c:forEach items="${list }" var="reply">
			      			
				      		<tr>
				      			<th>
				      				<c:if test="${!empty reply.getE_reply_indent() }">
										<c:forEach begin="1" end="${reply.getE_reply_indent() }" step="1">
						      				>
						      			</c:forEach>
				      				</c:if>
				      				${reply.getE_reply_nickname() }
				      			</th>
				      			<td>좋아요 : ${reply.getE_reply_like() }</td>
				      			<td>싫어요 : ${reply.getE_reply_dislike() }</td>
				      			<td >${reply.getE_reply_date() }</td>
				      		</tr>
							
				      		<tr><td colspan="4">
				      			<c:if test="${!empty reply.getE_reply_indent() }">
									<c:forEach begin="1" end="${reply.getE_reply_indent() }" step="1">
					      				&nbsp;&nbsp;&nbsp;
					      			</c:forEach>
				      			</c:if>

					      		${reply.getE_reply_content() }
				      		</td></tr>
				      		
			      		
							<tr><td colspan="4">
								<c:if test="${reply.getE_reply_indent() >= 2 }">
									<hr style="border: none; border-top: 3px dotted blue;">
								</c:if>
								<c:if test="${reply.getE_reply_indent() == 1 }">
									<hr>
								</c:if>
							</td></tr>
								    
			      		</c:forEach>
			      	</c:if>
		        </table> 
		        
				<form action="replySave.do">
					<input type="hidden" name="no" value="${dto.getEntire_no() }">
			        <table class="board">
			        	<tr>
			        		<td><textarea class="board reply-board" rows="4"  placeholder="댓글 쓰기" name="e_reply_content" ></textarea></td>
			        	</tr>
			        	<tr>
			        		<td colspan="2" align="right">
			        			nickname : <input name="e_reply_nickname">
				        		<input type="submit" value="저장">
		        			</td>
			        	</tr>
			        	<tr>
			        		<td><hr></td>
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