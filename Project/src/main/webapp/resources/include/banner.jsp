<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>



<script type='text/javascript' src='http://ajax.googleapis.com/ajax/libs/jquery/1.3.2/jquery.min.js?ver=1.3.2'></script>  
<script type="text/javascript">
	$(function() { 
	    var filter = "win16|win32|win64|macintel|mac|"; // PC일 경우 가능한 값

		 if( navigator.platform){
			 if( filter.indexOf(navigator.platform.toLowerCase())<0 ){	// 모바일 접속
				 $("#content").hide();
			 } else {// pc 접속
			} 
		}  

	    
	    var offset = $("#content").offset(); 
	    var topPadding = 100
	    $(window).scroll(function() {
	
	        if ($(window).scrollTop() > offset.top) {
	            $("#content").stop().animate({ 
	                marginTop: $(window).scrollTop() - offset.top + topPadding 
	            }, 600);
	        } else {
	            $("#content").stop().animate({
	                marginTop: -20
	            });
	        };
     	});
	    
	    
   	});
	    
</script>
 

<div id="content">
	<center><font class="names">SANGWON BANG</font></center> 
	<center>
		<a href="javascript:void(0)" target="_blank" class="fonts">
			<img src="resources/img/banner/phone.png" class="contacts"/>&nbsp;&nbsp;010 6362 1073
		</a>
	</center>
	
	<center>
		<a href="https://www.instagram.com/vang_sang/" target="_blank" class="fonts">
			<img  src="resources/img/banner/instagram.png" class="contacts" />&nbsp;&nbsp;vang_sang
		</a>
	</center>
	
	<center>
		<a href="javascript:void(0)" target="_blank" class="fonts">
			<img  src="resources/img/banner/kakaotalk.png" class="contacts"/>&nbsp;&nbsp;wony1073
		</a>
		</center>
	<br>  


	<center><font class="names">JINYEOP OH</font></center>
	<center>
		<a href="javascript:void(0)" target="_blank" class="fonts">
			<img src="resources/img/banner/phone.png" class="contacts"/>&nbsp;&nbsp;010 6362 1073
		</a>
	</center>
	<center>
		<a href="https://www.instagram.com/vang_sang/" target="_blank" class="fonts">
			<img  src="resources/img/banner/instagram.png" class="contacts" />&nbsp;&nbsp;ohhh_jinyeop
		</a>
	</center>
	<center>
		<a href="javascript:void(0)" target="_blank" class="fonts">
			<img  src="resources/img/banner/kakaotalk.png" class="contacts"/>&nbsp;&nbsp;ojy96
		</a>
	</center>
	<br> 
	
	
	
	<center><font class="names">CHIHYEOCK YOO</font></center>
	<center>
		<a href="javascript:void(0)" target="_blank" class="fonts">
			<img src="resources/img/banner/phone.png" class="contacts"/>&nbsp;&nbsp;010 3553 1079
		</a> 
	</center>
	<br>	
	 
</div>


<style>
	a#topBtn { 
		position: fixed; /* 포지션 고정 */ 
		right: 2%; /* 오른쪽에서 2% - %도 할수 있음*/ 
		bottom: 5px; /* 밑에서 5px */ 
		display: none; /* 보여지지 없음 - 기본적으로 안보여지게 */ 
		z-index: 9999; /* 포지션을 먼저 지정후 z-좌표(레이어) : 9999입니다. */ 
		width:75px;
		height:100px;
	}
</style>

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





 <a id="topBtn"><img src="<c:url value='/resources/img/portfolio/up.png'/>" width="10" height="10" alt="upButton" class="names">TOP</a>












