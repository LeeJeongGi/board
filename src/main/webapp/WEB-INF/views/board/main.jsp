<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %><%@taglib uri="http://www.springframework.org/tags" prefix="spring"%> 

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>메인 페이지</title>
<%	
	String del_yn = request.getParameter("del_yn");		
%>

<c:set var="del_yn" value="<%=del_yn%>"/> <!-- 친구 유무  -->

<!-- 공통 CSS -->
<link rel="stylesheet" type="text/css" href="/css/common/common.css"/>
<link rel="stylesheet" href="/css/common/bootstrap.css">

<!-- 공통 JavaScript -->
<script type="text/javascript" src="/js/common/jquery.js"></script>
<script type="text/javascript" src="/js/common/jquery.form.js"></script>
<script src="/js/common/bootstrap.js"></script>
<script type="text/javascript">
	
	$(document).ready(function(){	
		getBoardList();
	});	
	
	/** 게시판 - 작성 페이지 이동 */
	function goBoardWrite(){
		location.href = "/board/boardWrite";
	}
	
	/** 게시판 - 상세 페이지 이동 */
	function goBoardDetail(boardSeq){
		
		var url = unescape(location.href);
		  //파라미터만 자르고, 다시 &그분자를 잘라서 배열에 넣는다.
		var paramArr = (url.substring(url.indexOf("?")+1,url.length)).split("&");
		
		for(var i = 0 ; i < paramArr.length ; i++){
		 	var tempd = paramArr[i].split("=");
		}

		
		location.href = "/board/boardDetail?boardSeq="+ boardSeq + "&userID=" + tempd[1];
	}
	
	/** 게시판 - 목록 페이지 이동 */
	function goBoardList(){				
		location.href = "/board/boardList";
	}
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
	
	$(document).ready(function() {
		$('#getFriend input').on('click', function() {
			var currentRow = $(this).closest('tr');
			var col1 = currentRow.find('td:eq(0)').text();
			var col2 = currentRow.find('td:eq(1)').text();
			var col3 = currentRow.find('td:eq(2)').text();
			var del_yn = $("#del_yn").val();
			console.log("del_yn : " + del_yn);
			console.log("col1 : " + col2);
			
			var yn = confirm("이웃을 추가 하시겠습니까?");		
			if(yn){
				
				$.ajax({						
					url		: "/board/getFriend",
					data    : {"userID" : col2,
								"del_yn" : del_yn},
				    dataType: "JSON",
				    cache   : false,
					async   : true,
					type	: "POST",	
				    success : function(obj) {
				    	getFriendCallback(obj);				
				    },	       
				       error : function(xhr, status, error) {}
				        
				    });		
		 	}
		});
	});
 
 	/** 이웃 추가 기능 구현 콜백 함수 */
	function getFriendCallback(obj){
	
		if(obj != null){		
			
			var result = obj.result;
			
			if(result == "SUCCESS"){				
				alert("이웃 추가를 완료하였습니다.");				
				goMain();				
			} else  if(result == "FAIL"){				
				alert("이웃 추가를 실패하였습니다.");	
				return;
			} else {
				alert("이미 이웃 입니다.");
				return;
			}
		}
	}
	
	//구글 로그아웃
	function signOut() {
	    var auth2 = gapi.auth2.getAuthInstance();
	    auth2.signOut().then(function() {
	  	console.log('User signed out.'); 
	    });
	    auth2.disconnect();
	  }
	
	/** 게시판 - 목록 조회  */
	function getBoardList(currentPageNo){
				
		if(currentPageNo === undefined){
			currentPageNo = "1";
		}
		
		$("#current_page_no").val(currentPageNo);
		
		$.ajax({	
		
		    url		:"/board/getBoardList",
		    data    : $("#boardForm").serialize(),
	        dataType:"JSON",
	        cache   : false,
			async   : true,
			type	:"POST",	
	        success : function(obj) {
				getBoardListCallback(obj);				
	        },	       
	        error 	: function(xhr, status, error) {}
	        
	     });
	}
	
	/** 게시판 - 목록 조회  콜백 함수 */
	function getBoardListCallback(obj){

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
										
					str += "<td onclick='javascript:goBoardDetail("+ boardSeq + ");' style='cursor:Pointer'>";
					
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
<body style="overflow:auto;">
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
 	
	<div style="border: 1px dashed #BDBDBD; width: 900px; height: 300px; width:100%; ">
		<img src="<spring:url value = '/image/unnamed.jpg'/>" style="border: 1px dashed #BDBDBD; width: 900px; height: 300px; width:100%;"/>
	</div>
	<c:choose>
		<c:when
			test="${sessionScope.userID == null ||sessionScope.userID==\"\" ||
						 userDto.userID == null || userDto.userID ==\"\"}">
			<h3>
				블로그를 이용하시려면 <br />우측상단에서 로그인을 먼저 해주세요
			</h3>
		</c:when>
		<c:otherwise>
			<div style="overflow: auto;">
				<div
					style="border: 1px dashed #BDBDBD; width: 340px; height: 200px; float: left; width: 30%;">
					<table>
						<tr>
							<h3>프로필 정보</h3>
						</tr>

						<tr>
							<!-- 첫번째 줄 시작 -->
							<td>userID :</td>
							<td>${userDto.userID }</td>
							<input type="hidden" id="del_yn" name="del_yn" value="N" />
							<c:if test="${sessionScope.userID != userDto.userID }">
								<td id="getFriend"><input
									class="btn btn-info btn-md form-control" type="button"
									value="이웃 추가"></td>
							</c:if>
							<br />
						</tr>
						<!-- 첫번째 줄 끝 -->
						<tr>
							<!-- 두번째 줄 시작 -->
							<td>userName :</td>
							<td>${userDto.userName }</td>
						</tr>
						<br />
						<!-- 두번째 줄 끝 -->
						<tr>
							<!-- 세번째 줄 시작 -->
							<td>userEmail :</td>
							<td>${userDto.userEmail }</td>
						</tr>
						<br />
					</table>
				</div>


				<div
					style="border: 1px dashed #BDBDBD; width: 340px; height: 200px; float: rigth; width: 100%;">

					<tr>
						<h3>
							<th>이웃목록</th>
						</h3>
					</tr>
					<br />

					<form id="userForm" name="userForm">
						<c:forEach var="userDto2" items="${userDto2}">
							<tr>
								<td>이웃 아이디 : <c:out value="${userDto2.userFriend}" /></td>
								<td>// <a href="main?userID=${userDto2.userFriend}">블로그
										구경가기</a></td>
							</tr>
							<br />
						</c:forEach>
					</form>
					<br />
				</div>
			</div>

			<div
				style="border: 1px dashed #BDBDBD; width: 340px; height: 200px; float: rigth; width: 100%;">

				<tr>
					<h5>
						블로그를 소개해 주세요<span class="t_red">*</span>
					</h5>
				</tr>
				<c:choose>
					<c:when test="${userDto.userID == sessionScope.userID }">
						<form id="getIntroduce" method="post" action='getIntroduce'>
							<tr>
								<th>내용<span class="t_red">*</span></th>
								<td><textarea id="introduce" name="introduce" cols="10"
										rows="5" class="textarea01">${userDto.introContext}</textarea></td>
							</tr>
							<td>
							<td><input type="submit" value="입력"></td>

							</td>
						</form>
					</c:when>
					<c:otherwise>
						<h3>${ userDto.introContext}</h3>
					</c:otherwise>
				</c:choose>
			</div>
			<div id="wrap">
				<div id="container">
					<div class="inner">
						<h2>게시글</h2>
						<form id="boardForm" name="boardForm" method="get">
							<input type="hidden" id="function_name" name="function_name"
								value="getBoardList" /> <input type="hidden"
								id="current_page_no" name="current_page_no" value="1" /> <input
								type="hidden" id="board_writer" name="board_writer"
								value="<%=request.getParameter("userID")%>" />

							<div class="page_info">
								<span class="total_count"><strong>전체</strong> : <span
									id="total_count" class="t_red">0</span>개</span>
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
						<c:if
							test="${sessionScope.userID == param.userID }">
							<div class="btn_right mt15">
								<td><a href ="boardWrite?userID=${userDto.userID}">작성하기</a></td>
								
							</div>
						</c:if>
					</div>
					<div class="text-center">
						<div id="pagination"></div>
					</div>
		</c:otherwise>
	</c:choose>
</body>
</html>