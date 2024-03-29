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
	<%pageContext.setAttribute("newLineChar", "\n"); %>	<%-- \n -> newLineChar로 --%>
	
	<table class="board font-black" id="replyTable"> <%-- table : 선 긋기, table-hover : 마우스 올렸을 때 색변화 --%>
	<%------------------가져온 게시물의 답변글이 있다면-------------- --%>
	<c:if test="${!empty list }">
		<%-- 가져온 게시물 뿌려주기 --%>
		
		<c:set value="0" var="index"></c:set>
   		<c:forEach items="${list }" var="reply">
   			<!-- 닉네임 -->
     		<tr>
     			<th colspan="7">
     				> ${reply.getReply_nickname() }	
     				
     				<c:if test="${reply.getReply_nickname() == nickname || !empty admin}">
     					<a href="javascript:void(0)" onclick="showModifyBtn(${index})">
     						<img src="<c:url value='/resources/img/logos/more.png'/>" style="float: right; width: 25px">
     					</a>
     				
     					<input type="button" onclick="showReplyEdit(${index})" class="buttons modifies modifyBtn${index }" value="수정" style="float: right; margin-left: 10px"></input>
					    <input type="button" onclick="deleteReply(${reply.getReply_no()}, ${pageParam})" class="buttons modifies modifyBtn${index }" value="삭제" style="float: right;"></input>
     				</c:if>
     			</th>
     		</tr>
     		
     		<%-- 좋아요 / 싫어요 --%>
     		<tr>
  				<td colspan="2">
  					<%-- 로그인 안했을 떄 --%>
	     			<c:if test="${empty replyRec }">
							<a href="javascript:void(0)"  onclick="recommend(${reply.getReply_no()}, 'reply', 'like')" class="font-black no-deco">
								<img class="rec" src="<c:url value='/resources/img/logos/up1.png'/>">&nbsp;&nbsp;${reply.getReply_like() }
							</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					
							<a href="javascript:void(0)"  onclick="recommend(${reply.getReply_no()}, 'reply', 'dislike')" class="font-black no-deco">
								<img class="rec" src="<c:url value='/resources/img/logos/down1.png'/>">&nbsp;&nbsp;${reply.getReply_dislike() }
							</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					</c:if>
					
					<%-- 로그인 했을떄 --%>
					<c:if test="${!empty replyRec }">
						<c:set value="0" var="loop"></c:set> 
						<c:forEach items="${replyRec }" var="replyRec2">
							<c:if test="${replyRec2.getReply_no() == reply.getReply_no()}">	<%-- recommend 테이블에서 nickname(현재 사용자) 의 이름으로 다 가져옴 (그간 기록된 좋아요/싫어요) --%>
									<a href="javascript:void(0)"  onclick="recommend(${reply.getReply_no()}, 'reply', 'like')" class="font-black no-deco">
										<c:if test="${replyRec2.getRec_like() == 1 }">
											<img class="rec" src="<c:url value='/resources/img/logos/up2.png'/>">&nbsp;&nbsp;${reply.getReply_like() }
										</c:if>
										
										<c:if test="${replyRec2.getRec_like() == 0 }">
											<img class="rec" src="<c:url value='/resources/img/logos/up1.png'/>">&nbsp;&nbsp;${reply.getReply_like() }
										</c:if>
									</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
									
									<a href="javascript:void(0)"  onclick="recommend(${reply.getReply_no()}, 'reply', 'dislike')" class="font-black no-deco">
										<c:if test="${replyRec2.getRec_dislike() == 0 }">
											<img class="rec" src="<c:url value='/resources/img/logos/down1.png'/>">&nbsp;&nbsp;${reply.getReply_dislike() }
										</c:if>
		
										<c:if test="${replyRec2.getRec_dislike() == -1 }">
											<img class="rec" src="<c:url value='/resources/img/logos/down2.png'/>">&nbsp;&nbsp;${reply.getReply_dislike() }
										</c:if>
									</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								<c:set value="1" var="loop"></c:set>	<%-- 해당 댓글에 대한 전의 기록이 남아있어서 좋아요/싫어요 이미지 구현됐으면 loop을 1로 바꿔준다 --%>
							</c:if>
						</c:forEach>
							
						<c:if test="${loop == 0 }">	<%-- 해당 댓글에 대한 전의 기록이 없다면   --%>
								<a href="javascript:void(0)"  onclick="recommend(${reply.getReply_no()}, 'reply', 'like')" class="font-black no-deco">
									<img class="rec" src="<c:url value='/resources/img/logos/up1.png'/>">&nbsp;&nbsp;${reply.getReply_like() }
								</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								
								<a href="javascript:void(0)"  onclick="recommend(${reply.getReply_no()}, 'reply', 'dislike')" class="font-black no-deco">
									<img class="rec" src="<c:url value='/resources/img/logos/down1.png'/>">&nbsp;&nbsp;${reply.getReply_dislike() }
								</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						</c:if>
					</c:if>
				<td>
     			
     			<!-- 작성일 -->
     			<td >${reply.getReply_date() }</td>
     		</tr>
			
			<!-- 답변글 -->
     		<tr>
     			<td colspan="7"  > &nbsp;&nbsp;&nbsp;
     				<c:set var="replyStr" value="${fn:replace(reply.getReply_content(), '  ', '&nbsp;&nbsp;' ) }"></c:set>	<%-- 공백 가능하게 처리해줌 --%>
      				${fn:replace(replyStr , newLineChar, "<br>")} 	<!-- \n를 해주는 과정 --> 
     			</td>
     		</tr>
     		
			<tr class="hide replyEdit${index }">
        		<td colspan="7"><textarea class="board resize-none textarea" rows="4"  placeholder="댓글 수정" id="reply_content_edit${index }" >${reply.getReply_content() }</textarea></td>
        	</tr>

        	<tr class="hide replyEdit${index }"> 
        		<td colspan="7" align="right">
	        		<input type="button" id="reply" onclick="replyEditOk(${reply.getReply_no() },${index }, ${pageParam })" class="buttons" value="저장">
       			</td>
        	</tr>     		
	    	<!-- 답변 글 나누기 -->
			<tr><td colspan="7"><hr></td></tr>
			
			<c:set value="${index +1 }" var="index"></c:set>
   		</c:forEach>
			
			
			<tr>
      			<td colspan="7" align="center" >
      				<%-----------------Left Arrows----------- --%>
      				<c:if test="${ page.getPage() > page.getBlocks() }">
						<a href="javascript:void(0)" onclick="getReplyList(1); pageUp(1);" class="blocks">[◀◀]</a>
						<a href="javascript:void(0)" onclick="getReplyList(${page.getBlockStart() - 1}); pageUp(1);" class="blocks">[◀]</a>
					</c:if>
				 
      				
      				<%------------------ block 번호 ------------ --%>
		      		<c:forEach begin="${page.getBlockStart() }" end="${page.getBlockEnd() }" step="1" var="i">
		      			<c:if test="${page.getPage() == i }">
		      				<b>${i }</b> 
		      			</c:if>
		      
		      			<c:if test="${page.getPage() != i }">
							<c:set value="${i }" var="pageParam"></c:set>	<%-- page넘기려면 set 해줘야함 --%>
		      				<b><a href="javascript:void(0)" onclick="getReplyList(${pageParam}); pageUp(1);" class="blocks">${i }</a></b>
		      			</c:if>
		      			&nbsp;&nbsp;&nbsp;
		      		</c:forEach>

		      		
		      		<%--------------------Right Arrows----------------- --%>
		      		<c:if test="${page.getBlockEnd() < page.getTotalPages() }">
						<a href="javascript:void(0)" onclick="getReplyList(${page.getBlockEnd() + 1}); pageUp(1);" class="blocks">[▶]</a>
						<a href="javascript:void(0)" onclick="getReplyList(${page.getTotalPages() }); pageUp(1);" class="blocks">[▶▶] </a>
						
					</c:if>
	      		</td>
      		</tr>
   	</c:if>
   	</table>
