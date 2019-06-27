<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
<!-- Footer -->
  <footer class="footer text-center">
    <div class="container">
      <div class="row">

        <!-- Footer Location -->
        <div class="col-lg-4 mb-5 mb-lg-0">
          <h4 class="text-uppercase mb-4">Location</h4>
          <p class="lead mb-0">서울특별시 강남구 강남대로 374 
            <br>형제빌딩 3층 301호
          	<br>[오와열 프로젝트 팀]</p>
        </div>

        <!-- Footer Military Icons -->
        <div class="col-lg-4 mb-5 mb-lg-0">
          <h4 class="text-uppercase mb-4">관련기관 / 서비스 바로가기</h4>
          <a class="btn btn-outline-light btn-social mx-1" href="http://http://www.mnd.go.kr/mbshome/mbs/mnd/"> <!-- 국방부 사이트 -->
            <!-- <i class="fab fa-fw fa-facebook-f"></i> -->
            <img src="<c:url value='/resources/img/logos/mnd.png'/>" title="국방부로 이동" style="width: 33px;">
          </a>
          
             <a class="btn btn-outline-light btn-social mx-1" href="http://www.army.mil.kr"> <!-- 육군 사이트 -->
            <!-- <i class="fab fa-fw fa-instagram"></i> -->
            <img src="<c:url value='/resources/img/logos/rockArmy.png'/>" title="육군 사이트로 이동" style="width: 33px;">
          </a>
          
          <a class="btn btn-outline-light btn-social mx-1" href="http://www.navy.mil.kr">	<!-- 해군 사이트 -->
            <!--<i class="fab fa-fw fa-twitter"></i>-->
            <img src="<c:url value='/resources/img/logos/navy.png'/>" title="해군 사이트로 이동" style="width: 33px;">
          </a>
          
          <a class="btn btn-outline-light btn-social mx-1" href="http://http://mnd.go.kr">  <!-- 공군 사이트 -->
           <!--<i class="fab fa-fw fa-instagram"></i>-->
          	<img src="<c:url value='/resources/img/logos/airforce.png'/>" title="공군 사이트로 이동" style="width: 38px;">
          </a>
          
          <a class="btn btn-outline-light btn-social mx-1" href="http://www.rokmc.mil.kr"> <!-- 해병대 사이트 -->
            <!--<i class="fab fa-fw fa-youtube"></i>-->
            <img src="<c:url value='/resources/img/logos/marine.png'/>" title="해병대 사이트로 이동" style="width: 33px;">
          </a>
          
          <a class="btn btn-outline-light btn-social mx-1" href="https://www.mma.go.kr"> <!-- 병무청 사이트 -->
           <!--<i class="fab fa-fw fa-facebook-f"></i>-->
           <img src="<c:url value='/resources/img/logos/mma.png'/>" title="병무청 사이트로 이동" style="width: 23px;">
          </a><br>
       
          
          <br><br>
          <p class="lead mb-0">우리는 대한민국 청춘들을 응원합니다!</p>
          
			<a class="navbar-brand js-scroll-trigger" href="main.do">
				<img id="logo" src="<c:url value='/resources/img/logos/510_2.png'/>">
			</a> 
          
        </div>

        <!-- Footer About Text -->
        <div class="col-lg-4">
          <h4 class="text-uppercase mb-4">문의사항</h4>
          <p class="lead mb-0">E-mail : wony1073@hanmail.net</p>
          <p class="lead mb-1">H.P : 010-0000-0000</p>
          <p class="lead mb-2">FAX : 02-0000-0000</p>
          <p class="lead mb-3">업무시간 : AM 10:00 ~ PM 7:00</p>
        </div>

      </div>
    </div>
  </footer>