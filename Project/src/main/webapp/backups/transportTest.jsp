<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no">
<title>교통 테스트</title>
	<style type="text/css">
		.division{
			border: 1px solid white;
		    padding: 3px 20px;
		    border-radius: 15px;
		}
	</style>
<script type="text/javascript" src="<c:url value='/resources/jquery-3.4.1.js'/>"></script>
	<script>
		$(function(){
			$(".division").hide();
		})
		function getTable(){
			getIntercityTerminalID();  
			getExpressTerminalID();   
			getTrainTerminalID();   
			$(".division").show();
		}  
	
		function getIntercityTerminalID() {
			$("#intercityDiv").empty();
			var depart = document.getElementById('depart').value.trim();
			var arrival = document.getElementById('arrival').value.trim();
			var xhr = new XMLHttpRequest(); 
			var url = "https://api.odsay.com/v1/api/intercityBusTerminals?lang=0&terminalName="+depart+"&apiKey=mSyhSDNsrcpvXQzQURwNYs3mElOH5pql0KFjlvvTyUU";
			xhr.open("GET", url, true);
			xhr.send();
			xhr.onreadystatechange = function() {
				if (xhr.readyState == 4 && xhr.status == 200) {
					var resultObj = JSON.parse(xhr.responseText);
					
					var resultArr = resultObj.result;
					console.log(resultArr);
					
					var departTerminals = new Array();	// 출발터미널 ID
					var arrivalTerminals = new Array();	// 도착터미널 ID
					
					for (var i = 0; i < resultArr.length; i++) {
						var result = resultArr[i];
						var destinationTerminals = result.destinationTerminals;
						
						for(var j = 0; j < destinationTerminals.length; j++){ //출발지 기준 모든 도착터미널 가져옴
							// 도착터미널 중에서 입력받은 arrival이 포함되어 있다면 배열에 터미널ID 저장
							if(destinationTerminals[j].stationName.includes(arrival)){ 
								departTerminals.push(result.stationID);
								arrivalTerminals.push(destinationTerminals[j].stationID); 
							}
						}   
					} 
					
					// 출발터미널 ID에 아무것도 없으면 그냥 1, 1만 보냄
					if(departTerminals[0] == null){
						searchIntercityBusLaneAJAX(1, 1);
					} else {
						for(var i = 0; i < departTerminals.length; i++){
							// 버스 경로 찾는 함수로 index에 해당하는 터미널 ID 넘겨줌
							searchIntercityBusLaneAJAX(departTerminals[i], arrivalTerminals[i]); 
						}  
						
					} 
				} 
			}
		}	//getIntercityTerminalID()
		
		function searchIntercityBusLaneAJAX(departTerminal, arrivalTerminal) {
			var str = "";
			
			// 출발터미널 ID에 1만 있으면 찾는 경로 없음 표시 & return
			if(departTerminal == 1){
				str += "<div class='box'>";
				str += "찾는 경로가 없습니다.";
				str += "</div>";
				$("#intercityDiv").append(str);
				return;
			}
			
			var xhr = new XMLHttpRequest();
			var url = "https://api.odsay.com/v1/api/intercityServiceTime?lang=0&startStationID="+departTerminal+"&endStationID="+arrivalTerminal+"&apiKey=mSyhSDNsrcpvXQzQURwNYs3mElOH5pql0KFjlvvTyUU";
			xhr.open("GET", url, true);
			xhr.send();
			xhr.onreadystatechange = function() {
				if (xhr.readyState == 4 && xhr.status == 200) {  
					var resultObj = JSON.parse(xhr.responseText);
					console.log(resultObj);
					
					var resultArr = resultObj["result"]["station"];
					
					console.log(resultArr);
					
					for (var i = 0; i < resultArr.length; i++) {
						//운행시간표 띄어쓰기로 나눠서 저장
						var scheduleArr = resultArr[i].schedule.split(/(\s+)/);
						var nightScheduleArr = resultArr[i].nightSchedule.split(/(\s+)/);
						
						// wasteTime 분 -> 시간
						var rhour = resultArr[i].wasteTime / 60; 
						var hour = Math.floor( rhour );
						var min = Math.round((rhour - hour) * 60);
						
				//		str += "<div class='box'>";
						str += "<table style='width: 100%'>";
						str += "	<tr><td><hr></td></tr>";
						str += "	<tr>";
						str += "		<td>";
						str += "			<b>"+resultArr[i].startTerminal + " --> " + resultArr[i].destTerminal + "</b>";
						str += "		</td>";
						str += "	</tr>";
						
						str += "	<tr>";
						str += "		<td>"; 
						str += "			첫차 : " + resultArr[i].firstTime + " / 막차 : " + resultArr[i].lastTime;
						str += "		</td>";
						str += "	</tr>";
						
						str += "	<tr>";
						str += "		<td>";
						str += "			일반요금 : " + resultArr[i].normalFare + "원 / 심야요금 : " + resultArr[i].nightFare + "원";
						str += "		</td>";
						str += "	</tr>";
						
						str += "	<tr>";
						str += "		<td>"; 
						str += "			소요시간 : " + hour + "시간 " + min + "분";
						str += "		</td>";
						str += "	</tr>";
						
						str += "	<tr>";
						str += "		<td>";
						str += "			<br>운행시간표";
						str += "		</td>";
						str += "	</tr>";
						for(var j = 0; j < scheduleArr.length; j++){
							str += "<tr>";
							str += "	<td>";
							str += 			scheduleArr[j];
							str += "	</td>";
							str += "</tr>";
							j++;
						}
						console.log(nightScheduleArr);
						if(nightScheduleArr[0] != ""){
							str += "<tr>";
							str += "	<td>";
							str += "		<br>심야 운행시간표";
							str += "	</td>";
							str += "</tr>";
							for(var j = 0; j < nightScheduleArr.length; j++){
								str += "<tr>";
								str += "	<td>";
								str += 			nightScheduleArr[j];
								str += "	</td>";
								str += "</tr>";
								j++;
							}
						}
						str += "</table>";
					//	str += "</div>";
					}	//for (var i = 0; i < resultArr.length; i++)
					$("#intercityDiv").append(str);
				}	//if (xhr.readyState == 4 && xhr.status == 200)
			}
		}	//searchIntercityBusLaneAJAX()
	
		function getExpressTerminalID() {
			$("#expressDiv").empty();
			var depart = document.getElementById('depart').value.trim();
			var arrival = document.getElementById('arrival').value.trim();
			var xhr = new XMLHttpRequest(); 
			var url = "https://api.odsay.com/v1/api/expressBusTerminals?lang=0&terminalName="+depart+"&apiKey=mSyhSDNsrcpvXQzQURwNYs3mElOH5pql0KFjlvvTyUU";
			xhr.open("GET", url, true);
			xhr.send();
			xhr.onreadystatechange = function() {
				if (xhr.readyState == 4 && xhr.status == 200) {
					var resultObj = JSON.parse(xhr.responseText);
					
					var resultArr = resultObj.result;
					console.log(resultArr);
					
					var departTerminals = new Array();	// 출발터미널 ID
					var arrivalTerminals = new Array();	// 도착터미널 ID
					
					for (var i = 0; i < resultArr.length; i++) {
						var result = resultArr[i];
						var destinationTerminals = result.destinationTerminals;
						
						for(var j = 0; j < destinationTerminals.length; j++){ //출발지 기준 모든 도착터미널 가져옴
							// 도착터미널 중에서 입력받은 arrival이 포함되어 있다면 배열에 터미널ID 저장
							if(destinationTerminals[j].stationName.includes(arrival)){ 
								departTerminals.push(result.stationID);
								arrivalTerminals.push(destinationTerminals[j].stationID); 
							}
						}   
					} 
					
					// 출발터미널 ID에 아무것도 없으면 그냥 1, 1만 보냄
					if(departTerminals[0] == null){
						searchExpressBusLaneAJAX(1, 1);
					} else {
						for(var i = 0; i < departTerminals.length; i++){
							// 버스 경로 찾는 함수로 index에 해당하는 터미널 ID 넘겨줌
							searchExpressBusLaneAJAX(departTerminals[i], arrivalTerminals[i]); 
						}  
						
					} 
				} 
			}
		}	//getExpressTerminalID()
		
		function searchExpressBusLaneAJAX(departTerminal, arrivalTerminal) {
				var str = "";
				
				// 출발터미널 ID에 1만 있으면 찾는 경로 없음 표시 & return
				if(departTerminal == 1){
					str += "<div class='box'>";
					str += "찾는 경로가 없습니다.";
					str += "</div>";
					$("#expressDiv").append(str);
					return;
				}
				
				var xhr = new XMLHttpRequest();
				var url = "https://api.odsay.com/v1/api/expressServiceTime?lang=0&startStationID="+departTerminal+"&endStationID="+arrivalTerminal+"&apiKey=mSyhSDNsrcpvXQzQURwNYs3mElOH5pql0KFjlvvTyUU";
				xhr.open("GET", url, true);
				xhr.send();
				xhr.onreadystatechange = function() {
					if (xhr.readyState == 4 && xhr.status == 200) {  
						var resultObj = JSON.parse(xhr.responseText);
						console.log(resultObj);
						
						var resultArr = resultObj["result"]["station"];
						
						console.log(resultArr);
						
						for (var i = 0; i < resultArr.length; i++) {
							//운행시간표 띄어쓰기로 나눠서 저장
							var scheduleArr = resultArr[i].schedule.split(/(\s+)/);
							var nightScheduleArr = resultArr[i].nightSchedule.split(/(\s+)/);
							
							// wasteTime 분 -> 시간
							/* var rhour = resultArr[i].wasteTime / 60; 
							var hour = Math.floor( rhour );
							var min = Math.round((rhour - hour) * 60); */
							
							var wasteTime = resultArr[i].wasteTime.split(":");
							
							//str += "<div class='box'>";
							str += "<table style='width: 100%'>";
							str += "	<tr><td><hr></td></tr>";
							str += "	<tr>";
							str += "		<td>";
							str += "			<b>"+resultArr[i].startTerminal + " --> " + resultArr[i].destTerminal + "</b>";
							str += "		</td>";
							str += "	</tr>";
							  
							str += "	<tr>";
							str += "		<td>";
							str += "			일반요금 : " + resultArr[i].normalFare + "원 / 심야요금 : " + resultArr[i].nightFare + "원";
							str += "		</td>";
							str += "	</tr>";
							
							str += "	<tr>";
							str += "		<td>"; 
							str += "			소요시간 : " + wasteTime[0] + "시간 " + wasteTime[1] + "분";
							str += "		</td>";
							str += "	</tr>";
							
							str += "	<tr>";
							str += "		<td>";
							str += "			<br>운행시간표";
							str += "		</td>";
							str += "	</tr>";
							for(var j = 0; j < scheduleArr.length; j++){
								str += "<tr>";
								str += "	<td>";
								str += 			scheduleArr[j];
								str += "	</td>";
								str += "</tr>";
								j++;
							}
							console.log(nightScheduleArr);
							if(nightScheduleArr[0] != ""){
								str += "<tr>";
								str += "	<td>";
								str += "		<br>심야 운행시간표";
								str += "	</td>";
								str += "</tr>";
								for(var j = 0; j < nightScheduleArr.length; j++){
									str += "<tr>";
									str += "	<td>";
									str += 			nightScheduleArr[j];
									str += "	</td>";
									str += "</tr>";
									j++;
								}
							}
							str += "</table>";
							//str += "</div>";	
						}	//for (var i = 0; i < resultArr.length; i++)
						$("#expressDiv").append(str);
					}	//if (xhr.readyState == 4 && xhr.status == 200) 
				}
			}	//searchBusLaneAJAX()
		
			function getTrainTerminalID() {
				$("#trainDiv").empty();
				var depart = document.getElementById('depart').value.trim();
				var arrival = document.getElementById('arrival').value.trim();
				var xhr = new XMLHttpRequest(); 
				var url = "https://api.odsay.com/v1/api/trainTerminals?lang=0&terminalName="+depart+"&apiKey=mSyhSDNsrcpvXQzQURwNYs3mElOH5pql0KFjlvvTyUU";
				xhr.open("GET", url, true);
				xhr.send();
				xhr.onreadystatechange = function() {
					if (xhr.readyState == 4 && xhr.status == 200) {
						var resultObj = JSON.parse(xhr.responseText);
						
						var resultArr = resultObj.result;
						console.log(resultArr);
						
						var departTerminals = new Array();	// 출발터미널 ID
						var arrivalTerminals = new Array();	// 도착터미널 ID
						
						for (var i = 0; i < resultArr.length; i++) {
							var result = resultArr[i];
							var destinationTerminals = result.arrivalTerminals; 
							
							for(var j = 0; j < destinationTerminals.length; j++){ //출발지 기준 모든 도착터미널 가져옴
								// 도착터미널 중에서 입력받은 arrival이 포함되어 있다면 배열에 터미널ID 저장
								if(destinationTerminals[j].stationName.includes(arrival)){ 
									departTerminals.push(result.stationID);
									arrivalTerminals.push(destinationTerminals[j].stationID); 
								}
							}    
						} 
						
						
						// 출발터미널 ID에 아무것도 없으면 그냥 1, 1만 보냄
						if(departTerminals[0] == null){
							searchTrainAJAX(1, 1);
						} else {
							for(var i = 0; i < departTerminals.length; i++){
								// 버스 경로 찾는 함수로 index에 해당하는 터미널 ID 넘겨줌
								searchTrainAJAX(departTerminals[i], arrivalTerminals[i]); 
							}  
							
						} 
					} 
				}
			}	//getTrainTerminalID()
			
			function searchTrainAJAX(departTerminal, arrivalTerminal) {
				var str = "";
				
				// 출발터미널 ID에 1만 있으면 찾는 경로 없음 표시 & return
				if(departTerminal == 1){
					str += "<div class='box'>";
					str += "찾는 경로가 없습니다.";
					str += "</div>";
					$("#trainDiv").append(str);
					return;
				}
				
				var xhr = new XMLHttpRequest();
				var url = "https://api.odsay.com/v1/api/trainServiceTime?lang=0&startStationID="+departTerminal+"&endStationID="+arrivalTerminal+"&apiKey=mSyhSDNsrcpvXQzQURwNYs3mElOH5pql0KFjlvvTyUU";
				xhr.open("GET", url, true);
				xhr.send();
				xhr.onreadystatechange = function() {
					if (xhr.readyState == 4 && xhr.status == 200) {  
						var resultObj = JSON.parse(xhr.responseText);
						
						var resultArr = resultObj["result"]["station"];
						console.log(resultArr);
						
						for (var i = 0; i < resultArr.length; i++) {
							
							str += "<table style='width: 100%'>";
							str += "	<tr><td colspan='10'><hr></td></tr>";
							
							if(resultArr[i].runDay.includes("금토")){	 	//운행일이 금토가 포함되어 있으면 '주말/공휴일' 요금을 넣어줌
								str += "	<tr>";
								str += "		<th>노선</th><th>열차</th><th>출발</th><th>도착</th><th>시간</th><th>주말</th><th>공휴일</th><th>비고</th><th>운행</th>";
								str += "	</tr>";
						
								str += "	<tr>";
								str += "		<td>"+resultArr[i].railName+"</td><td>"+resultArr[i].trainClass+"</td><td>"+resultArr[i].departureTime+"</td>"+
									   "		<td>"+resultArr[i].arrivalTime+"</td><td>"+resultArr[i].wasteTime+"</td><td>"+resultArr[i]["generalFare"]["weekend"]+"원</td>"+
									   "		<td>"+resultArr[i]["generalFare"]["holiday"]+"원</td><td>  </td><td>"+resultArr[i].runDay+"</td>"; 
								str += "	</tr>";
							} else{ 
								str += "	<tr>";
								str += "		<th>노선</th><th>열차</th><th>출발</th><th>도착</th><th>시간</th><th>입석</th><th>일반</th><th>특석</th><th>운행</th>";
								str += "	</tr>";
						
								str += "	<tr>";
								str += "		<td>"+resultArr[i].railName+"</td><td>"+resultArr[i].trainClass+"</td><td>"+resultArr[i].departureTime+"</td>"+
									   "		<td>"+resultArr[i].arrivalTime+"</td><td>"+resultArr[i].wasteTime+"</td><td>"+resultArr[i]["fare"]["standing"]+"원</td>"+
									   "		<td>"+resultArr[i]["fare"]["general"]+"원</td><td>"+resultArr[i]["fare"]["special"]+"원</td><td>"+resultArr[i].runDay+"</td>";
								str += "	</tr>";
							}
							str += "</table>";
						}	//for (var i = 0; i < resultArr.length; i++)
						$("#trainDiv").append(str);
					}	//if (xhr.readyState == 4 && xhr.status == 200)
				}
			}	//searchTrainAJAX() 
		
		
		
		
			
			
