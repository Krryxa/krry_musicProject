<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>Krry账号注册成功</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
  </head>
  <style>
  	body{background:url("images/back.jpg");background-size:cover;}
  	p{color:red;
	    font-size: 24px;
	    font-weight: bold;
	    line-height: 50px;
	    margin: 30px 143px;}
	.username{color:#FF03B0;}
  </style>
  <body>
    <p>Krry账号注册成功!!欢迎<span class="username">${sessionScope.username}</span></p>
    <p><span class="pspan">3</span>秒后自动跳回首页...</p>
    <script src="js/jquery-1.11.3.min.js"></script>
    <script>
    	$(".for_inp").val($(".username").text());
    	var i = 2;
    	var timer = setInterval(function(){
    		$(".pspan").text(i);
    		i--;
    		if(i == -1){
    			location.href="index.jsp";
    			clearInterval(timer);
    		}
    	},1000);
    </script>
  </body>
</html>
