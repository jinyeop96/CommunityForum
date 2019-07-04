<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>hotel</title>
	<style type="text/css">
		.search{
		    border-radius: 5px;
		    background-color: transparent;
		    border: 1px solid black;
		    margin-left: 5px;
		    padding: 0px 20px;
		}

		.searchLoc{
			border-radius: 8px;
		}
		@media(max-width: 450px){
			#searchBar{
				display: none;
			}
			.map_wrap {position:relative;width:100%;height:150px;}
		}
		@media(min-width: 451px){
			.map_wrap {position:relative;width:100%;height:400px;} 
		}
		.map_wrap, .map_wrap * {margin:0; padding:0;font-family:'Malgun Gothic',dotum,'돋움',sans-serif;font-size:12px;}
		#category {position:absolute;top:10px;left:10px;border-radius: 5px; border:1px solid #909090;box-shadow: 0 1px 1px rgba(0, 0, 0, 0.4);background: #fff;overflow: hidden;z-index: 2;}
		#category li {float:left;list-style: none;width:50px;px;border-right:1px solid #acacac;padding:6px 0;text-align: center; cursor: pointer;}
		#category li.on {background: #eee;}
		#category li:hover {background: #ffe6e6;border-left:1px solid #acacac;margin-left: -1px;}
		#category li:last-child{margin-right:0;border-right:0;}
		#category li span {display: block;margin:0 auto 3px;width:27px;height: 28px;}
		#category li .category_bg {background:url(http://t1.daumcdn.net/localimg/localimages/07/mapapidoc/places_category.png) no-repeat;}
		#category li .hotel {background-position: -10px 0;}
		#category li.on .category_bg {background-position-x:-46px;}
		.placeinfo_wrap {position:absolute;bottom:28px;left:-150px;width:300px;}
		.placeinfo {position:relative;width:100%;border-radius:6px;border: 1px solid #ccc;border-bottom:2px solid #ddd;padding-bottom: 10px;background: #fff;}
		.placeinfo:nth-of-type(n) {border:0; box-shadow:0px 1px 2px #888;}
		.placeinfo_wrap .after {content:'';position:relative;margin-left:-12px;left:50%;width:22px;height:12px;background:url('http://t1.daumcdn.net/localimg/localimages/07/mapapidoc/vertex_white.png')}
		.placeinfo a, .placeinfo a:hover, .placeinfo a:active{color:#fff;text-decoration: none;}
		.placeinfo a, .placeinfo span {display: block;text-overflow: ellipsis;overflow: hidden;white-space: nowrap;}
		.placeinfo span {margin:5px 5px 0 5px;cursor: default;font-size:13px;}
		.placeinfo .title {font-weight: bold; font-size:14px;border-radius: 6px 6px 0 0;margin: -1px -1px 0 -1px;padding:10px; color: #fff;background: #d95050;background: #d95050 url(http://t1.daumcdn.net/localimg/localimages/07/mapapidoc/arrow_white.png) no-repeat right 14px center;}
		.placeinfo .tel {color:#0f7833;}
		.placeinfo .jibun {color:#999;font-size:11px;margin-top:0;}
	</style>
</head>
<body>

	<jsp:include page="/resources/include/navigation.jsp" />
	
	<header class="masthead bg-primary text-white text-center">
    <div class="container d-flex align-items-center flex-column">
    
    <h1 class="masthead-heading text-uppercase mb-0">숙박시설 검색</h1> <br><br><br>

	<table style="width: 100%">
		<tr>
			<td id="searchBar">
				<c:if test="${empty hotel_search }"><input class="searchLoc"><input type="button" class="search" onclick="search()" value="검색"></c:if>
				<c:if test="${!empty hotel_search }"><input class="searchLoc" value="${hotel_search }"><input class="search" type="button" onclick="search()" value="검색"></c:if>
    		</td>
		</tr>
	</table>

<div class="map_wrap">
    <div id="map" style="width:100%;height:100%; position:relative;overflow:hidden; border-radius: 15px "></div>
    
    <ul id="category" style="color:black;">
        <li id="AD5" data-order="0"> 
            <span class="category_bg hotel" ></span>
            숙박시설
        </li>       
       
    </ul>
</div>
	
	<br><br>

<div align="center" class="board font-black">
	<table id="board" class="font-black board"></table>
</div>

<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=86b59d080c4ee3e8f0d9fc3cfd7b71c8&libraries=services"></script>
<script>
	$(function(){
		boardBottomCon();
		
		//hotel.jsp 들어올때 기본적으로 댓글은 숨김
		$(".hide").hide();	//기본적으로 댓글 숨기기
		
	});
	
	function replyDelete(reply_no){
		if(confirm("댓글 삭제하시겠습니까?")){
			$.ajax({
				url:"replyDelete.do",
				type:"get",
				data: { "reply_no": reply_no},
			 
				success:function(){
						boardBottomCon();
						$(".hide").hide();	//기본적으로 댓글 숨기기
				}
			});
		}
	}
	
	function replyEdit(reply_no){
		$(".replyEditHide"+reply_no).toggle();
	}

	// 답변 수정
	function replyEditOk(reply_no,num, num2, pageParam){	
		$.ajax({
			url:"replyEditOk.do",
			type:"get",
			data: { "reply_no": reply_no,			//해당 원글 번호
					"reply_content": $("#reply_content_edit"+num2).val()},	//답글
		
			success:function(){
					$("#reply_content_edit"+num2).val("");
					boardBottomCon(pageParam, 0);
					$(".hide").hide();	//기본적으로 댓글 숨기기 
					showReply(num);
			}
		});
	};	//replyEditOk();

	// 답변 달기
	function reply(board_no, num, pageParam){	
		$.ajax({
			url:"replyUpdate.do",
			type:"get",
			data: { "board_no": board_no,			//해당 원글 번호
					"reply_content": $("#reply_content"+num).val(),	//답글
					"reply_nickname": "${nickname}",
					"pageParam": pageParam },	// 닉네임 (나중에 session으로 처리할 때 nickname으로 할 예정)
		
			success:function(result){	// result = pageParam
					$("#reply_content"+num).val("");
					boardBottomCon(result, 0);
					$(".hide").hide();	//기본적으로 댓글 숨기기
					showReply(num);
					$("html, body").animate({scrollTop : $("#reply"+num).offset().top}, 400);
			}
		});
	};	//reply();

	// 답변글 토글
	 function showReply(num){
		$(".reply"+num).toggle();
		$(".editHide").hide();
	}
 
	// 지도 아래 게시물 가져오기
	function boardBottomCon(pageParam, checkPageUp){  
		if(pageParam == null){
			pageParam = 1;	//가장 처음 boardContent.jsp에 들어올 때는 board.jsp의 몇번째 페이지 였는지 알아야함. 안그러면 bottomBoard에는 무조건 page1으로 감.
		}
		if(checkPageUp == 1){
			$("html, body").animate({scrollTop : $("#map").offset().top}, 400);
		}
		
		$.ajax({
			url: "boardBottomCon.do",
			type:"post",
			async: false,
			data: {"pageParam": pageParam,
				   "board_type": "hotel"},
			success:function(result){
				$("#board").html(result).trigger("create");
				$(".hide").hide();	//기본적으로 댓글 숨기기
			}
		});
	};	

// 모바일에서 지도 터치 했을 때 큰 지도로 넘어감
$("#map").on("click", function(){
	var filter = "win16|win32|win64|macintel|mac|"; // PC일 경우 가능한 값

	if( navigator.platform){
		 if( filter.indexOf(navigator.platform.toLowerCase())<0 ){	// 모바일 접속
			var searchLoc = $(".searchLoc").val();
			$("body").load("hotelPopup.do?hotel_search="+searchLoc,function(responseText, statusText, xhr){ 
				 if(statusText == "error")
	                 alert("An error occurred: " + xhr.status + " - " + xhr.statusText);  
			}); 
		} else {
			// pc 접속
		} 
			
	} 
	  
});
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// 마커를 클릭했을 때 해당 장소의 상세정보를 보여줄 커스텀오버레이입니다
var placeOverlay = new kakao.maps.CustomOverlay({zIndex:1}), 
    contentNode = document.createElement('div'), // 커스텀 오버레이의 컨텐츠 엘리먼트 입니다 
    markers = [], // 마커를 담을 배열입니다
    currCategory = ''; // 현재 선택된 카테고리를 가지고 있을 변수입니다
 
var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
    mapOption = {
        center: new kakao.maps.LatLng(37.566826, 126.9786567), // 지도의 중심좌표
        level: 7 // 지도의 확대 레벨
    };  
// 지도를 생성합니다    
var map = new kakao.maps.Map(mapContainer, mapOption); 
//지도 타입 변경 컨트롤을 생성한다
var mapTypeControl = new kakao.maps.MapTypeControl();
// 지도의 상단 우측에 지도 타입 변경 컨트롤을 추가한다
map.addControl(mapTypeControl, kakao.maps.ControlPosition.TOPRIGHT);
// 장소 검색 객체를 생성합니다
var ps = new kakao.maps.services.Places(map); 

//main.jsp 에서 바로 검색해서 들어온 경우 address 값이 있으면 바로 실행
$(function(){
	if("${!empty hotel_search}"){
		search();
	}
})

//  지도 이동
function search(){
	var searchLoc = $(".searchLoc").val();
	ps.keywordSearch(searchLoc, placesSearchLoc);
} 

function placesSearchLoc (data, status, pagination) {
    if (status === kakao.maps.services.Status.OK) {

        // 검색된 장소 위치를 기준으로 지도 범위를 재설정하기위해
        // LatLngBounds 객체에 좌표를 추가합니다
        var bounds = new kakao.maps.LatLngBounds();

        for (var i=0; i<data.length; i++) {
            bounds.extend(new kakao.maps.LatLng(data[i].y, data[i].x));
        }       

        // 검색된 장소 위치를 기준으로 지도 범위를 재설정합니다
        map.setBounds(bounds);
    } 
}	// 지도 이동 끝
	
// 지도에 idle 이벤트를 등록합니다
kakao.maps.event.addListener(map, 'idle', searchPlaces);
// 커스텀 오버레이의 컨텐츠 노드에 css class를 추가합니다 
contentNode.className = 'placeinfo_wrap';
// 커스텀 오버레이의 컨텐츠 노드에 mousedown, touchstart 이벤트가 발생했을때
// 지도 객체에 이벤트가 전달되지 않도록 이벤트 핸들러로 kakao.maps.event.preventMap 메소드를 등록합니다 
addEventHandle(contentNode, 'mousedown', kakao.maps.event.preventMap);
addEventHandle(contentNode, 'touchstart', kakao.maps.event.preventMap);
// 커스텀 오버레이 컨텐츠를 설정합니다
placeOverlay.setContent(contentNode);  
// 각 카테고리에 클릭 이벤트를 등록합니다
addCategoryClickEvent();
// 엘리먼트에 이벤트 핸들러를 등록하는 함수입니다
function addEventHandle(target, type, callback) {
    if (target.addEventListener) {
        target.addEventListener(type, callback);
    } else {
        target.attachEvent('on' + type, callback);
    }
}
// 카테고리 검색을 요청하는 함수입니다
function searchPlaces() {
    if (!currCategory) {
        return;
    }
    
    // 커스텀 오버레이를 숨깁니다 
    placeOverlay.setMap(null);
    // 지도에 표시되고 있는 마커를 제거합니다
    removeMarker();
    
    ps.categorySearch(currCategory, placesSearchCB, {useMapBounds:true}); 
}
// 장소검색이 완료됐을 때 호출되는 콜백함수 입니다
function placesSearchCB(data, status, pagination) {
    if (status === kakao.maps.services.Status.OK) {
        // 정상적으로 검색이 완료됐으면 지도에 마커를 표출합니다
        displayPlaces(data);
    } else if (status === kakao.maps.services.Status.ZERO_RESULT) {
        // 검색결과가 없는경우 해야할 처리가 있다면 이곳에 작성해 주세요
    } else if (status === kakao.maps.services.Status.ERROR) {
        // 에러로 인해 검색결과가 나오지 않은 경우 해야할 처리가 있다면 이곳에 작성해 주세요
        
    }
}
// 지도에 마커를 표출하는 함수입니다
function displayPlaces(places) {
    // 몇번째 카테고리가 선택되어 있는지 얻어옵니다
    // 이 순서는 스프라이트 이미지에서의 위치를 계산하는데 사용됩니다
    var order = document.getElementById(currCategory).getAttribute('data-order');
    
    for ( var i=0; i<places.length; i++ ) {
            // 마커를 생성하고 지도에 표시합니다
            var marker = addMarker(new kakao.maps.LatLng(places[i].y, places[i].x), order);
            // 마커와 검색결과 항목을 클릭 했을 때
            // 장소정보를 표출하도록 클릭 이벤트를 등록합니다
            (function(marker, place) {
                kakao.maps.event.addListener(marker, 'click', function() {
                    displayPlaceInfo(place);
                });
            })(marker, places[i]);
    }
}
// 마커를 생성하고 지도 위에 마커를 표시하는 함수입니다
function addMarker(position, order) {
		var imageSrc = 'http://t1.daumcdn.net/localimg/localimages/07/mapapidoc/places_category.png', // 마커 이미지 url, 스프라이트 이미지를 씁니다
        imageSize = new kakao.maps.Size(27, 28),  // 마커 이미지의 크기
        imgOptions =  {
            spriteSize : new kakao.maps.Size(72, 208), // 스프라이트 이미지의 크기
            spriteOrigin : new kakao.maps.Point(46, (order*36)), // 스프라이트 이미지 중 사용할 영역의 좌상단 좌표
            offset: new kakao.maps.Point(11, 28) // 마커 좌표에 일치시킬 이미지 내에서의 좌표
        }, 
        markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imgOptions),
            marker = new kakao.maps.Marker({
            position: position, // 마커의 위치
            image: markerImage 
        });
    marker.setMap(map); // 지도 위에 마커를 표출합니다
    markers.push(marker);  // 배열에 생성된 마커를 추가합니다
    return marker;
}
 




// 지도 위에 표시되고 있는 마커를 모두 제거합니다
function removeMarker() {
    for ( var i = 0; i < markers.length; i++ ) {
        markers[i].setMap(null);
    }   
    markers = [];
}
// 클릭한 마커에 대한 장소 상세정보를 커스텀 오버레이로 표시하는 함수입니다
function displayPlaceInfo (place) {

    var content = '<div class="placeinfo" >' +  
                    '<a class="title" onclick="closeOverlay()" title="닫기" href="' + place.place_url + '" target="_blank" title="' + place.place_name + '">' + place.place_name + '</a>';   

    var content = '<div class="placeinfo">' +
                    '   <a class="title" href="' + place.place_url + '" target="_blank" title="' + place.place_name + '">' + place.place_name + '</a>';   
    if (place.road_address_name) {
        content += '    <span title="' + place.road_address_name + '">' + place.road_address_name + '</span>' +
                    '  <span class="jibun" title="' + place.address_name + '">(지번 : ' + place.address_name + ')</span>';
    }  else {
        content += '    <span title="' + place.address_name + '">' + place.address_name + '</span>';
    }                
   
    content += '    <span class="tel">' + place.phone + '</span>' + 
                '</div>' + 
                '<div class="after"></div>';
    contentNode.innerHTML = content;
    placeOverlay.setPosition(new kakao.maps.LatLng(place.y, place.x));
    placeOverlay.setMap(map);  
}
// 각 카테고리에 클릭 이벤트를 등록합니다
function addCategoryClickEvent() {
    var category = document.getElementById('category'),
        children = category.children;
    for (var i=0; i<children.length; i++) {
        children[i].onclick = onClickCategory;
    }
    children[0].click();
}
// 카테고리를 클릭했을 때 호출되는 함수입니다
function onClickCategory() {
    var id = this.id,
        className = this.className;
    placeOverlay.setMap(null);
    if (className === 'on') {
        currCategory = '';
        changeCategoryClass();
        removeMarker();
    } else {
        currCategory = id;
        changeCategoryClass(this);
        searchPlaces();
    }
}
// 클릭된 카테고리에만 클릭된 스타일을 적용하는 함수입니다
function changeCategoryClass(el) {
    var category = document.getElementById('category'),
        children = category.children,
        i;
    for ( i=0; i<children.length; i++ ) {
        children[i].className = '';
    }
    if (el) {
        el.className = 'on';
    } 
} 
</script>
</div>
</header>

	<jsp:include page="/resources/include/footer.jsp" />
  	<jsp:include page="/resources/include/copyright.jsp" />
  	<jsp:include page="/resources/include/modals.jsp" />
	
</body>
</html>

