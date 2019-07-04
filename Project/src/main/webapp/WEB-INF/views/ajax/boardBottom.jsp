<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>

	      	
      	
      			 
     			<table class="board font-black " id="entireList"> <%-- table : 선 긋기, table-hover : 마우스 올렸을 때 색변화 --%>
	      		<%------------------가져온 전체 게시물 있다면-------------- --%>
	      		<c:if test="${!empty list }">
	      		 
	      			<%-- 가져온 게시물 뿌려주기 --%>
		      		<c:forEach items="${list }" var="dto">
			      		<tr>
			      			<td colspan="7" ><a href="content.do?board_no=${dto.getBoard_no() }&board_type=${board_type}&pageParam=${page.getPage()}" style="color: #000">
			      				<h6>
			      					${dto.getBoard_title() } [${dto.getBoard_reply() }]
			      					<c:if test="${dto.getBoard_hasFile() == 1 }"><img class="floppyDisk" src="<c:url value='/resources/img/logos/floppyDisk.png'/>"></c:if>
			      				</h6>
			      				
			      			</a></td>
			      		</tr>
			      		<tr>
			      			<td><b>> ${dto.getBoard_nickname() }</b></td>
			      			<td>${dto.getBoard_date().substring(0, 10) }</td>
			      			<td class="text-center">추천 ${dto.getBoard_like() }</td>
			      			<td class="text-center">조회 ${dto.getBoard_view() }</td>
			      		</tr>
			      		
			      		<tr><td colspan="7"><hr></td></tr>
			      		
		      		</c:forEach>
		      	
		      		
		      		<%-- 하단부 페이징 및 검색창 --%>
		      		
		      
			      	<tr>
		      			<td colspan="6" align="center">
		      				<%-----------------Left Arrows----------- --%>
		      				<c:if test="${ page.getPage() > page.getBlocks() }">
								<a href="javascript:void(0)" onclick="boardBottom(1); pageUp(2)" class="blocks">[◀◀]</a>
								<a href="javascript:void(0)" onclick="boardBottom(${pageB.getBlockStart() - 1}); pageUp(2)" class="blocks">[◀]</a>
							</c:if>
						 
		      				
		      				<%------------------ block 번호 ------------ --%>
				      		<c:forEach begin="${page.getBlockStart() }" end="${page.getBlockEnd() }" step="1" var="i">
				      			<!-- 현재페이지 -->
				      			<c:if test="${page.getPage() == i }">
				      				<b>${i }</b> 
				      			</c:if>
				      
				      			<!--  no 현재페이지 -->
				      			<c:if test="${page.getPage() != i }">
				      				<b><a href="javascript:void(0)" onclick="boardBottom(${i }); pageUp(2)" class="blocks">${i }</a></b> 
				      			</c:if>
				      			&nbsp;&nbsp;&nbsp;
				      		</c:forEach>

				      		
				      		<%--------------------Right Arrows----------------- --%>
				      		<c:if test="${page.getBlockEnd() < page.getTotalPages() }">
								<a href="javascript:void(0)" onclick="boardBottom(${pageB.getBlockEnd() + 1}); pageUp(2)" class="blocks">[▶]</a>
								<a href="javascript:void(0)" onclick="boardBottom(${pageB.getTotalPages() }); pageUp(2)" class="blocks">[▶▶] </a>
							</c:if>
			      		</td>
		      		</tr>
		      		
		      		 
	      		</c:if>
	      		
	      		<c:if test="${empty list }">
	      			<c:if test="${!empty nickname }">
			      		<tr>
			      			<td colspan="7" align="right">
			      				<input class="buttons" type="button" value="글쓰기" onclick="location.href='boardWrite.do?board_type=${board_type}'">
			      			</td>
			      		</tr>
			      		<br><br>
	      			</c:if>
	      		
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
