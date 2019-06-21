<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Content</title>
<script src="<c:url value='/resources/jquery-3.4.1.js' /> "></script>
	<script type="text/javascript">
		$(function(){
			getReplylist();	// 처음 실행될 때 답변글 가져오는 함수 실행.
			
			$("#reply").click(function(){	// id="reply" 버튼 누르면 reply() 실행
				reply();
			});
		});	
		
		function reply(){	// 답변 등록
			$.ajax({
				url:"<c:url value='replyUpdate.do' />",
				type:"get",
				data: { "no": "${dto.getEntire_no()}",			//해당 원글 번호
						"e_reply_content": $("#e_reply_content").val(),	//답글
						"e_reply_nickname": $("#e_reply_nickname").val() },	// 닉네임 (나중에 session으로 처리할 때 nickname으로 할 예정)
			
				success:function(){
						$("#e_reply_content").val("");
						$("#e_reply_nickname").val("");
						getReplylist();			// 댓글 달기 성공하면 바로 답변글 DB에서 가져옴
				}
			});
		};	//reply();
	
	
		function getReplylist(pageParam){  // 해당 글의 답변 다 가져오기
			if(pageParam == null){
				pageParam = 1;
			}
			
			$.ajax({
				url: "replyList.do",
				type:"post",
				data: {"no": "${dto.getEntire_no() }",
						"pageParam": pageParam},
				success:function(result){
					$("#replyTable").html(result).trigger("create");
				}
			});
		};	// getReplyList()
			
	</script>
