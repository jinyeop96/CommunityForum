<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Login</title>
</head>
	<jsp:include page="/resources/include/navigation.jsp" />
	

	 <!--  section01 -->
	<header class="masthead bg-primary text-white text-center">
    <div class="container d-flex align-items-center flex-column">
      
      <h1 class="masthead-heading text-uppercase mb-0">회원 가입</h1><br><br><br>
      
      <div id="JoinDiv" >
      <form method="post" action="<%=request.getContextPath()%>/join_ok.do">
      	<table>
      
      	
      		<tr>
      			<th>아 이 디 </th>
      			<td align="left"><input class="input" name="j_id">&nbsp;&nbsp;<input type="button" value="아이디중복확인"></td> 
      		</tr>
      		
      		<tr>
      			<th>비밀번호</th>
      			<td align="left"><input class="input" type="password" name="j_pwd" ></td>
      		</tr>
      		
      		<tr>
      			<th>비밀번호 확인</th>
      			<td align="left"><input class="input" type="password" name="c_pwd" ></td>
      		</tr>
      		
      		<tr>
      			<th>이    름 </th>
      			<td align="left"><input class="input" name="j_name"></td> 
      		</tr>
      		
      		<tr>
      			<th>닉 네 임 </th>
      			<td align="left"><input class="input" name="j_nickname"></td> 
      		</tr>
      		
      		<tr>
      			<th>이 메 일 </th>
      			<td align="left"><input class="input" name="j_email1">@<input name="j_emailself" placeholder="직접 입력">
      			<select name="j_email2">
      			  <option id="naver" value="@naver.com">naver.com</option>
      			  <option id="hanmail" value="@hanmail.net">hanmail.net</option>
      			  <option id="gmail" value="@gmail.com">gmail.com</option>
      			  
      			</select>
      			</td> 
      		
      		<tr>
      			<th>전화번호 </th>
      			<td align="left"><input class="input" name="j_mobile"></td> 
      		</tr>
      		
      		<tr>
      			<th>우편번호</th>
      			<td align="left"><input class="input" name="j_addr1">&nbsp;&nbsp; <input type="button" value="우편번호 검색"></td> 
      		</tr>
      		<tr>
      			<th>상세주소 </th>
      			<td align="left"><input class="input" name="j_addr2" size="50px"></td> 
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