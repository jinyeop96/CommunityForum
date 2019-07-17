<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Q&A</title>
<!-- jquery import -->
<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>

<style>
#content {  
  position:absolute;
  height:600px;   /* 퀵메뉴, 배너 이미지의 높이 */
  width:170px;    /* 퀵메뉴, 배너 이미지의 너비*/
  margin:0px 0px 0px 625px;   /* 가장 오른쪽의 수치가 화면 가운데에서 얼마만큼 오른쪽으로 레이어를 붙일 것인지 설정  */ 
  top: 110px;  /* 배너 상단에서 얼마나 떨어뜨릴지 설정*/
  left: 50%;     /* 레이어의 시작점이 왼쪽으로 부터 50% 지정 */
  text-align: left;
  padding: 0px;
}

.names{
	width: 100%; height: 100%
}

.contacts{
	width: 80%; height: 100%; margin-top:5px;
}

a#topBtn { position: fixed; /* 포지션 고정 */ 
right: 2%; /* 오른쪽에서 2% - %도 할수 있음*/ 
bottom: 5px; /* 밑에서 5px */ 
display: none; /* 보여지지 없음 - 기본적으로 안보여지게 */ 
z-index: 9999; /* 포지션을 먼저 지정후 z-좌표(레이어) : 9999입니다. */ 
width:75px;
height:100px;}

</style> 
 
<script type='text/javascript' src='http://ajax.googleapis.com/ajax/libs/jquery/1.3.2/jquery.min.js?ver=1.3.2'></script>  
<script type="text/javascript">
        $(function() {
            var offset = $("#content").offset();
            var topPadding = 100;
            $(window).scroll(function() {
    
                if ($(window).scrollTop() > offset.top) {
                    $("#content").stop().animate({
                        marginTop: $(window).scrollTop() - offset.top + topPadding
                    }, 600);
                } else {
                    $("#content").stop().animate({
                        marginTop: 50
                    });
                };
             });
        });
</script>
</head>

<script>
$(function() {
	   // 보이기 | 숨기기
	   $(window).scroll(function() {
	      if ($(this).scrollTop() > 130) { //250 넘으면 버튼이 보여짐니다.
	            $('#topBtn').fadeIn();
	            } else {
	            $('#topBtn').fadeOut();
	      }
	   });
	   // 버튼 클릭시
	   $("#topBtn").click(function() {   
	   $('html, body').animate({
	     scrollTop : 0    // 0 까지 animation 이동합니다.
	    }, 400);          // 속도 400
	    return false;
	    });
	  });
</script>

<body> 
<div id="content">
	<center><img src="resources/img/banner/sangwon.png" class="names"></center>
	<!-- <center><font class="names">SANGWON BANG</font></center> --> 
	<center><a href="javascript:void(0)" target="_blank"><img src="resources/img/banner/sangwon_phone.png" class="contacts"/></a></center>
	<center><a href="https://www.instagram.com/vang_sang/" target="_blank"><img  src="resources/img/banner/sangwon_insta.png" class="contacts" /></a></center>
	<br>  

	<center><img src="resources/img/banner/jinyeop.png"  class="names" ></center>
	<center><a href="javascript:void(0)" target="_blank"><img  src="resources/img/banner/jinyeop_phone.png" class="contacts" /></a></center>
	<center><a href="https://www.instagram.com/ohhh_jinyeop/" target="_blank"><img src="resources/img/banner/jinyeop_insta.png" class="contacts"/></a></center>
	<center><a href="javascript:void(0)" target="_blank"><img  src="resources/img/banner/jinyeop_kakao.png" class="contacts"/></a></center>
	<br> 
	
	<center><img src="resources/img/banner/chihyeock.png" class="names"  ></center>
	<center><a href="javascript:void(0)" target="_blank"><img src="resources/img/banner/chihyeock_phone.png" class="contacts" /></a></center>
	<br>	
	 
	  <a id="topBtn"><img src="resources/img/portfolio/up.png" width="10" height="10" alt="upButton" class="names">TOP</a>
	 
</div>
</body>


<script>

