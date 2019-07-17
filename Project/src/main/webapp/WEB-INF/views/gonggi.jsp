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
#content {  
  position:absolute;
  height:600px;   /* 퀵메뉴, 배너 이미지의 높이 */
  width:170px;    /* 퀵메뉴, 배너 이미지의 너비*/
  margin:0px 0px 0px 625px;   /* 가장 오른쪽의 수치가 화면 가운데에서 얼마만큼 오른쪽으로 레이어를 붙일 것인지 설정  */ 
  top: 110px;  /* 배너 상단에서 얼마나 떨어뜨릴지 설정*/
  left: 50%;     /* 레이어의 시작점이 왼쪽으로 부터 50% 지정 */
  text-align: left;
  padding: 0px;
}

.names{
	width: 100%; height: 100%
}

.contacts{
	width: 80%; height: 100%; margin-top:5px;
}

a#topBtn { position: fixed; /* 포지션 고정 */ 
right: 2%; /* 오른쪽에서 2% - %도 할수 있음*/ 
bottom: 5px; /* 밑에서 5px */ 
display: none; /* 보여지지 없음 - 기본적으로 안보여지게 */ 
z-index: 9999; /* 포지션을 먼저 지정후 z-좌표(레이어) : 9999입니다. */ 
width:75px;
height:100px;}


</style> 
 
<script type='text/javascript' src='http://ajax.googleapis.com/ajax/libs/jquery/1.3.2/jquery.min.js?ver=1.3.2'></script>  
<script type="text/javascript">
        $(function() {
            var offset = $("#content").offset();
            var topPadding = 100;
            $(window).scroll(function() {
    
                if ($(window).scrollTop() > offset.top) {
                    $("#content").stop().animate({
                        marginTop: $(window).scrollTop() - offset.top + topPadding
                    }, 600);
                } else {
                    $("#content").stop().animate({
                        marginTop: 50
                    });
                };
             });
        });
</script>
</head>


<script>
$(function() {
	   // 보이기 | 숨기기
	   $(window).scroll(function() {
	      if ($(this).scrollTop() > 130) { //250 넘으면 버튼이 보여짐니다.
	            $('#topBtn').fadeIn();
	            } else {
	            $('#topBtn').fadeOut();
	      }
	   });
	   // 버튼 클릭시
	   $("#topBtn").click(function() {   
	   $('html, body').animate({
	     scrollTop : 0    // 0 까지 animation 이동합니다.
	    }, 400);          // 속도 400
	    return false;
	    });
	  });
</script>


<body> 
<div id="content">
	<center><img src="resources/img/banner/sangwon.png" class="names"></center>
	<!-- <center><font class="names">SANGWON BANG</font></center> --> 
	<center><a href="javascript:void(0)" target="_blank"><img src="resources/img/banner/sangwon_phone.png" class="contacts"/></a></center>
	<center><a href="https://www.instagram.com/vang_sang/" target="_blank"><img  src="resources/img/banner/sangwon_insta.png" class="contacts" /></a></center>
	<br>  

	<center><img src="resources/img/banner/jinyeop.png"  class="names" ></center>
	<center><a href="javascript:void(0)" target="_blank"><img  src="resources/img/banner/jinyeop_phone.png" class="contacts" /></a></center>
	<center><a href="https://www.instagram.com/ohhh_jinyeop/" target="_blank"><img src="resources/img/banner/jinyeop_insta.png" class="contacts"/></a></center>
	<center><a href="javascript:void(0)" target="_blank"><img  src="resources/img/banner/jinyeop_kakao.png" class="contacts"/></a></center>
	<br> 
	
	<center><img src="resources/img/banner/chihyeock.png" class="names"  ></center>
	<center><a href="javascript:void(0)" target="_blank"><img src="resources/img/banner/chihyeock_phone.png" class="contacts" /></a></center>
	<br>	
	 
	  <a id="topBtn"><img src="resources/img/portfolio/up.png" width="10" height="10" alt="upButton" class="names">TOP</a>
	 
</div>
</body>

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
	$("#gonggiwrite").click(function(){
		$("#passch").css("display","block");
	});
	
	$("#passch").click(function(){
		var pass = $("#pass").val();
		if (pass == "1111"){
			window.location.href="/gonggiwrite.do"
		}
	});
});

</script>

<body>
	<jsp:include page="/resources/include/navigation.jsp" />
	

	 <!--  section01 -->
	<header class="masthead bg-primary text-white text-center">
    <div class="container d-flex align-items-center flex-column">
      
      <h1 class="masthead-heading text-uppercase mb-0" >공지사항</h1> 
      <div id="qnaDiv" align="center">
      	
      	<h1 style = " font-size:20px; margin-top:20px;" align="center" ></h1>
      		
      		<div style="margin-bottom:300px;">
      		<!-- qna 리스트 출력 -->
      			<table class="table table-bordered table-dark"  width=500 id="example">
	      			<tr align="center">
		      			<th scope="col" width="100">번호</th>
		      			<th scope="col" width="300">제목</th>
		      			<th scope="col" width="300">내용</th>
	      			</tr>
	      			<tr>
	      			<c:forEach items="${list}" var="list" varStatus="status">
	      				<tr align="center">
	      				<!-- oracle sequence 생성하면 nextval값은 2가나온다. 때문에  1이없다... -->
	      					<%-- <td style="color:white;">${(pageMaker.total - status.index) - ((pageMaker.cri.pageNum -1) * pageMaker.cri.amount)}</td> --%>
	      					 <td>${list.seq}</td> 
	      					<td> 		
	      						<a href="/gonggi.do/read.do/${list.seq}" style="color:white; text-decoration:none;">${list.title}</a>	
	      					</td>
	      					<td><a href="/gonggi.do/read.do/${list.seq}">${list.content}</a></td>
	      				</tr>
	      				
	      			</c:forEach>
		      			
	      			</tr>
      			</table>
      			
      			<div class="row">
      				<div class="col-lg-12">
      				<div>
      					<form id="searchForm" action="/gonggi.do" method="get">
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
      						
      						<button class="button">Search</button>
      						</div>      						
      					</form>
      					  <button type="button" id="gonggiwrite" style="float:right;margin-top:-30px;">글쓰기</button>
      		
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
      			
      			<form id="actionForm" action="/gonggi.do" method="get">
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