<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
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
			str += "<br>";
			
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
				str += "<br>";
				
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
				str += "<br>";
				
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
							
							if(resultArr[i].runDay.includes("금토")){
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
	    	<div>
				<input type="text" id="depart" placeholder="출발지">
				<input type="text" id="arrival" placeholder="도착지">
				<!-- <button onclick="searchBusLaneAJAX();">click</button> -->
				<button onclick="getTable();">click</button>
			</div>
				
			<br>
			<h5 class="font-black division">고속버스</h5>
			<div id="expressDiv" class="font-black" style="width: 100%"></div>
			<br>
			<h5 class="font-black division">시외버스</h5>
			<div id="intercityDiv" class="font-black" style="width: 100%"></div>
			<br>
			<h5 class="font-black division">기차</h5>
			<div id="trainDiv" class="font-black" style="width: 100%"></div>
	    </div>
    </header>
  
  
	<jsp:include page="/resources/include/footer.jsp" />
  	<jsp:include page="/resources/include/copyright.jsp" />
 	<jsp:include page="/resources/include/modals.jsp" />	<%-- modal.jsp 끝에 js 파일 있어서 반응형 웹이 됩니다~ 마지막에 꼭 넣으십쏘~ --%>
	

</body>
</html>