<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>OwyMember</title>
<script src="<c:url value='/resources/jquery-3.4.1.js' /> "></script>
</head>
	<jsp:include page="/resources/include/navigation.jsp" />
	
	<header class="masthead bg-primary text-white text-center">
    <div class="container d-flex align-items-center flex-column">
    
    	<h1 class="masthead-heading text-uppercase mb-0">O.W.Y Member</h1>
    	
    	<br><br>
    	
    	<h4>Jinyeop Oh[PM] - Birth : 1996 / Good skills : everything </h4>
    	<h4>Sangwon Bang - Birth : 1993 / Good skills : nothing</h4>
    	<h4>Chihyuk Yoo - Birth : 1985 / Good Skills : Javascript, C++, Sql</h4>
    </div>	
    
    
    
    <!--카카오 지도 생성  API 코드-->
    
<div id="map" style="width:100%;height:400px;"></div>

<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=86b59d080c4ee3e8f0d9fc3cfd7b71c8"></script>
<script>
var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
    mapOption = { 
        center: new kakao.maps.LatLng(37.496272, 127.028882), // 지도의 중심좌표
        level: 4 // 지도의 확대 레벨
    };

var map = new kakao.maps.Map(mapContainer, mapOption);

//지도 타입 변경 컨트롤을 생성한다
var mapTypeControl = new kakao.maps.MapTypeControl();

// 지도의 상단 우측에 지도 타입 변경 컨트롤을 추가한다
map.addControl(mapTypeControl, kakao.maps.ControlPosition.TOPRIGHT);

//지도 확대 축소를 제어할 수 있는  줌 컨트롤을 생성합니다
var zoomControl = new kakao.maps.ZoomControl();
map.addControl(zoomControl, kakao.maps.ControlPosition.RIGHT);

// 마커가 표시될 위치입니다 
var markerPosition  = new kakao.maps.LatLng(37.496272, 127.028882); 

// 마커를 생성합니다
var marker = new kakao.maps.Marker({
    position: markerPosition
});

// 마커가 지도 위에 표시되도록 설정합니다
marker.setMap(map);

var iwContent = '<div style="padding:5px; color:black;">오와열 프로젝트팀<br><a href="https://map.kakao.com/link/map/오와열 프로젝트팀!,37.496272, 127.028882" style="color:blue" target="_blank">크게보기</a><a>/</a><a href="https://map.kakao.com/link/to/오와열 프로젝트팀,37.496272, 127.028882" style="color:blue" target="_blank">길찾기</a></div>', // 인포윈도우에 표출될 내용으로 HTML 문자열이나 document element가 가능합니다
    iwPosition = new kakao.maps.LatLng(37.496272, 127.028882); //인포윈도우 표시 위치입니다

// 인포윈도우를 생성합니다
var infowindow = new kakao.maps.InfoWindow({
    position : iwPosition, 
    content : iwContent 
});
  
// 마커 위에 인포윈도우를 표시합니다. 두번째 파라미터인 marker를 넣어주지 않으면 지도 위에 표시됩니다
infowindow.open(map, marker); 
</script>

<h5>[서울특별시 강남구 역삼1동 강남대로 더조은컴퓨터아카데미 - 형제빌딩 3층 301호]</h5>

</body>
    	
    
    </header>
  
  
  <jsp:include page="/resources/include/footer.jsp" />
  <jsp:include page="/resources/include/copyright.jsp" />
  <jsp:include page="/resources/include/modals.jsp" />	<%-- modal.jsp 끝에 js 파일 있어서 반응형 웹이 됩니다~ 마지막에 꼭 넣으십쏘~ --%>

</html>
