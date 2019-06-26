<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Q&A</title>
<!-- jquery import -->
<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>

<script>

$(function(){
	//jquery mouseover와 mouseleave를 통해 해당 태그에 마우스 이벤트를 발생시킨다.
	//해당태그에 마우스가 올라갈 시 display block을 시켜 태그를 보여주고
	//마우스가 떠날시 display none으로 태그를 숨긴다.
	$("#qna1").mouseover(function(){
		$("#qna_show1").css("display","block");
	});
	$("#qna1").mouseleave(function(){
		$("#qna_show1").css("display","none");
	});
	
	$("#qna2").mouseover(function(){
		$("#qna_show2").css("display","block");
	});
	$("#qna2").mouseleave(function(){
		$("#qna_show2").css("display","none");
	});
	
	$("#qna3").mouseover(function(){
		$("#qna_show3").css("display","block");
	});
	$("#qna3").mouseleave(function(){
		$("#qna_show3").css("display","none");
	});
	
	$("#qna4").mouseover(function(){
		$("#qna_show4").css("display","block");
	});
	$("#qna4").mouseleave(function(){
		$("qna_show4").css("display","none");
	});
	
	$("#qna5").mouseover(function(){
		$("#qna_show5").css("display","block");
	});
	$("#qna5").mouseleave(function(){
		$("qna_show5").css("display","none");
	});

	
	
	//qna form 등록 버튼 입력시 
	$("#qnaform").submit(function(event){
		//이벤트막기
		event.preventDefault();

	var content=$("#content").val();
	var title=$("#title").val();
	var name=$("#name").val();
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
			name:name,
			pw:pw
		},
		success:function(data){
			if (data == 1){
				//정상적으로 등록되었을시 data는 1을 반환한다.
				alert("등록 되었습니다");
				$("#content").val("");
				$("#title").val("");
				$("#name").val("");
				$("#pw").val("");
			} else{
				alert("등록에 실패하였습니다");
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
		document.getElementbyId(id).style.display="none"; //숨김
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
      		
      		<h6 id="qna1">군인만 가입이 가능한가요?</h6>
      		<div>
	      		<h5 id="qna_show1" style="display:none;">대한민국 국민 누구나 가입가능합니다.</h5>
	      	</div>
      	
      		<br id="br1">	
      		<br id="br2">
      	
      		<h6 id="qna2">숙식 업체의 선별기준은 무엇인가요?</h6>
      		<div>
      		  <h5 id="qna_show2" style="display:none;">군장병들과 가족분들이 평가해주신 평점으로 선별됩니다~</h5>
      		</div>
      		
      	<br id="br3">
      	<br id="br4">
      	
      	<h6 id="qna3">비밀번호를 잊어 버렸어요.</h6>
      	<div>
      		<h5 id="qna_show3" style="display:none;">영업시간 내에 연락주시거나 비밀번호 찾기로 해결하실 수 있습니다.</h5>	
      	</div>	
      	
      	<br id="br5">
      	<br id="br6">
      	
      	<h6 id="qna4">이 사이트를 만든사람과 연락해서 취업시키고 싶은데 어떻게 하죠?</h6>
    	<div>
    		<h5 id="qna_show4" style="display:none;">제발 연락주세요. 제발. 먹고살고 싶습니다.</h5>
    	</div>
    	
    	<br id="br7">
    	<br id="br8">
    	
    	<h6 id="qna5">사이트가 왜 이모양 이꼴이죠?</h6>
    	<div>	
    		<h5 id="qna_show5" style="display:none;">그럼 니가만들어 뒤질래?</h5>
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
			<th>이름</th>
   				<td>
   				    <input class="input" id="name" name="name"/>
   				</td>
      		</tr>
      		
    		<div>
 
 			<label for="pw">비밀번호</label>
      				<input class="input" id="pw" type="password" name="pwd"/>
    		</div>  		
      		<input type="submit" value="등록" >
      		<input type="reset" value="취소">
      		</form>
      </div>
   	
    	
    		</div>
    	
  </header>
  </head>
  
  <jsp:include page="/resources/include/footer.jsp" />
  <jsp:include page="/resources/include/copyright.jsp" />
  <jsp:include page="/resources/include/modals.jsp" />	<%-- modal.jsp 끝에 js 파일 있어서 반응형 웹이 됩니다~ 마지막에 꼭 넣으십쏘~ --%>

</body>
</html>