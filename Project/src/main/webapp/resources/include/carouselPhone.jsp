<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<title>Bootstrap 4 Carousel</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
</head>

<script type='text/javascript' src='http://ajax.googleapis.com/ajax/libs/jquery/1.3.2/jquery.min.js?ver=1.3.2'></script>     
<script type="text/javascript">
	$(function() { 
	    var filter = "win16|win32|win64|macintel|mac|"; // PC일 경우 가능한 값

		 if( navigator.platform){
			 if( filter.indexOf(navigator.platform.toLowerCase())<0 ){	// 모바일 접속
			 
			 } else {// pc 접속
			$("#carouselHP").hide();
		 }
		}
	});
</script>	 


<body>
<div class="bs-example" id="carouselHP">
    <div id="myCarousel" class="carousel slide" data-ride="carousel">
        <!-- Carousel indicators -->
        <ol class="carousel-indicators">
            <li data-target="#myCarousel" data-slide-to="0" class="active"></li>
            <li data-target="#myCarousel" data-slide-to="1"></li>
            <li data-target="#myCarousel" data-slide-to="2"></li>
        </ol>
        
        
        <!-- Wrapper for carousel items -->
        <div class="carousel-inner">
            <div class="carousel-item active">
             <img class="d-block img-fluid" src="resources/img/background/white.png" alt="First slide"  style="width:2000px; height:200px">
               <div class="carousel-caption">
               <center><font class="names" style="color:black">SANGWON BANG</font></center>
        <center><a href="javascript:void(0)" target="_blank" class="fonts">
			<img src="resources/img/banner/phone.png" class="contacts"/>&nbsp;&nbsp;010 6362 1073
		</a></center>

	
		  <center><a href="https://www.instagram.com/vang_sang/" target="_blank" class="fonts">
			<img  src="resources/img/banner/instagram.png" class="contacts" />&nbsp;&nbsp;vang_sang
		</a></center>
	

		  <center><a href="javascript:void(0)" target="_blank" class="fonts">
			<img  src="resources/img/banner/kakaotalk.png" class="contacts"/>&nbsp;&nbsp;wony1073
		</a></center>
            </div>

</div>

            
            
           <div class="carousel-item">
     			 <img class="d-block img-fluid" src="resources/img/background/white.png" alt="Second slide"  style="width:2000px; height:200px">
  			<div class="carousel-caption">       
		<center><font class="names" style="color:black">JINYEOP OH</font></center>
		<a href="javascript:void(0)" target="_blank" class="fonts">
			<img src="resources/img/banner/phone.png" class="contacts"/>&nbsp;&nbsp;010 3119 3464
		</a></center>
		
		  <center><a href="https://www.instagram.com/ohhh_jinyeop/" target="_blank" class="fonts">
			<img  src="resources/img/banner/instagram.png" class="contacts" />&nbsp;&nbsp;ohhh_jinyeop
		</a></center>
		
		  <center><a href="javascript:void(0)" target="_blank" class="fonts">
			<img  src="resources/img/banner/kakaotalk.png" class="contacts"/>&nbsp;&nbsp;ojy96
		</a> </center> 
		          </div>
          </div>  
    
    
    
            
            <div class="carousel-item">
     			 <img class="d-block img-fluid" src="resources/img/background/white.png" alt="Third slide"  style="width:2000px; height:200px">
  			<div class="carousel-caption">
 	       	<center><font class="names" style="color:black">CHIHYEOCK YOO</font></center>
		  <center><a href="javascript:void(0)" target="_blank" class="fonts">
			<img src="resources/img/banner/phone.png" class="contacts"/>&nbsp;&nbsp;010 3553 1079
		</a> </center>
        		</div>           
         	</div>
        </div>
        
        
        <!-- Carousel controls -->
        <a class="carousel-control-prev" href="#myCarousel" data-slide="prev">
            <span class="carousel-control-prev-icon"></span>
        </a>
        <a class="carousel-control-next" href="#myCarousel" data-slide="next">
            <span class="carousel-control-next-icon"></span>
        </a>
</div>
</div>



</body>
</html>                                                        