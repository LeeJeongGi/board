<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
<meta name="google-signin-client_id" content="678671317229-7mvul8prbr6f8bepeps6fhe3jsgq62p3.apps.googleusercontent.com">
<script type="text/javascript">
$(document).ready(function(){
});

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
  	var name = profile.getEmail();
  
  	console.log('ID: ' + profile.getId()); // Do not send to your backend! Use an ID token instead.
	console.log('Name: ' + profile.getName());
	console.log('Image URL: ' + profile.getImageUrl());
	console.log('Email: ' + profile.getEmail()); // This is null if the 'email' scope is not present.
  	// The ID token you need to pass to your backend:
	var id_token = googleUser.getAuthResponse().id_token;
	var userID = profile.getId();
	console.log("ID Token: " + id_token);
	if (name !== null) {
	  	window.location.replace("http://" + window.location.hostname + ( (location.port==""||location.port==undefined)?"":":" + location.port) + "/board/main?userID=" + userID);
		} else if (name == null) {
	  
	  	window.location.replace("http://" + window.location.hostname + ( (location.port==""||location.port==undefined)?"":":" + location.port) + "/board/main");
		}
}

function init() {
	console.log('init');
	gapi.load('auth2', function() {
	    /* Ready. Make a call to gapi.auth2.init or some other API */
		console.log('auth2');
	    window.gauth = gapi.auth2.init ({
	    	client_id: '678671317229-u9clb6aanef1lgunrgr1it9q7hrnbuvv.apps.googleusercontent.com'
	    })
	    gauth.then(function () {
	    	console.log('googleauth success');

	    }, function() {
	    	console.log('googleauth fail');
	    })
	  });
}

/** 게시판 - 메인 페이지 이동 */
function goMain() {
	var userID = $("#userID").val();
	console.log(userID);
	location.href="/board/main?userID=" + userID;
}

/** 게시판 - 회원가입 페이지 이동 */
function goRegister() {
	location.href="/board/register";
}
/** 게시판 - 회원가입 */
function getLogin() {
	var userID = $("#userID").val();
	var userPassword = $("#userPassword").val();
	
	if (userID == "") {			
		alert("아이디를 입력해주세요.");
		$("#userID").focus();
		return;
	}

	if (userPassword == ""){			
		alert("비밀번호를 입력해주세요.");
		$("#userPassword").focus();
		return;
	}

	var yn = confirm("로그인을 하시겠습니까?");		
	if(yn){
		$.ajax({
			url		: "/board/getLogin",
			data    : $("#userForm").serialize(),
	        dataType:"JSON",
			cache   : false,
	        async   : true,
			type	: "POST",					 	
			success : function(obj) {
				loginCallback(obj);				
		    },	       
		    error 	: function(xhr, status, error) {}
		    
	    });
	}
}

/** 게시판 - 로그인 콜백 함수 */
function loginCallback(obj){

	if(obj != null){		
		var result = obj.result;
		
		if(result == "SUCCESS"){				
			alert("로그인을 성공하였습니다.");
			goMain();				 
		} else {				
			alert("로그인을 실패하였습니다.");	
			return;
		}
	}
}

	
</script>
<meta name="google-signin-client_id" content="678671317229-u9clb6aanef1lgunrgr1it9q7hrnbuvv.apps.googleusercontent.com">
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
	 		<a class="navbar=brand" href="main?userID=<%=session.getAttribute("userID")%>">블로그</a>
	 	</div>
	 	<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
	 		<ul class="nav navbar-nav">
	 			<li><a href="main?userID=<%=session.getAttribute("userID")%>">내 블로그</a></li>
	 			
	 			<c:choose>
	 				<c:when test = "${sessionScope.userID == \"admin\" }">
	 					<li><a href="admin">관리자 페이지</a></li>
	 				</c:when>
	 				<c:when test = "${sessionScope.userID != null && sessionScope.userID != \"\" 
	 							&& sessionScope.userID != \"admin\"}">
	 					<li><a href = "myPage">회원 목록</a></li>
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
 
 <div class="container">
 	<div class="col-lg-4"></div>
  	<div class="col-lg-4">
   		<div class="jumbotron" style="padding-top: 20px;">
    		<form method="post" id="userForm" name="userForm">
     		<h3 style="text-align: center;">로그인 화면</h3>
     		<div class="form-group">
      			<input type="text" class="form-control" id="userID" name="userID" value="" maxlength="20">
     		</div>
     		<div class="form-group">
      			<input type="password" class="form-control" id="userPassword" name="userPassword" value=""  maxlength="20">
     		</div>
     		   		
    		</form>
    		<button type="button" class="btn btn-primary form-control"  onclick="javascript:getLogin();">로그인</button>
    		
    		<a href="${google_url}"><button id="btnJoinGoogle" class="btn btn-primary btn-round"
                                style="width: 100%">
                                <i class="fa fa-google" aria-hidden="true"></i>Google Login
                            </button></a>
			
 		</div>
  	</div>
 </div>
<script src="https://apis.google.com/js/platform.js" async defer></script>
	
</body>
</html>