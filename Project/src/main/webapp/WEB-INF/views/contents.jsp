<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>

<style type="text/css">	
	/* banner */
	.banner {position: relative; width: 550px; height: 300px; top: 50px;  margin:0 auto; padding:0; overflow: hidden;}
	.banner ul {position: absolute; margin: 0px; padding:0; list-style: none; }
	.banner ul li {float: left; width: 550px; height: 300px; margin:0; padding:0;}

</style>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>


<style type="text/css" media="screen">
#content {  
  position:absolute;
  height:600px;   /* 퀵메뉴, 배너 이미지의 높이 */
  width:170px;    /* 퀵메뉴, 배너 이미지의 너비*/
  margin:0px 0px 0px 600px;   /* 가장 오른쪽의 수치가 화면 가운데에서 얼마만큼 오른쪽으로 레이어를 붙일 것인지 설정  */ 
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

<script language="JavaScript">

	$(document).ready(function() {
		var $banner = $(".banner").find("ul");

		var $bannerWidth = $banner.children().outerWidth();//이미지의 폭
		var $bannerHeight = $banner.children().outerHeight(); // 높이
		var $length = $banner.children().length;//이미지의 갯수
		var rollingId;

		//정해진 초마다 함수 실행
		rollingId = setInterval(function() { rollingStart(); }, 2400);//다음 이미지로 롤링 애니메이션 할 시간차
    
		function rollingStart() {
			$banner.css("width", $bannerWidth * $length + "px");
			$banner.css("height", $bannerHeight + "px");
			//alert(bannerHeight);
			//배너의 좌측 위치를 옮겨 준다.
			$banner.animate({left: - $bannerWidth + "px"}, 1500, function() { //숫자는 롤링 진행되는 시간이다.
				//첫번째 이미지를 마지막 끝에 복사(이동이 아니라 복사)해서 추가한다.
				$(this).append("<li>" + $(this).find("li:first").html() + "</li>");
				//뒤로 복사된 첫번재 이미지는 필요 없으니 삭제한다.
				$(this).find("li:first").remove();
				//다음 움직임을 위해서 배너 좌측의 위치값을 초기화 한다.
				$(this).css("left", 0);
				//이 과정을 반복하면서 계속 롤링하는 배너를 만들 수 있다.
			});
		}
	}); 

</script>


