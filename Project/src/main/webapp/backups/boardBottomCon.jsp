<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>	<%-- 줄바꿈 function --%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

	      	<%pageContext.setAttribute("newLineChar", "\n"); %>	<%-- \n -> newLineChar로 --%>
      	
      			 
     			<table class=" font-black " id="entireList"> <%-- table : 선 긋기, table-hover : 마우스 올렸을 때 색변화 --%>
	      			<!--  로그인 되어있으면 글쓰기 버튼 -->
	      		 	<c:if test="${!empty nickname || !empty admin}">
			      		<tr>
			      			<td colspan="7" align="right">
			      				<input class="buttons" type="button" value="글쓰기" onclick="location.href='boardWrite.do?board_type=${board_type}'">
					      		<br><br>
			      			</td>
			      		</tr>
	      			</c:if>
	      			
   				
	      		<%------------------가져온 공지가 있다면-------------- --%>
	      		<c:if test="${!empty upBoardList }">
	      			<c:forEach items="${upBoardList }" var="upBoardDto">
	      				<tr>
			      			<%-- <td colspan="7" class="upBoard" ><a href="content.do?board_no=${upBoardDto.getBoard_no() }&board_type=${board_type}&pageParam=${page.getPage()}" style="color: #000"> --%>
			      			<td colspan="7" class="upBoard" ><a href="javascript:void(0)" onclick="showContents(${upBoardDto.getBoard_no()});" style="color: #000">
			      				<h6>
			      					${upBoardDto.getBoard_title() } [${upBoardDto.getBoard_reply() }]
			      					<c:if test="${upBoardDto.getBoard_hasFile() == 1 }"><img class="floppyDisk" src="<c:url value='/resources/img/logos/floppyDisk.png'/>"></c:if>
			      				</h6>
			      			</a></td> 
			      		</tr>
			      		<tr>
			      			<td class="upBoard"><b>> ${upBoardDto.getBoard_nickname() }</b></td>
			      			<td class="upBoard">${upBoardDto.getBoard_date().substring(0, 10) }</td>
			      			<td class="text-center upBoard">추천 ${upBoardDto.getBoard_like() }</td>
			      			<td class="text-center upBoard">조회 ${upBoardDto.getBoard_view() }</td>
			      		</tr>
			      		
			      		<tr>
			      			<td colspan="7">
			      				<hr style="border-top: 1px solid white;">
			      			</td>
			      		</tr>
			      		
			      		<tr id="contentsCon"></tr>
	      			</c:forEach>
	      		</c:if>

	      		<%------------------가져온 전체 게시물 있다면-------------- --%>
	      		<c:if test="${!empty list }">
	      		<c:set var="num" value="0"></c:set>	<!-- 각 게시물마다 class="reply+1" 해줄예정-->
	      			<%-- 가져온 게시물 뿌려주기 --%>
      			
		      		<c:forEach items="${list }" var="dto">	<!-- 이건 게시글 뿌리기 -->
			      		<tr>	
			      			<td colspan="4" >
			      				<a href="javascript:void(0)" onclick="showReply(${num });" style="color: #000">
				      				<h6>
				      					${dto.getBoard_title() } [${dto.getBoard_reply() }]
				      					<!-- 자료 있는지 보여주기 -->
				      					<c:if test="${dto.getBoard_hasFile() == 1 }"><img class="floppyDisk" src="<c:url value='/resources/img/logos/floppyDisk.png'/>"></c:if>
				      							
				      					<c:if test="${dto.getBoard_nickname() == nickname || !empty admin }">	<!-- 답변글과 현재 로그인한 사람이 같을 때 수정/삭제 버튼 보여줌 -->
					     					<a href="javascript:void(0)" onclick="showModifyBtn(${num}, ${dto.getBoard_no() })">
					     						<img src="<c:url value='/resources/img/logos/more.png'/>" style="float: right; width: 25px">
					     					</a>
	
					     					<input type="button" onclick="boardEdit(${dto.getBoard_no()}, ${pageParam })" class="buttons modifies modifyBtn${num }" value="수정" style="float: right; margin-left: 10px"></input>
					     					<input type="button" onclick="boardDelete(${dto.getBoard_no()}, ${pageParam })" value="삭제" class="buttons modifies modifyBtn${num }" style="float: right"></input>
					     				</c:if>
				      				</h6>
								</a>			      				
			      			</td>
			      		</tr>
			      		
			      		<tr>
			      			<td><b>> ${dto.getBoard_nickname() }</b></td>
			      			<td>${dto.getBoard_date().substring(0, 10) }</td>
			      			<td class="text-center">추천 ${dto.getBoard_like() }</td>
			      			<td class="text-center">조회 ${dto.getBoard_view() }</td>
			      		</tr>
			      		
			      		<!--  첨부파일 -->  
			      		<br>
	      				<c:forEach items="${files }" var="file" >
			      			<c:if test="${file.getBoard_no() == dto.getBoard_no() }">
			      				<tr align="right" class="reply${num } hide files${num}"> 
			      					<td colspan="7"> 
			      						<a class="font-black attach" href="<spring:url value='/image/${file.getBoardfile_name() }'/> " >
			      						 	<span>${file.getBoardfile_name().substring(46) }</span>
			      						</a> 
			      					</td>
			      				</tr>
				      		</c:if>
	      				</c:forEach>
			      		
			      		<!-- 이미지/게시글 -->
			      		<tr class="reply${num } hide">
			      			<td colspan="7">
		      					<c:forEach items="${images }" var="image">
				      				<c:if test="${image.getBoard_no() == dto.getBoard_no()}">
				      						<img style="max-width: 80%" src="<spring:url value='/image/${image.getBoardfile_name() }'/>"><br>
				      				</c:if>
		      					</c:forEach>
		      					
		      					<br>
			      				
			      				<c:set var="content" value="${fn:replace(dto.getBoard_content(), '  ', '&nbsp;&nbsp;' ) }"></c:set>	<%-- 공백 가능하게 처리해줌 --%>
	      						${fn:replace(content , newLineChar, "<br>")} 	<!-- \n를 해주는 과정 --> <br><br>
			      			</td>
			      		</tr>

						<tr class="reply${num } hide">	
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
					     		
					     		
					     		<!--  수정 버튼 누르면 나오는 입력창 -->
					     		<tr class="editHide hide replyEditHide${reply.getReply_no()}">
					        		<td colspan="7"><textarea class="board resize-none textarea" rows="4"  placeholder="댓글 쓰기" id="reply_content_edit${num2 }" >${reply.getReply_content() }</textarea></td>
					        	</tr>
	
					        	<tr class="editHide hide replyEditHide${reply.getReply_no()}"> 
					        		<td colspan="7" align="right">
						        		<input type="button" id="reply" onclick="replyEditOk(${reply.getReply_no() },${num }, ${num2 }, ${pageParam })" class="buttons" value="저장">
				        			</td>
					        	</tr>
					     		
						    	
	      					</c:if>
		      		<c:set value="${num2+1 }" var="num2" ></c:set>	<!--  답변글에 붙이는 숫자 +1 -->
	      				</c:forEach>
	      				
			      		<tr><td colspan="7"><hr style="border-top: 1px solid white;"></td></tr> 
			      		
		      		<c:set value="${num+1 }" var="num" ></c:set>	<!-- 원글에 붙이는 숫자 +1 -->
		      		</c:forEach>
		      	
		      		
		      		<%---------------------------------- 하단부 페이징-----------------------------------------------%>
			      	<tr>
		      			<td colspan="6" align="center">
		      				<%-----------------Left Arrows----------- --%>
		      				<c:if test="${ page.getPage() > page.getBlocks() }">
								<a href="javascript:void(0)" onclick="boardBottomCon(1, 1); " class="blocks">[◀◀]</a>
								<a href="javascript:void(0)" onclick="boardBottomCon(${page.getBlockStart() - 1}, 1); " class="blocks">[◀]</a>
							</c:if>
						 
		      				
		      				<%------------------ block 번호 ------------ --%>
				      		<c:forEach begin="${page.getBlockStart() }" end="${page.getBlockEnd() }" step="1" var="i">
				      			<!-- 현재페이지 -->
				      			<c:if test="${page.getPage() == i }">
				      				<b>${i }</b> 
				      			</c:if>
				      
				      			<!--  no 현재페이지 -->
				      			<c:if test="${page.getPage() != i }">
				      				<b><a href="javascript:void(0)" onclick="boardBottomCon(${i }, 1);" class="blocks">${i }</a></b> 
				      			</c:if>
				      			&nbsp;&nbsp;&nbsp;
				      		</c:forEach>

				      		
				      		<%--------------------Right Arrows----------------- --%>
				      		<c:if test="${page.getBlockEnd() < page.getTotalPages() }">
								<a href="javascript:void(0)" onclick="boardBottomCon(${page.getBlockEnd() + 1}, 1);" class="blocks">[▶]</a>
								<a href="javascript:void(0)" onclick="boardBottomCon(${page.getTotalPages() }, 1); " class="blocks">[▶▶] </a>
							</c:if>
			      		</td>
		      		</tr>
		      		
		      		 
	      		</c:if>






				<!-- 게시물 없을 떄 -->	      		
	      		<c:if test="${empty list }">
	      			<tr>
	     				<th colspan="7" align="center">
		      				<c:if test="${empty searchData }">
			     				<h3>글이 하나도 없습니다! 새로운 글을 써주세요</h3>
		      				</c:if>
		      				
		      				<c:if test="${!empty searchData }">
			     				<h3>검색 게시물이 없습니다!</h3>
		      				</c:if>
	     				</th>
	     			</tr>
	      		</c:if>
	      		

	        </table>
