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
	var deletecount =0;
	var modifycount=0;
	$("#modify").click(function(){
			modifycount=1;
			deletecount=0;
			$("#passch").css("display","block");
	});
	$("#pwcheck").click(function(){
		var pw= $("#pass").val();
		
		if (pw == "1111"){
			if (modifycount == 1){
				window.location.href="/gonggi.do/modify.do/"+${NoticeDTO.seq};				
			}
			else if (deletecount == 1){
				$.ajax({
					url:"/gonggiDelete"
				   ,type:"post"
				   ,data:{
					   seq:${NoticeDTO.seq}
				   }
				   ,success:function(data){
					   if (data == 1){
						   alert("삭제되었습니다")
						   window.location.href="/gonggi.do";
					   }
					   else {
						   alert("삭제에 실패하였습니다");
					   }
					   
				   }
				});	
			}
		}
		else {
			alert("비밀번호가 틀렸습니다");
		}
	});
	
	$("#delete").click(function(){
		deletecount=1;
		modifycount=0;
		$("#passch").css("display","block");

	});
	$("#list").click(function(){
		window.location.href="/gonggi.do"
	});
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
  		<input type="text" class="form-control" id="title" name="title" placeholder="제목을 입력해주세요" style="width: 100%; height: 50px; position: relative;"value="${NoticeDTO.title}" readonly>
	</div>
   	<div style="margin: auto;  height: 370px; margin-top: 10px; width: 900px; " >
   		<textarea id="content" name="content" style="width: 100%; height: 100%;" placeholder="내용을 작성해주세요" readonly>${NoticeDTO.content}</textarea>
   	</div>

		<button type="button" id="modify">수정</button>
		<button type="button" id="delete">삭제</button>
		<button type="button" id="list">목록</button>
	<div id="passch" style="display:none; margin-top:10px; width:500px;">
	<div style="width:330px; margin:auto;">
		<label for="pass">비밀번호</label>
		<input type="password" id="pass" >
		<button type="button" class="btn btn-secondary" id="pwcheck" style="height:30px; padding-bottom:30px;">확인</button>
	</div>
   </div> 
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