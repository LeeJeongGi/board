<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>게시판 상세</title>
<%	
	String boardSeq = request.getParameter("boardSeq");
%>

<c:set var="boardSeq" value="<%=boardSeq%>"/> <!-- 게시글 번호 -->

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
	
	/** 자신 페이지 이동 */
	function goMain(){
		var url = unescape(location.href);
		  //파라미터만 자르고, 다시 &그분자를 잘라서 배열에 넣는다.
		var paramArr = (url.substring(url.indexOf("?")+1,url.length)).split("&");
		
		for(var i = 0 ; i < paramArr.length ; i++){
		 	var tempd = paramArr[i].split("=");
		}
		location.href = "/board/main?userID=" + tempd[1];
	}
	
	/** 게시판 - 수정 페이지 이동 */
	function goBoardUpdate(){
		var url = unescape(location.href);
		  //파라미터만 자르고, 다시 &그분자를 잘라서 배열에 넣는다.
		var paramArr = (url.substring(url.indexOf("?")+1,url.length)).split("&");
		
		for(var i = 0 ; i < paramArr.length ; i++){
		 	var tempd = paramArr[i].split("=");
		}
		var boardSeq = $("#board_seq").val();
		
		location.href = "/board/boardUpdate?boardSeq="+ boardSeq + "&userID=" +tempd[1] ;
	}
	
	/** 게시판 - 답글 페이지 이동 */
	function goBoardReply(){
		var url = unescape(location.href);
		  //파라미터만 자르고, 다시 &그분자를 잘라서 배열에 넣는다.
		var paramArr = (url.substring(url.indexOf("?")+1,url.length)).split("&");
		
		for(var i = 0 ; i < paramArr.length ; i++){
		 	var tempd = paramArr[i].split("=");
		}
		var boardSeq = $("#board_seq").val();
		
		location.href = "/board/boardReply?boardSeq="+ boardSeq + "&userID=" +tempd[1] ;
	}
	
	/** 게시판 - 첨부파일 다운로드 */
	function fileDownload(){		
		
		location.href = "/board/fileDownload";
	}
	
	
	
	/** 게시판 - 삭제  */
	function deleteBoard(){

		var boardSeq = $("#board_seq").val();
		
		var yn = confirm("게시글을 삭제하시겠습니까?");		
		if(yn){
			
			$.ajax({
				
			    url		: "/board/deleteBoard",
			    data    : $("#boardForm").serialize(),
		        dataType: "JSON",
		        cache   : false,
				async   : true,
				type	: "POST",	
		        success : function(obj) {
		        	deleteBoardCallback(obj);				
		        },	       
		        error 	: function(xhr, status, error) {}
		        
		     });
		}		
	}
	
	/** 게시판 - 삭제 콜백 함수 */
	function deleteBoardCallback(obj){
	
		if(obj != null){		
			
			var result = obj.result;
			
			if(result == "SUCCESS"){				
				alert("게시글 삭제를 성공하였습니다.");				
				goMain();				
			} else {				
				alert("게시글 삭제를 실패하였습니다.");	
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

<div id="wrap">
	<div id="container">
		<div class="inner">	
			<h2>게시글 상세</h2>
			<form id="boardForm" name="boardForm">		
				<table width="100%" class="table01">
				    <colgroup>
				        <col width="15%">
				        <col width="35%">
				        <col width="15%">
				        <col width="*">
				    </colgroup>
				    <tbody id="tbody" class="test-center">

				    		<tr>
				    			<th>제목</th>
				    				<td><c:out value="${boardDto.board_subject}"/></td>
				    			<th>조회수</th>
				    				<td><c:out value="${boardDto.board_hits}"/></td>	
				    		</tr>
				    		<tr>
				    			<th>작성자</th>
				    				<td><c:out value="${boardDto.board_writer}"/></td>
				    			<th>작성일시</th>
				    				<td><c:out value="${boardDto.ins_date}"/></td>
				    		</tr>
				    		<tr>
				    			<th>내용</th>
				    				<td colspan='3'><c:out value="${boardDto.board_content}"/></td>
				    		</tr>
				    		
							<tr>
								<th>첨부파일</th>
								<c:choose>
									<c:when test = "${boardDto.files == null ||  boardDto.files == \"[]\" }">	
										<td colspan='3'><c:out value = "파일 없음"/></a></td>		
										
									</c:when>
									
									<c:otherwise>
										<td colspan='3'><a href="/board/fileDownload?files=${boardDto.files}&boardSeq=<%=boardSeq %>" ><c:out value = "${boardDto.files}"/></a></td>
									</c:otherwise>
								</c:choose>
							</tr>				
							
				    </tbody>
				</table>		
				<input type="hidden" id="board_seq"		name="board_seq"	value="${boardSeq}"/> <!-- 게시글 번호 -->
				<input type="hidden" id="search_type"	name="search_type" 	value="S"/> <!-- 조회 타입 - 상세(S)/수정(U) -->
				
			</form>
			<div class="btn_right mt15">
				<button type="button" class="btn black mr5" onclick="javascript:goMain();">목록으로</button>
				<c:if test="${param.userID == sessionScope.userID || param.userID == 'admin' }">
					<button type="button" class="btn black mr5" onclick="javascript:goBoardUpdate();">수정하기</button>
					<button type="button" class="btn black" onclick="javascript:deleteBoard();">삭제하기</button>
				</c:if>

			</div>
		</div>
	</div>
</div>
</body>
</html>