<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">

<!-- Custom fonts for this theme -->
<link href="<c:url value="/resources/vendor/fontawesome-free/css/all.min.css" />" rel="stylesheet" type="text/css">
<link href="https://fonts.googleapis.com/css?family=Montserrat:400,700" rel="stylesheet" type="text/css">
<link href="https://fonts.googleapis.com/css?family=Lato:400,700,400italic,700italic" rel="stylesheet" type="text/css">

<!-- Theme CSS -->
<!-- <link href="/resources/css/freelancer.min.css" rel="stylesheet" type="text/css"> -->
<link href="<c:url value="/resources/css/freelancer.min.css" />" rel="stylesheet" type="text/css">

<!--  CSS by myself -->
<!-- <link href="/resources/css/myself1.css" rel="stylesheet" type="text/css"> -->
<link href="<c:url value="/resources/css/myself1.css" />" rel="stylesheet" type="text/css">
<script src="<c:url value='/resources/jquery-3.4.1.js' /> "></script>
	<style>
		@media(max-width: 500px){
			#logo{
				width: 85px;
			}
		}

		@media(min-width: 500px){
			#logo{
				width: 120px;
			}
		} 
	</style>

</head>
<body id="page-top">
	<!-- Navigation -->
	<nav
		class="navbar navbar-expand-lg bg-secondary text-uppercase fixed-top"
		id="mainNav">
		<div class="container">
			<a class="navbar-brand js-scroll-trigger" href="main.do">
				<img id="logo" src="<c:url value='/resources/img/logos/510_2.png'/>">
			</a> 
			<button
				class="navbar-toggler navbar-toggler-right text-uppercase font-weight-bold bg-primary text-white rounded"
				type="button" data-toggle="collapse" data-target="#navbarResponsive"
				aria-controls="navbarResponsive" aria-expanded="false"
				aria-label="Toggle navigation">
				Menu <i class="fas fa-bars"></i>
			</button>

			<div class="collapse navbar-collapse " id="navbarResponsive">
				<ul class="navbar-nav ml-auto menu-bar">
				
				<li class="nav-item mx-0 mx-lg-1">
					<a class="nav-link py-3 px-0 px-lg-3 rounded js-scroll-trigger">팀 소개</a>
						<ul>
							<li><a class="nav-link py-3 px-0 px-lg-3 rounded js-scroll-trigger" href="OwyMember.do">팀원구성</a></li>
							<li><a class="nav-link py-3 px-0 px-lg-3 rounded js-scroll-trigger" href="plan.do">기획의도</a></li>
							<li><a class="nav-link py-3 px-0 px-lg-3 rounded js-scroll-trigger" href="future.do">프로젝트의 미래</a></li>
						</ul>
				</li>
				
				
				<li class="nav-item mx-0 mx-lg-1">
					<a class="nav-link py-3 px-0 px-lg-3 rounded js-scroll-trigger">게시판</a>
						<ul class="board_bg">
							<li><a class="nav-link py-3 px-0 px-lg-3 rounded js-scroll-trigger" href="board.do?pageParam=1&board_type=entire&boardSearch=no">전체게시판</a></li>
							<li><a class="nav-link py-3 px-0 px-lg-3 rounded js-scroll-trigger" href="board.do?pageParam=1&board_type=free&boardSearch=no">자유게시판</a></li>
							<li><a class="nav-link py-3 px-0 px-lg-3 rounded js-scroll-trigger" href="board.do?pageParam=1&board_type=review&boardSearch=no">후기게시판</a></li>
							<li><a class="nav-link py-3 px-0 px-lg-3 rounded js-scroll-trigger" href="board.do?pageParam=1&board_type=question&boardSearch=no">질문게시판</a></li>
							<li><a class="nav-link py-3 px-0 px-lg-3 rounded js-scroll-trigger" href="board.do?pageParam=1&board_type=findPeople&boardSearch=no">사람찾습니다!</a></li>							
						</ul>
				</li>
				
				<li class="nav-item mx-0 mx-lg-1">
					<a class="nav-link py-3 px-0 px-lg-3 rounded js-scroll-trigger">Browse</a>
						<ul>
							<li><a class="nav-link py-3 px-0 px-lg-3 rounded js-scroll-trigger" href="#hotel">Hotel</a></li>
							<li><a class="nav-link py-3 px-0 px-lg-3 rounded js-scroll-trigger" href="#restaurant">Restaurant</a></li>
							<li><a class="nav-link py-3 px-0 px-lg-3 rounded js-scroll-trigger" href="#transport">Transport</a></li>
							<li><a class="nav-link py-3 px-0 px-lg-3 rounded js-scroll-trigger" href="#address">ADDRESS</a></li>
						</ul>
				</li>
					
			 	<li class="nav-item mx-0 mx-lg-1">
       				<a class="nav-link py-3 px-0 px-lg-3 rounded js-scroll-trigger" >Q&A</a>
       					<ul>
       						<li><a class="nav-link py-3 px-0 px-lg-3 rounded js-scroll-trigger" href="<%=request.getContextPath()%>/allqna.do">문의사항</a>
       						<li><a class="nav-link py-3 px-0 px-lg-3 rounded js-scroll-trigger" href="">공지사항</a></li>
       						<li><a class="nav-link py-3 px-0 px-lg-3 rounded js-scroll-trigger" href="">업데이트</a></li>
       					</ul>
      			</li>
						
				
				<li class="nav-item mx-0 mx-lg-1">
					<a class="nav-link py-3 px-0 px-lg-3 rounded js-scroll-trigger" >O.W.Y contents</a>
					<ul>
						<li><a class="nav-link py-3 px-0 px-lg-3 rounded js-scroll-trigger" href="contents.do">Logo</a></li>
					</ul>
				</li>
					
			<c:if test="${empty nickname }">
				<li class="nav-item mx-0 mx-lg-1">
         			<a class="nav-link py-3 px-0 px-lg-3 rounded js-scroll-trigger navbar-login" href="login.do">Login</a>
       			</li>

				<li class="nav-item mx-0 mx-lg-1">
      				<a class="nav-link py-3 px-0 px-lg-3 rounded js-scroll-trigger navbar-login" href="join.do">Join</a>
       			</li>
			</c:if>		
			
			<c:if test="${!empty nickname }">
				<li class="nav-item mx-0 mx-lg-1">
       				<a class="nav-link py-3 px-0 px-lg-3 rounded js-scroll-trigger navbar-login" href="logout.do">Logout</a>
       			</li>
	
				<li class="nav-item mx-0 mx-lg-1">
       				<a class="nav-link py-3 px-0 px-lg-3 rounded js-scroll-trigger navbar-login" href="#">${nickname }</a>
       			</li>
			</c:if>
						
				
			</div>
		</div>
		
		<div class="navbar-log-regi">
			<!-- 메뉴바 우측상단배치 -->
			<c:if test="${empty nickname }">
				<a class="navbar-top-right" href="login.do">Login</a> 
				<a class="navbar-top-right" href="join.do">Join</a>
			</c:if>
			
			<c:if test="${!empty nickname }">
				<a class="navbar-top-right-session" href="#">${nickname }</a> 
				<a class="navbar-top-right" href="logout.do">Logout</a>
			</c:if>
		</div>
	</nav>
	</body>
	
	
	
	
	