</script>
</head>
<body>
	<jsp:include page="/resources/include/navigation.jsp" />
	
	<header class="masthead bg-primary text-white text-center">
	    <div class="container d-flex align-items-center flex-column">
	    
	    	<div id="map" style="width:100%;height:400px;"></div>
	    
	    	<div>
				<input type="text" id="depart" placeholder="출발지"> 
				<input type="text" id="arrival" placeholder="도착지"> 
				<button onclick="getTable();">검색</button>
			</div>
				
			<br><br><br><h5 class="font-black division">고속버스</h5>
			<div id="expressDiv" class="font-black" style="width: 100%"></div>
			<br><br><br><h5 class="font-black division">시외버스</h5>
			<div id="intercityDiv" class="font-black" style="width: 100%"></div>
			<br><br><br><h5 class="font-black division">기차</h5>
			<div id="trainDiv" class="font-black" style="width: 100%"></div>
	    </div>
	    
<script type="text/javascript" src="https://openapi.map.naver.com/openapi/v3/maps.js?ncpClientId=qvqco74zp8"></script>

	
	<script type="text/javascript">
	// 지도 
		 var map = new naver.maps.Map('map', {
		       	//center: new naver.maps.LatLng(37.3595704, 127.105399), //지도의 초기 중심 좌표 , 없애면 기본 서울시청
		        zoom: 10, //지도의 초기 줌 레벨
		        minZoom: 1, //지도의 최소 줌 레벨
		        zoomControl: true, //줌 컨트롤의 표시 여부
		        zoomControlOptions: { //줌 컨트롤의 옵션 
		            position: naver.maps.Position.TOP_RIGHT
		        } 
		    });

        //setOptions 메서드를 이용해 옵션을 조정할 수도 있습니다.
        map.setOptions("mapTypeControl", true); //지도 유형 컨트롤의 표시 여부	(일반, 위성)
        
        //관성 드래깅 켜기
        map.setOptions("disableKineticPan", false);	
        
        // 현재위치 가쟈오기
        $(window).on("load", function() {
            if (navigator.geolocation) {
                navigator.geolocation.getCurrentPosition(onSuccessGeolocation, onErrorGeolocation);
            } else { 
                var center = map.getCenter();
            }
        });
        
        // 현재위치 가져오기 성공시
        function onSuccessGeolocation(position) {
            var location = new naver.maps.LatLng(position.coords.latitude, position.coords.longitude);

            map.setCenter(location); // 얻은 좌표를 지도의 중심으로 설정합니다.
            map.setZoom(10); // 지도의 줌 레벨을 변경합니다.
        }
		
        // 지도 현재위치 실패시
        function onErrorGeolocation() {
            var center = map.getCenter();
            $("#geoFail").html('<h5 style="margin-top:5px; color: black;">현재위치 가져오기 실패</h5>'); 
        }
    
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
    //경로
    
   
    
    /* var sx = 126.93737555322481;
	var sy = 37.55525165729346;
	var ex = 126.88265238619182;
	var ey = 37.481440035175375; */
	
 	var sx = 127.09406227235078;
	var sy = 37.53439359449373;
	var ex = 127.15442127024295;
	var ey = 36.819235354251994; 
	
	function searchPubTransPathAJAX() {
		var xhr = new XMLHttpRequest(); 
		//ODsay apiKey 입력
		var url = "https://api.odsay.com/v1/api/searchPubTransPath?SX="+sx+"&SY="+sy+"&EX="+ex+"&EY="+ey+"&apiKey=mSyhSDNsrcpvXQzQURwNYs3mElOH5pql0KFjlvvTyUU";
		//https://api.odsay.com/v1/api/searchPubTransPath?lang=0&SX=127.00584617227368&SY=37.505681204426914&EX=129.09544636493575&EY=35.28475727565264&OPT=0
		xhr.open("GET", url, true);
		xhr.send();
		xhr.onreadystatechange = function() {
			if (xhr.readyState == 4 && xhr.status == 200) {
				console.log( JSON.parse(xhr.responseText) ); // <- xhr.responseText 로 결과를 가져올 수 있음
				//노선그래픽 데이터 호출
				if(JSON.parse(xhr.responseText)["result"]["path"] != null ){ 
					callMapObjApiAJAX((JSON.parse(xhr.responseText))["result"]["path"][0].info.mapObj);
					console.log((JSON.parse(xhr.responseText))["result"]["path"][0].info.mapObj);
				} else{   
					if(JSON.parse(xhr.responseText)["result"]["trainRequest"].count != 0){
						for(var i = 0; i < JSON.parse(xhr.responseText)["result"]["trainRequest"].count; i++){
							if(JSON.parse(xhr.responseText)["result"]["trainRequest"]["OBJ"][i].mapOBJ != ""){
								callMapObjApiAJAX((JSON.parse(xhr.responseText))["result"]["trainRequest"]["OBJ"][i].mapOBJ);
								console.log((JSON.parse(xhr.responseText))["result"]["trainRequest"]["OBJ"][i].mapOBJ);
								return;
							}
						}
					}
					if(JSON.parse(xhr.responseText)["result"]["exBusRequest"].count != 0){
						for(var i = 0; i < JSON.parse(xhr.responseText)["result"]["exBusRequest"].count; i++){
							if(JSON.parse(xhr.responseText)["result"]["exBusRequest"]["OBJ"][i].mapOBJ != ""){
								callMapObjApiAJAX((JSON.parse(xhr.responseText))["result"]["exBusRequest"]["OBJ"][i].mapOBJ);
								console.log((JSON.parse(xhr.responseText))["result"]["exBusRequest"]["OBJ"][i].mapOBJ);
								return;
							}
						}
					}
					if(JSON.parse(xhr.responseText)["result"]["outBusRequest"].count != 0){
						for(var i = 0; i < JSON.parse(xhr.responseText)["result"]["outBusRequest"].count; i++){
							if(JSON.parse(xhr.responseText)["result"]["outBusRequest"]["OBJ"][i].mapOBJ != ""){
								callMapObjApiAJAX((JSON.parse(xhr.responseText))["result"]["outBusRequest"]["OBJ"][i].mapOBJ);
								console.log((JSON.parse(xhr.responseText))["result"]["outBusRequest"]["OBJ"][i].mapOBJ);
								return;
							}
						}
					}
				}
			} 
		}
	}
	
	 //길찾기 API 호출
	searchPubTransPathAJAX();
	
	function callMapObjApiAJAX(mabObj){
		var xhr = new XMLHttpRequest();
		//ODsay apiKey 입력
		var url = "https://api.odsay.com/v1/api/loadLane?mapObject=0:0@"+mabObj+"&apiKey=mSyhSDNsrcpvXQzQURwNYs3mElOH5pql0KFjlvvTyUU";
		xhr.open("GET", url, true);
		xhr.send();
		xhr.onreadystatechange = function() {
			if (xhr.readyState == 4 && xhr.status == 200) {
				var resultJsonData = JSON.parse(xhr.responseText);
				drawNaverMarker(sx,sy);					// 출발지 마커 표시
				drawNaverMarker(ex,ey);					// 도착지 마커 표시
				drawNaverPolyLine(resultJsonData);		// 노선그래픽데이터 지도위 표시
				// boundary 데이터가 있을경우, 해당 boundary로 지도이동
				if(resultJsonData.result.boundary){
						var boundary = new naver.maps.LatLngBounds(
				                new naver.maps.LatLng(resultJsonData.result.boundary.top, resultJsonData.result.boundary.left),
				                new naver.maps.LatLng(resultJsonData.result.boundary.bottom, resultJsonData.result.boundary.right)
				                );
						map.panToBounds(boundary);
				}
			}
		}
	}
	
	// 지도위 마커 표시해주는 함수
	function drawNaverMarker(x,y){
		var marker = new naver.maps.Marker({
		    position: new naver.maps.LatLng(y, x),
		    map: map
		});
	}
	
	// 노선그래픽 데이터를 이용하여 지도위 폴리라인 그려주는 함수
	function drawNaverPolyLine(data){
		var lineArray;
		
		for(var i = 0 ; i < data.result.lane.length; i++){
			for(var j=0 ; j <data.result.lane[i].section.length; j++){
				lineArray = null;
				lineArray = new Array();
				for(var k=0 ; k < data.result.lane[i].section[j].graphPos.length; k++){
					lineArray.push(new naver.maps.LatLng(data.result.lane[i].section[j].graphPos[k].y, data.result.lane[i].section[j].graphPos[k].x));
				}
				
			//지하철결과의 경우 노선에 따른 라인색상 지정하는 부분 (1,2호선의 경우만 예로 들음)
				if(data.result.lane[i].type == 1){
					var polyline = new naver.maps.Polyline({
					    map: map,
					    path: lineArray,
					    strokeWeight: 3,
					    strokeColor: '#003499'
					});
				}else if(data.result.lane[i].type == 2){
					var polyline = new naver.maps.Polyline({
					    map: map,
					    path: lineArray,
					    strokeWeight: 3,
					    strokeColor: '#37b42d'
					});
				}else{
					var polyline = new naver.maps.Polyline({
					    map: map,
					    path: lineArray,
					    strokeWeight: 3
					});
				}
			}
		}
	}
       
        
    </script>
	    
    </header>
  
  	
	<jsp:include page="/resources/include/footer.jsp" />
  	<jsp:include page="/resources/include/copyright.jsp" />
 	<jsp:include page="/resources/include/bottomJs.jsp" />	<%-- modal.jsp 끝에 js 파일 있어서 반응형 웹이 됩니다~ 마지막에 꼭 넣으십쏘~ --%>
	

</body>
</html>