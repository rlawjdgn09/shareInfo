<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<!DOCTYPE html>
 <html lang="ko">
 <head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <meta name="description" content="">
  <meta name="author" content="">

  <title>shareInfo/Tip</title>

  <!-- Bootstrap core CSS -->
  <link href="/resources/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">

  <!-- Custom fonts for this template -->
  <link href="/resources/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
  <link href="https://fonts.googleapis.com/css?family=Lora:400,700,400italic,700italic" rel="stylesheet" type="text/css">
  <link href="https://fonts.googleapis.com/css?family=Open+Sans:300italic,400italic,600italic,700italic,800italic,400,300,600,700,800" rel="stylesheet" type="text/css">

  <!-- Custom styles for this template -->
  <link href="/resources/css/clean-blog.min.css" rel="stylesheet">
  
    <!-- Bootstrap core JavaScript -->
  <script src="/resources/vendor/jquery/jquery.min.js"></script>
  <script src="/resources/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

  <!-- Custom scripts for this template -->
  <script src="/resources/js/clean-blog.min.js"></script>

</head>

<body>

  <nav class="navbar navbar-expand-lg navbar-light fixed-top" id="mainNav">
    <div class="container">
      <a class="navbar-brand" href="/board/getBoardList">shareInfo/Tip</a>
      <button class="navbar-toggler navbar-toggler-right" type="button" data-toggle="collapse" data-target="#navbarResponsive" aria-controls="navbarResponsive" aria-expanded="false" aria-label="Toggle navigation">
        Menu
        <i class="fas fa-bars"></i>
      </button>
      <div class="collapse navbar-collapse" id="navbarResponsive">
        <ul class="navbar-nav ml-auto">
          <li class="nav-item">
            <a class="nav-link" href="/board/getBoardList">게시판</a>
          </li>
          <sec:authorize access="isAnonymous()">
	           <li class="nav-item">
	            <a class="nav-link" href="/customLogin">로그인</a>
	          </li>	
          </sec:authorize>
          <sec:authorize access="hasRole('ROLE_MEMBER')">
         	<li class="nav-item dropdown">
                  <a class="nav-link dropdown-toggle" data-toggle="dropdown" href="#" role="button" aria-haspopup="true" aria-expanded="false"><sec:authentication property="principal.username"/></a>
                  <div class="dropdown-menu" style="">
                    <a class="dropdown-item" href="/member/modifyMember?memberId=<sec:authentication property="principal.username"/>">마이 페이지</a>
           			  <div class="dropdown-divider"></div>
                    <a class="dropdown-item" href="#">로그아웃</a>
                  </div>
                </li>
            </sec:authorize>
        </ul>
      </div>
    </div>
  </nav>
  
  <!-- Page Header -->
  <header class="masthead" style="background-image: url('/resources/img/home-bg.jpg')">
    <div class="overlay"></div>
    <div class="container">
      <div class="row">
        <div class="col-lg-8 col-md-10 mx-auto">
          <div class="site-heading">
            <h1>ShartInfo/Tip</h1>
            <span class="subheading">Let's share my Info/tips</span>
          </div>
        </div>
      </div>
    </div>
  </header>
