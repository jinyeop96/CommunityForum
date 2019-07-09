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