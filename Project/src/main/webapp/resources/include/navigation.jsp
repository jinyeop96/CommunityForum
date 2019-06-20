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
<link href="<c:url value="/resources/css/myself.css" />" rel="stylesheet" type="text/css">
<script src="<c:url value='/resources/jquery-3.4.1.js' /> "></script>

</head>
<body id="page-top">
	<!-- Navigation -->
	<nav
		class="navbar navbar-expand-lg bg-secondary text-uppercase fixed-top"
		id="mainNav">
		<div class="container">
			<a class="navbar-brand js-scroll-trigger" href="main.do">오와열</a>
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
						<a class="nav-link py-3 px-0 px-lg-3 rounded js-scroll-trigger">Board</a>
							<ul class="board_bg">
								<li><a class="nav-link py-3 px-0 px-lg-3 rounded js-scroll-trigger" href="entire.do?pageParam=1">전체</a></li>
								<li><a class="nav-link py-3 px-0 px-lg-3 rounded js-scroll-trigger" href="free.do">자유</a></li>
								<li><a class="nav-link py-3 px-0 px-lg-3 rounded js-scroll-trigger" href="#path">뭐뭐</a></li>
							</ul>
					</li>
					
					<li class="nav-item mx-0 mx-lg-1">
						<a class="nav-link py-3 px-0 px-lg-3 rounded js-scroll-trigger">Browse</a>
							<ul>
								<li><a class="nav-link py-3 px-0 px-lg-3 rounded js-scroll-trigger" href="#hotel">Hotel</a></li>
								<li><a class="nav-link py-3 px-0 px-lg-3 rounded js-scroll-trigger" href="#restaurant">Restaurant</a></li>
								<li><a class="nav-link py-3 px-0 px-lg-3 rounded js-scroll-trigger" href="#transport">Transport</a></li>
							</ul>
					</li>
					
					<li class="nav-item mx-0 mx-lg-1">
						<a class="nav-link py-3 px-0 px-lg-3 rounded js-scroll-trigger" href="#path">News</a>
						<ul>
		             		<li><a class="nav-link py-3 px-0 px-lg-3 rounded js-scroll-trigger" href="allqna.do">부대행사</a></li>
		              		<li><a class="nav-link py-3 px-0 px-lg-3 rounded js-scroll-trigger" href="allqnalist.do">전군공지</a></li>
		              	</ul>
					</li>
						
					<li class="nav-item mx-0 mx-lg-1">
           				<a class="nav-link py-3 px-0 px-lg-3 rounded js-scroll-trigger navbar-login" href="login.do">Login</a>
         			</li>
	
					<li class="nav-item mx-0 mx-lg-1">
           				<a class="nav-link py-3 px-0 px-lg-3 rounded js-scroll-trigger navbar-login" href="join.do">Join</a>
         			</li>
					 
		
				</ul>
			</div>
		</div>
		<div class="navbar-log-regi">
			<!-- 메뉴바 우측상단배치 -->
			<a class="navbar-top-right" href="login.do">Login</a> <a
				class="navbar-top-right" href="join.do">Join</a>
		</div>
	</nav>