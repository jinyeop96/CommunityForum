<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>오와열</title>
<style type="text/css" media="screen">
#content {  
  position:absolute;
  height:50px;   /* 퀵메뉴, 배너 이미지의 높이 */
  width:300px;    /* 퀵메뉴, 배너 이미지의 너비*/
  margin:0px 0px 0px 785px;   /* 가장 오른쪽의 수치가 화면 가운데에서 얼마만큼 오른쪽으로 레이어를 붙일 것인지 설정  */ 
  top: 220px;  /* 배너 상단에서 얼마나 떨어뜨릴지 설정*/
  left: 40%;     /* 레이어의 시작점이 왼쪽으로 부터 50% 지정 */
  text-align: left; 
  padding: 0px;
}

.names{
	width: 100%; height: 100%
}

.contacts{
	width: 80%; height: 100%; margin-top:5px;
}
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




	<%--
		resources 폴더에 css, image, js, jsp 등등 들어 있음. jsp 파일 불러오기는 아래와 같이 하시고~
	
		그 외 css, image, js 등은 
		 *중요! <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> jstl 사용 해주고
		 <c:url value="/resources/~~~/~~.css" />   	<= url에 요런 느낌으로 해주면 매핑 되어있어서 어디서든 쓸 수 있슴다
		 
		페이지 만들어 나가면서 <body></body> 는 include 하면 navigation.jsp 와 modals.jsp에 들어있으니까 빼도 되고
		modals.jsp도 마지막!!!에 꼭 넣어주셔요 js 파일들이 다 들어있는 곳이어서 넣어줘야 반응형 웹이 된답니다
	 --%>
			
	<jsp:include page="/resources/include/navigation.jsp" flush="false" />
	<jsp:include page="/resources/include/masthead.jsp" flush="false" />
	<jsp:include page="/resources/include/carousel.jsp" flush="false"/>
	<jsp:include page="/resources/include/section01.jsp" flush="false" />
	<jsp:include page="/resources/include/section02.jsp" flush="false" />
	<jsp:include page="/resources/include/section03.jsp" flush="false" />
	<jsp:include page="/resources/include/footer.jsp" flush="false" />
	<jsp:include page="/resources/include/copyright.jsp" flush="false" />
	<jsp:include page="/resources/include/modals.jsp" flush="false" />
  
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

 
</html>










