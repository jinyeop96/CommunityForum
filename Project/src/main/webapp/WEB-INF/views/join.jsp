<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">

<title>Login</title>
<script src="http://code.jquery.com/jquery-3.4.1.js"></script> <!-- JQuery사용을 위한 라이브러리 다운로드 -->
<script src="./resources/js/join.js" ></script>  <!-- Join.jsp에서 사용될 함수가 저장된 라이브러리로드 -->
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script> <!-- Daum 우편번호검색 API활용을 위한 라이브러리 다운로드 -->


<script >
$(function(){
	
	
	
	$("#idcheck").click(function(){
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
							alert("중복된 아이디입니다.");
							$("#id_leng").html("");
							$('#c_pwd').attr("readonly",true);
							idflag = 0;
						}else{
							alert("사용가능한 아이디입니다.");
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
						$('#email1').attr("readonly",true);
						$('#email2').attr("readonly",true);
						
					}else{
						$('#checknick').html("사용가능한 닉네임입니다.");
						$('#email2').attr("readonly",false);
						$('#email2').attr("readonly",false);
						
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
<body>
		<jsp:include page="/resources/include/navigation.jsp" />

	 <!--  section01 -->
	<header class="masthead bg-primary text-white text-center">
    <div class="container d-flex align-items-center flex-column">
      
      <h1 class="masthead-heading text-uppercase mb-0">회원 가입</h1>
      
      <div id="loginDiv" align="center" style="width: 100%">
      <form onsubmit="return formchk()" method="post" action="<%=request.getContextPath()%>/join_ok.do">
      	<table >
      
      	
      		<tr>
      			<th style="width: 20%" >아 이 디 </th>
      			<td align="left" style="margin-left: 0px"><input class="input" name="j_id" id="j_id"  maxlength="16" > <input type="button" id="idcheck" value="중복검사">
      			<br><span id="id_leng"></span>
      			</td> 
      		</tr>
      		
      		<tr>
      			<th>비밀번호</th>
      			<td align="left"><input class="input" type="password" name="c_pwd" id="c_pwd" onkeyup="PwdLength()">
      			<br><span id="pwd_leng"></span>
      			</td>
      		</tr>
      		
      		<tr>
      			<th>비밀번호 확인</th>
      			<td align="left"><input class="input" type="password" name="j_pwd" id="j_pwd" onkeyup="PwdChk()" >
      			<br><span id="pwd_chk"></span>
      			</td>
      		</tr>
      		
      		<tr>
      			<th>이    름 </th>
      			<td align="left"><input class="input" name="j_name" id="j_name"></td> 
      		</tr>
      		
      		<tr>
      			<th>닉 네 임 </th>
      			<td align="left"><input class="input" name="j_nickname" id="j_nickname" >
      			<br><span id="checknick"></span>
      			
      			</td> 
      		</tr>
      		
      		<tr>
      			<th>이 메 일 </th>
      			<td align="left"><input class="input" name="email1" id="email1" >@<input class="input" placeholder="직접 입력" id="email2" readonly="readonly">
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
      			<td align="left"><input class="input" name="j_mobile" id="j_mobile" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');" >
      			<br><span> ' - '없이 숫자만 입력</span></td> 
      		</tr>
      		
      		<tr>
      			<th>우편번호</th>
      		<td align="left"><input class="input"  id="zip" readonly="readonly" onclick="zipSearch()">&nbsp;&nbsp;  <input type="button" value="우편번호 검색" onclick="zipSearch()" ></td> 
      		</tr>
      		<tr>
      			<th>상세주소1 </th>
      			<td align="left"><input class="input"   id="addr1" readonly="readonly"></td> 
      		</tr>
      		<tr>
      			<th>상세주소2</th>
      			<td align="left"><input class="input"   id="addr2" onblur="addrsum();mailplus()" >
      			<input type="hidden" name="j_addr" id="j_addr" onblur="addrsum()">

      			</td> 
      		</tr>
      		
      		<tr>
      			<th>생년원일</th>
      			<td align="left"><input class="input" type="date" name="j_birth" value="1990-01-01"></td> 
      		</tr>
      			
      			
      		
      		
      		
      	</table>
      	<input  type="submit" value="가입하기" onmouseover="">&nbsp;&nbsp;
      	<input type="button" value="돌아가기" onclick="history.back();"> 
      	</form>
      </div>
    </div>
  </header>
  </head>
  
  <jsp:include page="/resources/include/footer.jsp" />
  <jsp:include page="/resources/include/copyright.jsp" />
  <jsp:include page="/resources/include/modals.jsp" />
</body>
</html>