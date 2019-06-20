<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>	<%-- 줄바꿈 function --%>

<meta charset="UTF-8">
<script src="<c:url value='/resources/jquery-3.4.1.js' /> "></script>
<style type="text/css">
	.rec{
		max-width: 21px;
		height: auto;
	}
	#inputSearch{
		width: 100%;
		max-width: 200px;
		min-width: 40px;
	}
</style>
	
	<table class="board font-black" id="replyTable"> <%-- table : 선 긋기, table-hover : 마우스 올렸을 때 색변화 --%>
	<%pageContext.setAttribute("newLineChar", "\n"); %>	<%-- \n -> newLineChar로 --%>
	<%------------------가져온 게시물의 답변글이 있다면-------------- --%>
	<c:if test="${!empty list }">
		<%-- 가져온 게시물 뿌려주기 --%>
   		<c:forEach items="${list }" var="reply">
     		<tr>
     			<th id="nickname" colspan="7">
     				<c:if test="${!empty reply.getE_reply_indent() }">
					<c:forEach begin="1" end="${reply.getE_reply_indent() }" step="1">
	      				>
	      			</c:forEach>
     				</c:if>
     				${reply.getE_reply_nickname() }
     			</th>
     		</tr>
     		
     		<tr>
     			<td colspan="2">
     				<a href="javascript:void(0)"  onclick="updateLike(${reply.getE_reply_no()})" class="font-black">
     					<img class="rec" src="<c:url value='/resources/img/logos/like2.png'/>">&nbsp;&nbsp;${reply.getE_reply_like() }
    				</a>
				</td>
     			<td colspan="2">
     				<a href="javascript:void(0)"  onclick="updateDislike(${reply.getE_reply_no()})" class="font-black">
     					<img class="rec" src="<c:url value='/resources/img/logos/dislike2.png'/>">&nbsp;&nbsp;${reply.getE_reply_dislike() }
     				</a>
     			</td>
     			<td >${reply.getE_reply_date() }</td>
     		</tr>
		
     		<tr><td colspan="7"  >
     			<c:if test="${!empty reply.getE_reply_indent() }">	<%-- indent 만큼 띄어쓰기를 해줄거임. --%>
					<c:forEach begin="1" end="${reply.getE_reply_indent() }" step="1">
	      				&nbsp;&nbsp;&nbsp;
	      			</c:forEach>
     			</c:if>
     			<c:set var="replyStr" value="${fn:replace(reply.getE_reply_content(), '  ', '&nbsp;&nbsp;' ) }"></c:set>	<%-- 공백 가능하게 처리해줌 --%>
      			${fn:replace(replyStr , newLineChar, "<br>")} 	<!-- \n를 해주는 과정 --> 
     		</td></tr>
	     		
	    		
			<tr>
				<td colspan="7">
					<c:if test="${reply.getE_reply_indent() >= 2 }">
						<hr style="border: none; border-top: 3px dotted blue;">
					</c:if>
					
					<c:if test="${reply.getE_reply_indent() == 1 }">
						<hr>
					</c:if>
				</td>
			</tr>
   		</c:forEach>
			
			
			<tr>
      			<td colspan="7" align="center" >
      				<%-----------------Left Arrows----------- --%>
      				<c:if test="${ page.getPage() > page.getBlocks() }">
						<a href="javascript:void(0)" onclick="getReplylist(1)" class="blocks">[◀◀]</a>
						<a href="javascript:void(0)" onclick="getReplylist(${page.getBlockStart() - 1})" class="blocks">[◀]</a>
					</c:if>
				 
      				
      				<%------------------ block 번호 ------------ --%>
		      		<c:forEach begin="${page.getBlockStart() }" end="${page.getBlockEnd() }" step="1" var="i">
		      			<c:if test="${page.getPage() == i }">
		      				<b>${i }</b> 
		      			</c:if>
		      
		      			<c:if test="${page.getPage() != i }">
		      				<c:set value="${i }" var="pageParam"></c:set>	<%-- page넘기려면 set 해줘야함 --%>
		      				<b><a href="javascript:void(0)" onclick="getReplylist(${pageParam})" class="blocks">${i }</a></b>
		      			</c:if>
		      			&nbsp;&nbsp;&nbsp;
		      		</c:forEach>

		      		
		      		<%--------------------Right Arrows----------------- --%>
		      		<c:if test="${page.getBlockEnd() < page.getTotalPages() }">
						<a href="javascript:void(0)" onclick="getReplylist(${page.getBlockEnd() + 1})" class="blocks">[▶]</a>
						<a href="javascript:void(0)" onclick="getReplylist(${page.getTotalPages() })" class="blocks">[▶▶] </a>
						
					</c:if>
	      		</td>
	      		
	      		
	      		<%-- 검색창 --%>
	      		<!-- <td colspan="4" align="center" >
	      			<select name="entireSearchType">
	      				<option value="all">전체</option>
	      				<option value="title">제목</option>
	      				<option value="content">내용</option>
	      				<option value="nickname">글쓴이</option>
	      			</select>
	      			
	      			<input name="entireSearchData" id="inputSearch input">
	      			<input type="submit" value="검색">
	      			
	      		</td> -->
      		</tr>
   	</c:if>
   	</table>
