<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>QNA</title>
<!-- jqeury import -->
<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>

<script>

$(function(){
	//jquery mouseover와 mouseleave를 통해 해당 태그에 마우스 이벤트를 발생시킨다.
	//해당태그에 마우스가 올라갈 시 display block을 시켜 태그를 보여주고
	//마우스가 떠날시 display none으로 태그를 숨긴다.
	$("#qna_btn").mouseover(function(){
		$("#qna_show1").css("display","block");
	});
	
	$("#qna_btn").mouseleave(function(){
		$("#qna_show1").css("display","none");
	});
	
	$("#q1").mouseover(function(){
		$("#qna_show2").css("display","block");
	});
	$("#q1").mouseleave(function(){
		$("#qna_show2").css("display","none");
	});
	
	
	//qna form 등록 버튼 입력시 
	$("#qnaform").submit(function(event){
		//이벤트막기
		event.preventDefault();

	var content=$("#content").val();
	var title=$("#title").val();
	var pw=$("#pw").val();

	console.log(content);
	console.log(title);
	console.log(pw);
	//비동기통신으로 qna 질문 등록
	$.ajax({
		url:"/allqna.do/qnainsert.do",
		type:"post",
		data:{
			content:content,
			title:title,
			pw:pw
		},
		success:function(data){
			if (data == 1){
				//정상적으로 등록되었을시 data는 1을 반환한다.
				alert("등록 되었습니다");
				$("#content").val("");
				$("#title").val("");
				$("#pw").val("");
			} else{
				alert("등록에 실패하였습니다");ㅍ 
			}
		}
		
	});
		
	});
	
});
function div_OnOff(v,id){
	//라디오 버튼 value 
	if(v=="1"){
		document.getElementById(id).style.display=""; //보여줌
	}else {
		document.getElementbyId(id).style.display="nome"; //숨김
	}
}

</script>
<body>
	<jsp:include page="/resources/include/navigation.jsp" />
	

	 <!--  section01 -->
	<header class="masthead bg-primary text-white text-center">
    <div class="container d-flex align-items-center flex-column">
      
      <h1 class="masthead-heading text-uppercase mb-0" >고객센터</h1> 
      <div id="qnaDiv" align="left">
      	
      	<h1 style = " font-size:20px; margin-top:40px;" align="center">자주하는 질문</h1>
      		
      		<h6 id="qna_btn">군인만 가입이 가능한가요?</h6>
      		<div>
	      		<h5 id="qna_show1" style="display:none;">대한민국 국민 누구나 가입가능합니다.</h5>
	      	</div>
      	
      		<br id="br1">
      	
      		<br id="br2">
      		<h6 id="q1">숙식 업체의 선별기준은 무엇인가요?</h6>
      		  <h5 id="qna_show2" style="display:none;">대한민국 국민 누구나 가입가능합니다.</h5>
      		</div>
    	<br>
    	<br>
    
    		<div id="qnaDiv2">
    		
    			<input type="radio" name="qnabtn" value="1" onclick="div_OnOff(this.value,'QNAP');">원하는 질문이 없으신가요?
    		
    			</div>
    	<div id="QNAP" style="display:none" align="center">	 
    
      	
      		<form role="qnaform" id="qnaform" action="" method="post">
      						<!-- qnalist 페이지 연동 -->
      		  	  		   	<a href="/allqnalist.do" style="color:black;">자주하는 질문들 & 내질문 보러가기</a>
      		  	  		   	<br>
      		<tr>
      		<th>궁금하신점을 작성해주세요~</th> <br></tr>
      		<tr>
      		<th>	<textarea id="content" name ="content" cols="60" rows="10"  align="center"></textarea> </th>
      		<br>
      		</tr>
      		<tr>
      		<th>제목</th>
      		<td><input class="input" id="title"></td> 
      		</tr>
      		<tr>
			<th>질문 비밀번호</th>
      				<td><input class="input" id="pw" type="password" name="pwd" ></td>
      		</tr>
    		<div>
 
      		<input type="submit" value="등록" >
      		<input type="reset" value="취소">
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