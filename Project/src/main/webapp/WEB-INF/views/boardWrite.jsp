<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>전체게시판</title>
<script src="<c:url value='/resources/jquery-3.4.1.js' /> "></script>
	<script type="text/javascript">
		function cancelConf(){
			if(confirm("취소하면 입력한 내용이 모두 사라집니다. 계속 하시겠습니까?")){
				history.back();
			}
		}
		
		function submitConf(){
			var board_title = $("#board_title").val();
			var board_content = $("#board_content").val();
			
			if(board_title == ""){
				alert("제목 써주세요");
				return false;
			} else if(board_content == ""){
				alert("글 꼭 써주세요");
				return false;
			}
			
			return true;
		}
		/*
		$(function(){
			$("#addFileBtn").click(function(){	
				var fileIndex = $('#fileArea').children().length;
				
				$("#fileArea").append(
						"<tr><td>" +
						"<input type='file' id='file"+fileIndex+"' style='width: 260px'>" +
						"<input align='right' type='button' id='delBtn"+fileIndex+"'  value='삭제' onclick='delFileBtn("+fileIndex+")' >" +
						"</td></tr>"
						);
			}); 
			
		}) 
		
		function delFileBtn(fileIndex){ 
			$("#file"+fileIndex).remove();
			$("#delBtn"+fileIndex).remove();
		}
		*/
		
	</script>
	<style type="text/css">
		.title{
		    width: 50%;
		    max-width: 500px;
		    min-width: 250px;
		}
		
		.msg{
			color: #ab3800;
			size: 15px;
		}
	</style>
	
</head>
<body>
	<jsp:include page="/resources/include/navigation.jsp" />
	
	 <!--  section01 -->
	<header class="masthead bg-primary text-white text-center">
		<div class="container d-flex align-items-center flex-column" >
			<c:if test="${board_type == 'entire' }">
	  		  	<h3 class="masthead-heading text-uppercase mb-0">전체 게시판</h3>
	      	</c:if>
	      	<c:if test="${board_type == 'free' }">
	  		  	<h3 class="masthead-heading text-uppercase mb-0">자유 게시판</h3>
	      	</c:if>
	      	<c:if test="${board_type == 'question' }">
	  		  	<h3 class="masthead-heading text-uppercase mb-0">질문 게시판</h3>
	      	</c:if>
	    	<br><br>
			
			<form action="boardWriteOk.do" method="post" enctype="multipart/form-data">
				<input type="hidden" name="board_type" value="${board_type }">
				<c:choose>
					<c:when test="${!empty nickname }">
						<input type="hidden" name="board_nickname" value="${nickname }">
					</c:when>

					<c:when test="${!empty admin }">
						<input type="hidden" name="board_nickname" value="${admin }">
					</c:when>
				</c:choose>
				
				<table class="board font-black ">
					<tr>
						<td align="left" colspan="3">
							<input name="board_title" placeholder="제목" class="title" id="board_title">
						</td>
					</tr>
					<tr style="padding: -5px;">
						<td align="left">
							<span class="msg">Ctrl를 누른채 선택시 중복가능</span><br>
							<span class="msg">용량은 최대 5MB입니다.</span> 
						</td>
					</tr>
					
					
					<tr id="fileArea" align="left">
						<td colspan="3">
							<input multiple="multiple" type="file" name="file">
						</td> 
					</tr>
					
					<tr>
						<td>
						<textarea rows="10" cols="200" class="board resize-none" name="board_content" id="board_content"></textarea>
					</tr>
					
					<tr>
						<td colspan="4" align="right">
							<c:if test="${user_type == 1 }">
								<input type="checkbox" name="upBoard" value="upBoard">공지사항 등록
							</c:if>
							<input type="button" value="취소" onclick="cancelConf()" class="buttons">
							<input type="submit" value="저장" class="buttons" onclick="return submitConf()">
						</td>
					</tr>
				</table>			
			</form>
		</div>
	</header>
	
	
	
	<jsp:include page="/resources/include/footer.jsp" />
	<jsp:include page="/resources/include/copyright.jsp" />
	<jsp:include page="/resources/include/modals.jsp" />	<%-- modal.jsp 끝에 js 파일 있어서 반응형 웹이 됩니다~ 마지막에 꼭 넣으십쏘~ --%>
	
</body>
</html>