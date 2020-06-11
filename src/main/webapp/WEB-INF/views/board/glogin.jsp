<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>게시판 목록</title>

<!-- 공통 CSS -->
<link rel="stylesheet" type="text/css" href="/css/common/common.css"/>
<link rel="stylesheet" href="/css/common/bootstrap.css">

<!-- 공통 JavaScript -->
<script type="text/javascript" src="https://static.nid.naver.com/js/naverLogin_implicit-1.0.2.js" charset="utf-8"></script>
<script type="text/javascript" src="/js/common/jquery.js"></script>
<script src="/js/common/bootstrap.js"></script>
<script src="https://apis.google.com/js/platform.js"></script>
  <style type="text/css">
  html, div, body,h3{
  	margin: 0;
  	padding: 0;
  }
  h3{
  	display: inline-block;
  	padding: 0.6em;
  }
  </style>
<script type="text/javascript">

//구글 로그아웃
function signOut() {
    var auth2 = gapi.auth2.getAuthInstance();
    auth2.signOut().then(function(){
  console.log('User signed out.'); 
        });
    auth2.disconnect();
  }

//구글 로그인
function onSignIn(googleUser) {
  // Useful data for your client-side scripts:
	var profile = googleUser.getBasicProfile();
    console.log("ID: " + profile.getId()); // Don't send this directly to your server!
    console.log('Full Name: ' + profile.getName());
    console.log('Given Name: ' + profile.getGivenName());
    console.log('Family Name: ' + profile.getFamilyName());
    console.log("Image URL: " + profile.getImageUrl());
    console.log("Email: " + profile.getEmail());
  
  	var name = profile.getEmail();
  
  	// The ID token you need to pass to your backend:
  	var id_token = googleUser.getAuthResponse().id_token;
  	console.log("ID Token: " + id_token);
  	if (name !== null) {
  	window.location.replace("http://" + window.location.hostname + ( (location.port==""||location.port==undefined)?"":":" + location.port) + "/board/main?name="+name);
	} else if (name == null) {
  
  		window.location.replace("http://" + window.location.hostname + ( (location.port==""||location.port==undefined)?"":":" + location.port) + "/board/main");
	}

}

</script type="text/javascript">
<meta name="google-signin-client_id" content="451815931731-u24ino5uecga1arf65814fd72201fcmu.apps.googleusercontent.com">
<meta name="google-signin-cookiepolicy" content="single_host_origin" />
<meta name="google-signin-requestvisibleactions" content="https://schema.org/AddAction" />
<meta name="google-signin-scope" content="https://www.googleapis.com/auth/plus.login" />
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
	 		<a class="navbar=brand" href="main.jsp">JSP 게시판 웹 사이트</a>
	 	</div>
	 	<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
	 		<ul class="nav navbar-nav">
	 			<li><a href="main">메인</a></li>
	 			<li><a href="boardList">게시판</a></li>
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
<div style="background-color:#15a181; width: 100%; height: 50px;text-align: center; color: white; "><h3>SIST Login</h3></div>
<br>
<!-- 구글 로그인 화면으로 이동 시키는 URL -->
<!-- 구글 로그인 화면에서 ID, PW를 올바르게 입력하면 oauth2callback 메소드 실행 요청-->
<div id="google_id_login" style="text-align:center">
	<a href="${google_url}"><img width="230" src="C:\Users\apple\eclipse-workspace\board\src\main\webapp\resource\images\google-login-button-png-3.png" onclick="javascript:onSignIn();"/></a>
</div>
</body>
</html>