<meta charset="UTF-8">
<title>contents</title>
<script src="<c:url value='/resources/jquery-3.4.1.js' /> "></script>
</head>
	<jsp:include page="/resources/include/navigation.jsp" />
	
	<header class="masthead bg-primary text-white text-center">
    <div class="container d-flex align-items-center flex-column">
     <h1 class="masthead-heading text-uppercase mb-0">상징물</h1> 
     
     <br><br>
     
     
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
     
     	<section class="box_instruc_con">
     		<div id="printContents">
     			<section class="overflowW marB40"> 				

				<img id="logo"  src="<c:url value='/resources/img/logos/510_2.png'/>" alt="html size" style="width:220px; height:160px">
     			
     				<div class=="floatL w55per marB20 re100">
     					<h3 class="title">- O.W.Y 로고 No.1 -</h3>
     					<ol class="marB20 grey2">
     						<h5>[팀프로젝트 명인 '오와열'이 내재 돼있고 군 관련 프로그램인 특성을 살려 군번줄을 형상화&메인 로고]</h5>
     					</ol>
     					<div class="line marB20"></div>
     					<div class="box_btn">
     						<a class="btn_down white" src="<c:url value='/resources/img/logos/510_2.png'/>" target="_blank" title="표준규격 다운로드">(우클릭->다른이름으로 저장)</a>
  	    					<a class="download" src="<c:url value='/resources/img/logos/OWY-1.png'/>" download></a>
     					</div>
     				</div>
     				<br><br><br>
     			
     				<div class="clear"></div>
     				
     		<!-- 		<div class="box_btn">
     					<div class="floatR">
     						<a class="btn_down greyL" href='/resources/img/logos/510_1.jpg' target="_blank" title="오와열 로고 다운로드(GIF)">|오와열 로고 다운로드(GIF) |</a>
 							<a class="btn_down greyL marR0" href='/resources/img/logos/510_1.jpg' target="_blank" title="오와열 로고 다운로드(일러파일)">오와열 로고 다운로드(일러파일)|</a>
     					</div>
     				</div> -->
     				
     				
     				<img id="logo" src="<c:url value='/resources/img/logos/510logo_2.png'/>" style="width:220px; height:160px">
     			
     				<div class=="floatL w55per marB20 re100">
     					<h3 class="title">- O.W.Y 로고 No.2 -</h3>
     					<ol class="marB20 grey2">
     						<h5>['오와열' 타이틀을 제거하여 simple하게 제작된 제 2의 로고]</h5>
     					</ol>
     					<div class="line marB20"></div>
     					<div class="box_btn">
     						<a class="btn_down white" scr="<c:url value='/resources/img/logos/510logo_2.png'/>" target="_blank" title="표준규격 다운로드">(우클릭->다른이름으로 저장)</a>
     					</div>
     				</div>
     				<br><br><br><br>
     				
     				
     				<img id="logo"  src="<c:url value='/resources/img/logos/OWY-1.png'/>" style="width:220px; height:160px">
     			
     				<div class=="floatL w55per marB20 re100">
     					<h3 class="title">- O.W.Y 로고 No.3 -</h3>
     					<ol class="marB20 grey2">
     						<h5>[팀 프로젝트명을 밀리터리 패턴으로 형식화-1]</h5>
     					</ol>
     					<div class="line marB20"></div>
     					<div class="box_btn">
     						<a class="btn_down white" src="<c:url value='/resources/img/logos/OWY-1.png'/>" target="_blank" title="표준규격 다운로드">(우클릭->다른이름으로 저장)</a>     						
     					</div>
     				</div>
     				<br><br><br><br>
     				
     				
     				<img id="logo"  src="<c:url value='/resources/img/logos/OWY-2.png'/>" style="width:220px; height:160px">
     			
     				<div class=="floatL w55per marB20 re100">
     					<h3 class="title">- O.W.Y 로고 No.4 -</h3>
     					<ol class="marB20 grey2">
     						<h5>[팀 프로젝트명을 밀리터리 패턴으로 형식화-2]</h5>
     					</ol>
     					<div class="line marB20"></div>
     					<div class="box_btn">
     						<a class="btn_down white" src="<c:url value='/resources/img/logos/OWY-2.png'/>" target="_blank" title="표준규격 다운로드">(우클릭->다른이름으로 저장)</a>
     					</div>
     				</div>
     				<br><br><br>
     				
     				
     				<img id="logo"  src="<c:url value='/resources/img/logos/OWY-3.png'/>" style="width:220px; height:160px">
     			
     				<div class=="floatL w55per marB20 re100">
     					<h3 class="title">- O.W.Y 로고 No.5 -</h3>
     					<ol class="marB20 grey2">
     						<h5>[팀 프로젝트명을 밀리터리 패턴으로 형식화-3]</h5>
     					</ol>
     					<div class="line marB20"></div>
     					<div class="box_btn">
     						<a class="btn_down white" src="<c:url value='/resources/img/logos/OWY-3.png'/>" target="_blank" title="표준규격 다운로드">(우클릭->다른이름으로 저장)</a>
     					</div>
     				</div>
     				<br><br><br>
     				
     				
     				<img id="logo"  src="<c:url value='/resources/img/logos/OWY-4.png'/>" style="width:220px; height:160px">
     			
     				<div class=="floatL w55per marB20 re100">
     					<h3 class="title">- O.W.Y 로고 No.6 -</h3>
     					<ol class="marB20 grey2">
     						<h5>[팀 프로젝트명을 밀리터리 패턴으로 형식화-4]</h5>
     					</ol>
     					<div class="line marB20"></div>
     					<div class="box_btn">
     						<a class="btn_down white" src="<c:url value='/resources/img/logos/OWY-4.png'/>" target="_blank" title="표준규격 다운로드">(우클릭->다른이름으로 저장)</a>
     					</div>
     				</div><br><br>
     				
     				
     				
     				
     			
     			<!-- 	<div class="clear"></div>
     				
     				<div class="box_btn">
     					<div class="floatR">
     						<a class="btn_down greyL" href='/resources/img/logos/510_1.jpg' target="_blank" title="오와열 로고 다운로드(GIF)">|오와열 로고 다운로드(GIF) |</a>
 							<a class="btn_down greyL marR0" href='/resources/img/logos/510_1.jpg' target="_blank" title="오와열 로고 다운로드(일러파일)">오와열 로고 다운로드(일러파일)|</a>
     					</div>
     				</div>
     				
     			</section>
     			
     			
     			
     			<section class="marB60">
     				<h3 class="title">규격별 다운로드</h3>
     				<div class="logo marB10">
     				
     				 <div>
     				 	<h5 class="floatL">|Download|</h5>
     				 	<img src="" alt="">
     				 </div>
     				</div>
     				<div class="box_btn">
     					<div class="floatR">
     						<a class="btn_down greyL" href='/resources/img/logos/510_1.jpg' target="_blank" title="오와열 로고 다운로드(표준규격)">오와열 로고 다운로드(표준규격)</a>
     						<a class="btn_down greyL" href='/resources/img/logos/510_1.jpg' target="_blank" title="요와열 로고 다운로드(GIF)">오와열 로고 다운로드(GIF)</a>
     						<a class="btn_down greyL" href='/resources/img/logos/510_1.jpg' target="_blank" title="오와열 로고 다운로드(JPG)">오와열 로고 다운로드(JPG)</a>
     					</div>
     				</div>
     			</section> -->
     			
     			 <div class="signature overflowW">
     				 	<img src="" alt="">
     			 </div>
     			
     		</div>
     		
     		
		<div class="banner">
			<ul>
				<li><img src="resources/img/logos/510_2.png" width="450px" height="280px"></li>
				<li><img src="resources/img/logos/510logo_2.png" width="450px" height="280px"></li>
				<li><img src="resources/img/logos/OWY-1.png" width="450px" height="280px"></li>		
				<li><img src="resources/img/logos/OWY-2.png" width="450px" height="280px"></li>			
				<li><img src="resources/img/logos/OWY-3.png" width="450px" height="280px"></li>			
				<li><img src="resources/img/logos/OWY-4.png" width="450px" height="280px"></li>				
			</ul>
		</div>
		
	</div>

	<br><br><br>

		<h3>OWY 컨텐츠 목록</h3>

	
    </div>
   
     		
     	</section>
    </div>
    </header>
  
  
  
  <jsp:include page="/resources/include/footer.jsp" />
  <jsp:include page="/resources/include/copyright.jsp" />
  <jsp:include page="/resources/include/modals.jsp" />	<%-- modal.jsp 끝에 js 파일 있어서 반응형 웹이 됩니다~ 마지막에 꼭 넣으십쏘~ --%>

</html>
