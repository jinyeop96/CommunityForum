<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    
<title>교통 검색</title>
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
    	 
    	 	<jsp:include page="/resources/include/navigation.jsp" />
	
    <h1 class="masthead-heading text-uppercase mb-0">교통 검색</h1><br><br>

<script>
	/**
	* HashMap 객체 정의
	*/
	HashMap = function() {
		this.initialize();
	};
	HashMap.prototype = {
		oStruct : null,
		sSize : 0,
		/**
		 * 객체 생성시
		 */
		initialize : function() {
			this.oStruct = {};
			return;
		},
		/**
		 * 내용 전체 삭제
		 */
		clear : function() {
			this.oStruct = {};
			this.sSize = 0;
			return;
		},
		/**
		 * key가 있는지 판단
		 */
		containsKey : function(sKey) {
			for ( var x in this.oStruct) {
				if (x == sKey && this.oStruct[sKey] != undefined) {
					return true;
				}
			}
			return false;
		},
		/**
		 * value가 있는지 판단
		 */
		containsValue : function(value) {
			for ( var prop in this.map) {
				if (this.map[prop] == value) {
					return true;
				}
			}
			return false;
		},
		/**
		 * key의 collection을 가져옴
		 */
		keySet : function() {
			var keySet = new Array();
			for ( var x in this.oStruct) {
				if (this.oStruct[x] != undefined) {
					keySet.push(x);
				}
			}
			return keySet;
		},
		/**
		 * key의 value를 가져옴
		 */
		get : function(sKey) {
			if (!this.containsKey(sKey)) {
				return null;
			}
			return this.oStruct[sKey];
		},
		/**
		 * 값이 있는지 판단
		 */
		isEmpty : function() {
			return (this.sSize <= 0) ? true : false;
		},
		/**
		 * 값을 입력
		 */
		put : function(sKey, oObj) {
			oOldObj = null;
			if (this.containsKey(sKey)) {
				oOldObj = this.get(sKey);
			}
			else {
				this.sSize++;
			}
			this.oStruct[sKey] = oObj;
			return oOldObj;
		},
		/**
		 * 값을 지움
		 */
		remove : function(sKey) {
			if (!this.containsKey(sKey)) {
				return null;
			}
			oldObj = this.oStruct[sKey];
			this.oStruct[sKey] = undefined;
			this.sSize--;
			return oldObj;
		},
		/**
		 * 전체 크기
		 */
		size : function() {
			return this.sSize;
		},
		toString : function() {
			var str = '[';
			for ( var x in this.oStruct) {
				str += x + ' : ' + this.oStruct[x] + ',';
			}
			str += ']';
			return str;
		}
	};
	  var map;
	  var gAppKey = "a09072d8-f982-4d48-b045-d780991a5540";
	  var map;
	  var markerLayer;
	  var marker;
	  var _MarkersMap = new HashMap();
	  function initTmap(){
	  	// map 생성
		// Tmap.map을 이용하여, 지도가 들어갈 div, 넓이, 높이를 설정합니다.
	    map = new Tmap.Map({div:'map_div', width:'100%', height:'400px'});
	    markerLayer = new Tmap.Layer.Markers();//마커 레이어 생성합니다.
		map.addLayer(markerLayer);//map에 마커 레이어 추가합니다.
	  }    
	  /**
	   * < POI 검색결과 창 닫기 >
	   */
	  $(document).ready(function() {
	      $('#close').click(function() {
	      	$("#searchResult").hide();
	      });
	    });
	  /**
	   * POI 이벤트 관련 
	   */
	  var PR_3857 = new Tmap.Projection("EPSG:3857");		// Google Mercator 좌표계인 EPSG:3857
	  var PR_4326 = new Tmap.Projection("EPSG:4326");		// WGS84 GEO 좌표계인 EPSG:4326
	  /**
	   * EPSG:3857를 EPSG:4326로 좌표변환~
	   * @param x
	   * @param y
	   * @returns
	   */
	  function get4326LonLat(x, y){
	  	return new Tmap.LonLat(x, y).transform(PR_3857, PR_4326);
	  }
	  /**
	   *  EPSG:4326를 EPSG:3857로 좌표변환~
	   * @param x
	   * @param y
	   * @returns
	   */
	  function get3857LonLat(x, y){
	  	return new Tmap.LonLat(x, y).transform(PR_4326, PR_3857);
	  }
	  /**
	   * 마우스커서가 대상 객체 위에 위치했을 때 발생 하는 이벤트
	   * @param evt
	   */
	  function onMarkerOver(evt){	
	  	this.popup.show();	// Label을 보여줍니다.
	  }
	  /**
	   * 마우스커서가 대상 객체 위를 벗어 났을 때 발생 하는 이벤트
	   * @param evt
	   */
	  function onMarkerOut(evt){
	      this.popup.hide();	// Label을 숨김니다.
	  }
	  /** 
	   * 마우스 커서가 대상 객체 위에 위치한 상태에서 마우스 버튼을 클릭 했을때 발생 하는 이벤트
	   */
	  function onClickMarker(evt){
	  	map.removeAllPopup();
	  	var popupId = this.id;	
	  	if(_MarkersMap.get(popupId) == null){
	  		map.addPopup(this);	// Map에 팝업 객체를 등록합니다.
	  		_MarkersMap.put(popupId, this);
	  	}else{
	  		map.removePopup(this);	// Map에 팝업 객체를 제거합니다.
	  		_MarkersMap.remove(popupId);
	  	}
	  }
	  /**
	   * Marker 추가 
	   */
	  function addMarkers(img, x, y, label, id){
	  	var lonlat = new Tmap.LonLat(x, y);//마커 좌표 설정합니다.
	  	var size = new Tmap.Size(24,38);//아이콘 크기 설정합니다.
	  	var offset = new Tmap.Pixel(-(size.w/2), -size.h);//아이콘 중심점 설정합니다. 	
	  	var icon = new Tmap.Icon('http://tmapapis.sktelecom.com/upload/tmap/marker/pin_b_m_a.png',size, offset);//마커 아이콘 설정합니다. 
	  	var labelText 	= new Tmap.Label('<div>'+label+'</div>');// Label 객체 생성합니다.
	  	marker = new Tmap.Markers(lonlat, icon, labelText);//마커 생성합니다.
	  	markerLayer.addMarker(marker);//마커 레이어에 마커 추가합니다.
	  	if(id){		
	  		_MarkersMap.put(id, marker);			
	  	}else{		
	  		_MarkersMap.put(img, marker);	
	  	}
	  }
	  /**
	   * Marker 전체 삭제 
	   */
	  function delTotMarker(){
	  	var makerKeySet = _MarkersMap.keySet();
	  	for(var i=0; i < makerKeySet.length; i++){
	  		markerLayer.removeMarker(_MarkersMap.get(makerKeySet[i]));		// MarkerLayer에서 Marker를 제거합니다.
	  		_MarkersMap.get(makerKeySet[i]).destroy();					// Tmap.Marker 객체를 메모리에서 제거합니다.
	  		_MarkersMap.remove(makerKeySet[i]);							// HashMap에서 모든 객체를 제거합니다.
	  	}
	  }
	  /**
	   * 해당 Marker를 삭제
	   * @param id
	   */
	  function removeMarker(id){
	  	try{
	  		markerLayer.removeMarker(_MarkersMap.get(id));//레이어의 마커를 삭제합니다.
	  	}catch(err){
	  	}
	  }
	  /**
	   * 마커에 이벤트를 등록
	   * @param id
	   */
	  function addMarkerEvent(id){
	  	marker = _MarkersMap.get(id);
	  	marker.events.register("mouseover", marker, onMarkerOver);//마커 마우스오버 이벤트 등록합니다.
	  	marker.events.register("mouseout" , marker, onMarkerOut);//마커  마우스 아웃 이벤트 등록합니다.
	  }
	  /** 
	   * popup창 생성/추가
	   * @param x
	   * @param y
	   * @param popupText
	   * @param id
	   */
	  function addMarkerPopup(x, y, popupText, id){
	  	marker = _MarkersMap.get(id);
	  	var lonlat = new Tmap.LonLat(x, y);	// LonLat 객체 생성합니다.	
	  	var content ="<div style=' position: relative; border-bottom: 1px solid #dcdcdc; line-height: 18px; padding: 0 35px 2px 0;'>"+
					    "<div style='font-size: 12px; line-height: 15px;'>"+
					        "<span style='display: inline-block; width: 14px; height: 14px; background-image: url(/resources/images/common/icon_blet.png); vertical-align: middle; margin-right: 5px;'></span>"+popupText+
					    "</div>"+
					 "</div>";	
	  	var popup  = new Tmap.Popup("popup"+id,  lonlat,  new Tmap.Size(300,50), content,  false);//팝업을 생성합니다.
	  	popup.autoSize=true;//popup 사이즈 자동 조절		                         
	  	marker.events.register("click", popup, onClickMarker);//클릭시 팝업을 보여줍니다.
	  }
	  
	  //POI 통합 검색 함수입니다. 
	  function getTotPOISearch() {
	  	var searchKeyword 	= $('#inp_keyword').val();
	  	if(searchKeyword == ''){
	  		alert('검색어를 입력해 주세요');
	  		return;
	  	}
	  	var lonlat = map.getCenter(); // 지도 중심좌표를 가져옵니다.
	  	var url = "https://api2.sktelecom.com/tmap/pois";//POI 검색 api url 입니다
	  	var params = {
	  			"version" : "1"//버전
	  			,"page" : "1"//페이지
	  			,"count"  : "20"//페이지당 검색수
	  			,"searchKeyword" : searchKeyword //검색어
	  			,"searchtypCd" : "R"//R: 거리순 / A:정확도순
	  			,"radius"  : "1" //검색반경
	  			,"centerLon" : lonlat.lon //경도
	  			,"centerLat" : lonlat.lat //위도
	  			,"appKey"  : gAppKey //앱키(서버키)
	  			,"reqCoordType" : "EPSG3857"
	  			,"resCoordType" : "EPSG3857"
	  	};
	  	$.get( url, params, function(data){
	  		if( data ) {
	  			// POI 통합검색 요청 성공 시 작업
	  			markerLayer.clearMarkers(); // 기존 마커를  모두 삭제합니다.
	  			var arrPoi = data.searchPoiInfo.pois.poi;//api를 요청 결과를 담는 변수입니다.
	  			var id, name, frontLat, frontLon;			
	  			var upperAddrName, middleAddrName, lowerAddrName, detailAddrName;
	  			var str = "", popupText = "";
	  			var bounds = new Tmap.Bounds();
	  			
	  			$("#searchCount").html(data.searchPoiInfo.count);//검색 결과의 수를 html에 출력합니다.
	  			for( var i in arrPoi ) {
	  				id			= arrPoi[i].id;//요청 결과에서 id를 추출합니다.
	  				name 		= arrPoi[i].name;
	  				frontLat 	= arrPoi[i].frontLat;
	  				frontLon 	= arrPoi[i].frontLon;			
	
	  				upperAddrName		= arrPoi[i].upperAddrName;//요청 결과에서 주소를 추출합니다.
	  				middleAddrName		= arrPoi[i].middleAddrName;
	  				lowerAddrName		= arrPoi[i].lowerAddrName;
	  				detailAddrName		= arrPoi[i].detailAddrName;
	  				
	  				//마우스 오버시 출력할 텍스트입니다.
	  				str += '<tr>';
	  				str += '<td>'+name+'</td>';
	  				str += '</tr>';		
	  				
	  				//popup에 출력할 텍스트입니다.
	  				popupText += '<tr>';
	  				popupText += '<td>'+upperAddrName+' '+middleAddrName+' '+lowerAddrName+' '+detailAddrName+' - '+name+'</td>';
	  				popupText += '</tr>';
	  				
	  				// Marker를 추가하는 함수입니다.
	  				addMarkers('point.png', frontLon, frontLat, name, id);
	
	  				// Marker에 Popup을 추가합니다.
	  				addMarkerPopup(frontLon, frontLat, popupText, id);
	  				//팝업 텍스트를 초기화합니다.
	  				popupText = '';	
	  				
	  				// Marker에 event를 추가하는 함수입니다.
	  				addMarkerEvent(id);
	  				
	  				bounds.extend( new Tmap.LonLat(frontLon, frontLat) ); // 마커가 보이도록 바운드 확장합니다.
	  			}
	  			
	  			// 모든 마커가 보이도록 줌레벨 조정합니다.
	  			map.zoomToExtent(bounds);
	  			
	  			$("#searchTbody").html(str);//str을 id가 searchTbody인 태그 안에 출력
				$('#searchResult').css('display', 'block');//id가 searchResult인 태그 css 수정
	  		}
	  		else {
	  			alert("검색결과가 없습니다");
	  		}
	  	});
	  }
	
	// 맵 생성 실행
	initTmap();
</script> 
<!-- poi 통합 검색 html 소스 -->
<div class="map_wrap" style="border:none;">
	<div id="menu_wrap" class="bg_white">
		<div class="option">
			<div>
				<div class="search_btn"><input id="inp_keyword" type="text" placeholder="ex) 서울"/><input type="button" value="POI 통합 검색" onclick="javascript:getTotPOISearch()"/></div>
			</div>
		</div>
		<hr>
		<div id="searchResult" style="display: none;">
			<div class="title">검색 결과(<span id="searchCount">0</span>)
				<input type="button" value="닫기" id="close" style="float:right;">
			</div>
			<table>					
				<tbody id="searchTbody">
				</tbody>
			</table>
			</div>
	</div>
</div>


    </div>
    </header>
	<jsp:include page="/resources/include/footer.jsp" />
  	<jsp:include page="/resources/include/copyright.jsp" />
  	<jsp:include page="/resources/include/modals.jsp" />
	
</body>
</html>