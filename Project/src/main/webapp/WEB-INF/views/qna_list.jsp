<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>QNA</title>
<!-- jqeury import -->
<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>


<style>

.paginate_button > a{
color:white;

}
.active > a{
color:black;
}
</style>
<script>
$(function(){
	//jquery mouseover와 mouseleave를 통해 해당 태그에 마우스 이벤트를 발생시킨다.
	//해당태그에 마우스가 올라갈 시 display block을 시켜 태그를 보여주고
	//마우스가 떠날시 display none으로 태그를 숨긴다.
var tr; 
var td;	
var pw;
var seq;
	//테이블 클릭 이벤트 
	$("#example tr").click(function(){
		
		//현재 클릭한 tr과  td정보를 가져온다 .
		 tr = $(this);
		 td = tr.children();
		 seq = td.eq(0).text();
		if (td.eq(0).text() != "번호") {
			$("#passch").css("display","block");
		}
	});
	
	//내글 비밀번호 확인
	$("#pwcheck").click(function(){
		pw = $("#pass").val();
		//입력한 비밀번호를 이용하여 비동기 통신으로
		//현재 글번호와 비밀번호를 매개변수로 이용하여
		//현재 글의 비밀번호가 맞는지 체크한다.
		$.ajax({
			url:"/qna_pwcheck",
			type:"post",
			data:{
				seq:seq,
				pw:pw
			},
			success:function(data){
				if (data == 1){
					$("#myqna").css("display","block");
					$("#admin_update").css("display","block");
					$("#qnatext").val(td.eq(2).text());
					
				} else{
					alert("비밀번호가 틀렸습니다");
				}
			}
		});
	});
	
	
	//관리자 수정 비밀번호 
	$("#admin_check").click(function(){
		var admin_pw = $("#admin_pw").val();
		
		if (admin_pw == "1111"){
			$("#admin_rediv").css("display","block");
		}
	});
	
	
	//페이징 처리
	var actionForm = $("#actionForm");
	//페이징 버튼 클릭시 
	$(".paginate_button a").on("click",function(e){
		e.preventDefault();
		
		actionForm.find("input[name='pageNum']").val($(this).attr("href"));
		actionForm.submit();
	});
});
function div_OnOff(v,id){
	//라디오 버튼 value 
	if(v=="1"){
		document.getElementById(id).style.display=""; //보여줌
	}else {
		document.getElementbyId(id).style.display="nome"; //숨김
	}
}

</script>

<body>
	<jsp:include page="/resources/include/navigation.jsp" />
	

	 <!--  section01 -->
	<header class="masthead bg-primary text-white text-center">
    <div class="container d-flex align-items-center flex-column">
      
      <h1 class="masthead-heading text-uppercase mb-0" >고객센터</h1> 
      <div id="qnaDiv" align="left">
      	
      	<h1 style = " font-size:20px; margin-top:30px;" align="center" >자주하는 질문</h1>
      		
      		<div style="margin-bottom:300px;">
      		<!-- qna 리스트 출력 -->
      			<table border="1" width=500 id="example">
	      			<tr>
		      			<th>번호</th>
		      			<th>제목</th>
	      			</tr>
	      			<tr>
	      			<c:forEach items="${list}" var="list" varStatus="status">
	      				<tr>
	      				<!-- oracle sequence 생성하면 nextval값은 2가나온다. 때문에  1이없다... -->
	      					<td>${list.seq-1}</td>
	      					<td> 		
	      						<a href="#" id="qnalist" style="color:white; text-decoration:none;">${list.title}</a>	
	      					</td>
	      					<td style="display:none;">${list.qna_content}</td>
	      				</tr>
	      				
	      			</c:forEach>
		      			
	      			</tr>
      			</table>
      			<!-- 페이징 처리 -->
      			<div class="pull-right" style="width:500px; margin-top:10px;">
      				<ul class="pagination" style="width:200px; margin:auto;">
      					<c:if test="${pageMaker.prev}">
      						<li class="paginate_button previous"><a href="${pageMaker.startPage-1}">Previous</a>
      						</li>
      					</c:if>
      					
      					<c:forEach var="num" begin="${pageMaker.startPage}" end="${pageMaker.endPage}">
      						<li class="paginate_button ${pageMaker.cri.pageNum == num ? "active":""} " style="margin-right:2px; border:solid 1px;"><a href="${num}" >${num}</a></li>
      					</c:forEach>
      					
      					<c:if test="${pageMaker.next}">
      						<li class="paginate_button next"><a href="${pageMaker.endPage+1}">Next</a></li>
      					</c:if>
      				</ul>
      			</div>
      			
      			<form id="actionForm" action="/allqnalist.do" method="get">
      			 	<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum}">
      			 	<input type="hidden" name="amount" value="${pageMaker.cri.amount}">
      			</form>
      			
      			
      			<div id="passch" style="display:none;">
	      			<label for="pass">비밀번호</label>
	      			<input type="password" id="pass">
	      			<button type="button" id="pwcheck">확인</button>
      			</div>
      			<div id="myqna" style="margin-top:50px; display:none; ">
	      			<h6>내가 등록한 질문</h6>
	      			<textarea id="qnatext" rows="5" cols="59" ></textarea>
	      			<h6>답변</h6>
	      			<textarea id="qnatext_re" rows="3" cols="59"></textarea>
      			</div>
      			<div id="admin_update" style="display:none;">
	      			<label for="admin_pw">관리자 수정</label>
	      			<input type="password" id="admin_pw">
	      			<button type="button" id="admin_check">확인</button>
	      			
	      			<div style="display:none" id="admin_rediv">
	      				<div>
	      					<textarea id="admin_re" rows="3" cols="59"></textarea>
	      				</div>
	      				<button type="button" id="admin_rebutton">답글등록</button>
	      			</div>
      			</div>
      			
      		</div>		
      	
      </div>
   	
    	
    		</div>
    	
  
  </header>
  </head>
  
  <jsp:include page="/resources/include/footer.jsp" />
  <jsp:include page="/resources/include/copyright.jsp" />
  <jsp:include page="/resources/include/modals.jsp" />	<%-- modal.jsp 끝에 js 파일 있어서 반응형 웹이 됩니다~ 마지막에 꼭 넣으십쏘~ --%>

</body>
</html>