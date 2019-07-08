<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>교통 테스트</title>

	<script>
		function getTerminalID() {
			$("#resultDiv").empty();
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
					
					for(var j = 0; j < departTerminals.length; j++){
						// 버스 경로 찾는 함수로 index에 해당하는 터미널 ID 넘겨줌
						searchBusLaneAJAX(departTerminals[j], arrivalTerminals[j]); 
					} 
				}
			}
		}
		
		function searchBusLaneAJAX(departTerminal, arrivalTerminal) {
			console.log(departTerminal);
			console.log(arrivalTerminal);
			var xhr = new XMLHttpRequest();
			var url = "https://api.odsay.com/v1/api/intercityServiceTime?lang=0&startStationID="+departTerminal+"&endStationID="+arrivalTerminal+"&apiKey=mSyhSDNsrcpvXQzQURwNYs3mElOH5pql0KFjlvvTyUU";
			xhr.open("GET", url, true);
			xhr.send();
			xhr.onreadystatechange = function() {
				if (xhr.readyState == 4 && xhr.status == 200) { 
					var resultObj = JSON.parse(xhr.responseText);
					var resultArr = resultObj["result"]["station"];
					
					console.log(resultArr);
					
					var str = "";
					for (var i = 0; i < resultArr.length; i++) {
						str += "<div class='box'>";
						str += "<p>출발: " + resultArr[i].startTerminal + "</p>";
						str += "<p>도착 : " + resultArr[i].destTerminal + "</p>";
						str += "<p>첫차 : " + resultArr[i].firstTime + "</p>";
						str += "<p>막차 : " + resultArr[i].lastTime + "</p>";
						str += "<p>요금 : " + resultArr[i].normalFare + "</p>";
						str += "<p>시간표 : " + resultArr[i].schedule + "</p>";
						str += "<hr>";
						str += "</div>";  
					}
					$("#resultDiv").append(str);
				}
			}
		}
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
				<button onclick="getTerminalID();">click</button>
			</div>
				
			<div id="resultDiv" class="font-black"></div>
	    </div>
    </header>
  
  
	<jsp:include page="/resources/include/footer.jsp" />
  	<jsp:include page="/resources/include/copyright.jsp" />
 	<jsp:include page="/resources/include/modals.jsp" />	<%-- modal.jsp 끝에 js 파일 있어서 반응형 웹이 됩니다~ 마지막에 꼭 넣으십쏘~ --%>
	

</body>
</html>