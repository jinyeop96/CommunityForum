<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<style type="text/css">	
	/* banner */
	.banner {position: relative; width: 200px; height: 300px; top: 50px;  margin:0 auto; padding:0; overflow: hidden;}
	.banner ul {position: absolute; margin: 0px; padding:0; list-style: none; }
	.banner ul li {float: left; width: 580px; height: 300px; margin:0; padding:0;}

</style>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>


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
 

<script language="JavaScript">

	$(document).ready(function() {
		var $banner = $(".banner").find("ul");

		var $bannerWidth = $banner.children().outerWidth();//이미지의 폭
		var $bannerHeight = $banner.children().outerHeight(); // 높이
		var $length = $banner.children().length;//이미지의 갯수
		var rollingId;

		//정해진 초마다 함수 실행
		rollingId = setInterval(function() { rollingStart(); }, 2400);//다음 이미지로 롤링 애니메이션 할 시간차
    
		function rollingStart() {
			$banner.css("width", $bannerWidth * $length + "px");
			$banner.css("height", $bannerHeight + "px");
			//alert(bannerHeight);
			//배너의 좌측 위치를 옮겨 준다.
			$banner.animate({left: - $bannerWidth + "px"}, 1500, function() { //숫자는 롤링 진행되는 시간이다.
				//첫번째 이미지를 마지막 끝에 복사(이동이 아니라 복사)해서 추가한다.
				$(this).append("<li>" + $(this).find("li:first").html() + "</li>");
				//뒤로 복사된 첫번재 이미지는 필요 없으니 삭제한다.
				$(this).find("li:first").remove();
				//다음 움직임을 위해서 배너 좌측의 위치값을 초기화 한다.
				$(this).css("left", 0);
				//이 과정을 반복하면서 계속 롤링하는 배너를 만들 수 있다.
			});
		}
	}); 

</script>


     			 <div class="signature overflowW">
     				 	<img src="" alt="">
     			 </div>
     			
     		</div>
     		
     	<div class="banner">
			<ul>
				<li><img src="resources/img/logos/510_2.png" width="370px" height="250px"></li>
				<li><img src="resources/img/logos/510logo_2.png" width="370px" height="250px"></li>
				<li><img src="resources/img/logos/OWY-1.png" width="370px" height="250px"></li>		
				<li><img src="resources/img/logos/OWY-2.png" width="370px" height="250px"></li>			
				<li><img src="resources/img/logos/OWY-3.png" width="370px" height="250px"></li>			
				<li><img src="resources/img/logos/OWY-4.png" width="370px" height="250px"></li>				
			</ul>
		</div>
		
	</div>