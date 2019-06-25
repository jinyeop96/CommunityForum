<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Login</title>
<script src="http://code.jquery.com/jquery-3.4.1.js"></script> <!-- JQuery사용을 위한 라이브러리 다운로드 -->
<script src="./resources/js/join.js" ></script>  <!-- Join.jsp에서 사용될 함수가 저장된 라이브러리로드 -->
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script> <!-- Daum 우편번호검색 API활용을 위한 라이브러리 다운로드 -->


</head>
	<jsp:include page="/resources/include/navigation.jsp" />
<script >
$(function(){
	var id; 
	var idflag = 0;
	var nickflag = 0;
	$("#j_id").keyup(function(){
		id = $("#j_id").val();
		if(id!=''){
			if(id.length < 5){
				$("#id_leng").html("아이디는 4자 이상 최대16자리까지만 가능합니다.");
				$('#id_check').html("");
			}else{
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
							$('#id_check').html("중복된 아이디입니다.");
							$("#id_leng").html("");
							$('#c_pwd').attr("readonly",true);
							idflag = 0;
						}else{
							$('#id_check').html("사용가능한 아이디입니다.");
							$("#id_leng").html("");
							idflag = 1;
							$('#c_pwd').attr("readonly",false);
						}
					},
					error : function(data){
						alert("오류 "+data);
					}
				});
			}
		
		}else{
			alert("아이디를 입력해주세요");
		}
	});
	
	$("#j_nickname").keyup(function(){
		var nickname;
		nickname=$('#j_nickname').val();
		$.ajax({
			url :"nickcheck.do",
			type : "post",
			data : {
				j_nickname : nickname
			},
			dataType : "text",
			success:function(data){
				if(nickname !=''){
				
					if(data == '1'){
						$('#checknick').html("중복된 닉네임입니다.");
						nickflag=0;
					}else{
						$('#checknick').html("사용가능한 닉네임입니다.");
						nickflag=1;
					}
					
				}else{
					$('#checknick').html("닉네임 입력해주세요.");
				}
				
			},
			error : function(data){
				alert("통신오류 " + data);
			}
		});
		
		
	});
	
	
	
});
</script>
	

	 <!--  section01 -->
	<header class="masthead bg-primary text-white text-center">
    <div class="container d-flex align-items-center flex-column">
      
      <h1 class="masthead-heading text-uppercase mb-0">회원 가입</h1><br><br><br>
      
      <div id="JoinDiv" >
      <form onsubmit="return formchk();" method="post" action="<%=request.getContextPath()%>/join_ok.do">
      	<table>
      
      	
      		<tr>
      			<th>아 이 디 </th>
      			<td align="left"><input class="input" name="j_id" id="j_id"  maxlength="16" >&nbsp;&nbsp;<span id="id_check"></span><br>
      			<span id="id_leng"></span>
      			</td> 
      		</tr>
      		
      		<tr>
      			<th>비밀번호</th>
      			<td align="left"><input class="input" type="password" name="c_pwd" id="c_pwd" onkeyup="PwdLength()">
      			<span id="pwd_leng"></span>
      			</td>
      		</tr>
      		
      		<tr>
      			<th>비밀번호 확인</th>
      			<td align="left"><input class="input" type="password" name="j_pwd" id="j_pwd" onkeyup="PwdChk()" >
      			<span id="pwd_chk"></span>
      			</td>
      		</tr>
      		
      		<tr>
      			<th>이    름 </th>
      			<td align="left"><input class="input" name="j_name" id="j_name"></td> 
      		</tr>
      		
      		<tr>
      			<th>닉 네 임 </th>
      			<td align="left"><input class="input" name="j_nickname" id="j_nickname">
      			<span id="checknick"></span>
      			</td> 
      		</tr>
      		
      		<tr>
      			<th>이 메 일 </th>
      			<td align="left"><input class="input" name="email1" id="email1">@<input class="input" placeholder="직접 입력" id="email2" >
      			<select id="email_select" onchange="mail()">
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
      			<td align="left"><input class="input"  size="50px" id="addr2" onblur="addrsum()" >
      			<input type="hidden" name="j_addr" id="j_addr" onblur="addrsum()">
      			</td> 
      		</tr>
      		
      		<tr>
      			<th>생년원일</th>
      			<td align="left"><input class="input" type="date" name="j_birth" value="1990-01-01"></td> 
      		</tr>
      			
      			
      		
      		
      		
      	</table>
      	<input  type="submit" value="가입하기">&nbsp;&nbsp;
      	<input type="button" value="돌아가기" onclick="history.back();"> 
      	</form>
      </div>
    </div>
  </header>
  
  
  <jsp:include page="/resources/include/footer.jsp" />
  <jsp:include page="/resources/include/copyright.jsp" />
  <jsp:include page="/resources/include/modals.jsp" />

</html>