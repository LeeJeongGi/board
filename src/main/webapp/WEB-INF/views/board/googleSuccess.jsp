<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>구글 로그인 성공 테스트</title>

<!-- 공통 CSS -->
<link rel="stylesheet" type="text/css" href="/css/common/common.css"/>
<link rel="stylesheet" href="/css/common/bootstrap.css">

<!-- 공통 JavaScript -->
<script type="text/javascript" src="https://static.nid.naver.com/js/naverLogin_implicit-1.0.2.js" charset="utf-8"></script>
<script type="text/javascript" src="/js/common/jquery.js"></script>
<script src="/js/common/bootstrap.js"></script>
<script src="https://apis.google.com/js/platform.js"></script>
<style type="text/css">
html, div, body, h3 {
	margin: 0;
	padding: 0;
}

h3 {
	display: inline-block;
	padding: 0.6em;
}
</style>


</head>
<body>
 <nav class="navbar navbar-default">
	 	<div class="navbar-header">
	 		<button type="button" class="navbar-toggle collapsed"
	 			data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
	 			aria-expanded="false">
	 			<span class="icon-bar"</span>
	 			<span class="icon-bar"</span>
	 			<span class="icon-bar"</span>	 		
	 		</button>
	 		<a class="navbar=brand" href="main">블로그</a>
	 	</div>
	 	<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
	 		<ul class="nav navbar-nav">
	 			<li><a href="main">메인</a></li>
	 			<c:if test = "${sessionScope.userID != null && sessionScope.userID != \"\" }">
	 				<li><a href="boardList">게시판</a></li>
	 			</c:if>
	 			<c:choose>
	 				<c:when test = "${sessionScope.userID == \"admin\" }">
	 					<li><a href="admin">관리자 페이지</a></li>
	 				</c:when>
	 				<c:when test = "${sessionScope.userID != null && sessionScope.userID != \"\" 
	 							&& sessionScope.userID != \"admin\"}">
	 					<li><a href = "myPage">이웃 목록</a></li>
	 					<li><a href = "friend">이웃 글 보기</a></li>
	 				</c:when>
	 				<c:otherwise>
	 					<c:out value=" "/>
	 				</c:otherwise>
	 			</c:choose>		
	 		</ul>
	 		<ul class="nav navbar-nav navbar-right">
	 			<li class="dropdown">
	 				<a href="#" class="dropdown-toggle"
	 				data-toggle="dropdown" role="button" aria-haspopup="true"
	 				aria-expanded="false">접속하기<span class="caret"></span></a>
	 					
	 				<c:choose>
	 					<c:when test="${sessionScope.userID == null ||sessionScope.userID==\"\"}">
	 						<ul class="dropdown-menu">
	 							<li><a href="login">로그인</a></li>
	 							<li class="active"><a href="register">회원가입</a></li>
	 						</ul>
	 					</c:when>
	 								
	 					<c:otherwise>
	 						<ul class="dropdown-menu">
	 							<li><a href="logout">로그아웃</a></li>
	 							<li class="active"><a href="register">회원가입</a></li>
	 						</ul>
	 					</c:otherwise>
	 				</c:choose>
	 				
	 			</li>	
	 		
	 		</ul>  		
   		</div>
 	</nav>
	<div
		style="background-color: #15a181; width: 100%; height: 50px; text-align: center; color: white;">
		<h3>SIST Google_Login Success</h3>
	</div>
	<br>
	<h2 style="text-align: center" id="name"></h2>
	<h4 style="text-align: center" id="email"></h4>

</body>
</html>