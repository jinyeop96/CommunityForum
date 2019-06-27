<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>호텔 검색</title>
	<style type="text/css">
		#map{
			width: 100%;
			height: 600px;
		}
	</style>
</head>
<body>
	
	<jsp:include page="/resources/include/navigation.jsp" />

	 <!--  section01 -->
	<header class="masthead bg-primary text-white text-center">
    	<div class="container d-flex align-items-center flex-column">
    	 
    		<div id="map"></div>
    		<p>
			    <button onclick="zoomIn()">확대</button>
			    <button onclick="zoomOut()">축소</button>
			    <span id="maplevel"></span>
			</p>
    		
    
    	</div>
	</header>    
	 

	
	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=c69f3f4c30330f21683d0ad0e2e9cb2b&libraries=services"></script>
	<script>
	var mapContainer = document.getElementById("map"), // 지도를 표시할 div 
	    mapOption = { 
	        center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
	        level: 3 // 지도의 확대 레벨
	    };
	
	// 지도를 표시할 div와  지도 옵션으로  지도를 생성합니다
	var map = new kakao.maps.Map(mapContainer, mapOption); 
	
	
	// 지도 레벨을 표시합니다
	displayLevel();
	 
	// 지도 레벨은 지도의 확대 수준을 의미합니다
	// 지도 레벨은 1부터 14레벨이 있으며 숫자가 작을수록 지도 확대 수준이 높습니다
	function zoomIn() {        
	    // 현재 지도의 레벨을 얻어옵니다
	    var level = map.getLevel();
	    
	    // 지도를 1레벨 내립니다 (지도가 확대됩니다)
	    map.setLevel(level - 1);
	    
	    // 지도 레벨을 표시합니다
	    displayLevel();
	}    

	function zoomOut() {    
	    // 현재 지도의 레벨을 얻어옵니다
	    var level = map.getLevel(); 
	    
	    // 지도를 1레벨 올립니다 (지도가 축소됩니다)
	    map.setLevel(level + 1);
	    
	    // 지도 레벨을 표시합니다
	    displayLevel(); 
	}    
	 
	function displayLevel(){
	    var levelEl = document.getElementById('maplevel');
	}
	</script>
    
    
	<jsp:include page="/resources/include/footer.jsp" />
  	<jsp:include page="/resources/include/copyright.jsp" />
  	<jsp:include page="/resources/include/modals.jsp" />
	
</body>
</html>