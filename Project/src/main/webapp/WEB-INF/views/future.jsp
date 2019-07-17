<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>future</title>
<script src="<c:url value='/resources/jquery-3.4.1.js' />"></script>

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


</head>
	<jsp:include page="/resources/include/navigation.jsp" />
	
	<header class="masthead bg-primary text-white text-center">
    <div class="container d-flex align-items-center flex-column">
    
    	<h1 class="masthead-heading text-uppercase mb-0">프로젝트의 미래</h1> 
    	
    	<br><br>
    	
    	<h4>현역 군인들을 위해 처음 개발을 목적으로 시작되었지만 점차 그 주변인들과 전역자들 모두가 이용할 수 있게 확장 되었습니다.</h4><br>
    	<h4>프로젝트가 확장되면 지금 제공되고 있는 기능들의 업데이트를 중심으로 더욱 더 다양한 기능을 제공할 예정입니다.</h4><br>
    	<h4>저희의 프로젝트로 인해 폐쇄적인 환경에서 활동하며 청춘을 나라를 위해 바치고 있는 젊은 청년들에게 조금이나마 도움이 되었으면 합니다.</h4>
    
    </div>
    </header>
  
  

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
	 
</div>
</body>
  
  <a id="topBtn"><img src="resources/img/portfolio/up.png" width="10" height="10" alt="upButton" class="names">TOP</a>
  
  <jsp:include page="/resources/include/footer.jsp" />
  <jsp:include page="/resources/include/copyright.jsp" />
  <jsp:include page="/resources/include/modals.jsp" />	<%-- modal.jsp 끝에 js 파일 있어서 반응형 웹이 됩니다~ 마지막에 꼭 넣으십쏘~ --%>

</html>
