<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>

<style type="text/css">	
	/* banner */
	.banner {position: relative; width: 340px; height: 210px; top: 50px;  margin:0 auto; padding:0; overflow: hidden;}
	.banner ul {position: absolute; margin: 0px; padding:0; list-style: none; }
	.banner ul li {float: left; width: 340px; height: 210px; margin:0; padding:0;}

</style>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>


<script language="JavaScript">

	$(document).ready(function() {
		var $banner = $(".banner").find("ul");

		var $bannerWidth = $banner.children().outerWidth();//이미지의 폭
		var $bannerHeight = $banner.children().outerHeight(); // 높이
		var $length = $banner.children().length;//이미지의 갯수
		var rollingId;

		//정해진 초마다 함수 실행
		rollingId = setInterval(function() { rollingStart(); }, 2500);//다음 이미지로 롤링 애니메이션 할 시간차
    
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
<title>plan</title>

<script language="JavaScript">

<script src="<c:url value='/resources/jquery-3.4.1.js' /> "></script>
</head>
 <body>
	<jsp:include page="/resources/include/navigation.jsp" />
	
	<header class="masthead bg-primary text-white text-center">
    <div class="container d-flex align-items-center flex-column">
    
    <h1 class="masthead-heading text-uppercase mb-0">기획의도</h1>
    
    <br><br>
    <h4>군인 - 국민 대통합 프로젝트!!!</h4><br>
    <h4>나라를 지키며 고생하는 청춘들과 그 청춘들을 애타게 걱정하며 무사를 기원하는 모든 분들을 위해 오와열 프로젝트는 개발되었습니다.</h4><br>
    <h4>군대를 갔다온 전역자 입장으로써 전/현직 군인들이 공감할 수 있는 내용들과 모두가 공감대를 공유할 수 있는 소통의 장을 제공하여 
    	모두에게 기쁨을 줄 수 있도록 방향성을 잡고 오와열은 시작되었습니다.</h4><br>
    <h4>오와열 프로젝트를 통해 현역과 그의 주변인들에게는 연락의 연결망, 전역자들에게는 추억을 나눌 수 있는 오와열이 되었으면 합니다.
    </h4>
    
    
        	<div class="contents">


		<div class="banner">
			<ul>
				<li><img src="resources/img/background/a1.jpg" width="340" height="210px"></li>
				<li><img src="resources/img/background/a2.jpg" width="340" height="210px"></li>
				<li><img src="resources/img/background/a3.jpg" width="340" height="210px"></li>			
			</ul>
		</div>
	</div>
	
    </div>
   
    </header>
    </body>
    
    
  
  <jsp:include page="/resources/include/footer.jsp" />
  <jsp:include page="/resources/include/copyright.jsp" />
  <jsp:include page="/resources/include/modals.jsp" />	<%-- modal.jsp 끝에 js 파일 있어서 반응형 웹이 됩니다~ 마지막에 꼭 넣으십쏘~ --%>

</html>



</head>