$(function(){
	
	
	$(document).ready(function(){
	    $("#checkBox01").change(function(){
	        if($("#checkBox01").is(":checked")){
	        	$("#qna_show1").css("display","block");
	        }else{
	        	$("#qna_show1").css("display","none");
	        }
	    });
	});
	
	$(document).ready(function(){
	    $("#checkBox02").change(function(){
	        if($("#checkBox02").is(":checked")){
	        	$("#qna_show2").css("display","block");
	        }else{
	        	$("#qna_show2").css("display","none");
	        }
	    });
	});
	
	$(document).ready(function(){
	    $("#checkBox03").change(function(){
	        if($("#checkBox03").is(":checked")){
	        	$("#qna_show3").css("display","block");
	        }else{
	        	$("#qna_show3").css("display","none");
	        }
	    });
	});
	
	$(document).ready(function(){
	    $("#checkBox04").change(function(){
	        if($("#checkBox04").is(":checked")){
	        	$("#qna_show4").css("display","block");
	        }else{
	        	$("#qna_show4").css("display","none");
	        }
	    });
	});
	
	$(document).ready(function(){
	    $("#checkBox05").change(function(){
	        if($("#checkBox05").is(":checked")){
	        	$("#qna_show5").css("display","block");
	        }else{
	        	$("#qna_show5").css("display","none");
	        }
	    });
	});
	/* //jquery mouseover와 mouseleave를 통해 해당 태그에 마우스 이벤트를 발생시킨다.
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
 */
	
	
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

setInterval(function(){
	  $(".blinkEle").toggle();
	}, 250);

</script>
<body>
	<jsp:include page="/resources/include/navigation.jsp" />
	

	 <!--  section01 -->
	<header class="masthead bg-primary text-white text-center">
    <div class="container d-flex align-items-center flex-column">
      
      <h1 class="masthead-heading text-uppercase mb-0" >고객센터 문의사항</h1> 
      <div id="qnaDiv" align="left">
      	
      	
      	
      	<h1 style = " font-size:20px; margin-top:40px;" align="center">자주하는 질문</h1>
      		
      		<h6 id="qna1">군인만 가입이 가능한가요?<input type="checkbox" id="checkBox01">←클릭</h6>
      		<div>
	      		<h5 id="qna_show1" style="display:none;">대한민국 국민 누구나 가입가능합니다.</h5>
	      	</div>
      	
      		<br id="br1">	
      		<br id="br2">
      	
      		<h6 id="qna2">숙식 업체의 선별기준은 무엇인가요? <input type="checkbox" id="checkBox02">←클릭</h6>
      		<div>
      		  <h5 id="qna_show2" style="display:none;">군장병들과 가족분들이 평가해주신 평점으로 선별됩니다~</h5>
      		</div>
      		
      	<br id="br3">
      	<br id="br4">
      	
      	<h6 id="qna3">비밀번호를 잊어 버렸어요. <input type="checkbox" id="checkBox03">←클릭</h6>
      	<div>
      		<h5 id="qna_show3" style="display:none;">영업시간 내에 연락주시거나 비밀번호 찾기로 해결하실 수 있습니다.</h5>	
      	</div>	
      	
      	<br id="br5">
      	<br id="br6">
      	
      	<h6 id="qna4">이 사이트를 만든사람과 연락해서 취업시키고 싶은데 어떻게 하죠?  <input type="checkbox" id="checkBox04">←클릭</h6>
    	<div>
    		<h5 id="qna_show4" style="display:none;">제발 연락주세요. 제발. 먹고살고 싶습니다.</h5>
    	</div>
    	
    	<br id="br7">
    	<br id="br8">
    	
    	<h6 id="qna5">사이트가 왜 이모양 이꼴이죠?  <input type="checkbox" id="checkBox05">←클릭</h6>
    	<div>	
    		<h5 id="qna_show5" style="display:none;">그럼 니가만들어 뒤질래?</h5>
    	</div>
    	
    	<br>
    	<br>
    
    	<div id="qnaDiv2">
    		
	원하는 질문이 없으신가요? 클릭→    <input type="radio" name="qnabtn" value="1" onclick="div_OnOff(this.value,'QNAP');">
    	   
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