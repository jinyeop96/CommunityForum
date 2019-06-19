<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Login</title>
<script src="http://code.jquery.com/jquery-3.4.1.js"></script> <!-- JQuery사용을 위한 라이브러리 다운로드 -->
<script src="./resources/js/join.js" ></script>  <!-- Join.jsp에서 사용될 함수가 저장된 라이브러리 다운로드 -->
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script> <!-- Daum 우편번호검색 API활용을 위한 라이브러리 다운로드 -->
<script >
$(function(){
	var id;
	$("#idchk").click(function(){

		id = $("#j_id").val();
		alert(id);
		$.ajax({
			url:"idcheck.do",
			type : "post",
			data : {
				j_id : id
			},
			dataType : "text",
			
			success:function(data){
				
				console.log(data);
				
				if(data == '1'){
					alert("사용불가");
				}else{
					alert("사용가능");
				}
			},
			error : function(data){
				alert("오류 "+data);
			}
		});
		
	});


});
</script>

</head>
	<jsp:include page="/resources/include/navigation.jsp" />
	

	 <!--  section01 -->
	<header class="masthead bg-primary text-white text-center">
    <div class="container d-flex align-items-center flex-column">
      
      <h1 class="masthead-heading text-uppercase mb-0">회원 가입</h1><br><br><br>
      
      <div id="JoinDiv" >
      <form onsubmit="mailplus();return formchk()" method="post" action="<%=request.getContextPath()%>/join_ok.do">
      	<table>
      
      	
      		<tr>
      			<th>아 이 디 </th>
      			<td align="left"><input class="input" name="j_id" id="j_id" onkeyup="IdLength()">&nbsp;&nbsp;<input type="button" value="아이디중복확인" id="idchk"><br>
      			<span id="id_leng"></span>
      			</td> 
      		</tr>
      		
      		<tr>
      			<th>비밀번호</th>
      			<td align="left"><input class="input" type="password" name="j_pwd" id="j_pwd" onkeyup="PwdLength()">
      			<span id="pwd_leng"></span>
      			</td>
      		</tr>
      		
      		<tr>
      			<th>비밀번호 확인</th>
      			<td align="left"><input class="input" type="password" name="c_pwd" id="c_pwd" onkeyup="PwdChk()">
      			<span id="pwd_chk"></span>
      			</td>
      		</tr>
      		
      		<tr>
      			<th>이    름 </th>
      			<td align="left"><input class="input" name="j_name" id="j_name"></td> 
      		</tr>
      		
      		<tr>
      			<th>닉 네 임 </th>
      			<td align="left"><input class="input" name="j_nickname" id="j_nickname" onkeyup="NickChk()">
      			<span id="checknick"></span>
      			</td> 
      		</tr>
      		
      		<tr>
      			<th>이 메 일 </th>
      			<td align="left"><input class="input" name="email1" id="j_email">@<input name="j_emailself" class="input" placeholder="직접 입력" id="emailadd" >
      			<select id="email2" onchange="mail()">
      			  <option value="">메일 도메인</option>
      			  <option  value="naver.com" >naver.com</option>
      			  <option  value="hanmail.net">hanmail.net</option>
      			  <option  value="gmail.com">gmail.com</option>
      			</select>
      				<input type="hidden" name="j_email" id="j_email">
      			</td> 
      		
      		<tr>
      			<th>전화번호 </th>
      			<td align="left"><input class="input" name="j_mobile" id="j_mobile" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');"><span> ' - '없이 숫자만 입력</span></td> 
      		</tr>
      		
      		<tr>
      			<th>우편번호</th>
      		<td align="left"><input class="input"  id="zip" readonly="readonly" onclick="zipSearch()">&nbsp;&nbsp;  <input type="button" value="우편번호 검색" onclick="zipSearch()" ></td> 
      		</tr>
      		<tr>
      			<th>상세주소1 </th>
      			<td align="left"><input class="input"  size="50px" id="addr1"></td> 
      		</tr>
      		<tr>
      			<th>상세주소2</th>
      			<td align="left"><input class="input"  size="50px" id="addr2" onblur="addrsum()">
      			<input type="hidden" name="j_addr" id="j_addr">
      			</td> 
      		</tr>
      		
      		<tr>
      			<th>생년원일</th>
      			<td align="left"><input class="input" type="date" name="j_birth" value="1990-01-01"></td> 
      		</tr>
      			
      			
      		
      		
      		
      	</table>
      	<input id="joginBtn" type="submit" value="가입하기">&nbsp;&nbsp;
      	<input type="button" value="돌아가기" onclick="history.back();"> 
      	</form>
      </div>
    </div>
  </header>
  
  
  <jsp:include page="/resources/include/footer.jsp" />
  <jsp:include page="/resources/include/copyright.jsp" />
  <jsp:include page="/resources/include/modals.jsp" />

</html>