</head>
<body>
	<jsp:include page="/resources/include/navigation.jsp" />
	
		 <!--  section01 -->
		<header class="masthead bg-primary text-white text-center">
	    <div class="container d-flex align-items-center flex-column">
	      
	    	<h3 class="masthead-heading text-uppercase mb-0">content</h3>
	      	
	      	<div class="board" align="center"> 
      			<table class="board font-black">
		      		<tr class="t2">
		      			<th class="content-title">${dto.getEntire_title() }</th>
		      		</tr>
		      		
		      		<tr class="t2">
		      			<td class="t3">${dto.getEntire_nickname() }</td>
		      		</tr>
		      		
		      		<tr>
		      			<td class="t3">${dto.getEntire_date() } </td>
		      		</tr>
		      		
		      		<tr>
		      			<td class="t3">조회수  : ${dto.getEntire_view() }</td> 
		      		</tr>
		      		
		      		<tr>
		      			<td class="t3">추천 : ${dto.getEntire_like() }</td> 
		      		</tr>
		      				      		
		      		<tr>
		      			<td class="t3">비추천 : ${dto.getEntire_dislike() }</td> 
		      		</tr>
		      				      		
		      		<tr>
		      			<td class="t3">답글 : ${dto.getEntire_reply() }</td> 
		      		</tr>
		      		
		      		<tr>
		      			<td><hr></td>
		      		</tr>
		      		
		      		<tr>
		      			<td>${dto.getEntire_content() }</td>
		      		</tr>	
		      		
		      		<tr>
		      			<td><hr></td>
		      		</tr>
		      		
		        </table>
				
				<%-- 답변글 뿌려주기 --%>
				<!-- <div class="board replyTable"> -->
				<table class="board font-black" id="replyTable"> <%--table : 선 긋기, table-hover : 마우스 올렸을 때 색변화 --%>
		      		<%pageContext.setAttribute("newLineChar", "\n"); %>	<%-- \n -> newLineChar로 --%>
					<%-- ----------------가져온 게시물의 답변글이 있다면----------------%>
					<%-- <c:if test="${!empty list }">
						가져온 게시물 뿌려주기
				   		<c:forEach items="${list }" var="reply">
				     		<tr>
				     			<th style="border: 1px solid red;">
				     				<c:if test="${!empty reply.getE_reply_indent() }">
									<c:forEach begin="1" end="${reply.getE_reply_indent() }" step="1">
					      				>
					      			</c:forEach>
				     				</c:if>
				     				${reply.getE_reply_nickname() }
				     			</th>
				     			<td ><img class="rec" src="<c:url value='/resources/img/logos/like2.png'/>"> ${reply.getE_reply_like() }</td>
				     			<td><img class="rec" src="<c:url value='/resources/img/logos/dislike2.png'/>"> ${reply.getE_reply_dislike() }</td>
				     			<td >${reply.getE_reply_date() }</td>
				     		</tr>
						
				     		<tr><td colspan="4">
				     			<c:if test="${!empty reply.getE_reply_indent() }">	indent 만큼 띄어쓰기를 해줄거임.
									<c:forEach begin="1" end="${reply.getE_reply_indent() }" step="1">
					      				&nbsp;&nbsp;&nbsp;
					      			</c:forEach>
				     			</c:if>
				     			<c:set var="replyStr" value="${fn:replace(reply.getE_reply_content(), '  ', '&nbsp;&nbsp;' ) }"></c:set>	공백 가능하게 처리해줌
				      			${fn:replace(replyStr , newLineChar, "<br>")} 	<!-- \n를 해주는 과정 --> 
				     		</td></tr>
					     		
					    		
							<tr>
								<td colspan="4">
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
				      			<td colspan="2" align="center" style="border: 1px solid red;">
				      				---------------Left Arrows---------
				      				<c:if test="${ page.getPage() > page.getBlocks() }">
										<a href="entire.do?pageParam=1" class="blocks">[◀◀]</a>
										<a href="entire.do?pageParam=${page.getBlockStart() - 1}" class="blocks">[◀]</a>
									</c:if>
								 
				      				
				      				---------------- block 번호 ----------
						      		<c:forEach begin="${page.getBlockStart() }" end="${page.getBlockEnd() }" step="1" var="i">
						      			<c:if test="${page.getPage() == i }">
						      				<b>${i }</b> 
						      			</c:if>
						      
						      			<c:if test="${page.getPage() != i }">
						      				<c:set value="${i }" var="pageParam"></c:set>	page넘기려면 set 해줘야함
						      				<b><a href="javascript:void(0)" onclick="getReplylist(${pageParam})" class="blocks">${i }</a></b>
						      			</c:if>
						      			&nbsp;&nbsp;&nbsp;
						      		</c:forEach>
				
						      		
						      		------------------Right Arrows---------------
						      		<c:if test="${page.getBlockEnd() < page.getTotalPages() }">
										<a href="entire.do?pageParam=${page.getBlockEnd() + 1}" class="blocks">[▶]</a>
										<a href="entire.do?pageParam=${page.getTotalPages() }" class="blocks">[▶▶] </a>
										
									</c:if>
					      		</td>
					      		
					      		
					      		검색창
					      		<td colspan="2" align="center" style="border: 1px solid red;">
					      			<select name="entireSearchType">
					      				<option value="all">전체</option>
					      				<option value="title">제목</option>
					      				<option value="content">내용</option>
					      				<option value="nickname">글쓴이</option>
					      			</select>
					      			
					      			<input name="entireSearchData" id="inputSearch">
					      			<input type="submit" value="검색">
					      			
					      		</td>
				      		</tr>
				   	</c:if> --%>
		        </table> 
		        <!-- </div> -->
		        
		        <%-- 답변 글쓰기 폼 --%>
		        <table class="board">
		        	<tr>
		        		<td><textarea class="board reply-board" rows="4"  placeholder="댓글 쓰기" id="e_reply_content" ></textarea></td>
		        	</tr>
		        	<tr>
		        		<td colspan="2" align="right">
		        			nickname : <input id="e_reply_nickname">
			        		<input type="button" id="reply" value="저장">
	        			</td>
		        	</tr>
		        	<tr>
		        		<td><hr></td>
		        	</tr>
		        </table>
     		 </div>
	   	 </div>
	  </header>
	  
	  
	  <jsp:include page="/resources/include/footer.jsp" />
	  <jsp:include page="/resources/include/copyright.jsp" />
	  <jsp:include page="/resources/include/modals.jsp" />	<%-- modal.jsp 끝에 js 파일 있어서 반응형 웹이 됩니다~ 마지막에 꼭 넣으십쏘~ --%>
	
</body>
</html>