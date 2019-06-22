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
	</script>
	<style type="text/css">
		.title{
		    width: 50%;
		    max-width: 500px;
		    min-width: 250px;
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
			
			<form action="boardWriteOk.do" method="post">
				<input type="hidden" name="board_type" value="${board_type }">
				<table class="board font-black ">
					<tr>
						<td align="left"><input name="board_title" placeholder="제목" class="title"></td>
					</tr>
					
					<tr>
						<td>
						<textarea rows="10" cols="200" class="board resize-none" name="board_content" ></textarea>
					</tr>
					
					<tr>
						<td colspan="2" align="right" >
							<input name="board_nickname" placeholder="닉네임" class="radius-10px">
							<input name="board_pwd" placeholder="비밀번호" class="radius-10px">
						</td>
					</tr>
					
					<tr>
						<td colspan="3" align="right">
							<input type="button" value="취소" onclick="cancelConf()" class="buttons">
							<input type="submit" value="저장" class="buttons">
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