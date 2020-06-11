<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>개인 페이지</title>

<!-- 공통 CSS -->
<link rel="stylesheet" type="text/css" href="/css/common/common.css"/>
<link rel="stylesheet" href="/css/common/bootstrap.css">

<!-- 공통 JavaScript -->
<script type="text/javascript" src="/js/common/jquery.js"></script>
<script src="/js/common/bootstrap.js"></script>
<meta name="google-signin-client_id" content="678671317229-7mvul8prbr6f8bepeps6fhe3jsgq62p3.apps.googleusercontent.com">
<script type="text/javascript">
$(document).ready(function(){
});

/** 마이 페이지 이동 */
function goMypage(){				
	location.href = "/board/myPage";
}

	/*이웃 추가 기능 다른 방법*/
	
 	
	/*이웃 삭제 기능 다른 방법*/
	$(document).ready(function() {
		$('#delFriend input').on('click', function() {
			var currentRow = $(this).closest('tr');
			var col1 = currentRow.find('td:eq(0)').text();
			var col2 = currentRow.find('td:eq(1)').text();
			var col3 = currentRow.find('td:eq(2)').text();
			
			var yn = confirm("이웃을 삭제하시겠습니까?");		
			if(yn){
				
				$.ajax({						
					url		: "/board/delFriend",
					data    : {"userID" : col1},
				    dataType: "JSON",
				    cache   : false,
					async   : true,
					type	: "POST",	
				    success : function(obj) {
				    	delFriendCallback(obj);				
				    },	       
				       error : function(xhr, status, error) {}
				        
				    });		
		 	}
		});
	});
	
	/** 이웃 추가 기능 구현 콜백 함수 */
	function delFriendCallback(obj){
	
		if(obj != null){		
			
			var result = obj.result;
			
			if(result == "SUCCESS"){				
				alert("이웃 삭제를 완료하였습니다.");				
				goMypage();				
			} else  {				
				alert("이웃 삭제를 실패하였습니다.");	
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
 	
 	<div class="jumbotron">
    	<h1>개인 페이지</h1>
	</div>
	
	<div class="container">
    <table class="table table-striped">
        <thead>
            <tr>
                <th>userID</th>
                <th>userName</th>
                <th>userGender</th>
                <th>userEmail</th>
                <th>블로그 놀러가기</th>
            </tr>
        </thead>
        <tbody>
        <form id="userForm" name="userForm" >
            <c:forEach var="userDto" items="${userDto}">
                <tr>              
                    <td><c:out value="${userDto.userID}"/></td>
                    <td><c:out value="${userDto.userName}"/></td>
                    <td><c:out value="${userDto.userGender}"/></td>
                    <td><c:out value="${userDto.userEmail}"/></td>
                    <input type="hidden" id="userID" name="userID"	value="${userDto.userID}"/> <!-- 이웃아이디 -->
              		
              		<td><a href ="main?userID=${userDto.userID}">블로그 구경가기</a></td>
              		<td id = "delFriend"><input 
              		class = "btn btn-info btn-md form-control" type = "button"
              		value = "이웃 삭제"></td>
                </tr>
            </c:forEach>
            
         </form>
        </tbody>
    </table>
</div>
			
	

</body>
</html>