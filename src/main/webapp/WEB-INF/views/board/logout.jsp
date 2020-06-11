<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>로그아웃</title>
<!-- 공통 CSS -->
<link rel="stylesheet" type="text/css" href="/css/common/common.css"/>
<link rel="stylesheet" href="/css/common/bootstrap.css">

<!-- 공통 JavaScript -->
<script type="text/javascript" src="/js/common/jquery.js"></script>
<script src="/js/common/bootstrap.js"></script>
<script type="text/javascript">
	$(document).ready(function(){		
	
	});

	
</script>
</head>
<body>
	 <%
	 	session.invalidate();
	 %>
	 <script>
	 	location.href="main";
	 </script>
</body>
</html>