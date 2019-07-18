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
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>


<style>

.paginate_button > a{
color:white;

}
.active > a{
color:black;
}
</style>

  <jsp:include page="/resources/include/banner.jsp"/>



<script>
$(function(){
	//jquery mouseover와 mouseleave를 통해 해당 태그에 마우스 이벤트를 발생시킨다.
	//해당태그에 마우스가 올라갈 시 display block을 시켜 태그를 보여주고
	//마우스가 떠날시 display none으로 태그를 숨긴다.
var tr; 
var td;	
var pw;
var seq;
var clickcount=0;
var seqlist= new Array();
	//테이블 클릭 이벤트 
	$("#example tr").click(function(){
		clickcount++;
		//현재 클릭한 tr과  td정보를 가져온다 .
		 tr = $(this);
		 td = tr.children();
		 seq = td.eq(1).text();
		 seqlist.push(seq);
		 console.log(seq);
		if (td.eq(1).text() != "이름") {
			$("#passch").css("display","block");
			$("#myqna").css("display","none");
			$("#admin_update").css("display","none");
			$("#myqnaButton").css("display","none");

		}else {
			$("#passch").css("display","none");
			$("#myqna").css("display","none");
			$("#admin_update").css("display","none");
			$("#myqnaButton").css("display","none");

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
					$("#qnatext").val(td.eq(5).text());
					$("#qnatext_re").val(td.eq(6).text());
					$("#myqnaButton").css("display","block");
					$("#pass").val("");
					
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
	
	//사용자 질문 수정
	$("#qnamodify").click(function(){
		var content = $("#qnatext").val();
		$.ajax({
			url:"/allqnalist.do/qnamodify.do",
			type:"post",
			data:{
				seq:seq,
				content:content
			},
			success:function(data){
				if (data == 1){
					alert("수정되었습니다");
					window.location.reload();
				} else {
					alert("수정에 실패하였습니다");
				}
			}
			
		});	
	});
	
	//사용자 질문삭제
	$("#qnadel").click(function(){
		$.ajax({
			url:"allqnalist.do/qna_delete",
			data:{
				seq:seq
			},
			success:function(data){
				if (data == 1){
					alert("삭제되었습니다");
					window.location.reload();
				} else{
					alert("삭제에 실패하였습니다");
				}
			}
		});
	});
	
	//관리자 답글 등록 
	$("#admin_rebutton").click(function(){
		var reply = $("#admin_re").val();
		$.ajax({
			url:"/allqnalist.do/adminreply.do",
			type:"post",
			data:{
				seq:seq,
				reply:reply
			},
			success:function(data){
				if (data == 1) {
					alert("답글이 등록되었습니다");
					window.location.reload();
				} else {
					alert("등록에 실패하였습니다");
				}
			}
		});
	});
	
	//관리자질문삭제
	$("#qna_delete").click(function(){
		$.ajax({
			url:"/allqnalist.do/qna_delete",
			type:"post",
			data:{
				seq:seq
			},
			success:function(data){
				if (data == 1){
					alert("삭제되었습니다");
					window.location.reload();
				} else {
					alert("삭제에 실패하였습니다")
				}
			}
		});
	});
	
	//페이징 처리
	var actionForm = $("#actionForm");
	//페이징 버튼 클릭시 
	$(".paginate_button a").on("click",function(e){
		e.preventDefault();
		
		actionForm.find("input[name='pageNum']").val($(this).attr("href"));
		actionForm.submit();
	});
	
	
	var searchForm = $("#searchForm");
	
	$("#searchForm button").on("click",function(e){
		
	 	if (!searchForm.find("option:selected").val()){
			alert("검색 종류를 선택하세요");
			return false;
		}
		if (!searchForm.find("input[name='keyword']").val()){
			alert("키워드를 입력하세요");
			return false;
		} 
		searchForm.find("input[name='pageNum']").val("1");
		
		e.preventDefault();
		
		searchForm.submit();
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

function namechange(name){
	
}

</script>

<body>
	<jsp:include page="/resources/include/navigation.jsp" />
	

	 <!--  section01 -->
	<header class="masthead bg-primary text-white text-center">
    <div class="container d-flex align-items-center flex-column">
      
      <h1 class="masthead-heading text-uppercase mb-0" >문의사항 게시판</h1> 
      <div id="qnaDiv" align="center">
      	
      	<h1 style = " font-size:20px; margin-top:20px;" align="center" ></h1>
      		
      		<div style="margin-bottom:300px;">
      		<!-- qna 리스트 출력 -->
      			<table class="table table-bordered table-dark"  width=500 id="example">
	      			<tr align="center">
		      			<th scope="col" width="100">번호</th>
		      			<th scope="col" width="100">이름</th>
		      			<th scope="col" width="500">제목</th>
	      			</tr>
	      			<tr>
	      			<c:forEach items="${list}" var="list" varStatus="status">
	      				<tr align="center">
	      				<!-- oracle sequence 생성하면 nextval값은 2가나온다. 때문에  1이없다... -->
	      					<td style="color:white;">${(pageMaker.total - status.index) - ((pageMaker.cri.pageNum -1) * pageMaker.cri.amount)}</td>
	      					<td style="display:none;">${list.seq}</td>
	      					<script type="text/javascript">
	      						var name ="${list.name}";
	      						name = name.substring(0,2);
	      						name = name+ "x";
	      						document.write("<td style='color:white;'><a href='#'>"+name+"</a></td>");
	      					</script>
	      					<td> 		
	      						<a href="#" id="qnalist" style="color:white; text-decoration:none;">${list.title}</a>	
	      					</td>
	      					<td style="display:none;">${list.qna_content}</td>
	      					<td style="display:none;">${list.qna_reply}</td>
	      				</tr>
	      				
	      			</c:forEach>
		      			
	      			</tr>
      			</table>
      			
      			<div class="row">
      				<div class="col-lg-12">
      					<form id="searchForm" action="/allqnalist.do" method="get">
      						<select name="type">
      							<option value=""
      							<c:out value="${pageMaker.cri.type == null ?'selected':''}"/>>--</option>
      							<option value="T"
      							<c:out value="${pageMaker.cri.type eq 'T'? 'selected' :''}"/>>제목</option>
      							<option value="N"
      							<c:out value="${pageMaker.cri.type eq 'N'? 'selected' :''}"/>>이름</option>
      						</select>
      						<input type="text" name="keyword" value='<c:out value="${pageMaker.cri.keyword}"/>'/>
      						<input type="hidden" name="pageNum" value='<c:out value="${pageMaker.cri.pageNum}"/>'>
      						<%-- <input type="hidden" name="type" value='<c:out value="${pageMaker.cri.type}"/>'> --%>
      						<input type="hidden" name="amount" value='<c:out value="${pageMaker.cri.amount}"/>'>
      						<button class="btn btn-default">Search</button>
      					</form>
      				</div>
      			</div>
      			<!-- 페이징 처리 -->
      			<div class="pull-right" style="width:500px; margin-top:10px;">
      				<ul class="pagination" style="width:200px; margin:auto;">
      					<c:if test="${pageMaker.prev}">
      						<li class="paginate_button previous" style="margin:auto;"><a href="${pageMaker.startPage-1}">Previous</a>
      						</li>
      					</c:if>
      					
      					<c:forEach var="num" begin="${pageMaker.startPage}" end="${pageMaker.endPage}">
      						<li class="paginate_button ${pageMaker.cri.pageNum == num ? "active":""} " style="margin-right:2px; border:solid 1px; margin:auto;"><a href="${num}" >${num}</a></li>
      					</c:forEach>
      					
      					<c:if test="${pageMaker.next}">
      						<li class="paginate_button next" style="margin:auto;"><a href="${pageMaker.endPage+1}">Next</a></li>
      					</c:if>
      				</ul>
      			</div>
      			
      			<form id="actionForm" action="/allqnalist.do" method="get">
      			 	<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum}">
      			 	<input type="hidden" name="amount" value="${pageMaker.cri.amount}">
      			</form>
      			
      			
      			<div id="passch" style="display:none; margin-top:10px; width:500px;">
      				<div style="width:330px; margin:auto;">
		      			<label for="pass">비밀번호</label>
		      			<input type="password" id="pass" >
		      			<button type="button" class="btn btn-secondary" id="pwcheck" style="height:30px; padding-bottom:30px;">확인</button>
      				</div>
      			</div>
      			<div id="myqna" style="margin-top:30px; display:none; ">
	      			<h6>내가 등록한 질문</h6>
	      			<textarea id="qnatext" rows="5" cols="59" ></textarea>
	      			<h6>답변</h6>
	      			<textarea id="qnatext_re" rows="3" cols="59" readonly style="background-color:gray;"></textarea>
      			</div>
      			<div id="myqnaButton" style="display:none; margin-top:5px; margin-bottom:5px;">
      				<button type="button"  class="btn btn-warning" id="qnamodify">질문수정</button>
      				<button type="button" class="btn btn-danger" id="qnadel">질문삭제</button>
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
	      				<button type="button" id="qna_delete">질문삭제</button>
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