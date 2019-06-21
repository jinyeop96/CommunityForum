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
			
			//$("#replyTable").hide();
			
			
			$("#reply").click(function(){	// 답장버튼 누르면 reply() 실행
				reply();
			});
		});	
		
		
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
	
	
		
		/// 좋아요 & 싫어요
		function updateLike(e_reply_no){
			$.ajax({
				url: "entireUpdateLike.do",
				type:"get",
				data: {"no": "${dto.getEntire_no() }",
						"e_reply_no": e_reply_no},
				success:function(result){
					getReplylist();
				},
				error:function(){
					alert("오류가 생겼습니다.");
				}
			});
		}

		function updateDislike(e_reply_no){
			$.ajax({
				url: "entireUpdateDislike.do",
				type:"get",
				data: {"no": "${dto.getEntire_no() }",
					   "e_reply_no": e_reply_no},
				success:function(result){
					getReplylist();
				},
				error:function(){
					alert("오류가 생겼습니다.");
				}
			});
		}
		
		
	</script>
</head>
<body>
	<jsp:include page="/resources/include/navigation.jsp" />
	
		 <!--  section01 -->
		<header class="masthead bg-primary text-white text-center">
	    <div class="container d-flex align-items-center flex-column">
	      
	      	
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
		      			<td class="t3">답글 : ${replyNum }</td> 
		      		</tr>
		      		
		      		<tr>
		      			<td><hr style="border: none; border-top: 1px solid white"></td>
		      		</tr>
		      		
		      		<tr>
		      			<td>${dto.getEntire_content() }</td>
		      		</tr>	
		      		
		      		<tr>
		      			<td><hr style="border: none; border-top: 1px solid white"></td>
		      		</tr>
		        </table>
				
				<%-- 답변글 뿌려주기 --%>
				<table class="board font-black" id="replyTable"> <%--table : 선 긋기, table-hover : 마우스 올렸을 때 색변화 --%>
		        </table> 
		        
		        <%-- 답변 글쓰기 폼 --%>
		        <table class="board">
		        	<tr>
		        		<td><textarea class="board resize-none" rows="4"  placeholder="댓글 쓰기" id="e_reply_content" ></textarea></td>
		        	</tr>
		        	<tr>
		        		<td colspan="2" align="right">
		        			<input id="e_reply_nickname" placeholder="nickname"> 
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