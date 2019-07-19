<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>	<%-- 줄바꿈 function --%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
						
						
			<table>
		      			<c:if test="${!empty files}">
							<c:forEach items="${files }" var="file" >
				      				<tr align="right" class="reply${index } hide files${index}"> 
				      					<td colspan="7"> 
				      						<a class="font-black attach" href="<spring:url value='/image/${file.getBoardfile_name() }'/> " >
				      						 	<span>${file.getBoardfile_name().substring(46) }</span>
				      						</a> 
				      					</td>
				      				</tr>
		      				</c:forEach>
			      		</c:if>
							
						<!-- 이미지/게시글 -->
			      		<tr class="reply${index } hide">
			      			<td colspan="7">
			      				<c:if test="${!empty images }">
			      					<c:forEach items="${images }" var="image">
			      						<img style="max-width: 80%" src="<spring:url value='/image/${image.getBoardfile_name() }'/>"><br>
			      					</c:forEach>
			      				</c:if>
		      					
		      					<br>
			      				
			      				<c:set var="content" value="${fn:replace(dto.getBoard_content(), '  ', '&nbsp;&nbsp;' ) }"></c:set>	<%-- 공백 가능하게 처리해줌 --%>
	      						${fn:replace(content , newLineChar, "<br>")} 	<!-- \n를 해주는 과정 --> <br><br>
			      			</td>
			      		</tr>

						<tr class="reply${index } hide">	
			      			<td align="center" colspan="7">
			      				<a href="javascript:recommend(${dto.getBoard_no()}, 'board', 'like', ${num }, ${pageParam })" id="like2">
				      				<img class="contentRec"  src="<c:url value='/resources/img/logos/like2.png'/>">&nbsp;&nbsp;&nbsp;
				      				<font class="boardUpdateLike" style="color: white; text-decoration: none;">${dto.getBoard_like() }</font>&nbsp;&nbsp;&nbsp;
			      				</a>
			      				
			      				<a href="javascript:recommend(${dto.getBoard_no()}, 'board', 'dislike', ${num }, ${pageParam })">
				      				<img class="contentRec" src="<c:url value='/resources/img/logos/dislike2.png'/>">&nbsp;&nbsp;&nbsp;
				      				<font class="boardUpdateDislike" style="color: white; text-decoration: none;">${dto.getBoard_dislike() }</font>
			      				</a>
			      			</td>
			      		</tr>
							

			      		 <%-- 답변 글쓰기 폼 --%>	
			        	<c:if test="${!empty nickname || !empty admin}">	<!-- 로그인 했을 때 댓글 허용 -->
			        		<tr class="reply${num } hide"><td colspan="7"><hr style="width: 90%"></td></tr>
				        
				        	<tr class="reply${num } hide">
				        		<td colspan="7"><textarea class="board resize-none textarea" rows="4"  placeholder="댓글 쓰기" id="reply_content${num }" ></textarea></td>
				        	</tr>

				        	<tr class="reply${num } hide">
				        		<td colspan="7" align="right">
					        		<input type="button" id="reply" onclick="reply(${dto.getBoard_no()}, ${num }, ${pageParam })" class="buttons" value="저장">
			        			</td>
				        	</tr>
			        	</c:if>
	
			        	<c:if test="${empty nickname && empty admin}">	<!--  로그인 안했을 때 댓글 비허용 -->
			        		<tr class="reply${num } hide"><td colspan="7"><hr style="width: 90%"></td></tr>
				        	
				        	<tr class="reply${num } hide">
				        		<td colspan="7"><textarea class="board resize-none textarea" rows="2" id="reply_content" readonly >회원만 댓글 쓸 수 있습니다.</textarea></td> 
				        	</tr>
			        	</c:if>
				        	
			      		
			 		    <c:set value="0" var="num2"></c:set>	<!-- 각각의 댓글에 붙여줄 번호 -->
			      		<!--  해당 글에 대한 답변 -->
	      				<c:forEach items="${replyList }" var="reply">	<!--이건 게시글에 대한 답변 뿌리기 -->
	      					<c:if test="${reply.getReply_group() == dto.getBoard_no() }">	<!-- dto글번호와 reply의 글번호가 같으면 -->
	      						<!-- 답변 글 나누기 -->
								<tr class="reply${num } hide"><td colspan="7"><hr style="width: 90%"></td></tr>
								
					     		<!-- 닉네임 -->
					     		<tr  class="reply${num } hide">
					     			<td colspan="7">
					     				<b>>> ${reply.getReply_nickname() }</b>
					     				
					     				<c:if test="${reply.getReply_nickname() == nickname || !empty admin}">	<!-- 답변글과 현재 로그인한 사람이 같을 때 수정/삭제 버튼 보여줌 -->
					     					<a href="javascript:void(0)" onclick="showModifyBtn(${num2}, ${reply.getReply_no() })">
					     						<img src="<c:url value='/resources/img/logos/more.png'/>" style="float: right; width: 25px">
					     					</a>

					     					<input type="button" onclick="replyEdit(${reply.getReply_no()})" class="buttons modifies modifyBtn${num2 }" value="수정" style="float: right; margin-left: 10px"></input>
					     					<input type="button" onclick="replyDelete(${reply.getReply_no()}, ${num }, ${pageParam })" value="삭제" class="buttons modifies modifyBtn${num2 }" style="float: right"></input>
					     				</c:if>
					     			</td>
					     		</tr> 
					     		
					     		<tr class="reply${num } hide">
					     			
					     			<!--  좋아요 -->
					     			<td colspan="7">
					     				<a href="javascript:void(0)"  onclick="recommend(${reply.getReply_no()}, 'reply', 'like', ${num}, ${pageParam })" class="font-black">
					     					<img class="rec" src="<c:url value='/resources/img/logos/like2.png'/>">&nbsp;&nbsp;${reply.getReply_like() }
					    				</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					    			
									<!-- 싫어요 -->
					     				<a href="javascript:void(0)"  onclick="recommend(${reply.getReply_no()}, 'reply', 'dislike', ${num}, ${pageParam })" class="font-black">
					     					<img class="rec" src="<c:url value='/resources/img/logos/dislike2.png'/>">&nbsp;&nbsp;${reply.getReply_dislike() }
					     				</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					     			
					     			<!-- 작성일 -->
					     				${reply.getReply_date() }
					     			</td>
					     			
					     		</tr>
								
								<!-- 답변글 -->
					     		<tr class="reply${num } hide">
					     			<td colspan="7"> &nbsp;&nbsp;&nbsp;
					     				<c:set var="replyStr" value="${fn:replace(reply.getReply_content(), '  ', '&nbsp;&nbsp;' ) }"></c:set>	<%-- 공백 가능하게 처리해줌 --%>
					      				${fn:replace(replyStr , newLineChar, "<br>")} 	<!-- \n를 해주는 과정 --> 
					     			</td>
					     		</tr>
					     	</c:if>
					     </c:forEach>
					     
				</table>