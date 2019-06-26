<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>${dto.getBoard_title() }</title>
<script src="<c:url value='/resources/jquery-3.4.1.js' /> "></script>
	<script type="text/javascript">
		$(function(){
			$(".files").hide();	

			getReplyList();	// 처음 실행될 때 답변글 가져오는 함수 실행.
			boardBottom();
			
			$("#reply").click(function(){	// 답장버튼 누르면 reply() 실행
				reply();
			});
			
		});
		
		
		
		function showFile(){
			$(".files").toggle();  
		}
		
		// 페이지 버튼 눌렀을 떄 위쪽으로 올라가는 에니메이션
		function pageUp(num){	
			if(num == 1){
				$("html, body").animate({scrollTop : $("#dislike").offset().top}, 400); 
			} else {
				$("html, body").animate({scrollTop : $("#reply_content").offset().top}, 400);
			}
		}
		
		
		function getReplyList(pageParam){  // 해당 글의 답변 다 가져오기
			if(pageParam == null){
				pageParam = 1;
			}
			
			$.ajax({
				url: "replyList.do",
				type:"post",
				async: false,
				data: {"board_no": "${dto.getBoard_no() }",
					   "pageParam": pageParam},
					   
				success:function(result){
					$("#replyNum").text(result.replyNum);
					$("#replyTable").html(result).trigger("create");

				}
			});
		};	// getReplyList()
		
		function boardBottom(pageParam){  
			if(pageParam == null){
				pageParam = ${pageParam};	//가장 처음 boardContent.jsp에 들어올 때는 board.jsp의 몇번째 페이지 였는지 알아야함. 안그러면 bottomBoard에는 무조건 page1으로 감.
			}
			
			$.ajax({
				url: "boardBottom.do",
				type:"post",
				async: false,
				data: {"pageParam": pageParam,
					   "board_type": "${dto.getBoard_type()}"},
				success:function(result){
					$("#boardBottom").html(result).trigger("create");
				}
			});
		};	// getReplyList()
		
		
		function reply(){	// 답변 등록
		
			
			$.ajax({
				url:"replyUpdate.do",
				type:"get",
				data: { "board_no": "${dto.getBoard_no()}",			//해당 원글 번호
						"reply_content": $("#reply_content").val(),	//답글
						"reply_nickname": $("#reply_nickname").val() },	// 닉네임 (나중에 session으로 처리할 때 nickname으로 할 예정)
			
				success:function(){
						$("#reply_content").val("");
						$("#reply_nickname").val("");
						getReplyList();			// 댓글 달기 성공하면 바로 답변글 DB에서 가져옴
				}
			});
		};	//reply();
	
	
		/// 좋아요 & 싫어요
		function updateLike(reply_no){
			$.ajax({
				url: "updateLike.do",
				type:"get",
				data: {"reply_no": reply_no},
				success:function(result){
					getReplyList();
				},
				error:function(){
					alert("오류가 생겼습니다.");
				}
			});
		}

		function updateDislike(reply_no){
			$.ajax({
				url: "updateDislike.do",
				type:"get",
				data: {"reply_no": reply_no},
				success:function(result){
					getReplyList();
				},
				error:function(){
					alert("오류가 생겼습니다.");
				}
			});
		}
		
		
		//////////////////////////////////////원글 좋아요&싫어요////////////////
		function boardUpdateLike(board_no){
			$.ajax({
				url: "boardUpdateLike.do",
				type:"get",
				data: {"board_no": board_no},
				success:function(result){
					getLikeDislike();
				},
				error:function(){
					alert("오류가 생겼습니다.");
				}
			});
		}

		function boardUpdateDislike(board_no){
			$.ajax({
				url: "boardUpdateDislike.do",
				type:"get",
				data: {"board_no": board_no},
				success:function(result){
					getLikeDislike();
				},
				error:function(){
					alert("오류가 생겼습니다.");
				}
			});
		}
		
		function getLikeDislike(){
			$.ajax({
				url: "getLikeDislike.do",
				type:"get",
				data: {"board_no": "${dto.getBoard_no()}"},
				success:function(result){
					$(".boardUpdateLike").text(result.likes);
					$(".boardUpdateDislike").text(result.dislikes); 
				},
				error:function(){
					alert("오류가 생겼습니다.");
				}
			});
		}
		
	</script>
	
	<style type="text/css">
		.attach{
		    font-weight: bold;
		    color: white;
		    text-decoration: underline;
		    font-style: italic;
		    font-size: 15px;
		}
	</style>
