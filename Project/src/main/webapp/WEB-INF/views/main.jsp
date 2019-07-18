<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<title>오와열</title>
<style type="text/css" media="screen">

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
</style>


<script type='text/javascript' src='http://ajax.googleapis.com/ajax/libs/jquery/1.3.2/jquery.min.js?ver=1.3.2'></script>  
<script type="text/javascript" src="http://code.jquery.com/jquery-latest.js"></script>
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
=======
<body> 
	
	<%-- 
>>>>>>> branch 'master' of https://github.com/jinyeop96/test
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
	<jsp:include page="/resources/include/bottomJs.jsp" flush="false" /> 
	<jsp:include page="/resources/include/banner.jsp" flush="false" /> 
  

</body>


</html>










