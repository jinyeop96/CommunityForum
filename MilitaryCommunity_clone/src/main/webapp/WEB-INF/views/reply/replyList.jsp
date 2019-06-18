<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>	<%-- 줄바꿈 function --%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
</head>
<body>
	<%pageContext.setAttribute("newLineChar", "\n"); %>	<%-- \n -> newLineChar로 --%>
	<%------------------가져온 게시물의 답변글이 있다면-------------- --%>
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
     			<c:if test="${!empty reply.getE_reply_indent() }">	<%-- indent 만큼 띄어쓰기를 해줄거임. --%>
					<c:forEach begin="1" end="${reply.getE_reply_indent() }" step="1">
	      				&nbsp;&nbsp;&nbsp;
	      			</c:forEach>
     			</c:if>
     			<c:set var="replyStr" value="${fn:replace(reply.getE_reply_content(), '  ', '&nbsp;&nbsp;' ) }"></c:set>	<%-- 공백 가능하게 처리해줌 --%>
      			${fn:replace(replyStr , newLineChar, "<br>")} 	<!-- \n를 해주는 과정 --> 
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
</body>
</html>