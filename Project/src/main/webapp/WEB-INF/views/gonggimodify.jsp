<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>QNA</title>
<!-- jqeury import -->
<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>


<style>

.paginate_button > a{
color:white;

}
.active > a{
color:black;
}
</style>
<script>
$(function(){
	if ("${result}"=="success"){
		alert("등록되었습니다");
	} else if ("${result}" == "fail"){
		alert("등록 실패하였습니다");
	}
	
});

</script>

<body>
	<jsp:include page="/resources/include/navigation.jsp" />
	

	 <!--  section01 -->
	<header class="masthead bg-primary text-white text-center">
    <div class="container d-flex align-items-center flex-column">
      
      <h1 class="masthead-heading text-uppercase mb-0" >공지사항 등록</h1> 
      <div id="qnaDiv" align="center">
      	
      	<h1 style = " font-size:20px; margin-top:20px;" align="center" ></h1>
      		
      		<div style="margin-bottom:300px;">
      		<!-- qna 리스트 출력 -->
      		<form method="post" action="/gonggiwriteUpdate.do">
      		<!-- <div class="row">
      			<div class="col-lg-12">
      				<label for="title">제목</label>
      				<input type="text" id="title">
      			</div>
      			<div class="col-lg-12">
	      			<label for="content">내용</label>
	      			<textArea id="content"></textArea>
	      		</div>
      		</div> -->
     <div style="margin: auto;  height: 70px; margin-top: 20px; width: 900px;" >
  		<input type="text" class="form-control" id="title" name="title" placeholder="제목을 입력해주세요" style="width: 100%; height: 50px; position: relative;" value="${NoticeDTO.title}" required>
	</div>
   	<div style="margin: auto;  height: 370px; margin-top: 10px; width: 900px; " >
   		<textarea id="content" name="content" style="width: 100%; height: 100%;" placeholder="내용을 작성해주세요" required>${NoticeDTO.content}</textarea>
   	</div>
	 <input type="hidden" name="seq" value="${NoticeDTO.seq}">
      			
      			<button type="submit">등록</button>
      			<button type="reset">취소</button>
      		</form>
      		</div>
      </div>
     </div>
    	
  
  </header>
  </head>
  
 <jsp:include page="/resources/include/footer.jsp" />
  <jsp:include page="/resources/include/copyright.jsp" />
  <jsp:include page="/resources/include/modals.jsp" />	<%-- modal.jsp 끝에 js 파일 있어서 반응형 웹이 됩니다~ 마지막에 꼭 넣으십쏘~ --%>

</body>
</html>