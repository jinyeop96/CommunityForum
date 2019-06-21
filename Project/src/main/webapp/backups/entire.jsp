<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>entire</title>
<script src="<c:url value='/resources/jquery-3.4.1.js' /> "></script>
	<style type="text/css">
		#hr{
			background-color: transparent;
		}
		.text-center{
			text-align: center;
		}
	</style>
</head>
<body>
		<jsp:include page="/resources/include/navigation.jsp" />
	
		 <!--  section01 -->
		<header class="masthead bg-primary text-white text-center">
	    <div class="container d-flex align-items-center flex-column">
	      
	    	<h3 class="masthead-heading text-uppercase mb-0">전체 게시물</h3>
	    	<br><br>
	      
	      	<div class="board" align="center"> 
	      		<form action="entireSearch.do" method="get">
	     			<input type="hidden" name="pageParam" value="1">
	      			 
	      			<table class="board font-black " id="entireList"> <%-- table : 선 긋기, table-hover : 마우스 올렸을 때 색변화 --%>
			      		<%------------------가져온 전체 게시물 있다면-------------- --%>
			      		<c:if test="${!empty list }">
				      		<tr class="t2">
				      			<th class="text-center"><h5>번호</h5></th>
				      			<th class="text-center"><h5>제목</h5></th>
				      			<th class="text-center"><h5>글쓴이</h5></th>
				      			<th class="text-center"><h5>작성일</h5></th>
				      			<th class="text-center"><h5>조회</h5></th>
				      			<th class="text-center"><h5>추천</h5></th>
				      		</tr>
			      		
			      			<%-- 가져온 게시물 뿌려주기 --%>
				      		<c:forEach items="${list }" var="dto">
					      		<tr>
					      		
					      			<td class="text-center">${dto.getEntire_no() }</td>
					      			<td ><a href="content.do?no=${dto.getEntire_no() }" style="color: #000">
					      				${dto.getEntire_title() }
					      			</a></td>
					      			<td class="text-center">${dto.getEntire_nickname() }</td>
					      			<td class="text-center">${dto.getEntire_date().substring(0, 10) }</td>
					      			<td class="text-center">${dto.getEntire_view() }</td>
					      			<td class="text-center">${dto.getEntire_like() }</td>
					      		</tr>
					      		
					      		<tr>
					      			<td colspan="7">
					      				<hr style="border: none; border-top: 1px solid white;" id="hr">
					      			</td>
					      		</tr>
					      		
				      		</c:forEach>
				      		
				      		<tr>
				      			<%-- 검색창 --%>
					      		<td colspan="6" align="center">
					      			<select name="entireSearchType">
					      				<option value="all">전체</option>
					      				<option value="title">제목</option>
					      				<option value="content">내용</option>
					      				<option value="nickname">글쓴이</option>
					      			</select>
					      			
					      			<input name="entireSearchData">
					      			<input type="submit" value="검색">
					      		</td>
				      		</tr>
				      	
				      		
				      		<%-- 하단부 페이징 및 검색창 --%>
					      	<tr>
				      			<td colspan="6" align="center">
				      				<%-----------------Left Arrows----------- --%>
				      				<c:if test="${ page.getPage() > page.getBlocks() }">
										<a href="entire.do?pageParam=1" class="blocks">[◀◀]</a>
										<a href="entire.do?pageParam=${page.getBlockStart() - 1}" class="blocks">[◀]</a>
									</c:if>
								 
				      				
				      				<%------------------ block 번호 ------------ --%>
						      		<c:forEach begin="${page.getBlockStart() }" end="${page.getBlockEnd() }" step="1" var="i">
						      			<c:if test="${page.getPage() == i }">
						      				<b>${i }</b> 
						      			</c:if>
						      
						      			<c:if test="${page.getPage() != i }">
						      				<b><a href="entire.do?pageParam=${i }" class="blocks">${i }</a></b>
						      			</c:if>
						      			&nbsp;&nbsp;&nbsp;
						      		</c:forEach>

						      		
						      		<%--------------------Right Arrows----------------- --%>
						      		<c:if test="${page.getBlockEnd() < page.getTotalPages() }">
										<a href="entire.do?pageParam=${page.getBlockEnd() + 1}" class="blocks">[▶]</a>
										<a href="entire.do?pageParam=${page.getTotalPages() }" class="blocks">[▶▶] </a>
									</c:if>
					      		</td>
					      		
				      		</tr>
			      		</c:if>
			      		
			      		
			      		<%---------전체 리스트 없다면------------ --%>
			      		<c:if test="${empty list }">
			      			<tr>
			     				<th colspan="6" align="center">
			     					<h3>검색하신 게시물에 존재하지 않습니다.</h3>
			     				</th>
			     			</tr>
			      			<tr>
			      				<td colspan="6" align="center">
					      			<select name="entireSearchType">
					      				<option value="all">전체</option>
					      				<option value="title">제목</option>
					      				<option value="content">내용</option>
					      				<option value="nickname">글쓴이</option>
					      			</select>
					      			<input name="entireSearchData">
					      			<input type="submit" value="검색">
					      		</td>
			      			</tr>
			      		</c:if>
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