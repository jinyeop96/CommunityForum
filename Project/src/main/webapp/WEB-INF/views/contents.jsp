<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>

<style type="text/css">	
	/* banner */
	.banner {position: relative; width: 410px; height: 300px; top: 50px;  margin:0 auto; padding:0; overflow: hidden;}
	.banner ul {position: absolute; margin: 0px; padding:0; list-style: none; }
	.banner ul li {float: left; width: 410px; height: 300px; margin:0; padding:0;}

</style>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>


		 <jsp:include page="/resources/include/banner.jsp"/>


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
				<li><img src="resources/img/logos/510_2.png" width="370px" height="250px"></li>
				<li><img src="resources/img/logos/510logo_2.png" width="370px" height="250px"></li>
				<li><img src="resources/img/logos/OWY-1.png" width="370px" height="250px"></li>		
				<li><img src="resources/img/logos/OWY-2.png" width="370px" height="250px"></li>			
				<li><img src="resources/img/logos/OWY-3.png" width="370px" height="250px"></li>			
				<li><img src="resources/img/logos/OWY-4.png" width="370px" height="250px"></li>				
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
