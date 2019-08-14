<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>	<%-- 줄바꿈 function --%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<script src="<c:url value='/resources/jquery-3.4.1.js' /> "></script>
<script type="text/javascript">
	$(function(){
		var filter = "win16|win32|win64|macintel|mac|"; // PC일 경우 가능한 값
	
		 if( navigator.platform){
			 if( filter.indexOf(navigator.platform.toLowerCase())<0 ){	// 모바일 접속
				 $(".pc").hide();
			} else { // pc 접속
				$(".mobile").hide();
			} 
		}  
		
	});
</script>
<%pageContext.setAttribute("newLineChar", "\n"); %>	<%-- \n -> newLineChar로 --%>

<table class=" font-black board" id="entireList"> <%-- table : 선 긋기, table-hover : 마우스 올렸을 때 색변화 --%>
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
	
	<%------------------가져온 공지가 있다면-------------- --%>
	<c:if test="${!empty upBoardList }">
		<c:forEach items="${upBoardList }" var="upBoardDto">
			<%-- pc에서만 보이게 --%>
			<tr class="pc">
				<td style="width: 250px" class="upBoard upBoard-left"><b>> ${upBoardDto.getBoard_nickname() }</b></td>
				<td style="width: 410px; max-width: 410px" class="upBoard">
					<a href="javascript:void(0)" onclick="showContents(${upBoardDto.getBoard_no()});" style="color: #000">
						<h6>
							${upBoardDto.getBoard_title() } [${upBoardDto.getBoard_reply() }]
							<c:if test="${upBoardDto.getBoard_hasFile() == 1 }"><img class="floppyDisk" src="<c:url value='/resources/img/logos/floppyDisk.png'/>"></c:if>
						</h6>
					</a>
				</td> 
				
				<td class="upBoard">${upBoardDto.getBoard_date().substring(0, 10) }</td>
				<td class="upBoard">추천 ${upBoardDto.getBoard_like() }</td> 
				<td class="upBoard">조회 ${upBoardDto.getBoard_view() }</td>
				<td class="upBoard upBoard-right">
					<c:if test="${!empty admin }">	<!-- 답변글과 현재 로그인한 사람이 같을 때 수정/삭제 버튼 보여줌 -->
     					<a href="javascript:void(0)" onclick="showModifyBtn(${upBoardDto.getBoard_no() })">
     						<img src="<c:url value='/resources/img/logos/more.png'/>" style="float: right; width: 25px">
						</a>
     				</c:if>
					<input type="button" onclick="boardEdit(${upBoardDto.getBoard_no()}, ${pageParam })" class="buttons modifies modifyBtn${upBoardDto.getBoard_no() }" value="수정" style="float: right; margin-left: 10px"></input>
		     		<input type="button" onclick="boardDelete(${upBoardDto.getBoard_no()}, ${pageParam })" value="삭제" class="buttons modifies modifyBtn${upBoardDto.getBoard_no() }" style="float: right"></input>
		     	</td>
		     					
			</tr>
			
			<%-- 모바일에서 보이게 --%>
			<tr class="mobile">
				<td colspan="7" class="upBoard upBoard-top">
					<a href="javascript:void(0)" onclick="showContents(${upBoardDto.getBoard_no()});" style="color: #000">
						<h6>
							${upBoardDto.getBoard_title() } [${upBoardDto.getBoard_reply() }]
							<c:if test="${upBoardDto.getBoard_hasFile() == 1 }"><img class="floppyDisk" src="<c:url value='/resources/img/logos/floppyDisk.png'/>"></c:if>
							
							<c:if test="${!empty admin }">	<!-- 답변글과 현재 로그인한 사람이 같을 때 수정/삭제 버튼 보여줌 -->
		     					<a href="javascript:void(0)" onclick="showModifyBtn(${upBoardDto.getBoard_no() })">
		     						<img src="<c:url value='/resources/img/logos/more.png'/>" style="float: right; width: 25px">
								</a>
								
		     					<input type="button" onclick="boardEdit(${upBoardDto.getBoard_no()}, ${pageParam })" class="buttons modifies modifyBtn${upBoardDto.getBoard_no() }" value="수정" style="float: right; margin-left: 10px"></input>
		     					<input type="button" onclick="boardDelete(${upBoardDto.getBoard_no()}, ${pageParam })" value="삭제" class="buttons modifies modifyBtn${upBoardDto.getBoard_no() }" style="float: right"></input>
		     				</c:if>
						</h6>
					</a>
				</td> 
			</tr>
			
			<tr class="upBoard mobile">
				<td colspan="7"><b>> ${upBoardDto.getBoard_nickname() }</b></td>
			</tr>
			
			<tr class="mobile">
				
				<td colspan="7" align="center" class="upBoard  upBoard-bottom">
					${upBoardDto.getBoard_date() }&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					추천 ${upBoardDto.getBoard_like() } &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					조회 ${upBoardDto.getBoard_view() }
				</td>
			</tr>
			
			<tr><td colspan="7"><hr style="border-top: 1px solid white;"></td></tr>
			
			<tr>
				<td colspan="7" align="center"> 
					<table id="contentsCon${upBoardDto.getBoard_no() }" class="board" style="width: 96%; background: #169e83; border-radius: 15px;"></table>
				</td>
			</tr>
			
		</c:forEach>
	</c:if>    
 
	<%------------------가져온 게시글 있다면-------------- --%>
	<c:if test="${!empty list }">
		<c:forEach items="${list}" var="dto">
			<tr class="pc">
				<td style="width: 250px"><b>> ${dto.getBoard_nickname() }</b></td>
				<td style="width: 410px; max-width: 410px">
					<a href="javascript:void(0)" onclick="showContents(${dto.getBoard_no()});" style="color: #000">
						<h6>
							${dto.getBoard_title() } [${dto.getBoard_reply() }]
							<c:if test="${dto.getBoard_hasFile() == 1 }"><img class="floppyDisk" src="<c:url value='/resources/img/logos/floppyDisk.png'/>"></c:if>
						</h6>
					</a>
				</td> 
				
				<td>${dto.getBoard_date().substring(0, 10) }</td>
				<td>추천 ${dto.getBoard_like() }</td> 
				<td>조회 ${dto.getBoard_view() }</td>
				<td>
					<c:if test="${dto.getBoard_nickname() == nickname || !empty admin }">	<!-- 답변글과 현재 로그인한 사람이 같을 때 수정/삭제 버튼 보여줌 -->
     					<a href="javascript:void(0)" onclick="showModifyBtn(${dto.getBoard_no() })">
     						<img src="<c:url value='/resources/img/logos/more.png'/>" style="float: right; width: 25px">
						</a>
     				</c:if>
					<input type="button" onclick="boardEdit(${dto.getBoard_no()}, ${pageParam })" class="buttons modifies modifyBtn${dto.getBoard_no() }" value="수정" style="float: right; margin-left: 10px"></input>
		     		<input type="button" onclick="boardDelete(${dto.getBoard_no()}, ${pageParam })" value="삭제" class="buttons modifies modifyBtn${dto.getBoard_no() }" style="float: right"></input>
		     	</td>
			</tr>
			
			<%-- 모바일에서 보이게 --%>
			<tr class="mobile">
				<td colspan="7" >
					<a href="javascript:void(0)" onclick="showContents(${dto.getBoard_no()});" style="color: #000">
						<h6>
							${dto.getBoard_title() } [${dto.getBoard_reply() }]
							<c:if test="${dto.getBoard_hasFile() == 1 }"><img class="floppyDisk" src="<c:url value='/resources/img/logos/floppyDisk.png'/>"></c:if>
							
							<c:if test="${dto.getBoard_nickname() == nickname || !empty admin }">	<!-- 답변글과 현재 로그인한 사람이 같을 때 수정/삭제 버튼 보여줌 -->
		     					<a href="javascript:void(0)" onclick="showModifyBtn(${dto.getBoard_no() })">
		     						<img src="<c:url value='/resources/img/logos/more.png'/>" style="float: right; width: 25px">
								</a>
								
		     					<input type="button" onclick="boardEdit(${dto.getBoard_no()}, ${pageParam })" class="buttons modifies modifyBtn${dto.getBoard_no() }" value="수정" style="float: right; margin-left: 10px"></input>
		     					<input type="button" onclick="boardDelete(${dto.getBoard_no()}, ${pageParam })" value="삭제" class="buttons modifies modifyBtn${dto.getBoard_no() }" style="float: right"></input>
		     				</c:if>
						</h6>
					</a>
				</td> 
			</tr>
			
			<tr class="mobile">
				<td colspan="7"><b>> ${dto.getBoard_nickname() }</b></td>
			</tr>
			<tr class="mobile">
				<td colspan="7" align="center" >
					${dto.getBoard_date() }&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					추천 ${dto.getBoard_like() }&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					조회 ${dto.getBoard_view() }
				</td>
			</tr>
			
			<tr>
				<td colspan="7">
					<hr style="border-top: 1px solid white;">
				</td>
			</tr>
			
			<tr>
				<td colspan="7" align="center"> 
					<table id="contentsCon${dto.getBoard_no() }" class="board" style="width: 96%; background: #169e83; border-radius: 15px;"></table>
				</td>
			</tr>
			
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
















































