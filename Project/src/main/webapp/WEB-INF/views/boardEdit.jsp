<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시물 수정</title>
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
		
		$(function(){
			$("#fileDelAll").click(function(){
				var check = $(this).is(":checked");
				
				if(check){
					$(".fileDel").prop("checked", true);
				} else{
					$(".fileDel").prop("checked", false);
				}
			})
			
		});
		
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
			
			<form action="boardEditOk.do" method="post" enctype="multipart/form-data">
				<input type="hidden" name="board_no" value="${dto.getBoard_no() }">
				<input type="hidden" name="board_type" value="${board_type }">
				<input type="hidden" name="pageParam" value="${pageParam }">
				<input type="hidden" name="board_nickname" value="${nickname }">
				
				
				<table class="board font-black ">
					<tr>
						<td align="left" colspan="3">
							<input name="board_title" placeholder="제목" class="title" value="${dto.getBoard_title() }" id="board_title">
						</td>
					</tr>
					
					<!-- 이 게시물이 첨부파일이 있을때 -->
					<c:if test="${!empty files }">
						<tr><td align="left">
							 첨부파일삭제 
						</td></tr> 

						<tr><td align="left"><input type="checkbox" id="fileDelAll" value="${files }">전체삭제 </td></tr>
						
						<c:forEach items="${files }" var="name">
							<tr>
								<td align="left">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
									<input type="checkbox" class="fileDel" name="fileDel" value="${name }">${name.substring(46) }
								</td>
							</tr>
						</c:forEach>
						
						<tr><td><br></td></tr>
					</c:if>					
					
					<!--  첨부파일 추가  -->
				 	<tr><td align="left">
						 첨부파일추가
					</td></tr>
					 					
					<tr id="fileArea" align="left">
						<td colspan="3">
							<input multiple="multiple" type="file" name="file">
						</td> 
					</tr> 
					
					<tr>
						<td>
						<textarea rows="10" cols="200" class="board resize-none" name="board_content" id="board_content" >${dto.getBoard_content() }</textarea>
					</tr>
					
					<tr>
						<td colspan="3" align="right">
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