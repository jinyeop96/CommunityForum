<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>	<%-- 줄바꿈 function --%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
						
<%pageContext.setAttribute("newLineChar", "\n"); %>	<%-- \n -> newLineChar로 --%>

	<!-- 첨부파일 -->						
	<c:if test="${!empty files}">
		<c:forEach items="${files }" var="file" >
			<tr align="right" class="board"> 
				<td colspan="7"> 
					<a class="font-black attach" href="<spring:url value='/image/${file.getBoardfile_name() }'/> " >
					 	<span>${file.getBoardfile_name().substring(46) }</span>
					</a> 
				</td>
			</tr>
		</c:forEach>
	</c:if>
				
	<!--  이미지 -->
	<c:if test="${!empty images }">
		<c:forEach items="${images }" var="image">
			<tr>
				<td>
					<img style="max-width: 80%" src="<spring:url value='/image/${image.getBoardfile_name() }'/>"><br>
				</td>
			</tr>	
		</c:forEach>
	</c:if>

	<tr><td><br></td></tr>
	
	<!-- 게시글 -->
	<tr>
		<td>
			<c:set var="content" value="${fn:replace(dto.getBoard_content(), '  ', '&nbsp;&nbsp;' ) }"></c:set>	<%-- 공백 가능하게 처리해줌 --%>
			${fn:replace(content , newLineChar, "<br>")} 	<!-- \n를 해주는 과정 --> <br><br>
		</td>
	</tr>
	
	<%-- 좋아요  / 싫어요 --%>
	<tr>	
		<td align="center">
			<c:choose>
				<%-- 로그인 안했을때 --%>
				<c:when test="${empty boardRec }">
					<a href="javascript:recommend(0, ${dto.getBoard_no()}, 'board', 'like', ${page.getPage() })" id="like${dto.getBoard_no() }">
						<img class="contentRec"  src="<c:url value='/resources/img/logos/like.png'/>">&nbsp;&nbsp;&nbsp;
						<font class="boardUpdateLike" style="color: white; text-decoration: none;">${dto.getBoard_like() }</font>&nbsp;&nbsp;&nbsp;
					</a>
					<a href="javascript:recommend(0, ${dto.getBoard_no()}, 'board', 'dislike', ${page.getPage() })">
						<img class="contentRec" src="<c:url value='/resources/img/logos/dislike.png'/>">&nbsp;&nbsp;&nbsp;
						<font class="boardUpdateDislike" style="color: white; text-decoration: none;">${dto.getBoard_dislike() }</font>
					</a>
				</c:when>
				
				<%-- 로그인 했을 때 --%>
				<c:when test="${!empty boardRec }">
					<c:if test="${boardRec.getRec_like() == 1 }">	
						<a href="javascript:recommend(0, ${dto.getBoard_no()}, 'board', 'like', ${page.getPage() })" id="like${dto.getBoard_no() }">
							<img class="contentRec"  src="<c:url value='/resources/img/logos/like2.png'/>">&nbsp;&nbsp;&nbsp;
							<font class="boardUpdateLike" style="color: white; text-decoration: none;">${dto.getBoard_like() }</font>&nbsp;&nbsp;&nbsp;
						</a>
					</c:if>

					<c:if test="${boardRec.getRec_like() == 0 }">
						<a href="javascript:recommend(0, ${dto.getBoard_no()}, 'board', 'like', ${page.getPage() })" id="like${dto.getBoard_no() }">
							<img class="contentRec"  src="<c:url value='/resources/img/logos/like.png'/>">&nbsp;&nbsp;&nbsp;
							<font class="boardUpdateLike" style="color: white; text-decoration: none;">${dto.getBoard_like() }</font>&nbsp;&nbsp;&nbsp;
						</a>
					</c:if>



					<c:if test="${boardRec.getRec_dislike() == 0 }">
						<a href="javascript:recommend(0, ${dto.getBoard_no()}, 'board', 'dislike', ${page.getPage() })">
							<img class="contentRec" src="<c:url value='/resources/img/logos/dislike.png'/>">&nbsp;&nbsp;&nbsp;
							<font class="boardUpdateDislike" style="color: white; text-decoration: none;">${dto.getBoard_dislike() }</font>
						</a>
					</c:if>

					<c:if test="${boardRec.getRec_dislike() == -1}">
						<a href="javascript:recommend(0, ${dto.getBoard_no()}, 'board', 'dislike', ${page.getPage() })">
							<img class="contentRec" src="<c:url value='/resources/img/logos/dislike2.png'/>">&nbsp;&nbsp;&nbsp;
							<font class="boardUpdateDislike" style="color: white; text-decoration: none;">${dto.getBoard_dislike() }</font>
						</a>
					</c:if>
				</c:when>
			</c:choose>
		</td>
	</tr>		
	
	<tr><td><hr style="width: 90%"></td></tr>


	
	
	<%--댓글 쓰기--%>
	<c:if test="${!empty nickname || !empty admin}">	<!-- 로그인 했을 때 댓글 허용 -->
		
		<tr>																	
			<td colspan="7"><textarea class="board resize-none textarea" id="replyContent${dto.getBoard_no() }" rows="4"  placeholder="댓글"></textarea></td>
		</tr>
		
		<tr>
			<td colspan="7" align="right">
				<input type="button" id="reply" onclick="reply(${dto.getBoard_no()})" class="buttons" value="댓글 저장">
			</td>
		</tr>
		
	</c:if>
		
	<c:if test="${empty nickname && empty admin}">	<!--  로그인 안했을 때 댓글 비허용 -->
		<tr>
			<td colspan="7"><textarea class="board resize-none textarea" rows="2" readonly >회원만 댓글 쓸 수 있습니다.</textarea></td> 
		</tr>
	</c:if>
	
	<tr><td colspan="7"><hr style="width: 90%"></td></tr>
	
	
	
	<%-- 댓글 뿌리기 --%>
	<c:if test="${!empty replyList}">	<!-- 답변 있으면 뿌리기 -->
		<c:set value="0" var="replyIndex"></c:set>
		<c:forEach items="${replyList }" var="reply">	<!--이건 게시글에 대한 답변 뿌리기 -->
		
		

			<!-- 닉네임 -->	
			<tr >
				<td colspan="7">
					<b>>> ${reply.getReply_nickname() }</b>
				
				<c:if test="${reply.getReply_nickname() == nickname || !empty admin}">	<!-- 답변글과 현재 로그인한 사람이 같을 때 수정/삭제 버튼 보여줌 -->
					<a href="javascript:void(0)" onclick="showModifyBtn(${reply.getReply_no() }, ${dto.getBoard_no() }, '${reply.getReply_content()}')">
						<img src="<c:url value='/resources/img/logos/more.png'/>" style="float: right; width: 25px">
					</a>
					
					<%-- 위 img 클릭했을 때 수정/삭제 버튼 보이기 --%>
					<span id="modifyBtn${reply.getReply_no() }"></span>
					
					
				</c:if>
				</td>
			</tr> 
	
			<%-- 댓글 좋아요/ 싫어요 --%>
			<tr>
				<td colspan="7">
					<%-- 로그인 안했을 때 --%>
					<c:if test="${empty replyRec }">
						<a href="javascript:void(0)"  onclick="recommend(${reply.getReply_no()}, ${dto.getBoard_no() }, 'reply', 'like', ${page.getPage() })" class="font-black">
							<img class="rec" src="<c:url value='/resources/img/logos/like.png'/>">&nbsp;&nbsp;${reply.getReply_like() }
						</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					
						<a href="javascript:void(0)"  onclick="recommend(${reply.getReply_no()}, ${dto.getBoard_no() }, 'reply', 'dislike', ${page.getPage() })" class="font-black">
							<img class="rec" src="<c:url value='/resources/img/logos/dislike.png'/>">&nbsp;&nbsp;${reply.getReply_dislike() }
						</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					</c:if>
					
					<%-- 로그인 했을떄 --%>
					<c:if test="${!empty replyRec }">
						<c:set value="0" var="loop"></c:set> 
						<c:forEach items="${replyRec }" var="replyRec2">
							<c:if test="${replyRec2.getReply_no() == reply.getReply_no()}">	<%-- recommend 테이블에서 nickname(현재 사용자) 의 이름으로 다 가져옴 (그간 기록된 좋아요/싫어요) --%>
								<c:if test="${replyRec2.getRec_like() == 1 }">
									<a href="javascript:void(0)"  onclick="recommend(${reply.getReply_no()}, ${dto.getBoard_no() }, 'reply', 'like', ${page.getPage() })" class="font-black">
										<img class="rec" src="<c:url value='/resources/img/logos/like2.png'/>">&nbsp;&nbsp;${reply.getReply_like() }
									</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								</c:if>

								<c:if test="${replyRec2.getRec_like() == 0 }">
									<a href="javascript:void(0)"  onclick="recommend(${reply.getReply_no()}, ${dto.getBoard_no() }, 'reply', 'like', ${page.getPage() })" class="font-black">
										<img class="rec" src="<c:url value='/resources/img/logos/like.png'/>">&nbsp;&nbsp;${reply.getReply_like() }
									</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								</c:if>
								
								<c:if test="${replyRec2.getRec_dislike() == 0 }">
									<a href="javascript:void(0)"  onclick="recommend(${reply.getReply_no()}, ${dto.getBoard_no() }, 'reply', 'dislike', ${page.getPage() })" class="font-black">
										<img class="rec" src="<c:url value='/resources/img/logos/dislike.png'/>">&nbsp;&nbsp;${reply.getReply_dislike() }
									</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								</c:if>
														  
								<c:if test="${replyRec2.getRec_dislike() == -1 }">
									<a href="javascript:void(0)"  onclick="recommend(${reply.getReply_no()}, ${dto.getBoard_no() }, 'reply', 'dislike', ${page.getPage() })" class="font-black">
										<img class="rec" src="<c:url value='/resources/img/logos/dislike2.png'/>">&nbsp;&nbsp;${reply.getReply_dislike() }
									</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								</c:if>
								
								<c:set value="1" var="loop"></c:set>	<%-- 해당 댓글에 대한 전의 기록이 남아있어서 좋아요/싫어요 이미지 구현됐으면 loop을 1로 바꿔준다 --%>
							</c:if>
						</c:forEach>
							
						<c:if test="${loop == 0 }">	<%-- 해당 댓글에 대한 전의 기록이 없다면   --%>
							<a href="javascript:void(0)"  onclick="recommend(${reply.getReply_no()}, ${dto.getBoard_no() }, 'reply', 'like', ${page.getPage() })" class="font-black">
								<img class="rec" src="<c:url value='/resources/img/logos/like.png'/>">&nbsp;&nbsp;${reply.getReply_like() }
							</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						
							<a href="javascript:void(0)"  onclick="recommend(${reply.getReply_no()}, ${dto.getBoard_no() }, 'reply', 'dislike', ${page.getPage() })" class="font-black">
								<img class="rec" src="<c:url value='/resources/img/logos/dislike.png'/>">&nbsp;&nbsp;${reply.getReply_dislike() }
							</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						</c:if>
					</c:if>
		
					<!-- 작성일 -->
					${reply.getReply_date() }
				</td>
			</tr>
	
			<!-- 답변글 -->
			<tr id="replies${reply.getReply_no() }">
				<td colspan="7"> &nbsp;&nbsp;&nbsp;
					<c:set var="replyStr" value="${fn:replace(reply.getReply_content(), '  ', '&nbsp;&nbsp;' ) }"></c:set>	<%-- 공백 가능하게 처리해줌 --%>
					${fn:replace(replyStr , newLineChar, "<br>")} 	<!-- \n를 해주는 과정 --> 
				</td>
			</tr>
			
			<tr><td colspan="7"><table class="board" id="replyEdit${reply.getReply_no() }"></table><td></tr>
	
			<!-- 답변 글 나누기 -->
			<tr><td><hr style="border-top: 1px solid white;"></td></tr>
		


		<c:set value="${replyIndex + 1}" var="replyIndex" ></c:set>	<!--  답변글에 붙이는 숫자 +1 -->
		</c:forEach>
	</c:if>
	
	<%-- 페이징 처리 --%>
	<tr>
		<td colspan="6" align="center">
			<%-----------------Left Arrows----------- --%>
			<c:if test="${ page.getPage() > page.getBlocks() }">
				<a href="javascript:void(0)" onclick="showContents(${dto.getBoard_no()}, 1, 1); " class="blocks">[◀◀]</a>
				<a href="javascript:void(0)" onclick="showContents(${dto.getBoard_no()}, ${page.getBlockStart() - 1}, 1); " class="blocks">[◀]</a>
			</c:if>
				
				
			<%------------------ block 번호 ------------ --%>
			<c:forEach begin="${page.getBlockStart() }" end="${page.getBlockEnd() }" step="1" var="i">
				<!-- 현재페이지 -->
				<c:if test="${page.getPage() == i }">
					<b>${i }</b> 
				</c:if>
				
				<!--  no 현재페이지 -->
				<c:if test="${page.getPage() != i }">
					<b><a href="javascript:void(0)" onclick="showContents(${dto.getBoard_no()}, ${i }, 1);" class="blocks">${i }</a></b> 
				</c:if>
				&nbsp;&nbsp;&nbsp;
			</c:forEach>
				
				
			<%--------------------Right Arrows----------------- --%>
			<c:if test="${page.getBlockEnd() < page.getTotalPages() }">
				<a href="javascript:void(0)" onclick="showContents(${dto.getBoard_no()}, ${page.getBlockEnd() + 1}, 1);" class="blocks">[▶]</a>
				<a href="javascript:void(0)" onclick="showContents(${dto.getBoard_no()}, ${page.getTotalPages() }, 1); " class="blocks">[▶▶] </a>
			</c:if>
		</td>
	</tr>

	<tr><td><hr style="border-top: 1px solid white;"></td></tr>
















