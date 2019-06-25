<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판</title>
<script src="<c:url value='/resources/jquery-3.4.1.js' /> "></script>
	
</head>
<body>
		<jsp:include page="/resources/include/navigation.jsp" />
	
		 <!--  section01 -->
		<header class="masthead bg-primary text-white text-center">
	    <div class="container d-flex align-items-center flex-column">
	    
	      	<c:if test="${board_type == 'entire' }">
	  		  	<h3 class="masthead-heading text-uppercase mb-0">전체 게시판</h3>
	      	</c:if>
	      	<c:if test="${board_type == 'free' }">
	  		  	<h3 class="masthead-heading text-uppercase mb-0">자유 게시판</h3>
	      	</c:if>
	      	<c:if test="${board_type == 'question' }">
	  		  	<h3 class="masthead-heading text-uppercase mb-0">질문 게시판</h3>
	      	</c:if>
	      	<c:if test="${board_type == 'review' }">
	  		  	<h3 class="masthead-heading text-uppercase mb-0">후기 게시판</h3>
	      	</c:if>
	      	<c:if test="${board_type == 'findPeople'}">
	      		<h3 class="masthead-heading text-uppercase mb-0">사람 찾습니다!</h3>
	      	</c:if>
	    	<br><br>
	    	
	      	<%--------------------------------------------------- --%>
	      	<div class="board" align="center"> 
	      		<%-- 검색내용 상단에 표시 --%>
	      			<c:if test="${!empty searchData }">
			      	<c:if test="${searchType == 'all' }">
			  		  	<b>전체</b>
			      	</c:if>
			      	<c:if test="${searchType == 'title' }">
			  		  	<b>제목</b>
			      	</c:if>
			      	<c:if test="${searchType == 'content' }">
			  		  	<b>내용</b>
			      	</c:if>
			      	<c:if test="${searchType == 'nickname' }">
			  		  	<b>글쓴이</b>
			      	</c:if>

			      	<b> -> ${searchData } (으)로 검색하였습니다.</b> 
	      		</c:if>
	      	
	      		<form action="boardSearch.do" method="get">
	     			<input type="hidden" name="pageParam" value="1">
	     			<input type="hidden" name="board_type" value="${board_type }">
	      			 
	      			<table class="board font-black " id="entireList"> 
			      		<%------------------가져온 전체 게시물 있다면-------------- --%>
			      		<c:if test="${!empty list }">
				      		<tr>
				      			<td colspan="7" align="right">
				      				<input class="buttons" type="button" value="글쓰기" onclick="location.href='boardWrite.do?board_type=${board_type}'">
				      			</td>
				      		</tr>
				      		<br><br>
			      		 
			      			<%-- 가져온 게시물 뿌려주기 --%>
				      		<c:forEach items="${list }" var="dto">
					      		<tr>
					      			<td colspan="7" ><a href="content.do?board_no=${dto.getBoard_no() }&board_type=${board_type}&pageParam=${page.getPage()}" style="color: #000">
					      				<h6>${dto.getBoard_title() } [${dto.getBoard_reply() }]</h6>
					      			</a></td>
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
					      		
				      		</c:forEach>
				      	
				      		
				      		<%-- 하단부 페이징 및 검색창 --%>
				      		
				      		
					      	<tr>
				      			<td colspan="6" align="center">
				      		<%------------------------ 일반 게시물이라면 ( 검색하지 않은 상태 ) ----------------------------%>
				      			<c:if test="${empty searchData }">
				      				<%-----------------Left Arrows----------- --%>
				      				<c:if test="${ page.getPage() > page.getBlocks() }">
										<a href="board.do?pageParam=1&board_type=${board_type }&boardSearch=no" class="blocks">[◀◀]</a>
										<a href="board.do?pageParam=${page.getBlockStart() - 1}&board_type=${board_type }&boardSearch=no" class="blocks">[◀]</a>
									</c:if>
								 
				      				
				      				<%------------------ block 번호 ------------ --%>
						      		<c:forEach begin="${page.getBlockStart() }" end="${page.getBlockEnd() }" step="1" var="i">
						      			<!-- 현재페이지 -->
						      			<c:if test="${page.getPage() == i }">
						      				<b>${i }</b> 
						      			</c:if>
						      
						      			<!--  no 현재페이지 -->
						      			<c:if test="${page.getPage() != i }">
						      				<b><a href="board.do?pageParam=${i }&board_type=${board_type }&boardSearch=no" class="blocks">${i }</a></b>
						      			</c:if>
						      			&nbsp;&nbsp;&nbsp;
						      		</c:forEach>

						      		
						      		<%--------------------Right Arrows----------------- --%>
						      		<c:if test="${page.getBlockEnd() < page.getTotalPages() }">
										<a href="board.do?pageParam=${page.getBlockEnd() + 1}&board_type=${board_type }&boardSearch=no" class="blocks">[▶]</a>
										<a href="board.do?pageParam=${page.getTotalPages() }&board_type=${board_type }&boardSearch=no" class="blocks">[▶▶] </a>
									</c:if>
				      			</c:if>
							
							
							
							<%------------------------ 검색한 상태라면 ----------------------------%>
									
								<c:if test="${!empty searchData }">
									<c:if test="${ page.getPage() > page.getBlocks() }">
										<a href="boardSearch.do?pageParam=1&board_type=${board_type }&searchType=${searchType}&searchData=${searchData}" class="blocks">[◀◀]</a>
										<a href="boardSearch.do?pageParam=${page.getBlockStart() - 1}&board_type=${board_type }&searchType=${searchType}&searchData=${searchData}" class="blocks">[◀]</a>
									</c:if>
								 
				      				
				      				<%------------------ block 번호 ------------ --%>
						      		<c:forEach begin="${page.getBlockStart() }" end="${page.getBlockEnd() }" step="1" var="i">
						      			<c:if test="${page.getPage() == i }">
						      				<b>${i }</b> 
						      			</c:if>
						      
						      			<c:if test="${page.getPage() != i }">
						      				<b><a href="boardSearch.do?pageParam=${i }&board_type=${board_type }&searchType=${searchType}&searchData=${searchData}" class="blocks">${i }</a></b>
						      			</c:if>
						      			&nbsp;&nbsp;&nbsp;
						      		</c:forEach>

						      		
						      		<%--------------------Right Arrows----------------- --%>
						      		<c:if test="${page.getBlockEnd() < page.getTotalPages() }">
										<a href="boardSearch.do?pageParam=${page.getBlockEnd() + 1}&board_type=${board_type }&searchType=${searchType}&searchData=${searchData}" class="blocks">[▶]</a>
										<a href="boardSearch.do?pageParam=${page.getTotalPages() }&board_type=${board_type }&searchType=${searchType}&searchData=${searchData}" class="blocks">[▶▶] </a>
									</c:if>
								</c:if>	
					      		</td>
				      		</tr>
			      		</c:if>
			      		
			      		
			      		<%---------전체 리스트 없다면------------ --%>
			      		<c:if test="${empty list }">
			      			<tr> 
				      			<td colspan="7" align="right">
				      				<input class="buttons" type="button" value="글쓰기" onclick="location.href='boardWrite.do?board_type=${board_type}'">
				      			</td>
				      		</tr>
			      		
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

						
						<%--검색창 --%>
		      			<tr>
		      				<td colspan="6" align="center">
				      			<select name="searchType" class="radius-10px">
				      				<option value="all">전체</option>
				      				<option value="title">제목</option>
				      				<option value="content">내용</option>
				      				<option value="nickname">글쓴이</option>
				      			</select>
				      			<input name="searchData" class="radius-10px">
				      			<input type="submit" value="검색"  class="searchBtn"> 
				      		</td>
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