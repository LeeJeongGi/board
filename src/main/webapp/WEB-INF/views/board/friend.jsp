<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>이웃 페이지</title>

<!-- 공통 CSS -->
<link rel="stylesheet" type="text/css" href="/css/common/common.css"/>
<link rel="stylesheet" href="/css/common/bootstrap.css">

<!-- 공통 JavaScript -->
<script type="text/javascript" src="/js/common/jquery.js"></script>
<script src="/js/common/bootstrap.js"></script>
<meta name="google-signin-client_id" content="678671317229-7mvul8prbr6f8bepeps6fhe3jsgq62p3.apps.googleusercontent.com">
<script type="text/javascript">
$(document).ready(function(){
	getfriend();
});

/** 게시판 - 상세 페이지 이동 */
function goBoardDetail(boardSeq){				
	location.href = "/board/boardDetail?boardSeq="+ boardSeq;
}

/** 게시판 - 목록 조회  */
function getfriend(currentPageNo){
			
	if(currentPageNo === undefined){
		currentPageNo = "1";
	}
	
	$("#current_page_no").val(currentPageNo);
	
	$.ajax({	
	
	    url		:"/board/getfriend",
	    data    : $("#boardForm").serialize(),
        dataType:"JSON",
        cache   : false,
		async   : true,
		type	:"POST",	
        success : function(obj) {
        	getfriendCallback(obj);				
        },	       
        error 	: function(xhr, status, error) {}
        
     });
}

/** 게시판 - 목록 조회  콜백 함수 */
function getfriendCallback(obj){

	var state = obj.state;
	
	if(state == "SUCCESS"){
		
		var data = obj.data;			
		var list = data.list;
		var listLen = list.length;		
		var totalCount = data.totalCount;
		var pagination = data.pagination;
			
		var str = "";
		
		if(listLen >  0){
			
			for(var a=0; a<listLen; a++){
				
				var boardSeq		= list[a].board_seq; 
				var boardReRef 		= list[a].board_re_ref; 
				var boardReLev 		= list[a].board_re_lev; 
				var boardReSeq 		= list[a].board_re_seq; 
				var boardWriter 	= list[a].board_writer; 
				var boardSubject 	= list[a].board_subject; 
				var boardContent 	= list[a].board_content; 
				var boardHits 		= list[a].board_hits;
				var delYn 			= list[a].del_yn; 
				var insUserId 		= list[a].ins_user_id;
				var insDate 		= list[a].ins_date; 
				var updUserId 		= list[a].upd_user_id;
				var updDate 		= list[a].upd_date;
	
				str += "<tr>";
				str += "<td>"+ boardSeq +"</td>";
									
				str += "<td onclick='javascript:goBoardDetail("+ boardSeq + " );' style='cursor:Pointer'>";
				
				if(boardReLev > 0){
					
					for(var b=0; b<boardReLev; b++){
						
						str += "Re:";
					}
				}
				
				str += boardSubject +"</td>";
									
				str += "<td>"+ boardHits +"</td>";
				str += "<td>"+ boardWriter +"</td>";	
				str += "<td>"+ insDate +"</td>";	
				str += "</tr>";
				
			} 
			
		} else {
			
			str += "<tr>";
			str += "<td colspan='5'>등록된 글이 존재하지 않습니다.</td>";
			str += "<tr>";
		}
		
		$("#tbody").html(str);
		$("#total_count").text(totalCount);
		$("#pagination").html(pagination);
		
	} else {
		alert("관리자에게 문의하세요.");
		return;
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
 	
 <div id="wrap">
	<div id="container">
		<div class="inner">		
			<h2>이웃 게시글 목록</h2>			
			<form id="boardForm" name="boardForm">
				<input type="hidden" id="function_name" name="function_name" value="getfriend" />
				<input type="hidden" id="current_page_no" name="current_page_no" value="1" />
				<input type="hidden" id="board_writer" name="board_writer" value="<%=session.getAttribute("userID")%>" />
				
				<div class="page_info">
					<span class="total_count"><strong>전체</strong> : <span id="total_count" class="t_red">0</span>개</span>
				</div>
			
				<table width="100%" class="table01">
					<colgroup>
						<col width="10%" />
						<col width="25%" />
						<col width="10%" />
						<col width="15%" />
						<col width="20%" />
					</colgroup>
					<thead>		
						<tr>
							<th>글번호</th>
							<th>제목</th>
							<th>조회수</th>
							<th>작성자</th>
							<th>작성일</th>
						</tr>
					</thead>
					<tbody id="tbody">
					
					</tbody>	
				</table>
			</form>	
		
		</div>
		<div class = "text-center"> 
			<div id="pagination"></div>	
		</div>
	</div>
	</div>
</body>
</html>