</head>
<body>
	<jsp:include page="/resources/include/navigation.jsp" />
	
		 <!--  section01 -->
		<header class="masthead bg-primary text-white text-center">
	    <div class="container d-flex align-items-center flex-column">
	      
	      	<%pageContext.setAttribute("newLineChar", "\n"); %>	<%-- \n -> newLineChar로 --%>
	      	<div class="board" align="center"> 
      			<table class="board font-black">
		      		<tr>
		      			<th class="content-title">${dto.getBoard_title() }</th>
		      		</tr>
		      		
		      		<tr>
		      			<td><b>> ${dto.getBoard_nickname() }</b></td>
		      		</tr>
		      		
		      		<tr>
		      			<td>${dto.getBoard_date() } </td>
		      		</tr>
		      		
		      		<tr>
		      			<td>조회수  : ${dto.getBoard_view() }</td> 
		      		</tr>
		      		
		      		<tr>
		      			<td>추천 : <span class="boardUpdateLike">${dto.getBoard_like() }</span></td> 
		      		</tr>
		      				      		
		      		<tr>
		      			<td id="dislike">비추천 : <span class="boardUpdateDislike">${dto.getBoard_dislike() }</span></td> 
		      		</tr>
		      				      		
		      		<tr>
		      			<td>답글 : <span id="replyNum">${replyNum }</span></td> 
		      		</tr>
		      		
		      		<tr>
		      			<td><hr style="border: none; border-top: 1px solid white"></td>
		      		</tr>
		      		
		      		<c:if test="${!empty files}">
		      			<tr align="right"><td><a href="javascript:showFile()" class="attach">첨부파일</a></td></tr>

	      				<c:forEach items="${files }" var="file" >
		      				<tr align="right" class="files"> 
		      					<td> 
		      						<a class="font-black attach" href="<spring:url value='/image/${file }'/> " >
		      						 	<span>${file.substring(48) }</span>
		      						</a>
		      					</td>
		      				</tr>
	      				</c:forEach>
		      		</c:if>
		      		
		      		<tr>
		      			<td>
		      				<c:if test="${!empty images }">
		      					<c:forEach items="${images }" var="image">
		      						<img style="max-width: 80%" src="<spring:url value='/image/${image }'/>"><br>
		      					</c:forEach>
		      				</c:if>
		      				
		      				<c:set var="content" value="${fn:replace(dto.getBoard_content(), '  ', '&nbsp;&nbsp;' ) }"></c:set>	<%-- 공백 가능하게 처리해줌 --%>
      						${fn:replace(content , newLineChar, "<br>")} 	<!-- \n를 해주는 과정 --> <br><br>
		      			</td>
		      		</tr>	
		      		
		      		<tr>
		      			<td align="center">
		      				<a href="javascript:boardUpdateLike(${dto.getBoard_no()})">
			      				<img class="contentRec"  src="<c:url value='/resources/img/logos/like2.png'/>">&nbsp;&nbsp;&nbsp;
			      				<span class="boardUpdateLike" style="color: white">${dto.getBoard_like() }</span>&nbsp;&nbsp;&nbsp;
		      				</a>
		      				
		      				<a href="javascript:boardUpdateDislike(${dto.getBoard_no()})">
			      				<img class="contentRec" src="<c:url value='/resources/img/logos/dislike2.png'/>">&nbsp;&nbsp;&nbsp;
			      				<span class="boardUpdateDislike" style="color: white">${dto.getBoard_dislike() }</span>
		      				</a>
		      			</td>
		      		</tr>

		      		<tr>
		      			<td><hr style="border: none; border-top: 1px solid white"></td>
		      		</tr>
		      		
		        </table>
				
				<%-- 답변글 뿌려주기 --%>
				<table class="board font-black" id="replyTable"></table> <%--table : 선 긋기, table-hover : 마우스 올렸을 때 색변화 --%> 
		        
		        <%-- 답변 글쓰기 폼 --%>
		        <table class="board">
		        	<tr>
		        		<td><textarea class="board resize-none" rows="4"  placeholder="댓글 쓰기" id="reply_content" ></textarea></td>
		        	</tr>
		        	<tr>
		        		<td colspan="2" align="right">
		        			<input id="reply_nickname" placeholder="nickname"> 
			        		<input type="button" id="reply" value="저장">
	        			</td>
		        	</tr>
		        	
		        	<tr><td><hr style="border: none; border-top: 1px solid white"></td></tr>
		        </table>
		        
		        <%-- 답글 아래 나오는 게시글 --%>
		        <table id="boardBottom" class="board font-black"></table>
		        
     		 </div>
	   	 </div>
	  </header>
	  
	  
	  <jsp:include page="/resources/include/footer.jsp" />
	  <jsp:include page="/resources/include/copyright.jsp" />
	  <jsp:include page="/resources/include/modals.jsp" />	<%-- modal.jsp 끝에 js 파일 있어서 반응형 웹이 됩니다~ 마지막에 꼭 넣으십쏘~ --%>
	
</body>
</html>