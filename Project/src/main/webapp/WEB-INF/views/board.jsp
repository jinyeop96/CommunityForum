<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판</title>
<script src="<c:url value='/resources/jquery-3.4.1.js' /> "></script>
	<style type="text/css">
		.floppyDisk{
			width: 18px;
		}
	</style>
</head>

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

<body>
		<jsp:include page="/resources/include/navigation.jsp" />
	
		 <!--  section01 -->
		<header class="masthead bg-primary text-white text-center">
	    <div class="container d-flex align-items-center flex-column">
	    
	      	<c:if test="${board_type == 'entire' }">
	  		  	<h3 class="masthead-heading text-uppercase mb-0">전체 게시판</h3>
	      	</c:if>
	      	<c:if test="${board_type == 'free' }">
	  		  	<h3 class="masthead-heading text-uppercase mb-0">자유 게시판</h3>
	      	</c:if>
	      	<c:if test="${board_type == 'question' }">
	  		  	<h3 class="masthead-heading text-uppercase mb-0">질문 게시판</h3>
	      	</c:if>
	      	<c:if test="${board_type == 'review' }">
	  		  	<h3 class="masthead-heading text-uppercase mb-0">후기 게시판</h3>
	      	</c:if>
	      	<c:if test="${board_type == 'findPeople'}">
	      		<h3 class="masthead-heading text-uppercase mb-0">사람 찾습니다!</h3>
	      	</c:if>
	    	<br><br>
	    	
	      	<%--------------------------------------------------- --%>
	      	<div class="board" align="center"> 
	      		<%-- 검색내용 상단에 표시 --%>
	      			<c:if test="${!empty searchData }">
			      	<c:if test="${searchType == 'all' }">
			  		  	<b>전체</b>
			      	</c:if>
			      	<c:if test="${searchType == 'title' }">
			  		  	<b>제목</b>
			      	</c:if>
			      	<c:if test="${searchType == 'content' }">
			  		  	<b>내용</b>
			      	</c:if>
			      	<c:if test="${searchType == 'nickname' }">
			  		  	<b>글쓴이</b>
			      	</c:if>

			      	<b> -> ${searchData } (으)로 검색하였습니다.</b> 
	      		</c:if>
	      	
	      		<form action="boardSearch.do" method="get">
	     			<input type="hidden" name="pageParam" value="1">
	     			<input type="hidden" name="board_type" value="${board_type }">
	      			 
	      			<table class="board font-black " id="entireList"> 
			      		<%------------------가져온 전체 게시물 있다면-------------- --%>
			      		<c:if test="${!empty list }">
			      			<c:if test="${!empty nickname }">
					      		<tr>
					      			<td colspan="7" align="right">
					      				<input class="buttons" type="button" value="글쓰기" onclick="location.href='boardWrite.do?board_type=${board_type}'">
					      			</td>
					      		</tr>
					      		<br><br>
			      			</c:if>
			      		 
			      			<%-- 가져온 게시물 뿌려주기 --%>
				      		<c:forEach items="${list }" var="dto">
					      		<tr>
					      			<td colspan="7" ><a href="content.do?board_no=${dto.getBoard_no() }&board_type=${board_type}&pageParam=${page.getPage()}" style="color: #000">
					      				<h6>
					      					${dto.getBoard_title() } [${dto.getBoard_reply() }]
					      					<c:if test="${dto.getBoard_hasFile() == 1 }"><img class="floppyDisk" src="<c:url value='/resources/img/logos/floppyDisk.png'/>"></c:if>
					      				</h6>
					      			</a></td> 
					      		</tr>
					      		<tr>
					      			<td><b>> ${dto.getBoard_nickname() }</b></td>
					      			<td>${dto.getBoard_date().substring(0, 10) }</td>
					      			<td class="text-center">추천 ${dto.getBoard_like() }</td>
					      			<td class="text-center">조회 ${dto.getBoard_view() }</td>
					      		</tr>
					      		
					      		<tr>
					      			<td colspan="7">
					      				<hr style="border-top: 1px solid white;">
					      			</td>
					      		</tr>
					      		
				      		</c:forEach>
				      	
				      		
				      		<%-- 하단부 페이징 및 검색창 --%>
				      		
				      		
					      	<tr>
				      			<td colspan="6" align="center">
				      		<%------------------------ 일반 게시물이라면 ( 검색하지 않은 상태 ) ----------------------------%>
				      			<c:if test="${empty searchData }">
				      				<%-----------------Left Arrows----------- --%>
				      				<c:if test="${ page.getPage() > page.getBlocks() }">
										<a href="board.do?pageParam=1&board_type=${board_type }&boardSearch=no" class="blocks">[◀◀]</a>
										<a href="board.do?pageParam=${page.getBlockStart() - 1}&board_type=${board_type }&boardSearch=no" class="blocks">[◀]</a>
									</c:if>
								 
				      				
				      				<%------------------ block 번호 ------------ --%>
						      		<c:forEach begin="${page.getBlockStart() }" end="${page.getBlockEnd() }" step="1" var="i">
						      			<!-- 현재페이지 -->
						      			<c:if test="${page.getPage() == i }">
						      				<b>${i }</b> 
						      			</c:if>
						      
						      			<!--  no 현재페이지 -->
						      			<c:if test="${page.getPage() != i }">
						      				<b><a href="board.do?pageParam=${i }&board_type=${board_type }&boardSearch=no" class="blocks">${i }</a></b>
						      			</c:if>
						      			&nbsp;&nbsp;&nbsp;
						      		</c:forEach>

						      		
						      		<%--------------------Right Arrows----------------- --%>
						      		<c:if test="${page.getBlockEnd() < page.getTotalPages() }">
										<a href="board.do?pageParam=${page.getBlockEnd() + 1}&board_type=${board_type }&boardSearch=no" class="blocks">[▶]</a>
										<a href="board.do?pageParam=${page.getTotalPages() }&board_type=${board_type }&boardSearch=no" class="blocks">[▶▶] </a>
									</c:if>
				      			</c:if>
							
							
							
							<%------------------------ 검색한 상태라면 ----------------------------%>
									
								<c:if test="${!empty searchData }">
									<c:if test="${ page.getPage() > page.getBlocks() }">
										<a href="boardSearch.do?pageParam=1&board_type=${board_type }&searchType=${searchType}&searchData=${searchData}" class="blocks">[◀◀]</a>
										<a href="boardSearch.do?pageParam=${page.getBlockStart() - 1}&board_type=${board_type }&searchType=${searchType}&searchData=${searchData}" class="blocks">[◀]</a>
									</c:if>
								 
				      				
				      				<%------------------ block 번호 ------------ --%>
						      		<c:forEach begin="${page.getBlockStart() }" end="${page.getBlockEnd() }" step="1" var="i">
						      			<c:if test="${page.getPage() == i }">
						      				<b>${i }</b> 
						      			</c:if>
						      
						      			<c:if test="${page.getPage() != i }">
						      				<b><a href="boardSearch.do?pageParam=${i }&board_type=${board_type }&searchType=${searchType}&searchData=${searchData}" class="blocks">${i }</a></b>
						      			</c:if>
						      			&nbsp;&nbsp;&nbsp;
						      		</c:forEach>

						      		
						      		<%--------------------Right Arrows----------------- --%>
						      		<c:if test="${page.getBlockEnd() < page.getTotalPages() }">
										<a href="boardSearch.do?pageParam=${page.getBlockEnd() + 1}&board_type=${board_type }&searchType=${searchType}&searchData=${searchData}" class="blocks">[▶]</a>
										<a href="boardSearch.do?pageParam=${page.getTotalPages() }&board_type=${board_type }&searchType=${searchType}&searchData=${searchData}" class="blocks">[▶▶] </a>
									</c:if>
								</c:if>	
					      		</td>
				      		</tr>
			      		</c:if>
			      		
			      		
			      		<%---------전체 리스트 없다면------------ --%>
			      		<c:if test="${empty list }">
			      			<c:if test="${!empty nickname }">
					      		<tr>
					      			<td colspan="7" align="right">
					      				<input class="buttons" type="button" value="글쓰기" onclick="location.href='boardWrite.do?board_type=${board_type}'">
					      			</td>
					      		</tr>
					      		<br><br>
			      			</c:if>
			      			
			      			<tr>
			     				<th colspan="7" align="center">
				      				<c:if test="${empty searchData }">
					     				<h3>글이 하나도 없습니다! 새로운 글을 써주세요</h3>
				      				</c:if>
				      				
				      				<c:if test="${!empty searchData }">
					     				<h3>검색 게시물이 없습니다!</h3>
				      				</c:if>
			     				</th>
			     			</tr>
			      		</c:if>

						
						<%--검색창 --%>
		      			<tr>
		      				<td colspan="6" align="center">
				      			<select name="searchType" class="radius-10px">
				      				<option value="all">전체</option>
				      				<option value="title">제목</option>
				      				<option value="content">내용</option>
				      				<option value="nickname">글쓴이</option>
				      			</select>
				      			<input name="searchData" class="radius-10px">
				      			<input type="submit" value="검색"  class="searchBtn"> 
				      		</td>
		      			</tr>
			        </table>
				</form>
	     	 </div>
	   	 </div>
	  </header>
	  
	  
	  <jsp:include page="/resources/include/footer.jsp" />
	  <jsp:include page="/resources/include/copyright.jsp" />
	  <jsp:include page="/resources/include/modals.jsp" />	<%-- modal.jsp 끝에 js 파일 있어서 반응형 웹이 됩니다~ 마지막에 꼭 넣으십쏘~ --%>

</body>
</html>