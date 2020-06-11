<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>회원 가입</title>

<!-- 공통 CSS -->
<link rel="stylesheet" type="text/css" href="/css/common/common.css"/>
<link rel="stylesheet" href="/css/common/bootstrap.css">

<!-- 공통 JavaScript -->
<script type="text/javascript" src="/js/common/jquery.js"></script>
<script type="text/javascript" src="/js/common/jquery.form.js"></script>
<script src="/js/common/bootstrap.js"></script>
<script type="text/javascript">
	$(document).ready(function(){
		
	});
	
	/** 게시판 - 메인 페이지 이동 */
	function goMain() {
		location.href="/board/main";
	}
	
	/** 게시판 - 로그인 페이지 이동 */
	function goLogin() {
		location.href="/board/login";
	}
	/** 게시판 - 회원가입 */
	function getRegister() {
		var userID = $("#userID").val();
		var userPassword = $("#userPassword").val();
		var userName = $("#userName").val();
		var userGender = $("userGender").val();
		var userEmail = $("#userEmail").val();
		
		if (userID == ""){			
			alert("아이디를 입력해주세요.");
			$("#userID").focus();
			return;
		}
		if (userPassword == ""){			
			alert("비밀번호를 입력해주세요.");
			$("#userPassword").focus();
			return;
		}
		if (userEmail == ""){			
			alert("이메일을 입력해주세요.");
			$("#userEmail").focus();
			return;
		}
		var yn = confirm("회원가입을 하시겠습니까?");		
		if(yn){
			console.log("8");
			$.ajax({
				url		: "/board/getRegister",
				data    : $("#userForm").serialize(),
		        dataType:"JSON",
				cache   : false,
		        async   : true,
				type	: "POST",					 	
				success : function(obj) {
					console.log("9");
					registerCallback(obj);				
			    },	       
			    error 	: function(xhr, status, error) {}
			    
		    });
		}
	}
	
	/** 게시판 - 회원가입 콜백 함수 */
	function registerCallback(obj){
	
		if(obj != null){		
			
			var result = obj.result;
			
			if(result == "SUCCESS"){				
				alert("회원가입을 성공하였습니다.");				
				goMain();				 
			} else {				
				alert("회원가입을 실패하였습니다.");	
				return;
			}
		}
	}
	
</script>
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
	 			<c:if test = "${sessionScope.userID != null && sessionScope.userID != \"\" }">
	 				<li><a href="boardList">게시판</a></li>
	 			</c:if>
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
    		<form id="userForm" name="userForm" >
     		<h3 style="text-align: center;">회원가입 화면</h3>
     		
     		<div class="form-group">
      			<input type="text" class="form-control" placeholder="아이디" id="userID" name="userID" maxlength="20">
     		</div>
     		
     		<div class="form-group">
      			<input type="password" class="form-control" placeholder="비밀번호" id="userPassword" name="userPassword" maxlength="20">
     		</div>
     		
     		<div class="form-group">
      			<input type="text" class="form-control" placeholder="이름" id="userName" name="userName" maxlength="20">
     		</div>
     		
     		<div class="form-group">
      			<input type="email" class="form-control" placeholder="이메일" id="userEmail" name="userEmail" value="" maxlength="20">
     		</div>   
     		
     		<div class="form-group" style="text-align: center;">
      			<div class="btn-group" data-toggle="buttons">
      				<label class="btn btn-primary active">
      					<input type="radio" name="userGender" autocomplete="off" value="남자" checked>남자		
      				</label>
      				<label class="btn btn-primary">
      					<input type="radio" name="userGender" autocomplete="off" value="여자"> 여자		
      				</label>
      			</div>
     		</div>
     		  		   		    		
    	</form>
    	<button type="button" class="btn btn-primary form-control"  onclick="javascript:getRegister();">회원가입</button>
    		
   		</div>
  	</div>
  	<div class="col-lg-4"></div>
 </div>

</body>
</html>