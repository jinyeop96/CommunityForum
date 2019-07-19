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
				<c:choose>
					<c:when test="${!empty nickname }">
						<input class="buttons" type="button" value="글쓰기" onclick="location.href='boardWrite.do?board_type=${board_type}&user_type=0'">
					</c:when>

					<c:when test="${!empty admin }">
						<input class="buttons" type="button" value="글쓰기" onclick="location.href='boardWrite.do?board_type=${board_type}&user_type=1'">
					</c:when>
				</c:choose>
			</td>
		</tr>
		
		<tr><td><br></td></tr>
	</c:if>
	
	<%-- 각 게시글에 붙을 숫자 --%>
	<c:set value="0" var="index"></c:set>
		
	<%------------------가져온 공지가 있다면-------------- --%>
	<c:if test="${!empty upBoardList }">
		<c:forEach items="${upBoardList }" var="upBoardDto">
			<tr>
				<td colspan="7" class="upBoard" >
					<a href="javascript:void(0)" onclick="showContents(${upBoardDto.getBoard_no()});" style="color: #000">
						<h6>
							${upBoardDto.getBoard_title() } [${upBoardDto.getBoard_reply() }]
							<c:if test="${upBoardDto.getBoard_hasFile() == 1 }"><img class="floppyDisk" src="<c:url value='/resources/img/logos/floppyDisk.png'/>"></c:if>
							
							<c:if test="${!empty admin }">	<!-- 답변글과 현재 로그인한 사람이 같을 때 수정/삭제 버튼 보여줌 -->
		     					<a href="javascript:void(0)" onclick="showModifyBtn2(${upBoardDto.getBoard_no() })">
		     						<img src="<c:url value='/resources/img/logos/more.png'/>" style="float: right; width: 25px">
								</a>
								
		     					<input type="button" onclick="boardEdit(${upBoardDto.getBoard_no()}, ${pageParam })" class="buttons modifies modifyBtn${upBoardDto.getBoard_no() }" value="수정" style="float: right; margin-left: 10px"></input>
		     					<input type="button" onclick="boardDelete(${upBoardDto.getBoard_no()}, ${pageParam })" value="삭제" class="buttons modifies modifyBtn${upBoardDto.getBoard_no() }" style="float: right"></input>
		     				</c:if>
						</h6>
					</a>
				</td> 
			</tr>
			<tr>
				<td class="upBoard"><b>> ${upBoardDto.getBoard_nickname() }</b></td>
				<td class="upBoard">${upBoardDto.getBoard_date().substring(0, 10) }</td>
				<td class="text-center upBoard">추천 ${upBoardDto.getBoard_like() }</td> 
				<td class="text-center upBoard">조회 ${upBoardDto.getBoard_view() }</td>
			</tr>
			
			<tr><td colspan="7"><hr style="border-top: 1px solid white;"></td></tr>
			
			<tr>
				<td colspan="7">
					<table id="contentsCon${upBoardDto.getBoard_no() }" class="board"></table>
				</td>
			</tr>
			
			<%-- 글에 붙는 숫자 + 1 해줌으로서 다음 글에 대한 index를 준비한다 --%> 
			<c:set value="${index + 1 }" var="index"></c:set>
		</c:forEach>
	</c:if>    
 
	<%------------------가져온 게시글 있다면-------------- --%>
	<c:if test="${!empty list }">
		<c:forEach items="${list}" var="dto">
			<tr>
				<td colspan="7" >
					<a href="javascript:void(0)" onclick="showContents(${dto.getBoard_no()});" style="color: #000">
						<h6>
							${dto.getBoard_title() } [${dto.getBoard_reply() }]
							<c:if test="${dto.getBoard_hasFile() == 1 }"><img class="floppyDisk" src="<c:url value='/resources/img/logos/floppyDisk.png'/>"></c:if>
							
							<c:if test="${dto.getBoard_nickname() == nickname || !empty admin }">	<!-- 답변글과 현재 로그인한 사람이 같을 때 수정/삭제 버튼 보여줌 -->
		     					<a href="javascript:void(0)" onclick="showModifyBtn2(${dto.getBoard_no() })">
		     						<img src="<c:url value='/resources/img/logos/more.png'/>" style="float: right; width: 25px">
								</a>
								
		     					<input type="button" onclick="boardEdit(${dto.getBoard_no()}, ${pageParam })" class="buttons modifies modifyBtn${dto.getBoard_no() }" value="수정" style="float: right; margin-left: 10px"></input>
		     					<input type="button" onclick="boardDelete(${dto.getBoard_no()}, ${pageParam })" value="삭제" class="buttons modifies modifyBtn${dto.getBoard_no() }" style="float: right"></input>
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
			
			<tr>
				<td colspan="7">
					<hr style="border-top: 1px solid white;">
				</td>
			</tr>
			
			<tr>
				<td colspan="7">
					<table id="contentsCon${dto.getBoard_no() }" class="board"></table>
				</td>
			</tr>
			
			<!-- 글에 붙는 숫자 + 1 해줌으로서 다음 글에 대한 index를 준비한다 -->
			<c:set value="${index + 1 }" var="index"></c:set>
		</c:forEach> 
	</c:if>
	
	<%-- 페이징 처리 --%>
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
	
	
</table>
















































